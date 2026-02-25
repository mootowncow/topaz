/*
===========================================================================

Copyright (c) 2010-2015 Darkstar Dev Teams

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "mobskill_state.h"
#include "../ai_container.h"
#include "../../entities/mobentity.h"
#include "../../entities/petentity.h"
#include "../../packets/action.h"
#include "../../utils/battleutils.h"
#include "../../mobskill.h"
#include "../../status_effect_container.h"
#include "../../enmity_container.h"

CMobSkillState::CMobSkillState(CMobEntity* PEntity, uint16 targid, uint16 wsid) :
    CState(PEntity, targid),
    m_PEntity(PEntity)
{
    auto skill = battleutils::GetMobSkill(wsid);
    if (!skill)
    {
        throw CStateInitException(nullptr);
    }

    if (m_PEntity->StatusEffectContainer->HasStatusEffect({EFFECT_AMNESIA, EFFECT_IMPAIRMENT}))
    {
        throw CStateInitException(nullptr);
    }

    auto PTarget = m_PEntity->IsValidTarget(m_targid, skill->getValidTargets(), m_errorMsg);

    if (!PTarget || m_errorMsg)
    {
        throw CStateInitException(std::move(m_errorMsg));
    }

    // Set the initial target, to stop weird things from happening when checking conal/behind/AOE
    SetInitialTarget(PTarget->targid);
    uint16 initialTarget = PTarget->targid;

    m_PSkill = std::make_unique<CMobSkill>(*skill);

    m_castTime = std::chrono::milliseconds(m_PSkill->getActivationTime());

    bool isPlayerPet = m_PEntity->objtype == TYPE_PET && m_PEntity->PMaster && m_PEntity->PMaster->objtype == TYPE_PC;

    if (isPlayerPet)
    {
        auto PAvatar = dynamic_cast<CPetEntity*>(m_PEntity);
        if (PAvatar && PAvatar->getPetType() == PETTYPE_AVATAR)
        {
            m_castTime = std::chrono::milliseconds(PAvatar->m_bloodPactActivationTime);
        }
        else
        {
            m_castTime = std::chrono::milliseconds(m_PSkill->getActivationTime());
        }
    }

    if (m_castTime > 0s)
    {
        action_t action;
        action.id = m_PEntity->id;
        action.actiontype = ACTION_MOBABILITY_START;

        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = PTarget->id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();

        actionTarget.reaction = REACTION_NONE;
        actionTarget.speceffect = SPECEFFECT_NONE;
        actionTarget.animation = 0;
        actionTarget.param = m_PSkill->getID();
        actionTarget.messageID = MSGBASIC_READIES_WS;

        // Store the skill used if mob (For BLU spell learning)
        if (m_PEntity->objtype == TYPE_MOB)
        {
            if (auto* PMob = dynamic_cast<CMobEntity*>(m_PEntity))
            {
                PMob->m_UsedSkillIds[m_PSkill->getID()] = PMob->GetMLevel();
            }
        }

        if ((m_PSkill->getValidTargets() & TARGET_ANY_ALLEGIANCE) && (m_PSkill->getValidTargets() & TARGET_SELF))

        {
            // This ability targets self for aoe skills (such as Frozen Mist)

            action.actiontype = ACTION_WEAPONSKILL_START;

            actionList.ActionTargetID = action.id;
        }

        if (isPlayerPet)
        {
            auto PAvatar = dynamic_cast<CPetEntity*>(m_PEntity);
            if (PAvatar && PAvatar->getPetType() == PETTYPE_AVATAR)
            {
                actionTarget.animation = ACTION_BLOODPACT_START;
                actionTarget.param = PAvatar->m_bloodPactAbilityId;
                actionTarget.messageID = MSGBASIC_PET_WS;
            }
            else
            {
                actionTarget.animation = 0;
                actionTarget.param = m_PSkill->getID();
                actionTarget.messageID = MSGBASIC_READIES_WS;
            }
        }

        m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE, new CActionPacket(action));
    }
    m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_STATE_ENTER", m_PEntity, m_PSkill->getID());
}

CMobSkill* CMobSkillState::GetSkill()
{
    return m_PSkill.get();
}

void CMobSkillState::SpendCost()
{
    auto tp = 0;
    // Don't remove TP if a TP "auto-attack", Two Hour or "special" skill
    if (m_PSkill->isTpSkill())
    {
        if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MEIKYO_SHISUI))
        {
            tp = m_PEntity->addTP(-1000);
        }
        else
        {
            tp = m_PEntity->health.tp;

            if (m_PEntity->getMod(Mod::WS_NO_DEPLETE) <= tpzrand::GetRandomNumber(100))
            {
                m_PEntity->health.tp = 0;
            }
        }

        if (tpzrand::GetRandomNumber(100) < m_PEntity->getMod(Mod::CONSERVE_TP))
        {
            m_PEntity->addTP(tpzrand::GetRandomNumber(10, 200));
        }
    }
    m_spent = tp;
}

bool CMobSkillState::Update(time_point tick)
{
    if (tick > GetEntryTime() + m_castTime && !IsCompleted())
    {
        CBattleEntity* PTarget = dynamic_cast<CBattleEntity*>(GetTarget());
        action_t action;

        if (PTarget)
        {
            bool isDeadTargetAllowed = (m_PSkill->getValidTargets() & TARGET_PLAYER_DEAD) != 0;

            if (PTarget->isAlive() || isDeadTargetAllowed)
            {
                if (m_PSkill->isTpSkill())
                {
                    SpendCost();
                }

                bool isPlayerPet = m_PEntity->objtype == TYPE_PET && m_PEntity->PMaster && m_PEntity->PMaster->objtype == TYPE_PC;

                if (isPlayerPet)
                {
                    auto PAvatar = dynamic_cast<CPetEntity*>(m_PEntity);
                    if (PAvatar && PAvatar->getPetType() == PETTYPE_AVATAR)
                    {
                        PAvatar->OnPlayerPetSkillFinished(*this, action);
                    }
                    else
                    {
                        m_PEntity->OnMobSkillFinished(*this, action);
                    }
                }
                else
                {
                    m_PEntity->OnMobSkillFinished(*this, action);
                }
            }
            else
            {
                action.actiontype = ACTION_MAGIC_FINISH;
                action.actionid = 28787;
                actionList_t& actionList = action.getNewActionList();
            }

            m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, new CActionPacket(action));
            m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_USE", m_PEntity, PTarget, m_PSkill->getID(), m_spent, &action);
            PTarget->PAI->EventHandler.triggerListener("WEAPONSKILL_TAKE", PTarget, m_PEntity, m_PSkill->getID(), m_spent, &action);
        }

        auto delay = std::chrono::milliseconds(m_PSkill->getAnimationTime());
        m_finishTime = tick + delay;
        Complete();
    }

    if (IsCompleted() && tick > m_finishTime)
    {
        auto PTarget = GetTarget();
        if (PTarget && PTarget->objtype == TYPE_MOB && PTarget != m_PEntity && m_PEntity->allegiance == ALLEGIANCE_PLAYER)
        {
            static_cast<CMobEntity*>(PTarget)->PEnmityContainer->UpdateEnmity(m_PEntity, 0, 0);
        }
        m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_STATE_EXIT", m_PEntity, m_PSkill->getID());
        return true;
    }
    return false;
}

void CMobSkillState::Cleanup(time_point tick)
{
    if (!IsCompleted())
    {
        action_t action;
        action.id = m_PEntity->id;
        action.actiontype = ACTION_MOBABILITY_INTERRUPT;

        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = m_PEntity->id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation = m_PSkill->getID();

        if (m_PSkill->isTpSkill())
        {
            auto tp = m_PEntity->health.tp;

            // Lose 1/3 TP when interrupted
            m_PEntity->setTP((tp * 2) / 3);
        }

        m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_STATE_INTERRUPTED", m_PEntity, m_PSkill->getID());
        m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE, new CActionPacket(action));
    }
}

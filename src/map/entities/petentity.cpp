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

#include <string.h>

#include "petentity.h"
#include "../mob_spell_container.h"
#include "../mob_spell_list.h"
#include "../packets/entity_update.h"
#include "../packets/pet_sync.h"
#include "../packets/mob_extdata.h"
#include "../ai/ai_container.h"
#include "../ai/controllers/pet_controller.h"
#include "../ai/helpers/pathfind.h"
#include "../ai/helpers/targetfind.h"
#include "../ai/states/ability_state.h"
#include "../ai/states/mobskill_state.h"
#include "../utils/battleutils.h"
#include "../utils/petutils.h"
#include "../utils/mobutils.h"
#include "../../common/utils.h"
#include "../mob_modifier.h"
#include "../status_effect_container.h"

CPetEntity::CPetEntity(PETTYPE petType)
: CMobEntity()
, m_PetID(0)
, m_PetType(petType)
, m_spawnLevel(0)
, m_jugSpawnTime(time_point::min())
, m_jugDuration(duration::min())
{
	objtype = TYPE_PET;
	m_EcoSystem = SYSTEM_UNCLASSIFIED;
	allegiance = ALLEGIANCE_PLAYER;
    spawnAnimation = SPAWN_ANIMATION::SPECIAL; // Initial spawn has the special spawn-in animation
    m_IsClaimable = false;
    m_MobSkillList = 0;
    m_HasSpellScript = 0;
    namevis = 0;

    PAI = std::make_unique<CAIContainer>(this, std::make_unique<CPathFind>(this), std::make_unique<CPetController>(this),
        std::make_unique<CTargetFind>(this));
}

CPetEntity::~CPetEntity()
{
}

PETTYPE CPetEntity::getPetType()
{
    return m_PetType;
}

uint8 CPetEntity::getSpawnLevel()
{
    return m_spawnLevel;
}

void CPetEntity::setSpawnLevel(uint8 level)
{
    m_spawnLevel = level;
}

bool CPetEntity::isBstPet()
{
  return getPetType() == PETTYPE_JUG_PET || objtype == TYPE_MOB;
}

bool CPetEntity::isAvatar()
{
    switch (m_PetID)
    {
        case PETID_FIRESPIRIT:
        case PETID_ICESPIRIT:
        case PETID_AIRSPIRIT:
        case PETID_EARTHSPIRIT:
        case PETID_THUNDERSPIRIT:
        case PETID_WATERSPIRIT:
        case PETID_LIGHTSPIRIT:
        case PETID_DARKSPIRIT:
        case PETID_CARBUNCLE:
        case PETID_FENRIR:
        case PETID_IFRIT:
        case PETID_TITAN:
        case PETID_LEVIATHAN:
        case PETID_GARUDA:
        case PETID_SHIVA:
        case PETID_RAMUH:
        case PETID_DIABOLOS:
        case PETID_ALEXANDER:
        case PETID_ODIN:
        case PETID_ATOMOS:
        case PETID_CAIT_SITH:
        case PETID_SIREN:
            return true;
    }

    return false;
}

int32 CPetEntity::getJugSpawnTime()
{
  TPZ_DEBUG_BREAK_IF(m_PetType != PETTYPE_JUG_PET)

  const auto epoch = m_jugSpawnTime.time_since_epoch();
  return static_cast<int32>(std::chrono::duration_cast<std::chrono::seconds>(epoch).count());
}

void CPetEntity::setJugSpawnTime(int32 spawnTime)
{
  TPZ_DEBUG_BREAK_IF(m_PetType != PETTYPE_JUG_PET);

  m_jugSpawnTime = std::chrono::system_clock::time_point(std::chrono::duration<int>(spawnTime));
}

int32 CPetEntity::getJugDuration()
{
  TPZ_DEBUG_BREAK_IF(m_PetType != PETTYPE_JUG_PET);

  return static_cast<int32>(std::chrono::duration_cast<std::chrono::seconds>(m_jugDuration).count());
}

void CPetEntity::setJugDuration(int32 seconds)
{
  TPZ_DEBUG_BREAK_IF(m_PetType != PETTYPE_JUG_PET);

  m_jugDuration = std::chrono::seconds(seconds);
}

std::string CPetEntity::GetScriptName()
{
    switch (getPetType())
    {
        case PETTYPE_AVATAR:
            return "avatar";
            break;
        case PETTYPE_WYVERN:
            return "wyvern";
            break;
        case PETTYPE_JUG_PET:
            return "jug";
            break;
        case PETTYPE_CHARMED_MOB:
            return "charmed";
            break;
        case PETTYPE_AUTOMATON:
            return "automaton";
            break;
        case PETTYPE_ADVENTURING_FELLOW:
            return "fellow";
            break;
        case PETTYPE_CHOCOBO:
            return "chocobo";
            break;
        case PETTYPE_LUOPAN:
            return "luopan";
            break;
        default:
            return "";
            break;
    }
}

WYVERNTYPE CPetEntity::getWyvernType()
{
  TPZ_DEBUG_BREAK_IF(PMaster == nullptr);

  switch(PMaster->GetSJob())
  {
    case JOB_BLM:
    case JOB_BLU:
    case JOB_SMN:
    case JOB_WHM:
    case JOB_RDM:
    case JOB_SCH:
    case JOB_GEO:
      return WYVERNTYPE_DEFENSIVE;
    case JOB_DRK:
    case JOB_PLD:
    case JOB_NIN:
    case JOB_BRD:
    case JOB_RUN:
      return WYVERNTYPE_MULTIPURPOSE;
    case JOB_WAR:
    case JOB_SAM:
    case JOB_THF:
    case JOB_BST:
    case JOB_RNG:
    case JOB_COR:
    case JOB_DNC:
      return WYVERNTYPE_OFFENSIVE;

    default:
      return WYVERNTYPE_OFFENSIVE;
  };
}

void CPetEntity::PostTick()
{
    CBattleEntity::PostTick();
    if (loc.zone && status != STATUS_DISAPPEAR)
    {
        if (updatemask)
        {
            loc.zone->PushPacket(this, CHAR_INRANGE, new CEntityUpdatePacket(this, ENTITY_UPDATE, updatemask));

            if (PMaster && PMaster->PPet == this)
            {
                ((CCharEntity*)PMaster)->pushPacket(new CPetSyncPacket((CCharEntity*)PMaster));
            }

            updatemask = 0;
        }

        if (extDataUpdateFlag)
        {
            // Send update packet for custom data..
            loc.zone->PushPacket(this, CHAR_INRANGE, new CMobExtDataPacket(this));

            // Clear flag..
            extDataUpdateFlag = false;
        }
    }
}

void CPetEntity::FadeOut()
{
    CMobEntity::FadeOut();
    loc.zone->UpdateEntityPacket(this, ENTITY_DESPAWN, UPDATE_NONE);
}

void CPetEntity::Die()
{
    PAI->ClearStateStack();
    // master is zoning, don't go to death state, instead despawn instantly
    if (health.hp > 0 && PMaster && PMaster->objtype == TYPE_PC && static_cast<CCharEntity*>(PMaster)->petZoningInfo.respawnPet)
    {
        PAI->Internal_Despawn();
    }
    else
    {
        PAI->Internal_Die(0s);
    }
    m_unkillable = false;
    
    if ((PAI != nullptr) && (PAI->GetController() != nullptr))
    {    
        PAI->GetController()->SetAutoAttackEnabled(true);
        PAI->GetController()->SetMagicCastingEnabled(true);
        PAI->GetController()->SetWeaponSkillEnabled(true);
    }
    
    luautils::OnMobDeath(this, nullptr);

    if (PLastAttacker)
    {
        loc.zone->PushPacket(this, CHAR_INRANGE, new CMessageBasicPacket(PLastAttacker, this, 0, 0, MSGBASIC_DEFEATS_TARG));
    }
    else
    {
        loc.zone->PushPacket(this, CHAR_INRANGE, new CMessageBasicPacket(this, this, 0, 0, MSGBASIC_FALLS_TO_GROUND));
    }

    CBattleEntity::Die();
    if (PMaster && PMaster->PPet == this && PMaster->objtype == TYPE_PC)
    {
        petutils::DetachPet(PMaster);
    }
}

void CPetEntity::Spawn()
{
    //we need to skip CMobEntity's spawn because it calculates stats (and our stats are already calculated)
    uint16 elementalRecast = 30 - PMaster->getMod(Mod::ELEMENTAL_MAGIC_COOL);

    if (PMaster && PMaster->objtype == TYPE_PC && m_EcoSystem == SYSTEM_ELEMENTAL)
    {
        this->defaultMobMod(MOBMOD_MAGIC_DELAY, 0);
        this->defaultMobMod(MOBMOD_MAGIC_COOL, elementalRecast);
        mobutils::GetAvailableSpells(this);
    }

    if (m_PetType == PETTYPE_JUG_PET)
    {
        m_jugSpawnTime = server_clock::now();
    }

    if (PMaster && PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_CONFRONTATION))
    {
        CStatusEffect* confrontation = PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_CONFRONTATION);
        int16 power = confrontation->GetPower();
        int32 tick = confrontation->GetTickTime() / 1000;
        int32 duration = confrontation->GetDuration();
        int32 subid = confrontation->GetSubID();
        int32 subPower = confrontation->GetSubPower();
        int32 tier = confrontation->GetTier();
        this->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_CONFRONTATION, EFFECT_CONFRONTATION, power, tick, duration, subid, subPower, tier));
    }

    this->health.tp = 0;
    CBattleEntity::Spawn();
    PAI->EventHandler.triggerListener("SPAWN", this);
    luautils::OnMobSpawn(this);
    // Max [HP/MP] Boost mods
    this->UpdateHealth();
    this->health.hp = this->GetMaxHP();
    this->health.mp = this->GetMaxMP();
}

bool CPetEntity::shouldDespawn(time_point tick)
{
    // This check was moved from the original call site when this method was added.
    // It is in theory not needed, but we are not removing it without further testing.
    // TODO: Consider removing this when possible.
    if (isCharmed && tick > charmTime)
    {
        return true;
    }

    if (PMaster != nullptr && PAI->IsSpawned() && m_PetType == PETTYPE_JUG_PET && tick > m_jugSpawnTime + m_jugDuration)
    {
        return true;
    }

    return false;
}

void CPetEntity::loadPetZoningInfo()
{
    if (!PAI->IsSpawned())
    {
        ShowWarning("Attempt to load info without Pet spawned.");
        return;
    }

    if (auto* master = dynamic_cast<CCharEntity*>(PMaster))
    {
        health.tp = static_cast<uint16>(master->petZoningInfo.petTP);
        health.hp = master->petZoningInfo.petHP;
        health.mp = master->petZoningInfo.petMP;

        if (m_PetType == PETTYPE_JUG_PET)
        {
            setJugDuration(master->petZoningInfo.jugDuration);
            setJugSpawnTime(master->petZoningInfo.jugSpawnTime);
        }
    }
}

// Pet JA's/skills (i.e. avatar blood pacts) are handled in CMobEntity::OnMobSkillFinished
void CPetEntity::OnAbility(CAbilityState& state, action_t& action)
{
    auto PAbility = state.GetAbility();
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    std::unique_ptr<CBasicPacket> errMsg;
    if (PTarget && IsValidTarget(PTarget->targid, PAbility->getValidTarget(), errMsg))
    {
        if (this != PTarget && distance(this->loc.p, PTarget->loc.p) > PAbility->getRange())
        {
            return;
        }

        // Currently, only the Wyvern uses abilities at all as of writing, but their abilities are not instant and are mob abilities.
        // Abilities are not subject to paralyze if they have non-zero cast time due to this corner case.
        if (state.GetAbility()->getCastTime() == 0s && battleutils::IsParalyzed(this))
        {
            setActionInterrupted(action, PTarget, MSGBASIC_IS_PARALYZED_2, 0);
            return;
        }

        action.id = this->id;
        action.actiontype = PAbility->getActionType();
        action.actionid = PAbility->getID();
        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = PTarget->id;
        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.reaction = REACTION_NONE;
        actionTarget.speceffect = SPECEFFECT_RECOIL;
        actionTarget.animation = PAbility->getAnimationID();
        actionTarget.param = 0;
        auto prevMsg = actionTarget.messageID;

        int32 value = luautils::OnUseAbility(this, PTarget, PAbility, &action);
        if (prevMsg == actionTarget.messageID) actionTarget.messageID = PAbility->getMessage();
        if (actionTarget.messageID == 0) actionTarget.messageID = MSGBASIC_USES_JA;
        actionTarget.param = value;

        if (value < 0)
        {
            actionTarget.messageID = ability::GetAbsorbMessage(actionTarget.messageID);
            actionTarget.param = -value;
        }
    }
    else // Can't target anything, just cancel the animation.
    {
        action.actiontype = ACTION_MOBABILITY_INTERRUPT;
        action.actionid = 28787; // Some hardcoded magic for interrupts
        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation = 0x1FC;
        actionTarget.messageID = 0;
        actionTarget.reaction = REACTION_ABILITY_HIT;
    }
}

void CPetEntity::OnPlayerPetSkillFinished(CMobSkillState& state, action_t& action)
{
    auto PSkill = ability::GetAbility(this->m_bloodPactAbilityId);
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    int16 tp = state.GetSpentTP();
    tp = battleutils::CalculateWeaponSkillTP(this, 0, tp);

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();

    PAI->TargetFind->reset();

    float distance = PSkill->getRange();
    uint8 findFlags = 0;

    // Buff abilities also hit pets
    if (PSkill->getValidTarget() == TARGET_SELF)
    {
        findFlags |= FINDFLAGS_PET;
    }

    if (PSkill->getValidTarget() & TARGET_PLAYER_DEAD)
    {
        findFlags |= FINDFLAGS_DEAD;
    }

    action.id = id;
    action.actiontype = ACTION_PET_MOBABILITY_FINISH;
    action.actionid = PSkill->getID();

    if (PTarget && PAI->TargetFind->isWithinRange(&PTarget->loc.p, distance))
    {
        if (PSkill->isAoE())
        {
            PAI->TargetFind->findWithinArea(PTarget, (AOERADIUS)PSkill->getAOE(), PSkill->getRange(), findFlags, PSkill->getValidTarget());
        }
        else if (PSkill->isConal())
        {
            float angle = 45.0f;
            PAI->TargetFind->findWithinCone(PTarget, distance, angle, findFlags, false, PSkill->getValidTarget());
        }
        else
        {
            PAI->TargetFind->findSingleTarget(PTarget, findFlags);
        }
    }
    else // Out of range
    {
        if (PTarget)
        {
            action.actiontype = ACTION_MOBABILITY_INTERRUPT;
            action.actionid = 0;
            actionList_t& actionList = action.getNewActionList();
            actionList.ActionTargetID = PTarget->id;
            actionTarget_t& actionTarget = actionList.getNewActionTarget();
            actionTarget.animation = 0x1FC; // Hardcoded magic sent from the server
            if (PTarget->isAlive())
            {
                actionTarget.messageID = MSGBASIC_TOO_FAR_AWAY;
            }
            else
            {
                actionTarget.messageID = 0;
            }

            actionTarget.speceffect = SPECEFFECT_BLOOD;
            this->PAI->EventHandler.triggerListener("WEAPONSKILL_STATE_INTERRUPTED", this, PSkill->getID());
            return;
        }
    }

    uint16 targets = static_cast<uint16>(PAI->TargetFind->m_targets.size());
    // No targets, perhaps something like Super Jump or otherwise untargetable
    if (targets == 0)
    {
        action.actiontype = ACTION_MOBABILITY_INTERRUPT;
        action.actionid = 28787; // Some hardcoded magic for interrupts
        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = id;
        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation = 0x1FC; // Hardcoded magic sent from the server
        actionTarget.messageID = 0;
        actionTarget.reaction = REACTION_ABILITY_HIT;
        return;
    }

    PSkill->setTotalTargets(targets);
    PSkill->setPrimaryTargetID(PTarget->id);

    uint16 msg = 0;
    uint16 defaultMessage = PSkill->getMessage();

    bool first{ true };
    for (auto&& PTarget : PAI->TargetFind->m_targets)
    {
        actionList_t& list = action.getNewActionList();

        list.ActionTargetID = PTarget->id;

        actionTarget_t& target = list.getNewActionTarget();

        list.ActionTargetID = PTarget->id;
        target.reaction = REACTION_HIT;
        target.speceffect = SPECEFFECT_HIT;
        target.animation = PSkill->getAnimationID();
        target.messageID = PSkill->getMessage();

        // reset the skill's message back to default
        PSkill->setMessage(defaultMessage);

        if (PTarget->isSuperJumped)
        {
            target.reaction = REACTION_EVADE;
            target.speceffect = SPECEFFECT_NONE;
            target.messageID = 188; // skill miss
            continue;
        }

        // Handle Level ? Holy (Cait Sith)
        if (PSkill->getID() == ABILITY_LEVEL_QUESTION_HOLY)
        {
            auto diceRoll = tpzrand::GetRandomNumber(6);
            this->SetLocalVar("Level?HolyRoll", diceRoll);
            target.animation = PSkill->getAnimationID() + diceRoll;
        }

        target.param = luautils::OnPetAbility(PTarget, this, PSkill, PMaster, &action);
        if (msg == 0)
        {
            msg = PSkill->getMessage();
        }
        else
        {
            msg = PSkill->getAoEMsg();
        }

        target.messageID = msg;

        if (PSkill->hasMissMsg())
        {
            target.reaction = REACTION_MISS;
            target.speceffect = SPECEFFECT_NONE;
            if (msg == PSkill->getAoEMsg())
                msg = 282;
        }
        else
        {
            target.reaction = REACTION_HIT;

            static const std::unordered_set<uint16> excludedMsgs{
                MSGBASIC_JA_RECOVERS_HP,
                MSGBASIC_JA_ENFEEB_IS,
                MSGBASIC_JA_GAINS_EFFFECT,
                MSGBASIC_JA_NO_EFFECT_2
            };
            // Don't add TP if the TP move is a two hour, buff, heal, or enfeeble.
            if (excludedMsgs.find(msg) == excludedMsgs.end() && !PSkill->isTwoHour() && !PSkill->isMagicAttack())
            {
                int32 delay = this->GetWeaponDelay(true);
                float ratio = 1.0f;
                int16 baseTp = 0;
                baseTp = battleutils::CalculateBaseTP((int32)(delay * 60.0f / 1000.0f / ratio));
                if (PTarget->id == PSkill->getPrimaryTargetID())
                    this->addTP((int16)(1 * (baseTp * (1.0f + 0.01f * (float)((this->getMod(Mod::STORETP)))))));
            }
        }

        if (target.speceffect & SPECEFFECT_HIT)
        {
            target.speceffect = SPECEFFECT_RECOIL;
            if (first && (PSkill->getPrimarySkillchain() != 0) && PTarget->isAlive() && !PSkill->hasMissMsg())
            {
                // Only Humanoid mobs, jug pets, and charmed mobs can skillchain
                if (IsHumanoid() || objtype == TYPE_PET || isCharmed)
                {
                    if (PSkill->getPrimarySkillchain())
                    {
                        SUBEFFECT effect = battleutils::GetSkillChainEffect(PTarget, PSkill->getPrimarySkillchain(), PSkill->getSecondarySkillchain(),
                                                                            PSkill->getTertiarySkillchain());
                        if (effect != SUBEFFECT_NONE)
                        {
                            // Apply Inundation weapon skill type tracking
                            if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_INUNDATION))
                            {
                                CStatusEffect* PEffect = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_INUNDATION, 0);
                                auto power = PEffect->GetPower();
                                auto currentFlag = WEAPONTYPE_PET;
                                auto subPower = PEffect->GetSubPower();
                                if ((subPower & currentFlag) == 0)
                                {
                                    PEffect->SetPower(power + 1);
                                    PEffect->SetSubPower(subPower | currentFlag);
                                }
                            }

                            int32 skillChainDamage = battleutils::TakeSkillchainDamage(this, PTarget, target.param, nullptr);
                            if (skillChainDamage < 0)
                            {
                                target.addEffectParam = -skillChainDamage;
                                target.addEffectMessage = 384 + effect;
                            }
                            else
                            {
                                target.addEffectParam = skillChainDamage;
                                target.addEffectMessage = 287 + effect;
                            }
                            target.additionalEffect = effect;
                        }
                        else if (effect == SUBEFFECT_NONE)
                        {
                            // Reset Inundation weapon skill type tracking
                            if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_INUNDATION))
                            {
                                CStatusEffect* PEffect = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_INUNDATION, 0);
                                auto currentFlag = WEAPONTYPE_PET;
                                PEffect->SetPower(0);
                                PEffect->SetSubPower(currentFlag);
                            }
                        }
                    }
                    first = false;
                }
            }
        }

        if (PTarget->isDead())
        {
            battleutils::ClaimMob(PTarget, this);
        }

        if (PTarget->isDead() && PTarget->objtype == TYPE_MOB && this->objtype == TYPE_PET && this->PMaster->objtype == TYPE_PC)
        {
            ((CMobEntity*)PTarget)->m_autoTargetKiller = ((CCharEntity*)PMaster);
            ((CMobEntity*)PTarget)->DoAutoTarget();
        }
    }

    PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    if (PTarget->objtype == TYPE_MOB && (PTarget->isDead() || (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() == PETTYPE_AVATAR)))
    {
        battleutils::ClaimMob(PTarget, this);
    }
    battleutils::DirtyExp(PTarget, this);
}

bool CPetEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    if (targetFlags & TARGET_PLAYER && PInitiator->allegiance == allegiance)
    {
        return false;
    }
    return CMobEntity::ValidTarget(PInitiator, targetFlags);
}

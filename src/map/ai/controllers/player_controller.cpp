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

#include "player_controller.h"

#include "../ai_container.h"
#include "../states/death_state.h"
#include "../../ability.h"
#include "../../entities/charentity.h"
#include "../../items/item_weapon.h"
#include "../../packets/char_update.h"
#include "../../packets/lock_on.h"
#include "../../packets/inventory_finish.h"
#include "../../packets/char_recast.h"
#include "../../utils/battleutils.h"
#include "../../utils/charutils.h"
#include "../../recast_container.h"
#include "../../latent_effect_container.h"
#include "../../status_effect_container.h"
#include "../../weapon_skill.h"
#include "../../roe.h"

CPlayerController::CPlayerController(CCharEntity* _PChar) :
    CController(_PChar)
{
}

void CPlayerController::Tick(time_point)
{}

bool CPlayerController::Cast(uint16 targid, SpellID spellid)
{
    auto PChar = static_cast<CCharEntity*>(POwner);
    if (!PChar->PRecastContainer->HasRecast(RECAST_MAGIC, static_cast<uint16>(spellid), 0))
    {
        return CController::Cast(targid, spellid);
    }
    else
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_CAST));
        return false;
    }
}

bool CPlayerController::Engage(uint16 targid)
{
    //#TODO: pet engage/disengage
    std::unique_ptr<CBasicPacket> errMsg;
    auto PChar = static_cast<CCharEntity*>(POwner);
    auto PTarget = PChar->IsValidTarget(targid, TARGET_ENEMY, errMsg);

    if (PTarget)
    {
        if (distance(PChar->loc.p, PTarget->loc.p) < 30)
        {
            if (m_lastAttackTime + std::chrono::milliseconds(PChar->GetWeaponDelay(false)) < server_clock::now())
            {
                if (CController::Engage(targid))
                {
                    PChar->PLatentEffectContainer->CheckLatentsWeaponDraw(true);
                    PChar->pushPacket(new CLockOnPacket(PChar, PTarget));
                    return true;
                }
            }
            else
            {
                errMsg = std::make_unique<CMessageBasicPacket>(PChar, PTarget, 0, 0, MSGBASIC_WAIT_LONGER);
            }
        }
        else
        {
            errMsg = std::make_unique<CMessageBasicPacket>(PChar, PTarget, 0, 0, MSGBASIC_TOO_FAR_AWAY);
        }
    }
    if (errMsg)
    {
        PChar->HandleErrorMessage(errMsg);
    }
    return false;
}

bool CPlayerController::ChangeTarget(uint16 targid)
{
    return CController::ChangeTarget(targid);
}

bool CPlayerController::Disengage()
{
    return CController::Disengage();
}

bool CPlayerController::Ability(uint16 targid, uint16 abilityid)
{
    auto PChar = static_cast<CCharEntity*>(POwner);
    auto playerTP = PChar->health.tp;

    if (PChar->PAI->CanChangeState())
    {
        CAbility* PAbility = ability::GetAbility(abilityid);
        if (!PAbility)
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
            return false;
        }
        if (PChar->PRecastContainer->HasRecast(RECAST_ABILITY, PAbility->getRecastId(), PAbility->getRecastTime()))
        {
            Recast_t* recast = PChar->PRecastContainer->GetRecast(RECAST_ABILITY, PAbility->getRecastId());
            // Set recast time in seconds to the normal recast time minus any charge time with the difference of the current time minus when the recast was set.
            // Abilities without a charge will have zero chargeTime
            uint32 recastSeconds = std::clamp<uint32>(recast->RecastTime - recast->chargeTime - ((uint32)time(nullptr) - recast->TimeStamp), 1, 99999);

            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA2));
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, recastSeconds, 0, MSGBASIC_TIME_LEFT));
            return false;
        }

        // Cannot use JA's while under the effect of Amnesia unless Mana Wall
        if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_AMNESIA) && abilityid != ABILITY_MANA_WALL)
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA2));
            return false;
        }
        if (PChar->StatusEffectContainer->HasStatusEffect({ EFFECT_AMNESIA, EFFECT_IMPAIRMENT }) && abilityid != ABILITY_MANA_WALL ||
            (!PAbility->isPetAbility() && !charutils::hasAbility(PChar, PAbility->getID())) ||
            (PAbility->isPetAbility() && !charutils::hasPetAbility(PChar, PAbility->getID() - ABILITY_HEALING_RUBY)))
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA2));
            return false;
        }
        if (PAbility->isPetAbility())
        {
            CBattleEntity* PPet = ((CBattleEntity*)PChar)->PPet;
            // Not enough time since last pet ability was used
            if (server_clock::now() < PChar->m_petAbilityWait)
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_PET_CANNOT_DO_ACTION));
                return false;
            }
            // Pet is unable to use pet abilities due to Amnesia or hard CC
            if (PPet->StatusEffectContainer->HasPreventActionEffect(false))
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_PET_CANNOT_DO_ACTION));
                return false;
            }
            // Make sure pet is engaged when trying to use ready moves
            if (PAbility->isReadyMove())
            {
                CBattleEntity* PPet = ((CBattleEntity*)PChar)->PPet;
                if (!PPet->PAI->IsEngaged())
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_PERFORM_ACTION));
                    return false;
                }
            }
            if (PAbility->isPetAbility())
            {
                // Blood pact MP costs are stored under animation ID
                if (PChar->health.mp < PAbility->getAnimationID())
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
                    return false;
                }
            }
        }

        // Check for TP costing JA's
        int16 tpCost = PAbility->getTPCost();
        if (PAbility->isWaltz())
        {
            tpCost -= PChar->getMod(Mod::WALTZ_COST);
        }

        if (PAbility->isStep())
        {
            tpCost -= PChar->getMod(Mod::STEP_COST);
        }

        if (playerTP < tpCost && !PChar->StatusEffectContainer->HasStatusEffect(EFFECT_TRANCE))
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_NOT_ENOUGH_TP));
            return false;
        }

        // Check for finishing moves
        if (PAbility->isFlourish())
        {
            if (!PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_FINISHING_MOVE))
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_NO_FINISHINGMOVES));
                return false;
            }
        }

        // Check for paraylze
        if (battleutils::IsParalyzed(PChar))
        {
            // 2 hours can be paraylzed but it won't reset their timers
            if (PAbility->getRecastId() != ABILITYRECAST_TWO_HOUR && PAbility->getRecastId() != ABILITYRECAST_TWO_HOUR_TWO)
            {
                PChar->PRecastContainer->Add(RECAST_ABILITY, PAbility->getRecastId(), PAbility->getRecastTime());
            }
            PChar->pushPacket(new CCharRecastPacket(PChar));
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_IS_PARALYZED));
            return false;
        }
        return PChar->PAI->Internal_Ability(targid, abilityid); // Adds delay to next weapon swing timer
    }
    else
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
        return false;
    }
}

bool CPlayerController::RangedAttack(uint16 targid)
{
    auto PChar = static_cast<CCharEntity*>(POwner);
    if (PChar->PAI->CanChangeState())
    {
        return PChar->PAI->Internal_RangedAttack(targid);
    }
    else
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_WAIT_LONGER));
    }
    return false;
}

bool CPlayerController::UseItem(uint16 targid, uint8 loc, uint8 slotid)
{
    auto PChar = static_cast<CCharEntity*>(POwner);
    if (PChar->PAI->CanChangeState())
    {
        if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_MUDDLE))
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_ITEM_CANNOT_USE));
            return false;
        }
        return PChar->PAI->Internal_UseItem(targid, loc, slotid);
    }
    return false;
}

bool CPlayerController::WeaponSkill(uint16 targid, uint16 wsid)
{
    auto PChar = static_cast<CCharEntity*>(POwner);
    if (PChar->PAI->CanChangeState())
    {
        //#TODO: put all this in weaponskill_state
        CWeaponSkill* PWeaponSkill = battleutils::GetWeaponSkill(wsid);

        if (PWeaponSkill && !charutils::hasWeaponSkill(PChar, PWeaponSkill->getID()))
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_WS));
            return false;
        }
        if (PChar->StatusEffectContainer->HasStatusEffect({EFFECT_AMNESIA, EFFECT_IMPAIRMENT}))
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_ANY_WS));
            return false;
        }
        if (PChar->health.tp < 1000)
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_NOT_ENOUGH_TP));
            return false;
        }
        if (PWeaponSkill->getType() == SKILL_ARCHERY || PWeaponSkill->getType() == SKILL_MARKSMANSHIP)
        {
            auto PItem = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO));
            auto weapon = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_RANGED]);
            auto ammo = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_AMMO]);

            // before allowing ranged weapon skill...
            if (PItem == nullptr ||
                !weapon || !weapon->isRanged() ||
                !ammo || !ammo->isRanged() ||
                PChar->equip[SLOT_AMMO] == 0)
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_NO_RANGED_WEAPON));
                return false;
            }
        }

        std::unique_ptr<CBasicPacket> errMsg;
        auto PTarget = PChar->IsValidTarget(targid, battleutils::isValidSelfTargetWeaponskill(wsid) ? TARGET_SELF : TARGET_ENEMY, errMsg);

        if (PTarget)
        {
            if (!facing(PChar->loc.p, PTarget->loc.p, 64) && PTarget != PChar)
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PTarget, 0, 0, MSGBASIC_CANNOT_SEE));
                return false;
            }
            roeutils::event(ROE_WSKILL_USE, PChar, RoeDatagramList{});

            m_lastWeaponSkill = PWeaponSkill;

            return CController::WeaponSkill(targid, wsid);
        }
        else if (errMsg)
        {
            PChar->pushPacket(std::move(errMsg));
        }
    }
    else
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_WS));
    }
    return false;
}

time_point CPlayerController::getLastAttackTime()
{
    return m_lastAttackTime;
}


void CPlayerController::setLastAttackTime(time_point _lastAttackTime)
{
    m_lastAttackTime = _lastAttackTime;
}

time_point CPlayerController::getLastRangedAttackTime()
{
    return m_lastRangedAttackTime;
}

void CPlayerController::setLastRangedAttackTime(time_point _lastRangedAttackTime)
{
    m_lastRangedAttackTime = _lastRangedAttackTime;
}

void CPlayerController::setLastErrMsgTime(time_point _LastErrMsgTime)
{
    m_errMsgTime = _LastErrMsgTime;
}

time_point CPlayerController::getLastErrMsgTime()
{
    return m_errMsgTime;
}

CWeaponSkill* CPlayerController::getLastWeaponSkill()
{
    return m_lastWeaponSkill;
}

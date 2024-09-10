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
#include "../../utils/petutils.h"

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
            if (PAbility->isReadyMove())
            {
                PAbility = ability::GetAbility(ABILITY_SIC);
                recast = PChar->PRecastContainer->GetRecast(RECAST_ABILITY, PAbility->getRecastId());
            }

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
        if (PAbility->isPetAbility() || PAbility->isPetCommand())
        {
            CBattleEntity* PPet = ((CBattleEntity*)PChar)->PPet;
            // Not enough time since last pet ability was used
            if (server_clock::now() < PChar->m_petAbilityWait)
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_PET_CANNOT_DO_ACTION));
                return false;
            }
            // Pet is unable to use pet abilities due to Amnesia or hard CC
            if (PPet)
            {
                if (PPet->StatusEffectContainer->HasPreventActionEffect(false) ||
                    PPet->StatusEffectContainer->HasStatusEffect({ EFFECT_AMNESIA, EFFECT_IMPAIRMENT }))
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

    std::map<int, EFFECT> abilityToEffectMap = { { ABILITY_DIFFUSION, EFFECT_DIFFUSION },
                                                     { ABILITY_ACCESSION, EFFECT_ACCESSION },
                                                     { ABILITY_ADDENDUM_BLACK, EFFECT_ADDENDUM_BLACK },
                                                     { ABILITY_ADDENDUM_WHITE, EFFECT_ADDENDUM_WHITE },
                                                     { ABILITY_ALACRITY, EFFECT_ALACRITY },
                                                     { ABILITY_ALTRUISM, EFFECT_ALTRUISM },
                                                     { ABILITY_APOGEE, EFFECT_APOGEE },
                                                     { ABILITY_CELERITY, EFFECT_CELERITY },
                                                     { ABILITY_DARK_ARTS, EFFECT_DARK_ARTS },
                                                     { ABILITY_EBULLIENCE, EFFECT_EBULLIENCE },
                                                     { ABILITY_ENLIGHTENMENT, EFFECT_ENLIGHTENMENT },
                                                     { ABILITY_EQUANIMITY, EFFECT_EQUANIMITY },
                                                     { ABILITY_FOCALIZATION, EFFECT_FOCALIZATION },
                                                     { ABILITY_LIGHT_ARTS, EFFECT_LIGHT_ARTS },
                                                     { ABILITY_MANIFESTATION, EFFECT_MANIFESTATION },
                                                     { ABILITY_PARSIMONY, EFFECT_PARSIMONY },
                                                     { ABILITY_PENURY, EFFECT_PENURY },
                                                     { ABILITY_PERPETUANCE, EFFECT_PERPETUANCE },
                                                     { ABILITY_RAPTURE, EFFECT_RAPTURE },
                                                     { ABILITY_TRANQUILITY, EFFECT_TRANQUILITY } };

        // JA error checks (Checking in LUA will cause delay to be added to your auto-attacks on an error)
        switch (PAbility->getID())
        {
            // Quick Draw
            case ABILITY_FIRE_SHOT:
            case ABILITY_ICE_SHOT:
            case ABILITY_WIND_SHOT:
            case ABILITY_EARTH_SHOT:
            case ABILITY_THUNDER_SHOT:
            case ABILITY_WATER_SHOT:
            case ABILITY_LIGHT_SHOT:
            case ABILITY_DARK_SHOT:
            {
                uint16 elementCardID = 0;

                switch (PAbility->getID())
                {
                    case ABILITY_FIRE_SHOT:
                        elementCardID = 2176;
                        break; // Fire Card ID
                    case ABILITY_ICE_SHOT:
                        elementCardID = 2177;
                        break; // Ice Card ID
                    case ABILITY_WIND_SHOT:
                        elementCardID = 2178;
                        break; // Wind Card ID
                    case ABILITY_EARTH_SHOT:
                        elementCardID = 2179;
                        break; // Earth Card ID
                    case ABILITY_THUNDER_SHOT:
                        elementCardID = 2180;
                        break; // Thunder Card ID
                    case ABILITY_WATER_SHOT:
                        elementCardID = 2181;
                        break; // Water Card ID
                    case ABILITY_LIGHT_SHOT:
                        elementCardID = 2182;
                        break; // Light Card ID
                    case ABILITY_DARK_SHOT:
                        elementCardID = 2183;
                        break; // Dark Card ID
                }

                bool hasElementCard = (PChar->getStorage(LOC_INVENTORY)->SearchItem(elementCardID) != ERROR_SLOTID);
                bool hasTrumpCard = (PChar->getStorage(LOC_INVENTORY)->SearchItem(2974) != ERROR_SLOTID); // Trump Card ID

                if (!hasElementCard && !hasTrumpCard)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_PERFORM_ACTION));
                    return false;
                }

                auto PItem = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO));
                auto weapon = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_RANGED]);
                auto ammo = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_AMMO]);

                if (PItem == nullptr || !weapon || weapon->getSkillType() != SKILL_MARKSMANSHIP ||
                    !ammo || ammo->getSkillType() != SKILL_MARKSMANSHIP ||
                    PChar->equip[SLOT_AMMO] == 0)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_NO_RANGED_WEAPON));
                    return false;
                }
                break;
            }

            // COR rolls
            case ABILITY_FIGHTERS_ROLL:
            case ABILITY_MONKS_ROLL:
            case ABILITY_HEALERS_ROLL:
            case ABILITY_WIZARDS_ROLL:
            case ABILITY_WARLOCKS_ROLL:
            case ABILITY_ROGUES_ROLL:
            case ABILITY_GALLANTS_ROLL:
            case ABILITY_CHAOS_ROLL:
            case ABILITY_BEAST_ROLL:
            case ABILITY_CHORAL_ROLL:
            case ABILITY_HUNTERS_ROLL:
            case ABILITY_SAMURAI_ROLL:
            case ABILITY_NINJA_ROLL:
            case ABILITY_DRACHEN_ROLL:
            case ABILITY_EVOKERS_ROLL:
            case ABILITY_MAGUSS_ROLL:
            case ABILITY_CORSAIRS_ROLL:
            case ABILITY_PUPPET_ROLL:
            case ABILITY_DANCERS_ROLL:
            case ABILITY_SCHOLARS_ROLL:
            case ABILITY_BOLTERS_ROLL:
            case ABILITY_CASTERS_ROLL:
            case ABILITY_COURSERS_ROLL:
            case ABILITY_BLITZERS_ROLL:
            case ABILITY_TACTICIANS_ROLL:
            case ABILITY_ALLIES_ROLL:
            case ABILITY_MISERS_ROLL:
            case ABILITY_COMPANIONS_ROLL:
            case ABILITY_AVENGERS_ROLL:
            case ABILITY_NATURALISTS_ROLL:
            case ABILITY_RUNEISTS_ROLL:
            {
                // Check if the player has the status effect for the roll
                EFFECT rollEffect = EFFECT_KO;

                switch (PAbility->getID())
                {
                    case ABILITY_FIGHTERS_ROLL:
                        rollEffect = EFFECT_FIGHTERS_ROLL;
                        break;
                    case ABILITY_MONKS_ROLL:
                        rollEffect = EFFECT_MONKS_ROLL;
                        break;
                    case ABILITY_HEALERS_ROLL:
                        rollEffect = EFFECT_HEALERS_ROLL;
                        break;
                    case ABILITY_WIZARDS_ROLL:
                        rollEffect = EFFECT_WIZARDS_ROLL;
                        break;
                    case ABILITY_WARLOCKS_ROLL:
                        rollEffect = EFFECT_WARLOCKS_ROLL;
                        break;
                    case ABILITY_ROGUES_ROLL:
                        rollEffect = EFFECT_ROGUES_ROLL;
                        break;
                    case ABILITY_GALLANTS_ROLL:
                        rollEffect = EFFECT_GALLANTS_ROLL;
                        break;
                    case ABILITY_CHAOS_ROLL:
                        rollEffect = EFFECT_CHAOS_ROLL;
                        break;
                    case ABILITY_BEAST_ROLL:
                        rollEffect = EFFECT_BEAST_ROLL;
                        break;
                    case ABILITY_CHORAL_ROLL:
                        rollEffect = EFFECT_CHORAL_ROLL;
                        break;
                    case ABILITY_HUNTERS_ROLL:
                        rollEffect = EFFECT_HUNTERS_ROLL;
                        break;
                    case ABILITY_SAMURAI_ROLL:
                        rollEffect = EFFECT_SAMURAI_ROLL;
                        break;
                    case ABILITY_NINJA_ROLL:
                        rollEffect = EFFECT_NINJA_ROLL;
                        break;
                    case ABILITY_DRACHEN_ROLL:
                        rollEffect = EFFECT_DRACHEN_ROLL;
                        break;
                    case ABILITY_EVOKERS_ROLL:
                        rollEffect = EFFECT_EVOKERS_ROLL;
                        break;
                    case ABILITY_MAGUSS_ROLL:
                        rollEffect = EFFECT_MAGUSS_ROLL;
                        break;
                    case ABILITY_CORSAIRS_ROLL:
                        rollEffect = EFFECT_CORSAIRS_ROLL;
                        break;
                    case ABILITY_PUPPET_ROLL:
                        rollEffect = EFFECT_PUPPET_ROLL;
                        break;
                    case ABILITY_DANCERS_ROLL:
                        rollEffect = EFFECT_DANCERS_ROLL;
                        break;
                    case ABILITY_SCHOLARS_ROLL:
                        rollEffect = EFFECT_SCHOLARS_ROLL;
                        break;
                    case ABILITY_BOLTERS_ROLL:
                        rollEffect = EFFECT_BOLTERS_ROLL;
                        break;
                    case ABILITY_CASTERS_ROLL:
                        rollEffect = EFFECT_CASTERS_ROLL;
                        break;
                    case ABILITY_COURSERS_ROLL:
                        rollEffect = EFFECT_COURSERS_ROLL;
                        break;
                    case ABILITY_BLITZERS_ROLL:
                        rollEffect = EFFECT_BLITZERS_ROLL;
                        break;
                    case ABILITY_TACTICIANS_ROLL:
                        rollEffect = EFFECT_TACTICIANS_ROLL;
                        break;
                    case ABILITY_ALLIES_ROLL:
                        rollEffect = EFFECT_ALLIES_ROLL;
                        break;
                    case ABILITY_MISERS_ROLL:
                        rollEffect = EFFECT_MISERS_ROLL;
                        break;
                    case ABILITY_COMPANIONS_ROLL:
                        rollEffect = EFFECT_COMPANIONS_ROLL;
                        break;
                    case ABILITY_AVENGERS_ROLL:
                        rollEffect = EFFECT_AVENGERS_ROLL;
                        break;
                    case ABILITY_NATURALISTS_ROLL:
                        rollEffect = EFFECT_NATURALISTS_ROLL;
                        break;
                    case ABILITY_RUNEISTS_ROLL:
                        rollEffect = EFFECT_RUNEISTS_ROLL;
                        break;
                }

                if (rollEffect != EFFECT_KO && PChar->StatusEffectContainer->HasStatusEffect(rollEffect))
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_ROLL_ALREADY_ACTIVE));
                    return false;
                }

                int16 numBusts = PChar->StatusEffectContainer->GetEffectsCount(EFFECT_BUST);
                if (numBusts >= 2 && PChar->GetMJob() == JOB_COR ||
                    numBusts >= 1 && PChar->GetMJob() != JOB_COR)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_PERFORM_ACTION));
                    return false;
                }
                break;
            }

            case ABILITY_DOUBLE_UP:
            {
                if (!PChar->StatusEffectContainer->HasStatusEffect(EFFECT_DOUBLE_UP_CHANCE))
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_NO_ELIGIBLE_ROLL));
                    return false;
                }
            }
            break;

            case ABILITY_FOLD:
            {
                if (!PChar->StatusEffectContainer->HasCorsairEffect(PChar->id))
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_PERFORM_ACTION));
                    return false;
                }
            }
            break;

            case ABILITY_CURING_WALTZ:
            case ABILITY_CURING_WALTZ_II:
            case ABILITY_CURING_WALTZ_III:
            case ABILITY_CURING_WALTZ_IV:
            case ABILITY_HEALING_WALTZ:
            case ABILITY_DIVINE_WALTZ:
            case ABILITY_DIVINE_WALTZ_II:
            case ABILITY_CURING_WALTZ_V:
            {
                // TODO: Might need instance logic? It's in lua utils for GetEntity stuff like DespawnMob
                CBattleEntity* PTarget = (CBattleEntity*)(PChar->GetEntity(targid));
                if (PTarget && PTarget->GetHPP() == 0)
                {
                    // TODO: Not sure why this says "You cannot attack that target", try with // command
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_ON_THAT_TARG));
                    return false;
                }
                else if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SABER_DANCE))
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA2));
                    return false;
                }
                break;
            }

            case ABILITY_WEAPON_BASH:
            case ABILITY_HASSO:
            case ABILITY_SEIGAN:
            case ABILITY_BLADE_BASH:
            {
                auto weapon = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_MAIN]);

                if (weapon == nullptr || !weapon || !weapon->isTwoHanded())
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_NEEDS_2H_WEAPON));
                    return false;
                }
                break;
            }

            case ABILITY_ACTIVATE:
            case ABILITY_DEUX_EX_AUTOMATA:
            case ABILITY_CALL_BEAST:
            case ABILITY_CALL_WYVERN:
            case ABILITY_CHARM:
            {
                if (PChar->PPet != nullptr)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_ALREADY_HAS_A_PET));
                    return false;
                }

                if (!PChar->loc.zone->CanUseMisc(MISC_PET))
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANT_BE_USED_IN_AREA));
                    return false;
                }

                if (PAbility->getID() == ABILITY_CALL_BEAST)
                {
                    CItemWeapon* PItem = static_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO));

                    if (PItem != nullptr && PItem->getSubSkillType() >= SUBSKILL_SHEEP && PItem->getSubSkillType() <= SUBSKILL_SEFINA)
                    {
                        // Valid Jug item
                    }
                    else
                    {
                        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_NO_JUG_PET_ITEM));
                        return false;
                    }
                }

                if (PAbility->getID() == ABILITY_CHARM)
                {
                    // TODO: Might need instance logic? It's in lua utils for GetEntity stuff like DespawnMob
                    CBattleEntity* PTarget = (CBattleEntity*)(PChar->GetEntity(targid));
                    if (PTarget && PTarget->PMaster && PTarget->PMaster->objtype == TYPE_PC)
                    {
                        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_THAT_SOMEONES_PET));
                        return false;
                    }
                }
                break;
            }

            case ABILITY_BESTIAL_LOYALTY:
            case ABILITY_FAMILIAR:
            case ABILITY_FIGHT:
            case ABILITY_HEEL:
            case ABILITY_SIC:
            case ABILITY_SNARL:
            case ABILITY_SPUR:
            case ABILITY_STAY:
            case ABILITY_RUN_WILD:
            case ABILITY_KILLER_INSTINCT:
            case ABILITY_LEAVE:
            {
                if (PChar->PPet == nullptr)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_REQUIRES_A_PET));
                    return false;
                }

                if (PAbility->getID() == ABILITY_FAMILIAR)
                {
                    if (PChar->PPet != nullptr)
                    {
                        CPetEntity* PPet = static_cast<CPetEntity*>(PChar->PPet);
                        if (PPet->getPetType() != PETTYPE_JUG_PET && !PPet->isCharmed ||
                            (PPet->GetLocalVar("ReceivedFamiliar") > 0))
                        {
                            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_NO_EFFECT_ON_PET));
                            return false;
                        }
                    }
                }

                if (PAbility->getID() == ABILITY_FIGHT)
                {
                    // TODO: Might need instance logic? It's in lua utils for GetEntity stuff like DespawnMob
                    CBattleEntity* PTarget = (CBattleEntity*)(PChar->GetEntity(targid));
                    if (PTarget)
                    {
                        if (PChar->PPet->id == PTarget->id || PTarget->PMaster && PTarget->PMaster->objtype == TYPE_PC)
                        {
                            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_ATTACK_TARGET));
                            return false;
                        }
                    }
                }

                if (PAbility->getID() == ABILITY_SIC)
                {
                    uint16 familyID = ((CPetEntity*)PChar->PPet)->m_Family;
                    const std::vector<uint16>& MobSkills = battleutils::GetMobSkillList(familyID);
                    if (PChar->PPet->GetHPP() == 0 ||
                        !PChar->PPet->GetBattleTargetID() ||
                        (MobSkills.size() == 0))
                    {
                        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
                        return false;
                    }
                }

                if (PAbility->getID() == ABILITY_SNARL)
                {
                    if (!PChar->PPet->GetBattleTargetID())
                    {
                        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_PET_CANNOT_DO_ACTION));
                        return false;
                    }

                    if (PChar->PPet != nullptr)
                    {
                        CPetEntity* PPet = static_cast<CPetEntity*>(PChar->PPet);
                        if (PPet->getPetType() != PETTYPE_JUG_PET)
                        {
                            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_PET_CANNOT_DO_ACTION));
                            return false;
                        }
                    }
                }
                break;
            }

            case ABILITY_DEEP_BREATHING:
            case ABILITY_DISMISS:
            case ABILITY_RESTORING_BREATH:
            case ABILITY_SMITING_BREATH:
            case ABILITY_SPIRIT_LINK:
            case ABILITY_SPIRIT_SURGE:
            {
                if (PChar->PPet == nullptr)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_REQUIRES_A_PET));
                    return false;
                }

                CPetEntity* PPet = static_cast<CPetEntity*>(PChar->PPet);

                if (PAbility->getID() != ABILITY_DEEP_BREATHING)
                {
                    // TODO: Might need instance logic? It's in lua utils for GetEntity stuff like DespawnMob
                    CBattleEntity* PTarget = dynamic_cast<CBattleEntity*>(PChar->GetEntity(targid));
                    if (distance(PChar->PPet->loc.p, PTarget->loc.p) > 13)
                    {
                        PChar->pushPacket(new CMessageBasicPacket(PChar, PPet, 0, 0, MSGBASIC_TOO_FAR_AWAY));
                        return false;
                    }
                }

                if (PChar->PPet != nullptr)
                {
                    if (PPet->getPetType() != PETTYPE_WYVERN)
                    {
                        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_PET_CANNOT_DO_ACTION));
                        return false;
                    }
                }

                if (PAbility->getID() == ABILITY_SPIRIT_SURGE)
                {
                    if (PChar->GetLocalVar("UndaRunes") < 3)
                    {
                        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_PERFORM_ACTION));
                        return false;
                    }
                }
                break;
            }

            case ABILITY_ELEMENTAL_SIPHON:
            case ABILITY_AVATARS_FAVOR:
            case ABILITY_MANA_CEDE:
            case ABILITY_ASTRAL_CONDUIT:
            {
                if (PChar->PPet == nullptr)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_REQUIRES_A_PET));
                    return false;
                }

                CPetEntity* PPet = static_cast<CPetEntity*>(PChar->PPet);
                if (PAbility->getID() == ABILITY_ELEMENTAL_SIPHON)
                {
                    if (PPet->m_PetID > PETID_DARKSPIRIT) // Not an elemental spirit
                    {
                        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_PET_CANNOT_DO_ACTION));
                        return false;
                    }
                }
                else
                {
                    if (PPet->getPetType() != PETTYPE_AVATAR)
                    {
                        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_PET_CANNOT_DO_ACTION));
                        return false;
                    }
                }
                break;
            }

            case ABILITY_COOLDOWN:
            case ABILITY_DEACTIVATE:
            case ABILITY_OVERDRIVE:
            case ABILITY_TACTICAL_SWITCH:
            case ABILITY_VENTRILOQUY:
            case ABILITY_ROLE_REVERSAL:
            case ABILITY_HEADY_ARTIFICE:
            {
                if (PChar->PPet == nullptr)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_REQUIRES_A_PET));
                    return false;
                }

                if (PChar->PPet != nullptr)
                {
                    CPetEntity* PPet = static_cast<CPetEntity*>(PChar->PPet);
                    if (PPet->getPetType() != PETTYPE_AUTOMATON)
                    {
                        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_PET_CANNOT_DO_ACTION));
                        return false;
                    }
                }
                break;
            }

            case ABILITY_REWARD:
            case ABILITY_MAINTENANCE:
            case ABILITY_REPAIR:
            {
                CItem* PItem = PChar->getEquip((SLOTTYPE)SLOT_AMMO);
                if (PItem == nullptr)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
                    return false;
                }

                if (PItem->isType(ITEM_EQUIPMENT))
                {
                    if (PAbility->getID() == ABILITY_REWARD)
                    {
                        // Pet Food Biscuits, Roborant, and Poultice
                        if ((PItem->getID() >= 17016 && PItem->getID() <= 17023) || PItem->getID() == 19251 || PItem->getID() == 19252)
                        {
                            // Valid pet food
                        }
                        else
                        {
                            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_MUST_HAVE_FOOD));
                            return false;
                        }

                        CPetEntity* PPet = static_cast<CPetEntity*>(PChar->PPet);
                        if (PPet->getPetType() != PETTYPE_JUG_PET && !PPet->isCharmed)
                        {
                            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_NO_EFFECT_ON_PET));
                            return false;
                        }
                    }

                    if (PAbility->getID() == ABILITY_MAINTENANCE || PAbility->getID() == ABILITY_REPAIR)
                    {
                        // Automaton Oils
                        if ((PItem->getID() >= 18731 && PItem->getID() <= 18733) || PItem->getID() == 19185)
                        {
                            // Valid Oil
                        }
                        else
                        {
                            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
                            return false;
                        }

                        CPetEntity* PPet = static_cast<CPetEntity*>(PChar->PPet);
                        if (PPet->getPetType() != PETTYPE_AUTOMATON)
                        {
                            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_NO_EFFECT_ON_PET));
                            return false;
                        }
                    }
                }
                break;
            }

            case ABILITY_ANGON:
            case ABILITY_TOMAHAWK:
            {
                // TODO: Might need instance logic? It's in lua utils for GetEntity stuff like DespawnMob
                CBattleEntity* PTarget = dynamic_cast<CBattleEntity*>(PChar->GetEntity(targid));
                if (!facing(PChar->loc.p, PTarget->loc.p, 45))
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PTarget, 0, 0, MSGASIC_CANNOT_SEE_TARGET));
                    return false;
                }

                CItem* PItem = PChar->getEquip((SLOTTYPE)SLOT_AMMO);
                if (PItem == nullptr)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
                    return false;
                }

                if (PItem->isType(ITEM_EQUIPMENT))
                {
                    if (PAbility->getID() == ABILITY_ANGON)
                    {
                        // Angon
                        if (PItem->getID() != 18259)
                        {
                            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
                            return false;
                        }
                    }

                    if (PAbility->getID() == ABILITY_TOMAHAWK)
                    {
                        // Tomahawk
                        if (PItem->getID() != 18258)
                        {
                            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
                            return false;
                        }
                    }
                }
                break;
            }

            case ABILITY_ACCOMPLICE:
            case ABILITY_COLLABORATOR:
            case ABILITY_COVER:
            case ABILITY_DEVOTION:
            case ABILITY_MARTYR:
            case ABILITY_CAPER_EMISSARIUS:
            {
                // TODO: Might need instance logic? It's in lua utils for GetEntity stuff like DespawnMob
                CBattleEntity* PTarget = dynamic_cast<CBattleEntity*>(PChar->GetEntity(targid));
                if (!PTarget ||
                    PChar->id == PTarget->id ||
                    (PTarget->objtype != TYPE_PC && PTarget->objtype != TYPE_TRUST))
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_ON_THAT_TARG));
                    return false;
                }

                if (PAbility->getID() == ABILITY_DEVOTION || PAbility->getID() == ABILITY_MARTYR)
                {
                    if (PChar->health.hp < 4)
                    {
                        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
                        return false;
                    }
                }
                break;
            }

            case ABILITY_CONVERT:
            {
                if (PChar->health.mp == 0)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_PERFORM_ACTION));
                    return false;
                }
                break;
            }

            case ABILITY_DESPOIL:
            case ABILITY_STEAL:
            {
                if (PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() == 0)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_FULL_INVENTORY));
                    return false;
                }
                break;
            }

            case ABILITY_EAGLE_EYE_SHOT:
            {
                // Get the equipped items
                auto ranged = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_RANGED));
                auto ammo = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO));

                // Check if ranged weapon is equipped and is of type weapon
                if (ranged && ranged->isType(ITEM_WEAPON))
                {
                    // Check the skill type of the ranged weapon
                    uint16 skilltype = ranged->getSkillType();
                    if (skilltype == SKILL_ARCHERY || skilltype == SKILL_MARKSMANSHIP || skilltype == SKILL_THROWING)
                    {
                        // Check if ammo is equipped and is of type weapon or if skill type is throwing
                        if (ammo && (ammo->isType(ITEM_WEAPON) || skilltype == SKILL_THROWING))
                        {
                            break; // All checks passed, continue to use the ability
                        }
                    }
                }

                // If any of the checks fail, send the message and return false
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_NO_RANGED_WEAPON));
                return false;
            }

            case ABILITY_BOX_STEP:
            case ABILITY_FEATHER_STEP:
            case ABILITY_QUICKSTEP:
            case ABILITY_STUTTER_STEP:
            case ABILITY_DESPERATE_FLOURISH:
            case ABILITY_VIOLENT_FLOURISH:
            case ABILITY_WILD_FLOURISH:
            case ABILITY_KONZEN_ITTAI:
            case ABILITY_CONSPIRATOR:
            {
                if (PChar->animation != ANIMATION_ATTACK)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, abilityid, 0, MSGBASIC_REQUIRES_COMBAT));
                    return false;
                }
                break;
            }

            case ABILITY_DIFFUSION:
            case ABILITY_ACCESSION:
            case ABILITY_ADDENDUM_BLACK:
            case ABILITY_ADDENDUM_WHITE:
            case ABILITY_ALACRITY:
            case ABILITY_ALTRUISM:
            case ABILITY_APOGEE:
            case ABILITY_CELERITY:
            case ABILITY_DARK_ARTS:
            case ABILITY_EBULLIENCE:
            case ABILITY_ENLIGHTENMENT:
            case ABILITY_EQUANIMITY:
            case ABILITY_FOCALIZATION:
            case ABILITY_LIGHT_ARTS:
            case ABILITY_MANIFESTATION:
            case ABILITY_PARSIMONY:
            case ABILITY_PENURY:
            case ABILITY_PERPETUANCE:
            case ABILITY_RAPTURE:
            case ABILITY_TRANQUILITY:
            {
                EFFECT effectID = abilityToEffectMap[PAbility->getID()];
                if (PChar->StatusEffectContainer->HasStatusEffect(effectID))
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_EFFECT_ALREADY_ACTIVE));
                    return false;
                }

                if (PAbility->getID() == ABILITY_DARK_ARTS)
                {
                    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_ADDENDUM_BLACK))
                    {
                        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_EFFECT_ALREADY_ACTIVE));
                        return false;
                    }
                }

                if (PAbility->getID() == ABILITY_LIGHT_ARTS)
                {
                    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_ADDENDUM_WHITE))
                    {
                        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_EFFECT_ALREADY_ACTIVE));
                        return false;
                    }
                }
                break;
            }

            case ABILITY_SHIELD_BASH:
            {
                if (PChar->getShieldSize() == SHIELDSIZE_NONE)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_REQUIRES_SHIELD));
                    return false;
                }
                break;
            }

            case ABILITY_HAGAKURE:
            case ABILITY_HAMANOHA:
            case ABILITY_SENGIKORI:
            case ABILITY_YAEGASUMI:
            {
                if (PChar->GetLocalVar("IgnisRunes") == 0)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_PERFORM_ACTION));
                    return false;
                }
                break;
            }

            case ABILITY_SHIKIKOYO:
            {
                // TODO: Might need instance logic? It's in lua utils for GetEntity stuff like DespawnMob
                CBattleEntity* PTarget = dynamic_cast<CBattleEntity*>(PChar->GetEntity(targid));
                if (PChar->id == PTarget->id)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_ON_THAT_TARG));
                    return false;
                }

                if (PChar->health.tp < 1000)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_NOT_ENOUGH_TP));
                    return false;
                }
                break;
            }

            case ABILITY_ARCANE_CREST:
            case ABILITY_DRAGON_BREAKER:
            case ABILITY_SEPULCHER:
            {
                // TODO: Might need instance logic? It's in lua utils for GetEntity stuff like DespawnMob
                CBattleEntity* PTarget = dynamic_cast<CBattleEntity*>(PChar->GetEntity(targid));
                if (!PTarget)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_ON_THAT_TARG));
                    return false;
                }

                // Get the target's ecosystem
                ECOSYSTEM eco = PTarget->m_EcoSystem;

                // Determine the required ecosystem based on the ability
                ECOSYSTEM requiredEco;
                switch (PAbility->getID())
                {
                    case ABILITY_ARCANE_CREST:
                        requiredEco = SYSTEM_ARCANA;
                        break;
                    case ABILITY_DRAGON_BREAKER:
                        requiredEco = SYSTEM_DRAGON;
                        break;
                    case ABILITY_SEPULCHER:
                        requiredEco = SYSTEM_UNDEAD;
                        break;
                    default:
                        // Shouldn't happen
                        requiredEco = SYSTEM_ERROR;
                        break;
                }

                // Check if the target's ecosystem matches the required ecosystem
                if (eco != requiredEco)
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_ON_THAT_TARG));
                    return false;
                }
                break;
            }
                // Add more cases for other abilities as needed
            default:
                break;
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

bool CPlayerController::UseItem(uint16 targid, uint8 loc, uint16 slotid)
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

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

#include "mob_controller.h"
#include "../ai_container.h"
#include "../helpers/targetfind.h"
#include "../states/ability_state.h"
#include "../states/magic_state.h"
#include "../states/weaponskill_state.h"
#include "../states/mobskill_state.h"
#include "../states/item_state.h"
#include "../states/attack_state.h"
#include "../../mobskill.h"
#include "../../party.h"
#include "../../status_effect_container.h"
#include "../../recast_container.h"
#include "../../enmity_container.h"
#include "../../mob_modifier.h"
#include "../../mob_spell_container.h"
#include "../../entities/mobentity.h"
#include "../../utils/battleutils.h"
#include "../../../common/utils.h"
#include "../../utils/petutils.h"
#include "../../items/item_weapon.h"
#include "../../mob_spell_list.h"

CMobController::CMobController(CMobEntity* PEntity) :
    CController(PEntity),
    PMob(PEntity),
    m_forceDeaggroAll(false)
{}

void CMobController::Tick(time_point tick)
{
    TracyZoneScoped;
    TracyZoneIString(PMob->GetName());

    m_Tick = tick;

    if (PMob->isAlive())
    {
        if (PMob->PAI->IsEngaged())
        {
            DoCombatTick(tick);
        }
        else if (!PMob->isDead())
        {
            DoRoamTick(tick);
        }
    }
}

bool CMobController::TryDeaggro()
{
    TracyZoneScoped;
    if (PTarget == nullptr && (PMob->PEnmityContainer != nullptr && PMob->PEnmityContainer->GetHighestEnmity() == nullptr))
    {
        m_forcedDeaggroEntities.clear();
        m_forceDeaggroAll = false;
        return true;

    }

    // Deaggro player pets if they mount up
    if (PTarget)
    {
        if (PTarget->objtype == TYPE_PET && PTarget->PMaster != nullptr)
        {
            if (PTarget->PMaster->isMounted())
            {
                if (PTarget)
                    PMob->PEnmityContainer->Clear(PTarget->id);
                PTarget = PMob->PEnmityContainer->GetHighestEnmity();
                PMob->SetBattleTargetID(PTarget ? PTarget->targid : 0);
                return TryDeaggro();
            }
        }
    }

    
    bool isForcedDeaggro = (std::find(m_forcedDeaggroEntities.begin(), m_forcedDeaggroEntities.end(), PTarget) != m_forcedDeaggroEntities.end());
    // target is no longer valid, so wipe them from our enmity list
    if (!PTarget || PTarget->isDead() || PTarget->isMounted() || PTarget->loc.zone->GetID() != PMob->loc.zone->GetID() ||
        PMob->StatusEffectContainer->GetConfrontationEffect() != PTarget->StatusEffectContainer->GetConfrontationEffect() ||
        PMob->allegiance == PTarget->allegiance || CheckDetection(PTarget) || CheckHide(PTarget) || isForcedDeaggro || m_forceDeaggroAll)
    {
        if (PTarget)
            PMob->PEnmityContainer->Clear(PTarget->id);
        PTarget = PMob->PEnmityContainer->GetHighestEnmity();
        PMob->SetBattleTargetID(PTarget ? PTarget->targid : 0);
        return TryDeaggro();
    }

    m_forcedDeaggroEntities.clear();
    m_forceDeaggroAll = false;
    return false;


    // target is no longer valid, so wipe them from our enmity list
    if (!PTarget || PTarget->isDead() ||
        PTarget->isMounted() ||
        PTarget->loc.zone->GetID() != PMob->loc.zone->GetID() ||
        PMob->StatusEffectContainer->GetConfrontationEffect() != PTarget->StatusEffectContainer->GetConfrontationEffect() ||
        PMob->allegiance == PTarget->allegiance ||
        CheckDetection(PTarget) ||
        CheckHide(PTarget))
    {
        if (PTarget) PMob->PEnmityContainer->Clear(PTarget->id);
        PTarget = PMob->PEnmityContainer->GetHighestEnmity();
        PMob->SetBattleTargetID(PTarget ? PTarget->targid : 0);
        return TryDeaggro();
    }

    return false;
}

bool CMobController::CanPursueTarget(CBattleEntity* PTarget)
{
    TracyZoneScoped;
    if (PMob->m_Detects & DETECT_SCENT)
    {
        // if mob is in water it will instant deaggro if target cannot be detected
        if (!PMob->PAI->PathFind->InWater() && !PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DEODORIZE))
        {
            // certain weather / deodorize will turn on time deaggro
            return PMob->m_disableScent;
        }
    }
    return false;
}

bool CMobController::CheckHide(CBattleEntity* PTarget)
{
    TracyZoneScoped;
    if (PTarget->GetMJob() == JOB_THF && PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_HIDE))
    {
        return !CanPursueTarget(PTarget) && !PMob->m_TrueDetection;
    }
    return false;
}

bool CMobController::CheckDetection(CBattleEntity* PTarget)
{
    TracyZoneScoped;
    if (CanDetectTarget(PTarget) || CanPursueTarget(PTarget) ||
        PMob->StatusEffectContainer->HasPreventActionEffect(false))
    {
        TapDeaggroTime();
    }

    return PMob->CanDeaggro() && (m_Tick >= m_DeaggroTime + 180s); // increased from 25s
}

void CMobController::TryLink()
{
    TracyZoneScoped;
    if (PTarget == nullptr)
    {
        return;
    }

    //handle pet behaviour on the targets behalf (faster than in ai_pet_dummy)
    // Avatars defend masters by attacking mobs if the avatar isn't attacking anything currently (bodyguard behaviour)
    if (PTarget->PPet != nullptr && PTarget->PPet->GetBattleTargetID() == 0)
    {
        if (PTarget->PPet->objtype == TYPE_PET && ((CPetEntity*)PTarget->PPet)->getPetType() == PETTYPE_AVATAR)
        {
            auto* PChar = dynamic_cast<CCharEntity*>(PTarget);
            if (PChar && PChar->IsMobOwner(PMob))
            {
                petutils::AttackTarget(PTarget, PMob);
            }
        }
    }

    // my pet should help as well
    if (PMob->PPet != nullptr && PMob->PPet->PAI->IsRoaming())
    {
        PMob->PAI->EventHandler.triggerListener("LINK", PMob->PPet, PTarget->targid);
        PMob->PPet->PAI->Engage(PTarget->id);
    }

    if (PMob->PPet2 != nullptr && PMob->PPet2->PAI->IsRoaming())
    {
        PMob->PAI->EventHandler.triggerListener("LINK", PMob->PPet2, PTarget->targid);
        PMob->PPet2->PAI->Engage(PTarget->id);
    }

    // Mobs shouldn't link to pets unless the pet's master is on the enmity list
    if (PTarget->objtype == TYPE_PET || (PTarget->objtype == TYPE_MOB && PTarget->isCharmed))
    {
        EnmityList_t* enmityList = PMob->PEnmityContainer->GetEnmityList();
        bool shouldLink = false;

        for (EnmityList_t::iterator it = enmityList->begin(); it != enmityList->end(); ++it)
        {
            EnmityObject_t& PEnmityObject = it->second;
            if (PEnmityObject.PEnmityOwner)
            {
                if (PEnmityObject.PEnmityOwner->objtype == TYPE_PET)
                {
                    auto PPet = static_cast<CPetEntity*>(PEnmityObject.PEnmityOwner);
                    if (PPet->PMaster && PPet->PMaster->objtype == TYPE_PC)
                    {
                        // Check if the pet's master is on the enmity list
                        for (EnmityList_t::iterator masterIt = enmityList->begin(); masterIt != enmityList->end(); ++masterIt)
                        {
                            if (masterIt->second.PEnmityOwner == PPet->PMaster &&
                                (masterIt->second.CE > 0 || masterIt->second.VE > 0))
                            {
                                shouldLink = true;
                                break;
                            }
                        }
                    }
                }
            }
        }

        // Make sure the mob isn't supposed to super link
        if (PMob->getMobMod(MOBMOD_SUPERLINK) == 1)
        {
            shouldLink = true;
        }

        if (!shouldLink)
        {
            return;
        }
    }


    // Handle monster linking if they are close enough
    if (PMob->PParty != nullptr && !PMob->getMobMod(MOBMOD_ONE_WAY_LINKING))
    {
        for (auto& member : PMob->PParty->members)
        {
            CMobEntity* PPartyMember = dynamic_cast<CMobEntity*>(member);
            // Note if the mob to link with this one is a pet then do not link
            // Pets only link with their masters
            if (!PPartyMember || (PPartyMember && PPartyMember->PMaster))
            {
                continue;
            }

            if (PPartyMember->PAI->IsRoaming() && PPartyMember->CanLink(&PMob->loc.p, PMob->getMobMod(MOBMOD_SUPERLINK)))
            {
                PMob->PAI->EventHandler.triggerListener("LINK", PMob, PMob->targid);
                PPartyMember->PAI->Engage(PTarget->targid);
            }
        }
    }

    // ask my master for help
    if (PMob->PMaster != nullptr && PMob->PMaster->PAI->IsRoaming())
    {
        CMobEntity* PMaster = (CMobEntity*)PMob->PMaster;

        if (PMaster->PAI->IsRoaming() && PMaster->CanLink(&PMob->loc.p, PMob->getMobMod(MOBMOD_SUPERLINK)))
        {
            PMob->PAI->EventHandler.triggerListener("LINK", PMob, PMob->targid);
            PMaster->PAI->Engage(PTarget->targid);
        }
    }
}

/**
* Checks if the mob can detect the target using it's detection (sight, sound, etc)
* This is used to aggro and deaggro (Mobs start to deaggro after failing to detect target).
**/
bool CMobController::CanDetectTarget(CBattleEntity* PTarget, bool forceSight, bool detectDead)
{
    TracyZoneScoped;
    if ((!detectDead) && (PTarget->isDead() || PTarget->isMounted()))
    {
        return false;
    }

    // Don't aggro I'm a fomor and I don't hate you
    if (PMob->getMobMod(MOBMOD_FOMOR_HATE) > 0)
    {
        int32 hate = GetFomorHate(PTarget);
        if (hate >= 0 && hate < 8)
        {
            return false;
        }
    }

    auto detects = PMob->m_Detects;
    auto currentDistance = distance(PTarget->loc.p, PMob->loc.p);

    bool detectSight = (detects & DETECT_SIGHT) || forceSight || PMob->getMobMod(MOBMOD_AGGRO_SIGHT) > 0;
    bool detectSound = detects & DETECT_HEARING || PMob->getMobMod(MOBMOD_AGGRO_SOUND) > 0;
    bool detectMagic = detects & DETECT_MAGIC || PMob->getMobMod(MOBMOD_AGGRO_MAGIC) > 0;
    bool detectWS = detects & DETECT_WEAPONSKILL || PMob->getMobMod(MOBMOD_AGGRO_WS) > 0;
    bool detectJA = detects & DETECT_JOBABILITY || PMob->getMobMod(MOBMOD_AGGRO_JA) > 0;
    bool detectHP = detects & DETECT_LOWHP || PMob->getMobMod(MOBMOD_AGGRO_HP) > 0;
    bool hasInvisible = false;
    bool hasSneak = false;

    bool isTargetAndInRange = PMob->GetBattleTargetID() == PTarget->targid && currentDistance <= PMob->GetMeleeRange();

    if (PMob->m_TrueDetection == 0 && PMob->getMobMod(MOBMOD_TRUE_SIGHT_SOUND) == 0 && PMob->getMobMod(MOBMOD_TRUE_SIGHT) == 0 &&
        PMob->getMobMod(MOBMOD_TRUE_SOUND) == 0) // No True Detection
    {
        hasSneak = PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK);                   // Does not ignore sneak.
        hasInvisible = PTarget->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE); // Does not ignore invisible.
    }
    if (PMob->m_TrueDetection == 1 || PMob->getMobMod(MOBMOD_TRUE_SIGHT_SOUND) > 0) // True Sight and Hearing
    {
        // Ignores Invisible and Sneak
    }
    if (PMob->m_TrueDetection == 2 || PMob->getMobMod(MOBMOD_TRUE_SIGHT) > 0) // True Sight
    {
        hasSneak = PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK); // Does not ignore sneak.
    }
    if (PMob->m_TrueDetection == 3 || PMob->getMobMod(MOBMOD_TRUE_SOUND) > 0) // True Hearing
    {
        hasInvisible = PTarget->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE); // Does not ignore invisible.

    }
    // ShowDebug("Sight Range before %u \n", PMob->getMobMod(MOBMOD_SIGHT_RANGE));
    uint32 sightRange = (PMob->getMobMod(MOBMOD_SIGHT_RANGE) - PTarget->getMod(Mod::ALERTNESS)) * GetSightDetectionModifiers() / 100;
    // ShowDebug("Sight Range after %u \n", sightRange);
    if (detectSight && !hasInvisible && currentDistance < sightRange && facing(PMob->loc.p, PTarget->loc.p, 64))
    {
        return isTargetAndInRange || PMob->CanSeeTarget(PTarget);
    }

    if ((PMob->m_Behaviour & BEHAVIOUR_AGGRO_AMBUSH) && currentDistance < 3 && !hasSneak)
    {
        return true;
    }

    uint32 soundRange = PMob->getMobMod(MOBMOD_SOUND_RANGE) - PTarget->getMod(Mod::STEALTH);
    uint32 soundMod = GetSoundDetectionModifiers();
    // ShowDebug("Sound Range before %u \n", PMob->getMobMod(MOBMOD_SOUND_RANGE));
    // ShowDebug("Sound Mod %u \n", soundMod);

    // Undead sound range is 5, normal sound aggro mobs are 8
    if (IsUndead())
    {
        soundRange = 5;
    }
    // ShowDebug("Sound Range after undead check %u \n", soundRange);
    soundRange *= soundMod;

    soundRange /= 100;
    //ShowDebug("Sound Range after mod %u \n", soundRange);

    if ((detectSound) && currentDistance < soundRange && !hasSneak)
    {
        return isTargetAndInRange || PMob->CanSeeTarget(PTarget);
    }

    if ((detectMagic) && currentDistance < PMob->getMobMod(MOBMOD_MAGIC_RANGE) && PTarget->PAI->IsCurrentState<CMagicState>() &&
        static_cast<CMagicState*>(PTarget->PAI->GetCurrentState())->GetSpell()->hasMPCost())
    {
        return isTargetAndInRange || PMob->CanSeeTarget(PTarget);
    }

    if ((detectWS) && currentDistance < PMob->getMobMod(MOBMOD_WS_RANGE) && PTarget->PAI->IsCurrentState<CWeaponSkillState>())
    {
        return isTargetAndInRange || PMob->CanSeeTarget(PTarget);
    }

    if ((detectJA) && currentDistance < PMob->getMobMod(MOBMOD_JA_RANGE) && PTarget->PAI->IsCurrentState<CAbilityState>())
    {
        return isTargetAndInRange || PMob->CanSeeTarget(PTarget);
    }

    // ShowDebug("Blood Range before %u \n", PMob->getMobMod(MOBMOD_HP_RANGE));
    uint32 bloodRange = (PMob->getMobMod(MOBMOD_HP_RANGE) * GetBloodDetectionModifiers()) / 100;
    // ShowDebug("Blood Range after %u \n", bloodRange);
    if ((detectHP) && currentDistance < bloodRange && PTarget->GetHPP() < 75)
    {
        return isTargetAndInRange || PMob->CanSeeTarget(PTarget);
    }

    return false;
}

uint32 CMobController::GetSightDetectionModifiers()
{
    WEATHER weather = battleutils::GetWeather(PMob, false);
    uint32 VanadielHour = CVanaTime::getInstance()->getHour();
    ZONETYPE zoneType = PMob->loc.zone->GetType();

    if (IsDaySight())
    {
        // Day Vision
        // Fire And Water = Bonus vision range
        // Wind and Thunder = No Bonus
        // Rest = penalty
        // Only active outdoors
        if (zoneType != ZONETYPE_OUTDOORS)
        {
            return 100;
        }
        if (weather == WEATHER_HOT_SPELL || weather == WEATHER_HEAT_WAVE || weather == WEATHER_AURORAS || weather == WEATHER_STELLAR_GLARE)
        {
            return 150;
        }
        else if (weather == WEATHER_WIND || weather == WEATHER_GALES || weather == WEATHER_THUNDER || weather == WEATHER_THUNDERSTORMS)
        {
            return 100;
        }
        else if (VanadielHour >= 20 || VanadielHour < 4) // Neutral at day time, penalty at night
        {
            return 50;
        }
        else if (weather == WEATHER_NONE || weather == WEATHER_SUNSHINE || weather == WEATHER_CLOUDS)
        {
            return 100;
        }
        else
        {
            return 50;
        }
    }
    else
    {
        if (zoneType != ZONETYPE_OUTDOORS)
        {
            return 100;
        }
        if (weather == WEATHER_FOG || weather == WEATHER_RAIN || weather == WEATHER_SQUALL || weather == WEATHER_SNOW || weather == WEATHER_BLIZZARDS ||
            weather == WEATHER_THUNDER || weather == WEATHER_THUNDERSTORMS || weather == WEATHER_GLOOM || weather == WEATHER_DARKNESS)
        {
            return 150;
        }
        else if (weather == WEATHER_DUST_STORM || weather == WEATHER_SAND_STORM)
        {
            return 100;
        }
        else if (VanadielHour >= 6 && VanadielHour < 18) // Neutral at night time, penalty during the day
        {
            return 50;
        }
        if (weather == WEATHER_NONE || weather == WEATHER_SUNSHINE || weather == WEATHER_CLOUDS)
        {
            return 100;
        }
        else
        {
            return 50;
        }
    }
}

bool CMobController::IsDaySight()
{
    // If Day sight, return true, otherwise return false
    // Day Sight: Gigas, Orc War Machine, Cockatrice, Yagudo, Buffalo, Manticore, Ram, Bee, Cluster, Roc, Puk
    // Blind day Pattern: Bombs / Snolls / Djinn
    auto family = PMob->m_Family;

    if (family >= 126 && family <= 130 || family == 328 || family == 190 || family == 945 || family == 70 || family == 531 || family == 270 || family == 360 ||
        family == 943 || family == 57 || family == 179 || family == 208 || family == 48 || family == 68 || family == 69 || family == 125 || family == 198 ||
        family == 526) 
    {
        return true;
    }
    else
    {
        return false;
    }
}

uint32 CMobController::GetSoundDetectionModifiers()
{
    WEATHER weather = battleutils::GetWeather(PMob, false);
    uint32 VanadielHour = CVanaTime::getInstance()->getHour();
    ZONETYPE zoneType = PMob->loc.zone->GetType();

    // Sound aggro
    // 4 Sound range, game hours 4 - 18
    // 8 Sound range, game hours 18 - 4
    // Weather increases to 12
    // Weather decreases to 4
    // Static 8 in dungeons

    // Undead + sound
    // 2.5 Sound range, game hours 4 - 18
    // 5 Sound range, game hours 18 - 4
    // Weather decreases to 2.5
    // Weather increases to 7.5
    // Static 5 in dungeons
    if (zoneType != ZONETYPE_OUTDOORS)
    {
        return 100;
    }
    if (weather == WEATHER_DUST_STORM || weather == WEATHER_SAND_STORM || weather == WEATHER_WIND || weather == WEATHER_GALES)
    {
        return 150;
    }
    else if (weather == WEATHER_SNOW || weather == WEATHER_BLIZZARDS || weather == WEATHER_AURORAS || weather == WEATHER_STELLAR_GLARE ||
                weather == WEATHER_GLOOM || weather == WEATHER_DARKNESS)
    {
        return 100;
    }
    else if (VanadielHour >= 4 && VanadielHour < 18) // Neutral at night time, penalty during the day
    {
        return 50;
    }
    else if (weather == WEATHER_NONE || weather == WEATHER_SUNSHINE || weather == WEATHER_CLOUDS)
    {
        return 100;
    }
    else
    {
        return 50;
    }
}

uint32 CMobController::GetBloodDetectionModifiers()
{
    WEATHER weather = battleutils::GetWeather(PMob, false);
    uint32 VanadielHour = CVanaTime::getInstance()->getHour();
    ZONETYPE zoneType = PMob->loc.zone->GetType();

    // Blood aggro
    // 20 during no weather
    // 20 Static in dungeons
    // 30 during dark weather and fog
    // 10 during any other(than dark and fog) weathers
    if (IsUndead())
    {
        if (zoneType != ZONETYPE_OUTDOORS)
        {
            return 100;
        }
        if (weather == WEATHER_FOG || weather == WEATHER_GLOOM || weather == WEATHER_DARKNESS)
        {
            return 150;
        }
        else if (weather == WEATHER_NONE || weather == WEATHER_SUNSHINE || weather == WEATHER_CLOUDS)
        {
            return 100;
        }
        else
        {
            return 50;
        }
    }
    return 100;
}

bool CMobController::IsUndead()
{
    // Hounds, Skeletons, Ghosts, Doomed
    auto family = PMob->m_Family;

    if (family == 142 || family == 143 || family == 227 || family == 88 || family == 89 || family == 121 || family == 52 || family == 86 || family == 552)
    {
        return true;
    }
    else
    {
        return false;
    }
}

bool CMobController::MobSkill(int wsList)
{
    TracyZoneScoped;
    /* #TODO: mob 2 hours, etc */
    if (!wsList) wsList = PMob->getMobMod(MOBMOD_SKILL_LIST);
    auto skillList {battleutils::GetMobSkillList(wsList)};

    if (skillList.empty())
    {
        return false;
    }

    std::shuffle(skillList.begin(), skillList.end(), tpzrand::mt());
    CBattleEntity* PActionTarget {nullptr};
	
    uint16 scriptChoice = luautils::OnMobWeaponSkillPrepare((CBaseEntity*)PMob, (CBaseEntity*)PTarget);
    if (scriptChoice != 0)
    {
        skillList.insert(skillList.begin(), scriptChoice);
    }


    for (auto skillid : skillList)
    {
        auto PMobSkill {battleutils::GetMobSkill(skillid)};
        if (!PMobSkill)
        {
            continue;
        }
        if (PMobSkill->getValidTargets() == TARGET_ENEMY) //enemy
        {
            PActionTarget = PTarget;
        }
        else if (PMobSkill->getValidTargets() == TARGET_SELF) //self
        {
            PActionTarget = PMob;
        }
        else
        {
            continue;
        }
        if (PActionTarget == nullptr)
        {
            return false;
        }
        if (PMob->StatusEffectContainer->HasStatusEffect({ EFFECT_AMNESIA, EFFECT_IMPAIRMENT }))
        {
            return false;
        }
        float currentDistance = distance(PMob->loc.p, PActionTarget->loc.p);
        if (!PMobSkill->isTwoHour() && luautils::OnMobSkillCheck(PActionTarget, PMob, PMobSkill) == 0) //A script says that the move in question is valid
        {
            if (currentDistance <= PMobSkill->getDistance())
            {
                int16 tp = battleutils::CalculateWeaponSkillTP(PMob, 0, PMob->health.tp);

                tp = std::min(static_cast<int>(tp), 3000);
                PMob->SetLocalVar("tp", tp);
                // Set message for "Player" and Fomor TP moves, and Prishe/Tenzen TP moves
                if (PMobSkill->isReadiesException())
                {
                    PMob->loc.zone->PushPacket(PMob, CHAR_INRANGE, new CMessageBasicPacket(PMob, PTarget, 0, PMobSkill->getID(), MSGBASIC_READIES_WS));
                }

                return MobSkill(PActionTarget->targid, PMobSkill->getID());
            }
        }
    }

    return false;
}

bool CMobController::TrySpecialSkill()
{
    TracyZoneScoped;
    // get my special skill
    CMobSkill* PSpecialSkill = battleutils::GetMobSkill(PMob->getMobMod(MOBMOD_SPECIAL_SKILL));
    CBattleEntity* PAbilityTarget = nullptr;
    m_LastSpecialTime = m_Tick;

    if (PSpecialSkill == nullptr) {
        ShowError("CAIMobDummy::ActionSpawn Special skill was set but not found! (%d)\n", PMob->getMobMod(MOBMOD_SPECIAL_SKILL));
        return false;
    }

    if (!IsWeaponSkillEnabled())
    {
        return false;
    }

    if ((PMob->m_specialFlags & SPECIALFLAG_HIDDEN) && !PMob->IsNameHidden())
    {
        return false;
    }

    if (PSpecialSkill->getValidTargets() & TARGET_SELF)
    {
        PAbilityTarget = PMob;
    }
    else if (PTarget != nullptr)
    {
        // distance check for special skill
        float currentDistance = distance(PMob->loc.p, PTarget->loc.p);

        if (currentDistance <= PSpecialSkill->getDistance())
        {
            PAbilityTarget = PTarget;
        }
        else
        {
            return false;
        }
    }
    else
    {
        return false;
    }

    if (luautils::OnMobSkillCheck(PAbilityTarget, PMob, PSpecialSkill) == 0)
    {
        return MobSkill(PAbilityTarget->targid, PSpecialSkill->getID());
    }

    return false;
}

bool CMobController::TryRangedAttack()
{
    TracyZoneScoped;
    CBattleEntity* PAbilityTarget = nullptr;
    if ((PMob->m_specialFlags & SPECIALFLAG_HIDDEN) && !PMob->IsNameHidden())
    {
        return false;
    }

    if (PTarget != nullptr)
    {
        // distance check for ranged
        float currentDistance = distance(PMob->loc.p, PTarget->loc.p);

        if (currentDistance <= 25)
        {
            PAbilityTarget = PTarget;
        }
        else
        {
            return false;
        }
    }
    else
    {
        return false;
    }
    return RangedAttack(PAbilityTarget->targid);
}

bool CMobController::WeaponSkill(uint16 targid, uint16 wsid)
{
    if (PMob->PAI->CanChangeState())
    {
        // #TODO: put all this in weaponskill_state
        CWeaponSkill* PWeaponSkill = battleutils::GetWeaponSkill(wsid);

        if (PMob->StatusEffectContainer->HasStatusEffect({ EFFECT_AMNESIA, EFFECT_IMPAIRMENT }))
        {
            return false;
        }

        std::unique_ptr<CBasicPacket> errMsg;
        auto PTarget = PMob->IsValidTarget(targid, battleutils::isValidSelfTargetWeaponskill(wsid) ? TARGET_SELF : TARGET_ENEMY, errMsg);

        if (PTarget)
        {
            if (!facing(PMob->loc.p, PTarget->loc.p, 64) && PTarget != PMob)
            {
                return false;
            }
            return CController::WeaponSkill(targid, wsid);
        }
    }

    return false;
}

bool CMobController::TryCastSpell()
{
    TracyZoneScoped;
    if (!CanCastSpells())
    {
        return false;
    }

    float currentDistance = distance(PMob->loc.p, PTarget->loc.p);

    if (PMob->m_HasSpellScript)
    {
        // skip logic and follow script
        auto chosenSpellId = luautils::OnMonsterMagicPrepare(PMob, PTarget);
        if (chosenSpellId && currentDistance <= 20.4)
        {
            PMob->PRecastContainer->Del(RECAST_MAGIC, static_cast<uint16>(chosenSpellId.value()));
            CastSpell(chosenSpellId.value());
            return true;
        }
    }
    else
    {
        // find random spell
        std::optional<SpellID> chosenSpellId;
        if (m_firstSpell)
        {
            // mobs first spell, should be aggro spell
            chosenSpellId = PMob->SpellContainer->GetAggroSpell();
            m_firstSpell = false;
        }
        else
        {
            chosenSpellId = PMob->SpellContainer->GetSpell();
        }

        if (chosenSpellId && currentDistance <= 20.4)
        {
            CastSpell(chosenSpellId.value());
            return true;
        }
    }
    TapDeaggroTime();
    return false;
}

bool CMobController::CanCastSpells()
{
    TracyZoneScoped;
    if (!PMob->SpellContainer->HasSpells() && !PMob->m_HasSpellScript)
    {
        return false;
    }

    // check for spell blockers e.g. silence
    if (PMob->StatusEffectContainer->HasStatusEffect({EFFECT_SILENCE, EFFECT_MUTE}))
    {
        TapDeaggroTime();
        return false;
    }

    // smn can only cast spells if it has no pet
    if (PMob->GetMJob() == JOB_SMN)
    {
        if (PMob->PPet && !PMob->PPet->isDead())
        {
            return false;
        }
    }

    return IsMagicCastingEnabled();
}

void CMobController::CastSpell(SpellID spellid)
{
    TracyZoneScoped;
    CSpell* PSpell = spell::GetSpell(spellid);
    if (PSpell == nullptr)
    {
        ShowWarning(CL_YELLOW"ai_mob_dummy::CastSpell: SpellId <%i> is not found\n" CL_RESET, static_cast<uint16>(spellid));
    }
    else
    {
        CBattleEntity* PCastTarget = nullptr;
        CBattleEntity* PCureTarget = nullptr;
        // check valid targets
        if (PSpell->getValidTarget() & TARGET_SELF)
        {
            PCastTarget = PMob;

            // only buff other targets if i'm roaming
            if ((PSpell->getValidTarget() & TARGET_PLAYER_PARTY) && !PMob->PAI->IsEngaged())
            {
                // chance to target my master
                if (PMob->PMaster != nullptr && tpzrand::GetRandomNumber(2) == 0)
                {
                    // target my master
                    PCastTarget = PMob->PMaster;
                }
                else if (tpzrand::GetRandomNumber(2) == 0)
                {
                    // chance to target party
                    PMob->PAI->TargetFind->reset();
                    PMob->PAI->TargetFind->findWithinArea(PMob, AOERADIUS_ATTACKER, static_cast<float>(PCastTarget->m_ModelSize) + PSpell->getRange());

                    if (!PMob->PAI->TargetFind->m_targets.empty())
                    {
                        // randomly select a target
                        PCastTarget = PMob->PAI->TargetFind->m_targets[tpzrand::GetRandomNumber(PMob->PAI->TargetFind->m_targets.size())];

                        // only target if are on same action
                        if (PMob->PAI->IsEngaged() == PCastTarget->PAI->IsEngaged())
                        {
                            PCastTarget = PMob;
                        }
                    }
                }
            }
        }
        else
        {
            PCastTarget = PTarget;
        }

        // Healing logic for party members
        if (PSpell->isHeal() && PSpell->getValidTarget() & TARGET_PLAYER_PARTY)
        {
            PMob->PAI->TargetFind->reset();
            PMob->PAI->TargetFind->findWithinArea(PMob, AOERADIUS_ATTACKER, static_cast<float>(PMob->m_ModelSize) + PSpell->getRange());

            // Iterate through all targets and find the lowest HP target
            for (auto& target : PMob->PAI->TargetFind->m_targets)
            {
                if (target->GetHPP() <= PMob->getMobMod(MOBMOD_HP_HEAL_CHANCE) && target->PAI->IsEngaged()) // Don't heal targets out of combat
                {
                    if (PCureTarget == nullptr || target->GetHPP() < PCureTarget->GetHPP())
                    {
                        PCureTarget = target;
                    }
                }
            }

            // Check if we should heal this target (mob's HP must be higher than the target's HP)
            if (PCureTarget != nullptr && PCureTarget->GetHPP() <= PMob->getMobMod(MOBMOD_HP_HEAL_CHANCE) // Target's HP is below the heal chance threshold
                && PMob->GetHPP() >= PMob->getMobMod(MOBMOD_HP_HEAL_CHANCE)                              // Mob's HP is above the heal chance threshold
                && PMob->GetHPP() > PCureTarget->GetHPP())                                               // Mob's HP is higher than the target's HP
            {
                PCastTarget = PCureTarget;
            }

        }

        if (PCastTarget)
        {
            float currentDistance = distance(PMob->loc.p, PCastTarget->loc.p);
            // Make sure target is in spell range
            if (currentDistance <= static_cast<float>(PCastTarget->m_ModelSize) + PSpell->getRange())
            {
                Cast(PCastTarget->targid, spellid);
            }
        }
    }
}

void CMobController::DoCombatTick(time_point tick)
{
    TracyZoneScopedC(0xFF0000);
    if (PMob->m_OwnerID.targid != 0 && static_cast<CCharEntity*>(PMob->GetEntity(PMob->m_OwnerID.targid))->PClaimedMob != static_cast<CBattleEntity*>(PMob))
    {
        if (m_Tick >= m_DeclaimTime + 3s)
        {
            PMob->m_OwnerID.clean();
            PMob->updatemask |= UPDATE_STATUS;
        }
    }

    // i'm a worm pop back up
    if (PMob->m_roamFlags & ROAMFLAG_WORM)
    {
        PMob->animationsub = 0;
        PMob->HideName(false);
        PMob->Untargetable(false);
    }


    HandleEnmity();
    PTarget = static_cast<CBattleEntity*>(PMob->GetEntity(PMob->GetBattleTargetID()));

    if (TryDeaggro())
    {
        Disengage();
        return;
    }

    // Deaggro players in cutscenes
    if (PTarget != nullptr && PTarget->status == STATUS_CUTSCENE_ONLY)
    {
        DeaggroEntity(PTarget);
        return;
    }

    // Deaggro players zoning
    if (PTarget != nullptr && PTarget->status == STATUS_DISAPPEAR)
    {
        DeaggroEntity(PTarget);
        return;
    }

    TryLink();

    float currentDistance = distance(PMob->loc.p, PTarget->loc.p);

    PMob->PAI->EventHandler.triggerListener("COMBAT_TICK", PMob, PTarget);
    luautils::OnMobFight(PMob, PTarget);

    // If target is not in LOS, move towards them
    if (!PMob->CanSeeTarget(PTarget))
    {
        Move();
    }

    if (PMob->getMobMod(MOBMOD_SPELL_LIST) > 0)
    {
        PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(PMob->getMobMod(MOBMOD_SPELL_LIST));
    }

    // Try to spellcast (this is done first so things like Chainspell spam is prioritised over TP moves etc.
    if (IsSpecialSkillReady(currentDistance) && TrySpecialSkill())
    {
        return;
    }
    else if (IsRangedAttackReady(currentDistance) && TryRangedAttack())
    {
        return;
    }
    else if (IsSpellReady(currentDistance) && TryCastSpell() && currentDistance <= 20.4)
    {
        return;
    }
    else if (PMob->PAI->CanChangeState() && tpzrand::GetRandomNumber(1, 10000) <= PMob->TPUseChance() && MobSkill())
    {
        return;
    }

    Move();
}

void CMobController::FaceTarget(uint16 targid)
{
    TracyZoneScoped;

    // If CCed, don't face target!
    if (PMob->StatusEffectContainer->HasPreventActionEffect(false))
    {
        return;
    }

    // If busy, don't face target!
    if (PMob->PAI->IsCurrentState<CMagicState>() || PMob->PAI->IsCurrentState<CMobSkillState>() || PMob->PAI->IsCurrentState<CWeaponSkillState>() ||
        PMob->PAI->IsCurrentState<CItemState>())
    {
        return;
    }

    CBaseEntity* targ = PTarget;
    if (targid != 0 && ((targ && targid != targ->targid ) || !targ))
    {
        targ = PMob->GetEntity(targid);
    }
    if (!(PMob->m_Behaviour & BEHAVIOUR_NO_TURN) && targ)
    {
        PMob->PAI->PathFind->LookAt(targ->loc.p);
    }
}

bool CMobController::IsStuck()
{
    return m_Stuck;
}

void CMobController::UpdateLastKnownPosition()
{
    // Mob is considered "Stuck" if:
    // 1. Last Pos && Current Pos are <= 1.5
    // 2. Distance to Target > Melee Range
    // 3. Mob is not bound or asleep
    m_Stuck = distanceSquared(m_LastPos, PMob->loc.p) <= 1.5f && distanceSquared(PMob->loc.p, PTarget->loc.p) > PMob->GetMeleeRange() &&
              PMob->StatusEffectContainer->GetStatusEffect(EFFECT_BIND) == nullptr && PMob->StatusEffectContainer->GetStatusEffect(EFFECT_SLEEP) == nullptr &&
              PMob->StatusEffectContainer->GetStatusEffect(EFFECT_SLEEP_II) == nullptr;
    m_LastPos = PMob->loc.p;
}

void CMobController::Move()
{
    TracyZoneScoped;
    if (!PMob->PAI->CanFollowPath())
    {
        return;
    }

    // Ensure the mob faces the target if it's following a scripted path
    if (PMob->PAI->PathFind->IsFollowingScriptedPath())
    {
        PMob->PAI->PathFind->FollowPath();
        FaceTarget(); // Add FaceTarget() here
        return;
    }

    // attempt to teleport
    if (PMob->getMobMod(MOBMOD_TELEPORT_TYPE) == 1)
    {
        if (m_Tick >= m_LastSpecialTime + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_TELEPORT_CD)))
        {
            CMobSkill* teleportBegin = battleutils::GetMobSkill(PMob->getMobMod(MOBMOD_TELEPORT_START));

            if (teleportBegin)
            {
                m_LastSpecialTime = m_Tick;
                MobSkill(PMob->targid, teleportBegin->getID());
                FaceTarget(); // Ensure facing target after teleport attempt
            }
        }
    }

    bool move = PMob->PAI->PathFind->IsFollowingPath();
    float attack_range = PMob->GetMeleeRange() + PTarget->m_ModelSize;

    if (PMob->getMobMod(MOBMOD_ATTACK_SKILL_LIST) > 0)
    {
        auto skillList{ battleutils::GetMobSkillList(PMob->getMobMod(MOBMOD_ATTACK_SKILL_LIST)) };

        if (!skillList.empty())
        {
            auto* skill{ battleutils::GetMobSkill(skillList.front()) };
            if (skill)
            {
                attack_range = skill->getDistance();
            }
        }
    }

    float currentDistance = distance(PMob->loc.p, PTarget->loc.p);
    if (PMob->getMobMod(MOBMOD_SHARE_POS) > 0)
    {
        CMobEntity* posShare = (CMobEntity*)PMob->GetEntity(PMob->getMobMod(MOBMOD_SHARE_POS) + PMob->targid, TYPE_MOB);
        PMob->loc = posShare->loc;
    }
    else if (((currentDistance > attack_range - 0.2f) || move) && PMob->PAI->CanFollowPath())
    {
        // #TODO: can this be moved to scripts entirely?
        if (PMob->getMobMod(MOBMOD_DRAW_IN) > 0)
        {
            if (currentDistance >= PMob->GetMeleeRange() * 2 && battleutils::DrawIn(PTarget, PMob, PMob->GetMeleeRange() - 0.2f))
            {
                FaceTarget(); // Ensure facing target when drawing in
            }
        }
        if (PMob->speed != 0 && PMob->getMobMod(MOBMOD_NO_MOVE) == 0 && m_Tick >= m_LastSpecialTime)
        {
            // attempt to teleport to target (if in range)
            if (PMob->getMobMod(MOBMOD_TELEPORT_TYPE) == 2)
            {
                CMobSkill* teleportBegin = battleutils::GetMobSkill(PMob->getMobMod(MOBMOD_TELEPORT_START));

                if (teleportBegin && currentDistance <= teleportBegin->getDistance())
                {
                    MobSkill(PMob->targid, teleportBegin->getID());
                    m_LastSpecialTime = m_Tick;
                    FaceTarget(); // Ensure facing target after teleport attempt
                    return;
                }
            }
            else if (CanMoveForward(currentDistance))
            {
                // Do not move if current target has Palisade on and is < 12 yards away
                if (PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_PALISADE) && currentDistance <= 15)
                {
                    return;
                }
                if (!PMob->PAI->PathFind->IsFollowingPath() || distanceSquared(PMob->PAI->PathFind->GetDestination(), PTarget->loc.p) > 10)
                {
                    // path to the target if we don't have a path already
                    PMob->PAI->PathFind->PathInRange(PTarget->loc.p, attack_range - 0.2f, PATHFLAG_WALLHACK | PATHFLAG_RUN);
                }
                PMob->PAI->PathFind->FollowPath();

                // Only check if stuck every 2s, this prevents overlap or interference with
                // PathFind following path if the mob's move speed is slow.
                if (m_Tick - m_StuckTick >= 2s)
                {
                    m_StuckTick = m_Tick;

                    // Keep a record of the last known position to check if we need
                    // to manually intervene to move the mob.
                    UpdateLastKnownPosition();

                    // Check if the mob is stuck, if stuck, directly intervene
                    // by stepping to the player. This fixes people being able to hold mobs
                    // because they can't find a path around to the player's position.
                    if (IsStuck() && PTarget != nullptr)
                    {
                        PMob->PAI->PathFind->StepTo(PTarget->loc.p, false);
                        FaceTarget(); // Ensure facing target when stuck and stepping to it
                    }
                }
                if (!PMob->PAI->PathFind->IsFollowingPath())
                {
                    // arrived at target - move if there is another mob under me
                    if (PTarget->objtype == TYPE_PC)
                    {
                        auto spawnMOBList = static_cast<CCharEntity*>(PTarget)->SpawnMOBList;
                        if (spawnMOBList.size() > 0)
                        {
                            for (auto PSpawnedMob : spawnMOBList)
                            {
                                if (PSpawnedMob.second != PMob && !PSpawnedMob.second->PAI->PathFind->IsFollowingPath() &&
                                    distance(PSpawnedMob.second->loc.p, PMob->loc.p) < 1.f)
                                {
                                    auto angle = worldAngle(PMob->loc.p, PTarget->loc.p) + 64;
                                    position_t new_pos{ PMob->loc.p.x - (cosf(rotationToRadian(angle)) * 1.5f), PTarget->loc.p.y,
                                                        PMob->loc.p.z + (sinf(rotationToRadian(angle)) * 1.5f), 0, 0 };
                                    if (PMob->PAI->PathFind->ValidPosition(new_pos))
                                    {
                                        PMob->PAI->PathFind->PathTo(new_pos, PATHFLAG_WALLHACK | PATHFLAG_RUN);
                                        PMob->PAI->EventHandler.triggerListener("MOB_PATH", PMob, PTarget);
                                    }
                                    break;
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                if (currentDistance - PMob->m_ModelSize >
                    PTarget->GetMeleeRange()) // if mob can't move forward and is out of melee range, but is in melee range if you eliminate the Y axis
                                              // differential, then force the mob to move
                {
                    position_t new_pos{ PMob->loc.p.x, PTarget->loc.p.y, PMob->loc.p.z, 0, 0 };
                    if (distance(new_pos, PTarget->loc.p) - PMob->m_ModelSize <= PTarget->GetMeleeRange())
                    {
                        PMob->PAI->PathFind->StepTo(new_pos);
                        PMob->PAI->EventHandler.triggerListener("MOB_PATH", PMob, PTarget);
                        FaceTarget(); // Ensure facing target when stepping to new position
                    }
                }
                FaceTarget(); // Ensure facing target if no other conditions met
            }
        }
    }
    else
    {
        FaceTarget(); // Ensure facing target if not moving
    }
}


void CMobController::HandleEnmity()
{
    TracyZoneScoped;
    PMob->PEnmityContainer->DecayEnmity();
    auto* PHighestEnmityTarget{ PMob->PEnmityContainer->GetHighestEnmity() };

    // If busy, update enmity
    if (PMob->PAI->IsCurrentState<CMobSkillState>() || PMob->PAI->IsCurrentState<CWeaponSkillState>() ||
        PMob->PAI->IsCurrentState<CItemState>())
    {
        return;
    }

    if (PMob->getMobMod(MOBMOD_FIXATE) > 0)
    {
        ChangeTarget(PMob->getMobMod(MOBMOD_FIXATE));

        if (!PMob->GetBattleTargetID())
        {
            if (PHighestEnmityTarget)
            {
                ChangeTarget(PHighestEnmityTarget->targid);
            }
        }
    }
    else if (PMob->getMobMod(MOBMOD_SHARE_TARGET) > 0 && PMob->GetEntity(PMob->getMobMod(MOBMOD_SHARE_TARGET), TYPE_MOB))
    {
        ChangeTarget(static_cast<CMobEntity*>(PMob->GetEntity(PMob->getMobMod(MOBMOD_SHARE_TARGET), TYPE_MOB))->GetBattleTargetID());

        if (!PMob->GetBattleTargetID())
        {
            if (PHighestEnmityTarget)
            {
                ChangeTarget(PHighestEnmityTarget->targid);
            }
        }
    }
    else
    {
        if (PHighestEnmityTarget)
        {
            ChangeTarget(PHighestEnmityTarget->targid);
        }
    }

    // Bind / Palisade special case
    // Target the closest person
    // TODO: do jug pets do this?
    if (PMob->objtype == TYPE_MOB && PTarget && PMob->StatusEffectContainer && PMob->PAI->IsCurrentState<CAttackState>())
    {
        if (PMob->StatusEffectContainer->HasStatusEffect(EFFECT_BIND) || PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PALISADE))
        {
            // ShowDebug("Mob is bound and in Attack State.\n");
            CBattleEntity* PNewTarget = nullptr;
            std::unique_ptr<CBasicPacket> m_errorMsg; // Ignored

            // Check if the current target is out of range and if there is enmity
            if (!PMob->CanAttack(PTarget, m_errorMsg))
            {
                // ShowDebug("Current target is out of range or cannot be attacked. Looking for a new target.\n");

                PMob->PAI->TargetFind->reset();
                PMob->PAI->TargetFind->findWithinArea(PTarget, AOERADIUS_ATTACKER, 7.0f);

                // ShowDebug("Found targets in melee range.\n");

                // If there are targets within melee range, select a random one
                if (!PMob->PAI->TargetFind->m_targets.empty())
                {
                    int targetIndex = tpzrand::GetRandomNumber(PMob->PAI->TargetFind->m_targets.size());
                    PNewTarget = PMob->PAI->TargetFind->m_targets[targetIndex];

                    // ShowDebug("Randomly selected target: %s at index %d\n", PNewTarget->GetName(), targetIndex);
                }
            }

            if (PNewTarget)
            {
                // ShowDebug("Changing target to: %s\n", PNewTarget->name);
                ChangeTarget(PNewTarget->targid);
                FaceTarget(PNewTarget->targid);
            }
        }
    }
}

void CMobController::DoRoamTick(time_point tick)
{
    TracyZoneScopedC(0x00FF00);
    // If there's someone on our enmity list, go from roaming -> engaging
    if (PMob->PEnmityContainer->GetHighestEnmity() != nullptr && !(PMob->m_roamFlags & ROAMFLAG_IGNORE))
    {
        Engage(PMob->PEnmityContainer->GetHighestEnmity()->targid);
        return;
    }
    else if (PMob->m_OwnerID.id != 0 && !(PMob->m_roamFlags & ROAMFLAG_IGNORE))
    {
        // i'm claimed by someone and want to be fighting them
        PTarget = (CBattleEntity*)PMob->GetEntity(PMob->m_OwnerID.targid, TYPE_PC | TYPE_MOB | TYPE_PET | TYPE_TRUST);

        // Don't try to engage someone of the same allegiance
        if (PMob->allegiance != PTarget->allegiance)
        {
            Engage(PTarget->targid);
            return;
        }
    }
    //#TODO
    else if (PMob->GetDespawnTime() > time_point::min() && PMob->GetDespawnTime() < m_Tick)
    {
        Despawn();
        return;
    }

    if (PMob->m_roamFlags & ROAMFLAG_IGNORE)
    {
        // don't claim me if I ignore
        PMob->m_OwnerID.clean();
    }

    if (m_Tick >= m_mobHealTime + 10s && PMob->getMobMod(MOBMOD_NO_REST) == 0 && PMob->CanRest())
    {
        // recover 10% health and lose tp
        if (PMob->Rest(0.1f))
        {
            // health updated
            PMob->updatemask |= UPDATE_HP;
        }

        if (PMob->GetHPP() == 100)
        {
            // at max health undirty exp
            PMob->m_HiPCLvl = 0;
            PMob->m_HiPartySize = 0;
            PMob->m_giveExp = true;
            PMob->m_UsedSkillIds.clear();
        }
        m_mobHealTime = m_Tick;
    }

    //skip roaming if waiting or bound / cced
    if (m_Tick >= m_WaitTime && !PMob->StatusEffectContainer->HasPreventActionEffect(false) && !PMob->StatusEffectContainer->HasStatusEffect(EFFECT_BIND))
    {
        // don't aggro a little bit after I just disengaged
        PMob->m_neutral = PMob->CanBeNeutral() && m_Tick <= m_NeutralTime + 10s;

        if (PMob->PAI->PathFind->IsFollowingPath())
        {
            FollowRoamPath();
        }
        else if (m_Tick >= m_LastActionTime + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_ROAM_COOL)))
        {
            // lets buff up or move around

            if (PMob->CalledForHelp())
            {
                PMob->CallForHelp(false);
            }

            // if I just disengaged check if I should despawn
            if (PMob->getMobMod(MOBMOD_RETURN_TO_SPAWN) != 0)
            {
                PMob->loc.p = PMob->m_SpawnPoint;
            }
            if (PMob->IsFarFromHome())
            {
                if (PMob->CanRoamHome() && PMob->PAI->PathFind->PathTo(PMob->m_SpawnPoint))
                {
                    // walk back to spawn if too far away

                    // limit total path to just 10 or
                    // else we'll move straight back to spawn
                    PMob->PAI->PathFind->LimitDistance(10.0f);

                    FollowRoamPath();

                    // move back every 5 seconds
                    m_LastActionTime = m_Tick - (std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_ROAM_COOL)) + 10s);
                }
                else if (!PMob->getMobMod(MOBMOD_NO_DESPAWN) != 0 && !map_config.mob_no_despawn)
                {
                    PMob->PAI->Despawn();
                    return;
                }
            }
            else
            {
                // No longer including conditional for ROAMFLAG_AMBUSH now that using mixin to handle mob hiding
                if (PMob->getMobMod(MOBMOD_SPECIAL_SKILL) != 0 &&
                    m_Tick >= m_LastSpecialTime + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_SPECIAL_COOL)) &&
                    TrySpecialSkill())
                {
                    // I spawned a pet
                }
                else if (PMob->GetMJob() == JOB_SMN && CanCastSpells() && PMob->SpellContainer->HasBuffSpells() && m_Tick >= m_NextMagicTime)
                {
                    // summon pet
                    auto spellID = PMob->SpellContainer->GetBuffSpell();
                    if(spellID)
                    {
                        CastSpell(spellID.value());
                        m_LastActionTime = m_Tick;
                        return;
                    }
                }
                else if (CanCastSpells() && tpzrand::GetRandomNumber(10) < 5 && PMob->SpellContainer->HasBuffSpells())
                {
                    // Cast buff while roaming
                    auto spellID = PMob->SpellContainer->GetBuffSpell();
                    if (spellID)
                    {
                        CastSpell(spellID.value());
                        m_LastActionTime = m_Tick;
                        return;
                    }
                }
                else if (PMob->m_roamFlags & ROAMFLAG_EVENT)
                {
                    // allow custom event action
                    luautils::OnMobRoamAction(PMob);
                    m_LastActionTime = m_Tick;
                }
                else if (PMob->getMobMod(MOBMOD_NO_ROAM) == 0 && PMob->CanRoam() && PMob->PAI->PathFind->RoamAround(PMob->m_SpawnPoint, PMob->GetRoamDistance(), (uint8)PMob->getMobMod(MOBMOD_ROAM_TURNS), PMob->m_roamFlags))
                {
                    //#TODO: #AIToScript (event probably)
                    // Worm going underground and moving logic
                    if (PMob->m_roamFlags & ROAMFLAG_WORM)
                    {
                        // move down
                        PMob->animationsub = 1;
                        PMob->HideName(true);
                        PMob->Untargetable(true);

                        // don't move around until i'm fully in the ground
                        Wait(2s);
                    }
                    else if ((PMob->m_roamFlags & ROAMFLAG_STEALTH))
                    {
                        // hidden name
                        PMob->HideName(true);
                        PMob->Untargetable(true);

                        PMob->updatemask |= UPDATE_HP;
                    }
                    else
                    {
                        FollowRoamPath();
                    }
                }
                else
                {
                    m_LastActionTime = m_Tick;
                }
            }
        }
    }
    if (m_Tick >= m_LastRoamScript + 3s)
    {
        // Despawn if you are a pet and your master is dead
        if (PMob->PMaster != nullptr)
        {
            if (PMob->PMaster->isDead())
            {
                Despawn();
                return;
            }
        }

        PMob->PAI->EventHandler.triggerListener("ROAM_TICK", PMob);
        PMob->StatusEffectContainer->DelStatusEffect(EFFECT_HEALING);
        luautils::OnMobRoam(PMob);
        m_LastRoamScript = m_Tick;
    }
}

void CMobController::Wait(duration _duration)
{
    if (m_Tick > m_WaitTime)
    {
        m_WaitTime = m_Tick += _duration;
    }
    else
    {
        m_WaitTime += _duration;
    }
}

void CMobController::FollowRoamPath()
{
    TracyZoneScoped;
    if (PMob->PAI->CanFollowPath())
    {
        PMob->PAI->PathFind->FollowPath();

        CBattleEntity* PPet = PMob->PPet;
        if (PPet != nullptr)
        {
            if (PPet != nullptr && PPet->PAI->IsSpawned() && !PPet->PAI->IsEngaged())
            {
                // pet should follow me if roaming
                position_t targetPoint = nearPosition(PMob->loc.p, 2.1f, (float)M_PI);

                PPet->PAI->PathFind->PathTo(targetPoint);
            }
        }

        CBattleEntity* PPet2 = PMob->PPet2;
        if (PPet2 != nullptr)
        {
            if (PPet2 != nullptr && PPet2->PAI->IsSpawned() && !PPet2->PAI->IsEngaged())
            {
                // pet should follow me if roaming
                position_t targetPoint = nearPosition(PMob->loc.p, 2.1f, (float)M_PI);

                PPet2->PAI->PathFind->PathTo(targetPoint);
            }
        }

        // if I just finished reset my last action time
        if (!PMob->PAI->PathFind->IsFollowingPath())
        {
            uint16 roamRandomness = (uint16)(PMob->getBigMobMod(MOBMOD_ROAM_COOL) / PMob->GetRoamRate());
            m_LastActionTime = m_Tick - std::chrono::milliseconds(tpzrand::GetRandomNumber(roamRandomness));

            // i'm a worm pop back up
            if (PMob->m_roamFlags & ROAMFLAG_WORM)
            {
                PMob->animationsub = 0;
                PMob->HideName(false);
                PMob->Untargetable(false);
            }

            // face spawn rotation if I just moved back to spawn
            // used by dynamis mobs, bcnm mobs etc
            if ((PMob->m_roamFlags & ROAMFLAG_EVENT) &&
                distance(PMob->loc.p, PMob->m_SpawnPoint) <= PMob->m_maxRoamDistance)
            {
                PMob->loc.p.rotation = PMob->m_SpawnPoint.rotation;
            }
        }


        if (PMob->PAI->PathFind->OnPoint()) {
            luautils::OnPath(PMob);
        }
    }
}

void CMobController::Despawn()
{
    TracyZoneScoped;
    if (PMob)
    {
        PMob->PAI->Internal_Despawn();
    }
}

void CMobController::Reset()
{
    TracyZoneScoped;
    // Wait a little before roaming / casting spell / spawning pet
    m_LastActionTime = m_Tick - std::chrono::milliseconds(tpzrand::GetRandomNumber(PMob->getBigMobMod(MOBMOD_ROAM_COOL)));

    // Don't attack player right off of spawn
    PMob->m_neutral = true;
    m_NeutralTime = m_Tick;

    PTarget = nullptr;
}

bool CMobController::MobSkill(uint16 targid, uint16 wsid)
{
    TracyZoneScoped;
    if (POwner)
    {
        return POwner->PAI->Internal_MobSkill(targid, wsid);
    }

    return false;
}

bool CMobController::Disengage()
{
    TracyZoneScoped;
    // this will let me decide to walk home or despawn
    m_LastActionTime = m_Tick - std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_ROAM_COOL)) + 10s;
    PMob->m_neutral = true;
    m_NeutralTime = m_Tick;

    PMob->PAI->PathFind->Clear();
    PMob->PEnmityContainer->Clear();

    if (PMob->getMobMod(MOBMOD_IDLE_DESPAWN))
    {
        PMob->SetDespawnTime(std::chrono::seconds(PMob->getMobMod(MOBMOD_IDLE_DESPAWN)));
    }

    PMob->m_OwnerID.clean();
    PMob->updatemask |= (UPDATE_STATUS | UPDATE_HP);
    PMob->CallForHelp(false);
    PMob->animation = ANIMATION_NONE;
    // https://www.bluegartr.com/threads/108198-Random-Facts-Thread-Traits-and-Stats-(Player-and-Monster)?p=5670209&viewfull=1#post5670209
    PMob->m_THLvl = 0;
    PMob->extDataUpdateFlag = true;
    m_mobHealTime = m_Tick;

    return CController::Disengage();
}

bool CMobController::Engage(uint16 targid)
{
    TracyZoneScoped;
    auto ret = CController::Engage(targid);
    if (ret)
    {
        m_firstSpell = true;

        // Don't cast magic or use special ability right away
        if (PMob->getBigMobMod(MOBMOD_MAGIC_DELAY) > 0)
        {
            m_NextMagicTime = m_Tick + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_MAGIC_DELAY));
        }

        if (PMob->getBigMobMod(MOBMOD_SPECIAL_DELAY) > 0)
        {
            m_LastSpecialTime = m_Tick - std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_SPECIAL_DELAY));
        }
        // i'm a worm pop back up
        if (PMob->m_roamFlags & ROAMFLAG_WORM)
        {
            PMob->animationsub = 0;
            PMob->HideName(false);
            PMob->Untargetable(false);
        }

        // Pet should also fight the target if they can
        if (PMob->PPet && !PMob->PPet->PAI->IsEngaged())
        {
            PMob->PPet->PAI->Engage(targid);
        }

        if (PMob->PPet2 && !PMob->PPet2->PAI->IsEngaged())
        {
            PMob->PPet2->PAI->Engage(targid);
        }
    }
    return ret;
}

void CMobController::OnCastStopped(CMagicState& state, action_t& action)
{
    int32 magicCool = PMob->getBigMobMod(MOBMOD_MAGIC_COOL);
    m_NextMagicTime = m_Tick + std::chrono::milliseconds(magicCool);
}

int32 CMobController::GetFomorHate(CBattleEntity* PTarget)
{
    if (!PTarget || PTarget->objtype != TYPE_PC)
    {
        return -1;
    }
    CCharEntity* PChar = (CCharEntity*)PTarget;
    int32 hate = (int32)PChar->m_fomorHate;
    PChar->ForAlliance([PChar, &hate](CBattleEntity* PMember) {
        if (PMember->id != PChar->id && PMember->objtype == TYPE_PC && PMember->loc.zone->GetID() == PChar->loc.zone->GetID())
        {
            int32 memberHate = ((CCharEntity*)PMember)->m_fomorHate;
            if (memberHate > hate)
            {
                hate = memberHate;
            }
        }
    });
    return hate;
}

int32 CMobController::GetPixieHate(CBattleEntity* PTarget)
{
    if (!PTarget || PTarget->objtype != TYPE_PC)
    {
        return -1;
    }
    CCharEntity* PChar = (CCharEntity*)PTarget;
    int32 hate = (int32)PChar->m_pixieHate;
    return hate;
}



bool CMobController::CanAggroTarget(CBattleEntity* PTarget)
{
    TracyZoneScoped;
    TracyZoneIString(PMob->GetName());
    TracyZoneIString(PTarget->GetName());

    // Don't aggro I'm a fomor and I don't hate you
    if (PMob->getMobMod(MOBMOD_FOMOR_HATE) > 0)
    {
        int32 hate = GetFomorHate(PTarget);
        if (hate >= 0 && hate < 8)
        {
            return false;
        }
    }


    // Don't aggro I'm neutral
    if ((PMob->getMobMod(MOBMOD_ALWAYS_AGGRO) == 0 && !PMob->m_Aggro) || PMob->m_neutral || PMob->isDead())
    {
        return false;
    }

    // Don't aggro I'm special
    if (PMob->getMobMod(MOBMOD_NO_AGGRO) > 0)
    {
        return false;
    }

    // Don't aggro I'm a players charmed pet
    if (PTarget->objtype == TYPE_MOB && PTarget->isCharmed)
    {
        return false;
    }

    // Don't aggro I'm an underground worm
    if ((PMob->m_roamFlags & ROAMFLAG_WORM) && PMob->IsNameHidden())
    {
        return false;
    }

    if (PTarget->isDead() || PTarget->isMounted())
    {
        return false;
    }

    if (PMob->PMaster == nullptr && PMob->PAI->IsSpawned() && !PMob->PAI->IsEngaged() && CanDetectTarget(PTarget))
    {
        return true;
    }

    return false;
}

void CMobController::TapDeaggroTime()
{
    m_DeaggroTime = m_Tick;
}

void CMobController::TapDeclaimTime()
{
    m_DeclaimTime = m_Tick;
}

bool CMobController::DeaggroEntity(CBattleEntity* PEntity)
{
    if (!PEntity)
    {
        return false;
    }
    m_forcedDeaggroEntities.push_back(PEntity);
    return true;
}

bool CMobController::DeaggroAll()
{
    m_forceDeaggroAll = true;
    return true;
}


bool CMobController::Cast(uint16 targid, SpellID spellid)
{
    TracyZoneScoped;
    FaceTarget(targid);
    return CController::Cast(targid, spellid);
}

bool CMobController::CanMoveForward(float currentDistance)
{
    TracyZoneScoped;
    // Move forward if target is not in LOS
    if (!PMob->CanSeeTarget(PTarget))
    {
        return true;
    }

    // If behavior bitflag is standback, don't move if < 20 yards from target
    if(PMob->m_Behaviour & BEHAVIOUR_STANDBACK && currentDistance < 20)
    {
        return false;
    }

    // If mob mod no standback is 0, or HP is above MOBMOD_HP_STANDBACK, don't move forward
    if (PMob->getMobMod(MOBMOD_NO_STANDBACK) == 0 && PMob->getMobMod(MOBMOD_HP_STANDBACK) > 0 && currentDistance < 15 && PMob->GetHPP() >= PMob->getMobMod(MOBMOD_HP_STANDBACK)
        && currentDistance > PMob->GetMeleeRange() * 2)
    {
        // Excluding Nins, mobs should not standback if can't cast magic
        if (PMob->GetMJob() != JOB_NIN && PMob->SpellContainer->HasSpells() && !CanCastSpells())
        {
            return true;
        }

        return false;
    }

    if(PMob->getMobMod(MOBMOD_SPAWN_LEASH) > 0 && distance(PMob->loc.p, PMob->m_SpawnPoint) > PMob->getMobMod(MOBMOD_SPAWN_LEASH))
    {
        return false;
    }

    return true;
}

bool CMobController::IsSpecialSkillReady(float currentDistance)
{
    TracyZoneScoped;
    if (PMob->getMobMod(MOBMOD_SPECIAL_SKILL) == 0)
        return false;

    if (PMob->StatusEffectContainer->HasStatusEffect(EFFECT_CHAINSPELL))
        return false;

    int32 bonusTime = 0;
    if (currentDistance > 5)
    {
        // Mobs use ranged attacks quicker when standing back
        bonusTime = PMob->getBigMobMod(MOBMOD_STANDBACK_COOL);
    }

    if (m_Tick >= m_LastSpecialTime + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_SPECIAL_COOL) - bonusTime))
    {
        return true;
    }

    return false;
}

bool CMobController::IsRangedAttackReady(float currentDistance)
{
    TracyZoneScoped;

    if (PMob->getMobMod(MOBMOD_CAN_RA) == 0)
        return false;

    if (PMob->StatusEffectContainer->HasStatusEffect(EFFECT_CHAINSPELL))
        return false;

    int32 bonusTime = 0;
    if (currentDistance > 5)
    {
        // Mobs use ranged attacks quicker when standing back
        bonusTime = PMob->getBigMobMod(MOBMOD_STANDBACK_COOL);
    }

    if (m_Tick >= m_LastRangedAttackTime + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_CAN_RA) - bonusTime))
    {
        return true;
    }
    return false;
}

bool CMobController::IsSpellReady(float currentDistance)
{
    TracyZoneScoped;
    int32 bonusTime = 0;

    if (PMob->m_forceCast)
    {
        return true;
    }

    if (PMob->StatusEffectContainer->HasStatusEffect({EFFECT_CHAINSPELL, EFFECT_MANAFONT, EFFECT_AZURE_LORE, EFFECT_TABULA_RASA}))
    {
        return true;
    }

    return m_Tick >= m_NextMagicTime;
}

bool CMobController::Ability(uint16 targid, uint16 abilityid)
{
    if (PMob->PAI->CanChangeState())
    {
        return PMob->PAI->Internal_Ability(targid, abilityid);
    }
    return false;
}

bool CMobController::RangedAttack(uint16 targid)
{
    TracyZoneScoped;

    if (PMob->PAI->CanChangeState() && PMob->PAI->Internal_RangedAttack(targid))
    {
        m_LastRangedAttackTime = m_Tick;
    }
    return false;
}

bool CMobController::UseItem(uint16 targid, uint8 loc, uint16 slotid)
{
    auto PMob = static_cast<CMobEntity*>(POwner);
    if (PMob->PAI->CanChangeState())
    {
        if (PMob->StatusEffectContainer->HasStatusEffect(EFFECT_MUDDLE))
        {
            return false;
        }
        return PMob->PAI->Internal_UseItem(targid, loc, slotid);
    }
    return false;
}

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

#include "../../common/utils.h"

#include <math.h>

#include "battleutils.h"
#include "../grades.h"
#include "../trait.h"
#include "mobutils.h"
#include "petutils.h"
#include "zoneutils.h"
#include "../lua/luautils.h"
#include "../mob_modifier.h"
#include "../mob_spell_list.h"
#include "../spell.h"
#include "../items/item_weapon.h"
#include "../status_effect_container.h"
#include "../mob_spell_container.h"
#include "../ai/ai_container.h"
#include <vector>
#include "../packets/action.h"

namespace mobutils
{
    ModsMap_t mobFamilyModsList;
    ModsMap_t mobPoolModsList;
    ModsMap_t mobSpawnModsList;

    /************************************************************************
    *                                                                       *
    *  Calculate mob base weapon damage                                     *
    *                                                                       *
    ************************************************************************/

    uint16 GetWeaponDamage(CMobEntity* PMob, uint16 slot)
    {
        uint16 lvl = PMob->GetMLevel();
        int8 bonus = 2;
        uint16 damage = 0;

        if (slot == SLOT_RANGED)
        {
            bonus = 5;
        }

        if (lvl == 1)
        {
            bonus = 0;
        }

        damage = lvl + bonus;

        // Some mobs can have H2H skill but not be a MNK (Like Vampyrs)
        if (PMob->GetMJob() == JOB_MNK || PMob->GetMJob() == JOB_PUP || ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->getSkillType() == SKILL_HAND_TO_HAND)
        {
            uint16 h2hskill = battleutils::GetMaxSkill(SKILL_HAND_TO_HAND, JOB_MNK, PMob->GetMLevel());
            // https://ffxiclopedia.fandom.com/wiki/Category:Hand-to-Hand
            damage = 0.11f * h2hskill + 3 +
                     18 * PMob->GetMLevel() / 75; // basic h2h weapon dmg + scaling "weapon" for mnk mobs based on h2h skill (destroyers 18 dmg at 75)
        }

        // DW mobs use 1h weapon damage instead of 2h
        if (PMob->getMobMod(MOBMOD_DUAL_WIELD) > 0)
        {
            damage = (lvl / 2) + bonus;
        }

        damage = (uint16)(damage * PMob->m_dmgMult / 100.0f);

        if (PMob->getMobMod(MOBMOD_WEAPON_BONUS) != 0)
        {
            damage += (uint16)(PMob->getMobMod(MOBMOD_WEAPON_BONUS));
        }

        return damage;
    }

    // Gest base skill rankings for ACC/ATT/EVA/MEVA
    uint16 GetBase(CMobEntity* PMob, uint8 rank)
    {
        int8 mlvl = PMob->GetMLevel();

        switch (rank)
        {
            case 1:
                return battleutils::GetMaxSkill(SKILL_GREAT_AXE, JOB_WAR, mlvl); // A+ Skill (1)
            case 2:
                return battleutils::GetMaxSkill(SKILL_PARRY, JOB_DNC, mlvl); // B Skill (2)
            case 3:
                return battleutils::GetMaxSkill(SKILL_SINGING, JOB_BRD, mlvl); // C Skill (3)
            case 4:
                return battleutils::GetMaxSkill(SKILL_ARCHERY, JOB_WAR, mlvl); // D Skill (4)
            case 5:
                return battleutils::GetMaxSkill(SKILL_THROWING, JOB_MNK, mlvl); // E Skill (5)
        }

        ShowError("Mobutils::GetBase rank (%d) is out of bounds for mob (%u) ", rank, PMob->id);
        return 0;
    }

    uint16 GetMagicEvasion(CMobEntity* PMob)
    {
        uint8 mEvaRank = 3;
        return GetBase(PMob, mEvaRank);
    }

    /************************************************************************
     *                                                                       *
     *  Base value for defense                       *
     *                                                                       *
     ************************************************************************/

    uint16 GetDefense(CMobEntity* PMob, uint8 rank)
    {
        // family defense = [floor(defRank) + 8 + vit / 2 + job traits] * family multiplier
        uint8 lvl = PMob->GetMLevel();

        if (lvl > 50)
        {
            switch (rank)
            {
                case 1: // A
                    return (uint16)std::floor(153 + (lvl - 50) * 5.0f);
                case 2: // B
                    return (uint16)std::floor(147 + (lvl - 50) * 4.9f);
                case 3: // C
                    return (uint16)std::floor(142 + (lvl - 50) * 4.8f);
                case 4: // D
                    return (uint16)std::floor(136 + (lvl - 50) * 4.7f);
                case 5: // E
                    return (uint16)std::floor(126 + (lvl - 50) * 4.5f);
            }
        }
        else
        {
            switch (rank)
            {
                case 1: // A
                    return (uint16)std::floor(6 + (lvl - 1) * 3.0f);
                case 2: // B
                    return (uint16)std::floor(5 + (lvl - 1) * 2.9f);
                case 3: // C
                    return (uint16)std::floor(5 + (lvl - 1) * 2.8f);
                case 4: // D
                    return (uint16)std::floor(4 + (lvl - 1) * 2.7f);
                case 5: // E
                    return (uint16)std::floor(4 + (lvl - 1) * 2.5f);
            }
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Base value for stat calculations                                     *
     *                                                                       *
     ************************************************************************/

    uint16 GetBaseToRank(uint8 rank, uint16 lvl)
    {
        switch (rank)
        {
            case 1:
                return (5 + ((lvl - 1) * 50) / 100); // A
            case 2:
                return (4 + ((lvl - 1) * 45) / 100); // B
            case 3:
                return (4 + ((lvl - 1) * 40) / 100); // C
            case 4:
                return (3 + ((lvl - 1) * 35) / 100); // D
            case 5:
                return (3 + ((lvl - 1) * 30) / 100); // E
            case 6:
                return (2 + ((lvl - 1) * 25) / 100); // F
            case 7:
                return (2 + ((lvl - 1) * 20) / 100); // G
        }

        return 0;
    }

    /************************************************************************
 *                                                                       *
 *  Calculate mob stats                                                  *
 *                                                                       *
 ************************************************************************/

void CalculateMobStats(CMobEntity* PMob, bool recover)
{
    // remove all to keep mods in sync
    PMob->StatusEffectContainer->KillAllStatusEffect();
    PMob->restoreModifiers();
    PMob->restoreMobModifiers();

    bool isNM = PMob->m_Type & MOBTYPE_NOTORIOUS || PMob->m_Type & MOBTYPE_BATTLEFIELD || PMob->m_Type & MOBTYPE_QUEST ||
        PMob->getMobMod(MOBMOD_CHECK_AS_NM) > 0;
    JOBTYPE mJob = PMob->GetMJob();
    JOBTYPE sJob = PMob->GetSJob();
    uint8 mLvl = PMob->GetMLevel();
    uint8 sLvl = PMob->GetSLevel();
    ZONETYPE zoneType = PMob->loc.zone->GetType();
    ZONEID zoneID = PMob->loc.zone->GetID();

    uint8 mJobGrade; // main jobs grade
    uint8 sJobGrade; // subjobs grade

    if (recover == true)
    {
        if (PMob->HPmodifier == 0)
        {
            uint32 mobHP = 1; // Set mob HP

            uint32 baseMobHP = 0; // Define base mobs hp
            uint32 sjHP = 0;      // Define base subjob hp

            mJobGrade = grade::GetJobGrade(mJob, 0); // main jobs grade
            sJobGrade = grade::GetJobGrade(sJob, 0); // subjobs grade

            uint8 base = 0;     // Column for base hp
            uint8 jobScale = 1; // Column for job scaling
            uint8 scaleX = 2;   // Column for modifier scale

            uint8 BaseHP = grade::GetMobHPScale(mJobGrade, base);         // Main job base HP
            uint8 JobScale = grade::GetMobHPScale(mJobGrade, jobScale);   // Main job scaling
            uint8 ScaleXHP = grade::GetMobHPScale(mJobGrade, scaleX);     // Main job modifier scale
            uint8 sjJobScale = grade::GetMobHPScale(sJobGrade, jobScale); // Sub job scaling
            uint8 sjScaleXHP = grade::GetMobHPScale(sJobGrade, scaleX);   // Sub job modifier scale

            uint8 RIgrade = std::min(mLvl, (uint8)5); // RI Grade
            uint8 RIbase = 1;                         // Column for RI base

            uint8 RI = grade::GetMobRBI(RIgrade, RIbase); // Random Increment addition per grade vs. base

            uint8 mLvlIf = (PMob->GetMLevel() > 5 ? 1 : 0);
            uint8 mLvlIf30 = (PMob->GetMLevel() > 30 ? 1 : 0);
            uint8 raceScale = 6;
            uint8 mLvlScale = 0;

            if (mLvl > 0)
            {
                baseMobHP = BaseHP + (std::min(mLvl, (uint8)5) - 1) * (JobScale + raceScale - 1) + RI +
                            mLvlIf * (std::min(mLvl, (uint8)30) - 5) * (2 * (JobScale + raceScale) + std::min(mLvl, (uint8)30) - 6) / 2 +
                            mLvlIf30 * ((mLvl - 30) * (63 + ScaleXHP) + (mLvl - 31) * (JobScale + raceScale));
            }

            // 50+ = 1 hp sjstats
            if (mLvl > 49)
            {
                mLvlScale = std::floor(mLvl);
            }
            // 40-49 = 3/4 hp sjstats
            else if (mLvl > 39)
            {
                mLvlScale = std::floor(mLvl * 0.75);
            }
            // 31-39 = 1/2 hp sjstats
            else if (mLvl > 30)
            {
                mLvlScale = std::floor(mLvl * 0.50);
            }
            // 25-30 = 1/4 hp sjstats
            else if (mLvl > 24)
            {
                mLvlScale = std::floor(mLvl * 0.25);
            }
            // 1-24 = no hp sjstats
            else
            {
                mLvlScale = 0;
            }

            sjHP = std::ceil((sjJobScale * (std::max((mLvlScale - 1), 0)) + (0.5 + 0.5 * sjScaleXHP) * (std::max(mLvlScale - 10, 0)) +
                              std::max(mLvlScale - 30, 0) + std::max(mLvlScale - 50, 0) + std::max(mLvlScale - 70, 0)) /
                             2);

            // Orcs 5% more hp
            if ((PMob->m_Family == 189) || (PMob->m_Family == 190) || (PMob->m_Family == 334) || (PMob->m_Family == 407) || (PMob->m_Family == 944) ||
                (PMob->m_Family == 945))
            {
                mobHP = (baseMobHP + sjHP) * 1.05;
            }
            // Quadavs 5% less hp
            else if ((PMob->m_Family == 200) || (PMob->m_Family == 201) || (PMob->m_Family == 202) || (PMob->m_Family == 337) || (PMob->m_Family == 397) ||
                     (PMob->m_Family == 408) || (PMob->m_Family == 942))
            {
                mobHP = (baseMobHP + sjHP) * .95;
            }
            // Trolls, Mamools and Lamia / Merrow get 10% more HP
            else if (PMob->m_Family == 171 || PMob->m_Family == 176 || PMob->m_Family == 177 || PMob->m_Family == 182 || PMob->m_Family == 246 ||
                     PMob->m_Family == 591)
            {
                mobHP = (baseMobHP + sjHP) * 1.10;
            }
            // Manticore family has 50% more HP
            else if (PMob->m_Family == 179)
            {
                mobHP = (baseMobHP + sjHP) * 1.5;
            }
            // Qutrub family has 400% more HP
            else if (PMob->m_Family >= 203 && PMob->m_Family <= 205)
            {
                mobHP = (baseMobHP + sjHP) * 3.0;
            }
            // Chigoe family have ~20% of mob HP
            else if (PMob->m_Family == 64)
            {
                mobHP = (baseMobHP + sjHP) * 0.20f;
            }
            else
            {
                mobHP = baseMobHP + sjHP;
            }

            if (PMob->PMaster != nullptr)
            {
                mobHP *= 0.30f; // Retail captures have all pets at 30% of the mobs family of the same level
            }

            PMob->health.maxhp = (int16)(mobHP);
        }
        else
        {
            PMob->health.maxhp = PMob->HPmodifier;
        }

        if (isNM)
        {
            PMob->health.maxhp = (int32)(PMob->health.maxhp * map_config.nm_hp_multiplier);
        }
        else
        {
            PMob->health.maxhp = (int32)(PMob->health.maxhp * map_config.mob_hp_multiplier);
        }

        bool hasMp = false;

        switch (mJob)
        {
            case JOB_PLD:
            case JOB_WHM:
            case JOB_BLM:
            case JOB_RDM:
            case JOB_DRK:
            case JOB_BLU:
            case JOB_SCH:
            case JOB_SMN:
            case JOB_GEO:
            case JOB_RUN:
                hasMp = true;
                break;
            default:
                break;
        }

        switch (sJob)
        {
            case JOB_PLD:
            case JOB_WHM:
            case JOB_BLM:
            case JOB_RDM:
            case JOB_DRK:
            case JOB_BLU:
            case JOB_SCH:
            case JOB_SMN:
            case JOB_GEO:
            case JOB_RUN:
                hasMp = true;
                break;
            default:
                break;
        }

        if (PMob->getMobMod(MOBMOD_MP_BASE))
        {
            hasMp = true;
        }

        if (hasMp)
        {
            float scale = PMob->MPscale;

            if (PMob->getMobMod(MOBMOD_MP_BASE))
            {
                scale = (float)PMob->getMobMod(MOBMOD_MP_BASE) / 100.0f;
            }

            if (PMob->MPmodifier == 0)
            {
                PMob->health.maxmp = (int16)(18.2 * pow(mLvl, 1.1075) * scale) + 10;
            }
            else
            {
                PMob->health.maxmp = PMob->MPmodifier;
            }

            if (isNM)
            {
                PMob->health.maxmp = (int32)(PMob->health.maxmp * map_config.nm_mp_multiplier);
            }
            else
            {
                PMob->health.maxmp = (int32)(PMob->health.maxmp * map_config.mob_mp_multiplier);
            }
        }
    }

    ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDamage(GetWeaponDamage(PMob, SLOT_MAIN));
    ((CItemWeapon*)PMob->m_Weapons[SLOT_RANGED])->setDamage(GetWeaponDamage(PMob, SLOT_RANGED));

    // reduce weapon delay of MNK
    if (PMob->GetMJob() == JOB_MNK)
    {
        ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->resetDelay();
    }

    // Deprecate MOBMOD_DUAL_WIELD later, replace if check with value from DB
    if (PMob->getMobMod(MOBMOD_DUAL_WIELD))
    {
        PMob->m_dualWield = true;
    }

    uint16 fSTR = GetBaseToRank(PMob->strRank, mLvl);
    uint16 fDEX = GetBaseToRank(PMob->dexRank, mLvl);
    uint16 fVIT = GetBaseToRank(PMob->vitRank, mLvl);
    uint16 fAGI = GetBaseToRank(PMob->agiRank, mLvl);
    uint16 fINT = GetBaseToRank(PMob->intRank, mLvl);
    uint16 fMND = GetBaseToRank(PMob->mndRank, mLvl);
    uint16 fCHR = GetBaseToRank(PMob->chrRank, mLvl);

    uint16 mSTR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 2), mLvl);
    uint16 mDEX = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 3), mLvl);
    uint16 mVIT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 4), mLvl);
    uint16 mAGI = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 5), mLvl);
    uint16 mINT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 6), mLvl);
    uint16 mMND = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 7), mLvl);
    uint16 mCHR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 8), mLvl);

    uint16 sSTR = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 2), sLvl);
    uint16 sDEX = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 3), sLvl);
    uint16 sVIT = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 4), sLvl);
    uint16 sAGI = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 5), sLvl);
    uint16 sINT = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 6), sLvl);
    uint16 sMND = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 7), sLvl);
    uint16 sCHR = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(), 8), sLvl);

    // As per conversation with Jimmayus, all mobs at any level get bonus stats from subjobs.
    // From lvl 45 onwards, 1/2. Before lvl 30, 1/4. In between, the value gets progresively higher, from 1/4 at 30 to 1/2 at 44.
    // Im leaving that range at 1/3, for now.
    if (mLvl >= 45)
    {
        sSTR /= 2;
        sDEX /= 2;
        sAGI /= 2;
        sINT /= 2;
        sMND /= 2;
        sCHR /= 2;
        sVIT /= 2;
    }
    else if (mLvl > 30)
    {
        sSTR /= 3;
        sDEX /= 3;
        sAGI /= 3;
        sINT /= 3;
        sMND /= 3;
        sCHR /= 3;
        sVIT /= 3;
    }
    else
    {
        sSTR /= 4;
        sDEX /= 4;
        sAGI /= 4;
        sINT /= 4;
        sMND /= 4;
        sCHR /= 4;
        sVIT /= 4;
    }

    // [stat] = floor[family Stat] + floor[main job Stat] + floor[sub job Stat]
    PMob->stats.STR = fSTR + mSTR + sSTR;
    PMob->stats.DEX = fDEX + mDEX + sDEX;
    PMob->stats.VIT = fVIT + mVIT + sVIT;
    PMob->stats.AGI = fAGI + mAGI + sAGI;
    PMob->stats.INT = fINT + mINT + sINT;
    PMob->stats.MND = fMND + mMND + sMND;
    PMob->stats.CHR = fCHR + mCHR + sCHR;

    auto statMultiplier = isNM ? map_config.mob_stat_multiplier : map_config.nm_stat_multiplier;
    PMob->stats.STR = (uint16)(PMob->stats.STR * statMultiplier);
    PMob->stats.DEX = (uint16)(PMob->stats.DEX * statMultiplier);
    PMob->stats.VIT = (uint16)(PMob->stats.VIT * statMultiplier);
    PMob->stats.AGI = (uint16)(PMob->stats.AGI * statMultiplier);
    PMob->stats.INT = (uint16)(PMob->stats.INT * statMultiplier);
    PMob->stats.MND = (uint16)(PMob->stats.MND * statMultiplier);
    PMob->stats.CHR = (uint16)(PMob->stats.CHR * statMultiplier);


    // special case, give spell list to my pet
    if(PMob->getMobMod(MOBMOD_PET_SPELL_LIST) && PMob->PPet != nullptr)
    {
        // Stubborn_Dredvodd
        CMobEntity* PPet = (CMobEntity*)PMob->PPet;

        // give pet spell list
        PPet->m_SpellListContainer = mobSpellList::GetMobSpellList(PMob->getMobMod(MOBMOD_PET_SPELL_LIST));
    }

    if(PMob->getMobMod(MOBMOD_SPELL_LIST))
    {
        PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(PMob->getMobMod(MOBMOD_SPELL_LIST));
    }

    // cap all combat and magic skills for mobs
    for (int i=SKILL_DIVINE_MAGIC; i <=SKILL_BLUE_MAGIC; i++)
    {
        uint16 maxSkill = battleutils::GetMaxSkill(SKILL_ENFEEBLING_MAGIC, JOB_RDM, PMob->GetMLevel());
        if (maxSkill != 0)
        {
            PMob->WorkingSkills.skill[i] = maxSkill;
        }
        else //if the mob is WAR/BLM and can cast spell
        {
            // set skill as high as main level, so their spells won't get resisted
            uint16 maxSubSkill = battleutils::GetMaxSkill(SKILL_ENFEEBLING_MAGIC, JOB_RDM, PMob->GetMLevel());

            if (maxSubSkill != 0)
            {
                PMob->WorkingSkills.skill[i] = maxSubSkill;
            }
        }
    }
    for (int i=SKILL_HAND_TO_HAND; i <=SKILL_STAFF; i++)
    {
        uint16 maxSkill = battleutils::GetMaxSkill(SKILL_ENFEEBLING_MAGIC, JOB_RDM, PMob->GetMLevel());
        if (maxSkill != 0)
        {
            PMob->WorkingSkills.skill[i] = maxSkill;
        }
    }

    PMob->addModifier(Mod::DEF, GetDefense(PMob, PMob->defRank));
    PMob->addModifier(Mod::EVA, GetBase(PMob, PMob->evaRank));  // Base Evasion for all mobs
    PMob->addModifier(Mod::ATT, GetBase(PMob, PMob->attRank));  // Base Attack for all mobs is Rank A+ but pull from DB for specific cases
    PMob->addModifier(Mod::ACC, GetBase(PMob, PMob->accRank));  // Base Accuracy for all mobs is Rank A+ but pull from DB for specific cases
    PMob->addModifier(Mod::RATT, GetBase(PMob, PMob->attRank)); // Base Ranged Attack for all mobs is Rank A+ but pull from DB for specific cases
    PMob->addModifier(Mod::RACC, GetBase(PMob, PMob->accRank)); // Base Ranged Accuracy for all mobs is Rank A+ but pull from DB for specific cases

    // Note: Known Base Parry for all mobs is Rank C
    // MOBMOD_CAN_PARRY uses the mod value as the rank. It is unknown if mobs in current retail or somewhere else have a different parry rank
    // Known mobs to have parry rating
    // 1) Dynamis Mobs
    // 2) ???
    // 3) ???
    if (PMob->getMobMod(MOBMOD_CAN_PARRY) > 0)
    {
        PMob->addModifier(Mod::PARRY, GetBase(PMob, PMob->getMobMod(MOBMOD_CAN_PARRY)));
    }

    // add traits for sub and main
    battleutils::AddTraits(PMob, traits::GetTraits(mJob), mLvl);
    if (mJob != sJob)
    {
        battleutils::AddTraits(PMob, traits::GetTraits(sJob), PMob->GetSLevel());
    }

    // Mobs shouldn't have Inquartata unless Rune Fencers(?)
    if (PMob->GetMJob() != JOB_RUN)
    {
        PMob->setModifier(Mod::INQUARTATA, 0);
    }

    // Max [HP/MP] Boost traits
    PMob->UpdateHealth();
    PMob->health.tp = 0;
    PMob->health.hp = PMob->GetMaxHP();
    PMob->health.mp = PMob->GetMaxMP();

    SetupJob(PMob);
    SetupRoaming(PMob);

    // All beastmen drop gil
    if (PMob->m_EcoSystem == SYSTEM_BEASTMEN)
    {
        PMob->defaultMobMod(MOBMOD_GIL_BONUS, 100);
    }

    if (PMob->PMaster != nullptr)
    {
        SetupPetSkills(PMob);
    }

    PMob->m_Behaviour |= PMob->getMobMod(MOBMOD_BEHAVIOR);

    // Only mobs, not NPCs
    if (PMob->allegiance == ALLEGIANCE_MOB)
    {
        if (zoneType == ZONETYPE_DUNGEON)
        {
            SetupDungeonMob(PMob);
        }
        else if (zoneType == ZONETYPE_BATTLEFIELD)
        {
            SetupBattlefieldMob(PMob);
        }
        else if (zoneType == ZONETYPE_DYNAMIS)
        {
            SetupDynamisMob(PMob);
        }
        else if (zoneType == ZONETYPE_LIMBUS)
        {
            SetupLimbusMob(PMob);
        }
        else if (zoneType == ZONETYPE_DUNGEON_INSTANCED)
        {
            if (zoneID > ZONE_ALZADAAL_UNDERSEA_RUINS && zoneID < ZONE_NYZUL_ISLE)
            {
                SetupSalvageMob(PMob);
            }
            else
            {
                SetupDungeonInstancedMob(PMob);
            }
        }
        else if (zoneType == ZONETYPE_STRONGHOLDS)
        {
            SetupStrongholdsMob(PMob);
        }
    }

    if (PMob->m_Type & MOBTYPE_NOTORIOUS || PMob->m_Type & MOBTYPE_BATTLEFIELD || PMob->m_Type & MOBTYPE_QUEST ||
        PMob->getMobMod(MOBMOD_CHECK_AS_NM) > 0)
    {
        SetupNMMob(PMob);
    }

    if(PMob->m_Type & MOBTYPE_EVENT)
    {
        SetupEventMob(PMob);
    }

    if (PMob->CanStealGil())
    {
        PMob->ResetGilPurse();
    }

    // Check for possible miss-setups
    if (PMob->getMobMod(MOBMOD_SPECIAL_SKILL) != 0 && PMob->getMobMod(MOBMOD_SPECIAL_COOL) == 0)
    {
        ShowError("Mobutils::CalculateMobStats Mob (%s, %d) with special skill but no cool down set!\n", PMob->GetName(), PMob->id);
    }

    if (PMob->SpellContainer->HasSpells() && PMob->getMobMod(MOBMOD_MAGIC_COOL) == 0)
    {
        ShowError("Mobutils::CalculateMobStats Mob (%s, %d) with magic but no cool down set!\n", PMob->GetName(), PMob->id);
    }

    if (PMob->m_Detects == 0)
    {
        ShowError("Mobutils::CalculateMobStats Mob (%s, %d, %d) has no detection methods!\n", PMob->GetName(), PMob->id, PMob->m_Family);
    }
}

void SetupJob(CMobEntity* PMob)
{
    JOBTYPE mJob = PMob->GetMJob();
    JOBTYPE sJob = PMob->GetSJob();
    JOBTYPE job;
    uint8 mLvl = PMob->GetMLevel();
    uint8 sLvl = PMob->GetSLevel();

    if (grade::GetJobGrade(mJob, 1) > 0) // check if mainjob gives mp
    {
        job = mJob;
    }
    else // if mainjob had no MP, use subjob in switch cases.
    {
        job = sJob;
    }

    // WAR mobs have 25% DA
    if (mJob == JOB_WAR && mLvl >= 25)
    {
        PMob->setModifier(Mod::DOUBLE_ATTACK, 25);
    }
    // This switch falls back to a subjob if a mainjob isn't matched, and is mainly magic stuff
    switch(job)
    {
        case JOB_WAR:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::VIRUSRESTRAIT, 0);
            }
            if (mLvl >= 25)
            {
                PMob->setModifier(Mod::DOUBLE_ATTACK, 25);
            }
            break;
        case JOB_SAM:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::BLINDRESTRAIT, 0);
            }
            break;
        case JOB_BLM:
            PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 25);
            PMob->defaultMobMod(MOBMOD_GA_CHANCE, 40);
            PMob->defaultMobMod(MOBMOD_BUFF_CHANCE, 5);
            PMob->defaultMobMod(MOBMOD_SEVERE_SPELL_CHANCE, 10);
            break;
        case JOB_PLD:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::SLEEPRESTRAIT, 0);  
            }
            PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 30);
            PMob->defaultMobMod(MOBMOD_MAGIC_DELAY, 7);
            break;
        case JOB_DRK:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::PARALYZERESTRAIT, 0);
            }
            PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 30);
            PMob->defaultMobMod(MOBMOD_MAGIC_DELAY, 7);
            break;
        case JOB_WHM:
            PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 25);
            PMob->defaultMobMod(MOBMOD_MAGIC_DELAY, 10);
            break;
        case JOB_BRD:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::SILENCERESTRAIT, 0);
            }
            PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 25);
            PMob->defaultMobMod(MOBMOD_GA_CHANCE, 25);
            PMob->defaultMobMod(MOBMOD_BUFF_CHANCE, 60);
            PMob->defaultMobMod(MOBMOD_MAGIC_DELAY, 10);
            break;
        case JOB_BLU:
            PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 25);
            break;
        case JOB_RDM:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::PETRIFYRESTRAIT, 0);
            }
            PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 25);
            PMob->defaultMobMod(MOBMOD_GA_CHANCE, 40);
            PMob->defaultMobMod(MOBMOD_BUFF_CHANCE, 10);
            PMob->defaultMobMod(MOBMOD_MAGIC_DELAY, 10);
            break;
        case JOB_SMN:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::SLOWRESTRAIT, 0);
            }
            PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 5);
            PMob->defaultMobMod(MOBMOD_BUFF_CHANCE, 100); // SMN only has "buffs"
            break;
        case JOB_NIN:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::BINDRESTRAIT, 0);
            }
            PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 16);
            PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 25);
            PMob->defaultMobMod(MOBMOD_BUFF_CHANCE, 75);
            PMob->defaultMobMod(MOBMOD_MAGIC_DELAY, 7);
            break;
        case JOB_SCH:
            PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 25);
            PMob->defaultMobMod(MOBMOD_GA_CHANCE, 40);
            PMob->defaultMobMod(MOBMOD_BUFF_CHANCE, 5);
            PMob->defaultMobMod(MOBMOD_SEVERE_SPELL_CHANCE, 10);
            break;
        case JOB_GEO:
            PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 25);
            PMob->defaultMobMod(MOBMOD_GA_CHANCE, 40);
            PMob->defaultMobMod(MOBMOD_BUFF_CHANCE, 5);
            PMob->defaultMobMod(MOBMOD_SEVERE_SPELL_CHANCE, 10);
            break;
        case JOB_RUN:
            PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 30);
            PMob->defaultMobMod(MOBMOD_GA_CHANCE, 40);
            PMob->defaultMobMod(MOBMOD_BUFF_CHANCE, 5);
            PMob->defaultMobMod(MOBMOD_SEVERE_SPELL_CHANCE, 10);
            break;
        default:
            break;
    }

    // This switch is mainjob only and contains mainly non magic related stuff
    switch(mJob)
    {
        case JOB_THF:
            // thfs drop more gil
            if (PMob->m_EcoSystem == SYSTEM_BEASTMEN)
            {
                // 50% bonus
                PMob->defaultMobMod(MOBMOD_GIL_BONUS, 150);
            }
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::GRAVITYRESTRAIT, 0);
            }
            break;
        case JOB_RNG:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::POISONRESTRAIT, 0);
            }
            // Exclude Gear(s), Fomors(ToAU Shades)
            if (PMob->m_Family != 119 && PMob->m_Family != 120 && PMob->m_Family != 359)
            {
                if ((PMob->m_Family >= 126 && PMob->m_Family <= 130) || PMob->m_Family == 328) // Gigas
                {
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 658); // catapult only used while at range
                }
                else if (PMob->m_Family == 246)
                {
                    // Trolls love cannons, but they take a second to shoot
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 1747);
                    // so slow down the trolls a bit
                    PMob->defaultMobMod(MOBMOD_STANDBACK_COOL, 8);
                }
                else if (PMob->m_Family == 337 || PMob->m_Family == 954) // Quadav
                {
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 1123);
                    PMob->defaultMobMod(MOBMOD_STANDBACK_COOL, 8);
                }
                else if (PMob->m_Family == 358) // Dyna-Kindred
                {
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 1146);
                    PMob->defaultMobMod(MOBMOD_STANDBACK_COOL, 8);
                }
                else if (PMob->m_Family == 3) // Aern
                {
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 1388);
                }
                else
                {
                    // All other rangers
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 272);
                }

                PMob->defaultMobMod(MOBMOD_STANDBACK_COOL, 8);
                PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 16);
                PMob->defaultMobMod(MOBMOD_HP_STANDBACK, 65);
            }
            break;
        case JOB_COR:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::AMNESIARESTRAIT, 0);
                PMob->setModifier(Mod::PARALYZERESTRAIT, 0);
            }
            PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 272);
            PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 16);
            break;
        case JOB_NIN:
            if (!PMob->CMobEntity::IsHumanoid())
                // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::BINDRESTRAIT, 0);
            }
            // Exclude Fomors, Animated Weapons and Mamools
            if (PMob->m_Family != 176 && PMob->m_Family != 115 && PMob->m_Family != 359 && PMob->m_Family != 509 && PMob->m_Family != 17)
            {
                if (PMob->m_Family == 3)
                {
                    // aern
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 1388);
                    PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 16);
                }
                else if (PMob->m_Family == 337) // Dyna-Quadav
                {
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 1123);
                    PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 16);
                }
                else if (PMob->m_Family == 358) // Dyna-Kindred
                {
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 1146);
                    PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 16);
                }
                // exclude NIN Maat
                else if (PMob->m_Family != 335)
                {
                    PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 272);
                    PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 16);
                }

                PMob->defaultMobMod(MOBMOD_STANDBACK_COOL, 8);
                PMob->defaultMobMod(MOBMOD_HP_STANDBACK, 65);
            }
            break;
        case JOB_BST:
         if (!PMob->CMobEntity::IsHumanoid())
         // Only beastmen get resist job traits
         {
         PMob->setModifier(Mod::AMNESIARESTRAIT, 0);
         }
		 if (PMob->m_Family != 3)  // Exclude Aerns, should only summon in combat and hide their jobs
		 {
            PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 180);
            PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 1017);
		 }
            break;
        case JOB_PUP:
            PMob->defaultMobMod(MOBMOD_SPECIAL_SKILL, 1901);
            PMob->defaultMobMod(MOBMOD_SPECIAL_COOL, 180);
            break;
        case JOB_BLM:
            // We don't want to do the mages stand-back part from subjob, so we have it here
            PMob->defaultMobMod(MOBMOD_STANDBACK_COOL, 13);
            PMob->defaultMobMod(MOBMOD_HP_STANDBACK, 65);
            break;
        case JOB_SCH:
            // We don't want to do the mages stand-back part from subjob, so we have it here
            PMob->defaultMobMod(MOBMOD_STANDBACK_COOL, 13);
            PMob->defaultMobMod(MOBMOD_HP_STANDBACK, 65);
            break;
        case JOB_GEO:
            // We don't want to do the mages stand-back part from subjob, so we have it here
            PMob->defaultMobMod(MOBMOD_STANDBACK_COOL, 13);
            PMob->defaultMobMod(MOBMOD_HP_STANDBACK, 65);
            break;
        default:
            break;
    }
    // This switch is subjob only
    switch (sJob)
    {
        case JOB_WAR:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::VIRUSRESTRAIT, 0);
            }
            if (sLvl >= 25)
            {
                PMob->setModifier(Mod::DOUBLE_ATTACK, 25);
            }
            break;
        case JOB_RDM:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::PETRIFYRESTRAIT, 0);
            }
            break;
        case JOB_THF:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::GRAVITYRESTRAIT, 0);
            }
            break;
        case JOB_PLD:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::SLEEPRESTRAIT, 0);
            }
            break;
        case JOB_DRK:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::PARALYZERESTRAIT, 0);
            }
            break;
        case JOB_BRD:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::SILENCERESTRAIT, 0);
            }
            break;
        case JOB_BST:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::AMNESIARESTRAIT, 0);
            }
            break;
        case JOB_RNG:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::POISONRESTRAIT, 0);
            }
            break;
        case JOB_NIN:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::BINDRESTRAIT, 0);
            }
            break;
        case JOB_SAM:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::BLINDRESTRAIT, 0);
            }
            break;
        case JOB_SMN:
            if (!PMob->CMobEntity::IsHumanoid())
            // Only beastmen get resist job traits
            {
                PMob->setModifier(Mod::SLOWRESTRAIT, 0);
            }
            break;
        default:
            break;
    }
}

void SetupRoaming(CMobEntity* PMob)
{
    uint16 distance = 10;
    uint16 turns = 1;
    uint16 cool = 20;
    uint16 rate = 15;

    switch(PMob->m_EcoSystem)
    {
        case SYSTEM_BEASTMEN:
            distance = 20;
            turns = 5;
            cool = 45;
            break;
        default:
            break;
    }

    // default mob roaming mods
    PMob->defaultMobMod(MOBMOD_ROAM_DISTANCE, distance);
    PMob->defaultMobMod(MOBMOD_ROAM_TURNS, turns);
    PMob->defaultMobMod(MOBMOD_ROAM_COOL, cool);
    PMob->defaultMobMod(MOBMOD_ROAM_RATE, rate);

    if(PMob->m_roamFlags & ROAMFLAG_AMBUSH)
    {
        PMob->m_specialFlags |= SPECIALFLAG_HIDDEN;
        // always stay close to spawn
        PMob->m_maxRoamDistance = 2.0f;
        PMob->setMobMod(MOBMOD_ROAM_DISTANCE, 5);
        PMob->setMobMod(MOBMOD_ROAM_TURNS, 1);
    }
}

void SetupPetSkills(CMobEntity* PMob)
{
    int16 skillListId = 0;
    // same mob can spawn as different families
    // can't set this from the database
    switch(PMob->m_Family)
    {
        case 383: // ifrit
            skillListId = 715;
            break;
        case 388: // titan
            skillListId = 716;
            break;
        case 384: // levi
            skillListId = 717;
            break;
        case 382: //garuda
            skillListId = 718;
            break;
        case 387: // shiva
            skillListId = 719;
            break;
        case 386: // ramuh
            skillListId = 720;
            break;
        case 379: // carbuncle
            skillListId = 721;
            break;
    }

    if (skillListId != 0)
    {
        PMob->setMobMod(MOBMOD_SKILL_LIST, skillListId);
    }
}

void SetupDynamisMob(CMobEntity* PMob)
{
    // no gil drop, exp and no mugging!
    PMob->setMobMod(MOBMOD_GIL_MAX, -1);
    PMob->setMobMod(MOBMOD_MUG_GIL, -1);
    PMob->setMobMod(MOBMOD_EXP_BONUS, -100);

    // boost dynamis mobs weapon damage
    PMob->setMobMod(MOBMOD_WEAPON_BONUS, 30); // Add approximately 30 flat damage until proven otherwise (In-line with the 35% added previously)
    ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDamage(GetWeaponDamage(PMob, SLOT_MAIN));
    ((CItemWeapon*)PMob->m_Weapons[SLOT_RANGED])->setDamage(GetWeaponDamage(PMob, SLOT_RANGED));

    // job resist traits are much more powerful in dynamis
    // according to wiki
    for(auto&& PTrait : PMob->TraitList)
    {
        Mod type = PTrait->getMod();

        if(type >= Mod::SLEEPRES && type <= Mod::DEATHRES)
        {
            // give mob a total of x2 the regular rate
            PMob->addModifier(type, PTrait->getValue());
        }
    }

    PMob->addModifier(Mod::REFRESH, 400);
    PMob->PAI->PathFind->SetCarefulPathing(true);
}

void SetupLimbusMob(CMobEntity* PMob)
{
    uint8 mLvl = PMob->GetMLevel();
    // Bonus stats for difficulty
    if (mLvl >= 81)
    {
        if (PMob->GetMJob() != JOB_MNK || ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->getSkillType() != SKILL_HAND_TO_HAND)
        {
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDamage(150);
        }

        PMob->addModifier(Mod::ATTP, 25);
        PMob->addModifier(Mod::DEFP, 25);
        PMob->addModifier(Mod::ACC, 15);
        PMob->addModifier(Mod::EVA, 15);
        PMob->addModifier(Mod::MDEF, 40);
        PMob->addModifier(Mod::UDMGMAGIC, -13);
    }
    else
    {
        if (PMob->GetMJob() != JOB_MNK || ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->getSkillType() != SKILL_HAND_TO_HAND)
        {
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDamage(120);
        }

        PMob->addModifier(Mod::ATTP, 25);
        PMob->addModifier(Mod::DEFP, 25);
        PMob->addModifier(Mod::ACC, 20);
        PMob->addModifier(Mod::EVA, 20);
        PMob->addModifier(Mod::MDEF, 20);
    }

    // No gil drops or exp
    PMob->setMobMod(MOBMOD_GIL_MAX, -1);
    PMob->setMobMod(MOBMOD_MUG_GIL, -1);
    PMob->setMobMod(MOBMOD_EXP_BONUS, -100);

    // never despawn and zonewide hate
    PMob->SetDespawnTime(0s);
    PMob->setMobMod(MOBMOD_ALLI_HATE, 200);

    PMob->addModifier(Mod::REFRESH, 400);
    PMob->PAI->PathFind->SetCarefulPathing(true);
}

void SetupDungeonInstancedMob(CMobEntity* PMob)
{
    uint8 mLvl = PMob->GetMLevel();
    // Bonus stats for difficulty
    if (mLvl >= 81)
    {
        if (PMob->GetMJob() != JOB_MNK || ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->getSkillType() != SKILL_HAND_TO_HAND)
        {
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDamage(100);
        }

        PMob->addModifier(Mod::REGEN, 30);
        PMob->addModifier(Mod::REGAIN, 50);
    }
    else
    {
        if (PMob->GetMJob() != JOB_MNK || ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->getSkillType() != SKILL_HAND_TO_HAND)
        {
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDamage(90);
        }

        PMob->addModifier(Mod::ACC, 30);
        PMob->addModifier(Mod::REGEN, 30);
        PMob->addModifier(Mod::REGAIN, 50);
    }

    // No gil drops or exp
    PMob->setMobMod(MOBMOD_GIL_MAX, -1);
    PMob->setMobMod(MOBMOD_MUG_GIL, -1);
    PMob->setMobMod(MOBMOD_EXP_BONUS, -100);

    // never despawn
    PMob->SetDespawnTime(0s);

    PMob->addModifier(Mod::REFRESH, 400);
    PMob->PAI->PathFind->SetCarefulPathing(true);
}

void SetupSalvageMob(CMobEntity* PMob)
{
    uint8 mLvl = PMob->GetMLevel();
    uint8 mJob = PMob->GetMJob();
    // Bonus stats for difficulty
    if (mLvl >= 90)
    {
        if (PMob->GetMJob() != JOB_MNK || ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->getSkillType() != SKILL_HAND_TO_HAND)
        {
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDamage(60);
        }

        PMob->addModifier(Mod::ATTP, 25);
        PMob->addModifier(Mod::ACC, 15);
        PMob->setMobMod(MOBMOD_NO_ROAM, 1);
    }
    else if (mLvl >= 85)
    {
        if (PMob->GetMJob() != JOB_MNK || ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->getSkillType() != SKILL_HAND_TO_HAND)
        {
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDamage(50);
        }

        PMob->addModifier(Mod::ATTP, 25);
        PMob->addModifier(Mod::ACC, 15);
        PMob->setMobMod(MOBMOD_NO_ROAM, 1);
    }
    else
    {
        if (PMob->GetMJob() != JOB_MNK || ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->getSkillType() != SKILL_HAND_TO_HAND)
        {
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDamage(40);
        }

        PMob->addModifier(Mod::ATTP, 25);
        PMob->addModifier(Mod::DEFP, 25);
        PMob->addModifier(Mod::ACC, 15);
        PMob->addModifier(Mod::EVA, 15);
    }

    // No gil drops or exp
    PMob->setMobMod(MOBMOD_GIL_MAX, -1);
    PMob->setMobMod(MOBMOD_MUG_GIL, -1);
    PMob->setMobMod(MOBMOD_EXP_BONUS, -100);
    // set delay for non-monks
    if (mJob != JOB_MNK)
    {
        ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDelay(2000);
    }
    // add true sight + sound
    PMob->m_Aggro = 1;
    PMob->setMobMod(MOBMOD_AGGRO_SIGHT, 1);
    PMob->setMobMod(MOBMOD_AGGRO_SOUND, 1);
    PMob->setMobMod(MOBMOD_TRUE_SIGHT, 1);
    PMob->setMobMod(MOBMOD_TRUE_SOUND, 1);
    // add same family linking
    PMob->setMobMod(MOBMOD_FAMILYLINK, 1); 
    // reduce roam radius
    PMob->m_maxRoamDistance = 5.0f;
    // never despawn
    PMob->SetDespawnTime(0s);
    // return to spawn on disengage
    PMob->setMobMod(MOBMOD_RETURN_TO_SPAWN, 1); 
    // add global mods
    PMob->addModifier(Mod::DMGSPIRITS, -75);
    PMob->addModifier(Mod::REFRESH, 400);
    PMob->setModifier(Mod::MOVE_SPEED_STACKABLE, 15);
    PMob->PAI->PathFind->SetCarefulPathing(true);
}

void SetupStrongholdsMob(CMobEntity* PMob)
{
    // Unused
}

void SetupBattlefieldMob(CMobEntity* PMob)
{
    PMob->setMobMod(MOBMOD_NO_DESPAWN, 1);

    // Battlefield mobs don't drop gil or give exp
    PMob->setMobMod(MOBMOD_GIL_MAX, -1);
    PMob->setMobMod(MOBMOD_MUG_GIL, -1);
    PMob->setMobMod(MOBMOD_EXP_BONUS, -100);

    // never despawn
    PMob->SetDespawnTime(0s);
    // never despawn
    PMob->SetDespawnTime(0s);
    // do not roam around
    PMob->m_roamFlags |= ROAMFLAG_EVENT;
    PMob->m_maxRoamDistance = 0.5f;
    if ((PMob->m_bcnmID != 864) && (PMob->m_bcnmID != 704) && (PMob->m_bcnmID != 642) && (PMob->m_bcnmID != 706) && (PMob->m_bcnmID != 641))
    {
        // bcnmID 864 (desires of emptiness), 704 (darkness named), 641 (Follow The White Rabbit), 642 (When Hell Freezes Over, and 706 (waking dreams) don't superlink
        // force all mobs in same instance to superlink
        // plus one in case id is zero
        PMob->setMobMod(MOBMOD_SUPERLINK, PMob->m_battlefieldID);
    }

    PMob->addModifier(Mod::REFRESH, 400);
    PMob->PAI->PathFind->SetCarefulPathing(true);

}

void SetupDungeonMob(CMobEntity* PMob)
{
}

void SetupEventMob(CMobEntity* PMob)
{
    // event mob types will always have custom roaming
    PMob->m_roamFlags |= ROAMFLAG_EVENT;
    PMob->m_maxRoamDistance = 0.5f; // always go back to spawn

    PMob->setMobMod(MOBMOD_NO_DESPAWN, 1);
    PMob->PAI->PathFind->SetCarefulPathing(true);
}

void SetupNMMob(CMobEntity* PMob)
{
    JOBTYPE mJob = PMob->GetMJob();
    uint8 mLvl = PMob->GetMLevel();
    bool isQuestMob = PMob->m_Type & MOBTYPE_QUEST;

    PMob->setMobMod(MOBMOD_NO_DESPAWN, 1);

    // NMs cure earlier
    PMob->defaultMobMod(MOBMOD_HP_HEAL_CHANCE, 50);
    PMob->defaultMobMod(MOBMOD_HEAL_CHANCE, 40);

    // give a gil bonus if accurate value was not set
    if (PMob->getMobMod(MOBMOD_GIL_MAX) == 0 && PMob->getMobMod(MOBMOD_GIL_MIN) == 0 && !isQuestMob)
    {
        if (mLvl <= 10)
        {
            PMob->defaultMobMod(MOBMOD_GIL_MIN, 250);
        }
        else if (mLvl >= 11 && mLvl <= 20)
        {
            PMob->defaultMobMod(MOBMOD_GIL_MIN, 500);
        }
        else if (mLvl >= 21 && mLvl <= 30)
        {
            PMob->defaultMobMod(MOBMOD_GIL_MIN, 750);
        }
        else if (mLvl >= 31 && mLvl <= 40)
        {
            PMob->defaultMobMod(MOBMOD_GIL_MIN, 1000);
        }
        else if (mLvl >= 41 && mLvl <= 50)
        {
            PMob->defaultMobMod(MOBMOD_GIL_MIN, 1250);
        }
        else if (mLvl >= 51 && mLvl <= 60)
        {
            PMob->defaultMobMod(MOBMOD_GIL_MIN, 1500);
        }
        else if (mLvl >= 61 && mLvl <= 70)
        {
            PMob->defaultMobMod(MOBMOD_GIL_MIN, 1750);
        }
        else if (mLvl >= 71)
        {
            PMob->defaultMobMod(MOBMOD_GIL_MIN, 2000);
        }

        // Mug amount same as gil drop amount
        PMob->setMobMod(MOBMOD_MUG_GIL, PMob->getMobMod(MOBMOD_GIL_MIN));
    }

    if(mLvl >= 25)
    {
        if(mJob == JOB_WHM)
        {
            // whm nms have stronger regen effect
            PMob->addModifier(Mod::REGEN, mLvl/4);
        }
    }

    PMob->addModifier(Mod::REFRESH, 400);
    PMob->PAI->PathFind->SetCarefulPathing(true);
}

void RecalculateSpellContainer(CMobEntity* PMob)
{
    // clear spell list
    PMob->SpellContainer->ClearSpells();

    if (PMob->m_SpellListContainer == nullptr)
    {
        return;
    }

    //insert the rest of the spells
    for (std::vector<MobSpell_t>::iterator it = PMob->m_SpellListContainer->m_spellList.begin(); it != PMob->m_SpellListContainer->m_spellList.end(); ++it)
    {
        if (PMob->GetMLevel() >= (*it).min_level && PMob->GetMLevel() <= (*it).max_level)
        {
            PMob->SpellContainer->AddSpell((*it).spellId);
        }
    }
}

/* Gets the available spells for the specified monster.
 */
void GetAvailableSpells(CMobEntity* PMob) {
    //make sure the mob actually has a spell list
    if (PMob->m_SpellListContainer == nullptr)
    {
        return;
    }

    // catch all non-defaulted spell chances
    PMob->defaultMobMod(MOBMOD_MAGIC_COOL, 35);
    PMob->defaultMobMod(MOBMOD_GA_CHANCE, 35);
    PMob->defaultMobMod(MOBMOD_NA_CHANCE, 05);
    PMob->defaultMobMod(MOBMOD_SEVERE_SPELL_CHANCE, 20);
    PMob->defaultMobMod(MOBMOD_BUFF_CHANCE, 10);
    PMob->defaultMobMod(MOBMOD_HEAL_CHANCE, 40);
    PMob->defaultMobMod(MOBMOD_HP_HEAL_CHANCE, 40);

    RecalculateSpellContainer(PMob);

    // make sure mob has mp to cast spells
    if(PMob->health.maxmp == 0 && PMob->SpellContainer != nullptr && PMob->SpellContainer->HasMPSpells())
    {
        ShowError("mobutils::CalculateMobStats Mob (%u) has no mp for casting spells!\n", PMob->id);
    }
}

void SetSpellList(CMobEntity* PMob, uint16 spellList)
{
    if (PMob == nullptr)
    {
        return;
    }

    PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(spellList);
    RecalculateSpellContainer(PMob);
}

void InitializeMob(CMobEntity* PMob, CZone* PZone)
{
    // add special mob mods

    // this only has to be added once
    AddCustomMods(PMob);

    PMob->m_Immunity |= PMob->getMobMod(MOBMOD_IMMUNITY);

    PMob->defaultMobMod(MOBMOD_SKILL_LIST, PMob->m_MobSkillList);
    PMob->defaultMobMod(MOBMOD_LINK_RADIUS, 10);
    PMob->defaultMobMod(MOBMOD_TP_USE_CHANCE, 92); // 92 = 0.92% chance per 400ms tick (50% chance by 30 seconds) while mob HPP>25 and mob TP >=1000 but <3000
    PMob->defaultMobMod(MOBMOD_SIGHT_RANGE, (int16)CMobEntity::sight_range);
    PMob->defaultMobMod(MOBMOD_SOUND_RANGE, (int16)CMobEntity::sound_range);
    PMob->defaultMobMod(MOBMOD_MAGIC_RANGE, (int16)CMobEntity::magic_range);
    PMob->defaultMobMod(MOBMOD_WS_RANGE, (int16)CMobEntity::ws_range);
    PMob->defaultMobMod(MOBMOD_JA_RANGE, (int16)CMobEntity::ja_range);
    PMob->defaultMobMod(MOBMOD_HP_RANGE, (int16)CMobEntity::low_hp_range);

    // Killer Effect
    switch (PMob->m_EcoSystem)
      {
        case SYSTEM_AMORPH:   PMob->addModifier(Mod::BIRD_KILLER,     5); break;
        case SYSTEM_AQUAN:    PMob->addModifier(Mod::AMORPH_KILLER,   5); break;
        case SYSTEM_ARCANA:   PMob->addModifier(Mod::UNDEAD_KILLER,   5); break;
        case SYSTEM_BEAST:    PMob->addModifier(Mod::LIZARD_KILLER,   5); break;
        case SYSTEM_BIRD:     PMob->addModifier(Mod::AQUAN_KILLER,    5); break;
        case SYSTEM_DEMON:    PMob->addModifier(Mod::DRAGON_KILLER,   5); break;
        case SYSTEM_DRAGON:   PMob->addModifier(Mod::DEMON_KILLER,    5); break;
        case SYSTEM_LIZARD:   PMob->addModifier(Mod::VERMIN_KILLER,   5); break;
        case SYSTEM_LUMINION: PMob->addModifier(Mod::LUMORIAN_KILLER, 5); break;
        case SYSTEM_LUMORIAN: PMob->addModifier(Mod::LUMINION_KILLER, 5); break;
        case SYSTEM_PLANTOID: PMob->addModifier(Mod::BEAST_KILLER,    5); break;
        case SYSTEM_UNDEAD:   PMob->addModifier(Mod::ARCANA_KILLER,   5); break;
        case SYSTEM_VERMIN:   PMob->addModifier(Mod::PLANTOID_KILLER, 5); break;
        default: break;
      }

    if (PMob->m_maxLevel == 0 && PMob->m_minLevel == 0)
    {
        if (PMob->getZone() >= 1 && PMob->getZone() <= 252)
        {
            ShowError("Mob %s level is 0! zoneid %d, poolid %d\n", PMob->GetName(), PMob->getZone(), PMob->m_Pool);
        }
    }

    if (PMob->m_EcoSystem == SYSTEM_EMPTY || PMob->m_EcoSystem == SYSTEM_DEMON)
    {
        PMob->setMobMod(MOBMOD_ECOSYSTEMLINK, 1);
    }
}

/*
Loads up custom mob mods from mob_pool_mods and mob_family_mods table. This will allow you to customize
a mobs regen rate, magic defense, triple attack rate from a table instead of hardcoding it.

Usage:

    Evil weapons have a magic defense boost. So pop that into mob_family_mods table.
    Goblin Diggers have a vermin killer trait, so find its poolid and put it in mod_pool_mods table.

*/
void LoadCustomMods()
{

    // load family mods
    const char QueryFamilyMods[] = "SELECT familyid, modid, value, is_mob_mod FROM mob_family_mods;";

    int32 ret = Sql_Query(SqlHandle, QueryFamilyMods);

    if(ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while(Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            ModsList_t* familyMods = GetMobFamilyMods(Sql_GetUIntData(SqlHandle,0), true);

            CModifier* mod = new CModifier(static_cast<Mod>(Sql_GetUIntData(SqlHandle,1)));
            mod->setModAmount(Sql_GetIntData(SqlHandle,2));

            int8 isMobMod = Sql_GetIntData(SqlHandle,3);
            if(isMobMod == 1)
            {
                familyMods->mobMods.push_back(mod);
            }
            else
            {
                familyMods->mods.push_back(mod);
            }
        }
    }

    // load pool mods
    const char QueryPoolMods[] = "SELECT poolid, modid, value, is_mob_mod FROM mob_pool_mods;";

    ret = Sql_Query(SqlHandle, QueryPoolMods);

    if(ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while(Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            uint16 pool = Sql_GetUIntData(SqlHandle,0);
            ModsList_t* poolMods = GetMobPoolMods(pool, true);

            Mod id = static_cast<Mod>(Sql_GetUIntData(SqlHandle,1));


            CModifier* mod = new CModifier(id);
            mod->setModAmount(Sql_GetUIntData(SqlHandle,2));

            int8 isMobMod = Sql_GetIntData(SqlHandle,3);
            if(isMobMod == 1)
            {
                poolMods->mobMods.push_back(mod);
            }
            else
            {
                poolMods->mods.push_back(mod);
            }
        }
    }

    // load spawn mods
    const char QuerySpawnMods[] = "SELECT mobid, modid, value, is_mob_mod FROM mob_spawn_mods;";

    ret = Sql_Query(SqlHandle, QuerySpawnMods);

    if(ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while(Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            ModsList_t* spawnMods = GetMobSpawnMods(Sql_GetUIntData(SqlHandle,0), true);

            CModifier* mod = new CModifier(static_cast<Mod>(Sql_GetUIntData(SqlHandle,1)));
            mod->setModAmount(Sql_GetUIntData(SqlHandle,2));

            int8 isMobMod = Sql_GetIntData(SqlHandle,3);
            if(isMobMod == 1)
            {
                spawnMods->mobMods.push_back(mod);
            }
            else
            {
                spawnMods->mods.push_back(mod);
            }
        }
    }
}

ModsList_t* GetMobFamilyMods(uint16 familyId, bool create)
{
    if(mobFamilyModsList[familyId])
    {
        return mobFamilyModsList[familyId];
    }

    if(create)
    {
        // create new one
        ModsList_t* mods = new ModsList_t;
        mods->id = familyId;

        mobFamilyModsList[familyId] = mods;

        return mods;
    }

    return nullptr;
}

ModsList_t* GetMobPoolMods(uint32 poolId, bool create)
{
    if(mobPoolModsList[poolId])
    {
        return mobPoolModsList[poolId];
    }

    if(create)
    {
        // create new one
        ModsList_t* mods = new ModsList_t;
        mods->id = poolId;

        mobPoolModsList[poolId] = mods;

        return mods;
    }

    return nullptr;
}

ModsList_t* GetMobSpawnMods(uint32 mobId, bool create)
{
    if(mobSpawnModsList[mobId])
    {
        return mobSpawnModsList[mobId];
    }

    if(create)
    {
        // create new one
        ModsList_t* mods = new ModsList_t;
        mods->id = mobId;

        mobSpawnModsList[mobId] = mods;

        return mods;
    }

    return nullptr;
}

void AddCustomMods(CMobEntity* PMob)
{

    // find my families custom mods
    ModsList_t* PFamilyMods = GetMobFamilyMods(PMob->m_Family);

    if(PFamilyMods != nullptr)
    {
        // add them
        for(std::vector<CModifier*>::iterator it = PFamilyMods->mods.begin(); it != PFamilyMods->mods.end() ; ++it)
        {
            PMob->addModifier((*it)->getModID(), (*it)->getModAmount());
        }
        //TODO: don't store mobmods in a CModifier
        for(std::vector<CModifier*>::iterator it = PFamilyMods->mobMods.begin(); it != PFamilyMods->mobMods.end() ; ++it)
        {
            PMob->setMobMod(static_cast<uint16>((*it)->getModID()), (*it)->getModAmount());
        }
    }

    // find my pools custom mods
    ModsList_t* PPoolMods = GetMobPoolMods(PMob->m_Pool);

    if(PPoolMods != nullptr)
    {
        // add them
        for(std::vector<CModifier*>::iterator it = PPoolMods->mods.begin(); it != PPoolMods->mods.end() ; ++it)
        {
            PMob->addModifier((*it)->getModID(), (*it)->getModAmount());
        }

        for(std::vector<CModifier*>::iterator it = PPoolMods->mobMods.begin(); it != PPoolMods->mobMods.end() ; ++it)
        {
            PMob->setMobMod(static_cast<uint16>((*it)->getModID()), (*it)->getModAmount());
        }
    }

    // find my pools custom mods
    ModsList_t* PSpawnMods = GetMobSpawnMods(PMob->id);

    if(PSpawnMods != nullptr)
    {
        // add them
        for(std::vector<CModifier*>::iterator it = PSpawnMods->mods.begin(); it != PSpawnMods->mods.end() ; ++it)
        {
            PMob->addModifier((*it)->getModID(), (*it)->getModAmount());
        }

        for(std::vector<CModifier*>::iterator it = PSpawnMods->mobMods.begin(); it != PSpawnMods->mobMods.end() ; ++it)
        {
            PMob->setMobMod(static_cast<uint16>((*it)->getModID()), (*it)->getModAmount());
        }
    }
}

CMobEntity* InstantiateAlly(uint32 groupid, uint16 zoneID, CInstance* instance)
{
    const char* Query =
        "SELECT zoneid, mob_groups.name, \
        respawntime, spawntype, dropid, mob_groups.HP, mob_groups.MP, minLevel, maxLevel, \
        modelid, mJob, sJob, cmbSkill, cmbDmgMult, cmbDelay, behavior, links, mobType, immunity, \
        systemid, mobsize, speed, \
        STR, DEX, VIT, AGI, `INT`, MND, CHR, EVA, DEF, \
        Slash, Pierce, H2H, Impact, \
        Fire, Ice, Wind, Earth, Lightning, Water, Light, Dark, Element, \
        mob_pools.familyid, name_prefix, entityFlags, animationsub, \
        (mob_family_system.HP / 100), (mob_family_system.MP / 100), hasSpellScript, spellList, ATT, ACC, mob_groups.poolid, \
        allegiance, namevis, aggro, mob_pools.skill_list_id, mob_pools.true_detection, mob_family_system.detects, packet_name \
        FROM mob_groups INNER JOIN mob_pools ON mob_groups.poolid = mob_pools.poolid \
        INNER JOIN mob_family_system ON mob_pools.familyid = mob_family_system.familyid \
        WHERE mob_groups.groupid = %u";

    int32 ret = Sql_Query(SqlHandle, Query, groupid);

    CMobEntity* PMob = nullptr;

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        if (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            PMob = new CMobEntity;
            PMob->PInstance = instance;

            PMob->name.insert(0, (const char*)Sql_GetData(SqlHandle, 1));
            PMob->packetName.insert(0, (const char*)Sql_GetData(SqlHandle, 61));

            PMob->m_RespawnTime = Sql_GetUIntData(SqlHandle, 2) * 1000;
            PMob->m_SpawnType = (SPAWNTYPE)Sql_GetUIntData(SqlHandle, 3);
            PMob->m_DropID = Sql_GetUIntData(SqlHandle, 4);

            PMob->HPmodifier = (uint32)Sql_GetIntData(SqlHandle, 5);
            PMob->MPmodifier = (uint32)Sql_GetIntData(SqlHandle, 6);

            PMob->m_minLevel = (uint8)Sql_GetIntData(SqlHandle, 7);
            PMob->m_maxLevel = (uint8)Sql_GetIntData(SqlHandle, 8);

            memcpy(&PMob->look, Sql_GetData(SqlHandle, 9), 23);

            PMob->SetMJob(Sql_GetIntData(SqlHandle, 10));
            PMob->SetSJob(Sql_GetIntData(SqlHandle, 11));

            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setMaxHit(1);
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setSkillType(Sql_GetIntData(SqlHandle, 12));
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDmgType(DAMAGE_HTH);
            PMob->m_dmgMult = Sql_GetUIntData(SqlHandle, 13);
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDelay((Sql_GetIntData(SqlHandle, 14) * 1000) / 60);
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setBaseDelay((Sql_GetIntData(SqlHandle, 14) * 1000) / 60);

            PMob->m_Behaviour = (uint16)Sql_GetIntData(SqlHandle, 15);
            PMob->m_Link = (uint8)Sql_GetIntData(SqlHandle, 16);
            PMob->m_Type = (uint8)Sql_GetIntData(SqlHandle, 17);
            PMob->m_Immunity = (IMMUNITY)Sql_GetIntData(SqlHandle, 18);
            PMob->m_EcoSystem = (ECOSYSTEM)Sql_GetIntData(SqlHandle, 19);
            PMob->m_ModelSize = (uint8)Sql_GetIntData(SqlHandle, 20);

            PMob->speed = (uint8)Sql_GetIntData(SqlHandle, 21);    // Overwrites baseentity.cpp's defined speed
            PMob->speedsub = (uint8)Sql_GetIntData(SqlHandle, 21); // Overwrites baseentity.cpp's defined speedsub

            PMob->strRank = (uint8)Sql_GetIntData(SqlHandle, 22);
            PMob->dexRank = (uint8)Sql_GetIntData(SqlHandle, 23);
            PMob->vitRank = (uint8)Sql_GetIntData(SqlHandle, 24);
            PMob->agiRank = (uint8)Sql_GetIntData(SqlHandle, 25);
            PMob->intRank = (uint8)Sql_GetIntData(SqlHandle, 26);
            PMob->mndRank = (uint8)Sql_GetIntData(SqlHandle, 27);
            PMob->chrRank = (uint8)Sql_GetIntData(SqlHandle, 28);
            PMob->evaRank = (uint8)Sql_GetIntData(SqlHandle, 29);
            PMob->defRank = (uint8)Sql_GetIntData(SqlHandle, 30);
            PMob->attRank = (uint8)Sql_GetIntData(SqlHandle, 52);
            PMob->accRank = (uint8)Sql_GetIntData(SqlHandle, 53);

            PMob->setModifier(Mod::SLASHRES, (uint16)(Sql_GetFloatData(SqlHandle, 31) * 1000));
            PMob->setModifier(Mod::PIERCERES, (uint16)(Sql_GetFloatData(SqlHandle, 32) * 1000));
            PMob->setModifier(Mod::RANGEDRES, (uint16)(Sql_GetFloatData(SqlHandle, 32) * 1000));
            PMob->setModifier(Mod::HTHRES, (uint16)(Sql_GetFloatData(SqlHandle, 33) * 1000));
            PMob->setModifier(Mod::IMPACTRES, (uint16)(Sql_GetFloatData(SqlHandle, 34) * 1000));

            //PMob->setModifier(Mod::FIRERES, (int16)((Sql_GetFloatData(SqlHandle, 35) - 1) * -100)); // These are stored as floating percentages
            //PMob->setModifier(Mod::ICERES, (int16)((Sql_GetFloatData(SqlHandle, 36) - 1) * -100)); // and need to be adjusted into modifier units.
            //PMob->setModifier(Mod::WINDRES, (int16)((Sql_GetFloatData(SqlHandle, 37) - 1) * -100)); // Higher RES = lower damage.
            //PMob->setModifier(Mod::EARTHRES, (int16)((Sql_GetFloatData(SqlHandle, 38) - 1) * -100)); // Negatives signify lower resist chance.
            //PMob->setModifier(Mod::THUNDERRES, (int16)((Sql_GetFloatData(SqlHandle, 39) - 1) * -100)); // Positives signify increased resist chance.
            //PMob->setModifier(Mod::WATERRES, (int16)((Sql_GetFloatData(SqlHandle, 40) - 1) * -100));
            //PMob->setModifier(Mod::LIGHTRES, (int16)((Sql_GetFloatData(SqlHandle, 41) - 1) * -100));
            //PMob->setModifier(Mod::DARKRES, (int16)((Sql_GetFloatData(SqlHandle, 42) - 1) * -100));

            PMob->setModifier(Mod::FIRERES, (int16)((Sql_GetFloatData(SqlHandle, 35) - 1) * -100));    // These are stored as floating percentages
            PMob->setModifier(Mod::ICERES, (int16)((Sql_GetFloatData(SqlHandle, 36) - 1) * -100));     // and need to be adjusted into modifier units.
            PMob->setModifier(Mod::WINDRES, (int16)((Sql_GetFloatData(SqlHandle, 37) - 1) * -100));    // Higher RES = lower damage.
            PMob->setModifier(Mod::EARTHRES, (int16)((Sql_GetFloatData(SqlHandle, 38) - 1) * -100));   // Negatives signify lower resist chance.
            PMob->setModifier(Mod::THUNDERRES, (int16)((Sql_GetFloatData(SqlHandle, 39) - 1) * -100)); // Positives signify increased resist chance.
            PMob->setModifier(Mod::WATERRES, (int16)((Sql_GetFloatData(SqlHandle, 40) - 1) * -100));
            PMob->setModifier(Mod::LIGHTRES, (int16)((Sql_GetFloatData(SqlHandle, 41) - 1) * -100));
            PMob->setModifier(Mod::DARKRES, (int16)((Sql_GetFloatData(SqlHandle, 42) - 1) * -100));

            PMob->m_Element = (uint8)Sql_GetIntData(SqlHandle, 43);
            PMob->m_Family = (uint16)Sql_GetIntData(SqlHandle, 44);
            PMob->m_name_prefix = (uint8)Sql_GetIntData(SqlHandle, 45);
            PMob->m_flags = (uint32)Sql_GetIntData(SqlHandle, 46);

            //Special sub animation for Mob (yovra, jailer of love, phuabo)
            // yovra 1: en hauteur, 2: en bas, 3: en haut
            // phuabo 1: sous l'eau, 2: sort de l'eau, 3: rentre dans l'eau
            PMob->animationsub = (uint32)Sql_GetIntData(SqlHandle, 47);

            // Setup HP / MP Stat Percentage Boost
            PMob->HPscale = Sql_GetFloatData(SqlHandle, 48);
            PMob->MPscale = Sql_GetFloatData(SqlHandle, 49);

            // Check if we should be looking up scripts for this mob
            PMob->m_HasSpellScript = (uint8)Sql_GetIntData(SqlHandle, 50);

            PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(Sql_GetIntData(SqlHandle, 51));

            PMob->m_Pool = Sql_GetUIntData(SqlHandle, 54);

            PMob->allegiance = Sql_GetUIntData(SqlHandle, 55);
            PMob->namevis = Sql_GetUIntData(SqlHandle, 56);
            PMob->m_Aggro = Sql_GetUIntData(SqlHandle, 57);
            PMob->m_MobSkillList = Sql_GetUIntData(SqlHandle, 58);
            PMob->m_TrueDetection = Sql_GetUIntData(SqlHandle, 59);
            PMob->m_Detects = Sql_GetUIntData(SqlHandle, 60);

            // must be here first to define mobmods
            mobutils::InitializeMob(PMob, zoneutils::GetZone(zoneID));

            zoneutils::GetZone(zoneID)->InsertPET(PMob);

            luautils::OnMobInitialize(PMob);
            luautils::ApplyMixins(PMob);
            luautils::ApplyZoneMixins(PMob);

            PMob->saveModifiers();
            PMob->saveMobModifiers();
        }
    }
    return PMob;
}

void WeaknessTrigger(CBaseEntity* PTarget, WeaknessType level)
{
    uint16 animationID = 0;
    switch (level)
    {
    case WeaknessType::RED:
        animationID = 1806;
        break;
    case WeaknessType::YELLOW:
        animationID = 1807;
        break;
    case WeaknessType::BLUE:
        animationID = 1808;
        break;
    case WeaknessType::WHITE:
        animationID = 1946;
        break;
    }
    action_t action;
    action.actiontype = ACTION_MOBABILITY_FINISH;
    action.id = PTarget->id;
    actionList_t& list = action.getNewActionList();
    list.ActionTargetID = PTarget->id;
    actionTarget_t& target = list.getNewActionTarget();
    target.animation = animationID;
    target.param = 2582;
    PTarget->loc.zone->PushPacket(PTarget, CHAR_INRANGE, new CActionPacket(action));
}

}; // namespace mobutils

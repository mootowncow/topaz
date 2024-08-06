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

#include "../../common/timer.h"
#include "../../common/utils.h"

#include <string.h>
#include <vector>
#include <math.h>

#include "battleutils.h"
#include "charutils.h"
#include "puppetutils.h"
#include "../grades.h"
#include "../map.h"
#include "petutils.h"
#include "zoneutils.h"
#include "../entities/mobentity.h"
#include "../entities/automatonentity.h"
#include "../ability.h"
#include "../status_effect_container.h"
#include "../latent_effect_container.h"
#include "../mob_spell_list.h"
#include "../enmity_container.h"
#include "../items/item_weapon.h"
#include "../zone_instance.h"

#include "../ai/ai_container.h"
#include "../ai/controllers/mob_controller.h"
#include "../ai/controllers/pet_controller.h"
#include "../ai/controllers/automaton_controller.h"
#include "../ai/states/ability_state.h"

#include "../packets/char_abilities.h"
#include "../packets/char_sync.h"
#include "../packets/char_update.h"
#include "../packets/entity_update.h"
#include "../packets/message_standard.h"
#include "../packets/pet_sync.h"
#include "mobutils.h"
#include "../job_points.h"
#include "../mob_modifier.h"

struct Pet_t
{
    uint16      PetID;      // ID in pet_list.sql
    look_t		look;		// внешний вид
    string_t	name;		// имя
    ECOSYSTEM	EcoSystem;	// эко-система

    uint8       minLevel;	// минимально-возможный  уровень
    uint8       maxLevel;	// максимально-возможный уровень

    uint8       name_prefix;
    uint8       size;		// размер модели
    uint16      m_Family;
    uint32      time;		// время существования (будет использоваться для задания длительности статус эффекта)

    uint8       mJob;
    uint8       sJob;
    uint8       m_Element;
    float       HPscale;                             // HP boost percentage
    float       MPscale;                             // MP boost percentage

    uint16      cmbDelay;
    uint8       speed;
    // stat ranks
    uint8        strRank;
    uint8        dexRank;
    uint8        vitRank;
    uint8        agiRank;
    uint8        intRank;
    uint8        mndRank;
    uint8        chrRank;
    uint8        attRank;
    uint8        defRank;
    uint8        evaRank;
    uint8        accRank;

    uint16       m_MobSkillList;

    // magic stuff
    bool hasSpellScript;
    uint16 spellList;

    // resists
    uint16 slashres;
    uint16 pierceres;
    uint16 hthres;
    uint16 impactres;

    uint16 firedef;
    uint16 icedef;
    uint16 winddef;
    uint16 earthdef;
    uint16 thunderdef;
    uint16 waterdef;
    uint16 lightdef;
    uint16 darkdef;

    //int16 fireres;
    //int16 iceres;
    //int16 windres;
    //int16 earthres;
    //int16 thunderres;
    //int16 waterres;
    //int16 lightres;
    //int16 darkres;

    uint16 fireresSDT;
    uint16 iceresSDT;
    uint16 windresSDT;
    uint16 earthresSDT;
    uint16 thunderresSDT;
    uint16 waterresSDT;
    uint16 lightresSDT;
    uint16 darkresSDT;

    uint16 eemamnesia;
    uint16 eemvirus;
    uint16 eemsilence;
    uint16 eemgravity;
    uint16 eemstun;
    uint16 eemlightsleep;
    uint16 eemcharm;
    uint16 eemparalyze;
    uint16 eembind;
    uint16 eemslow;
    uint16 eempetrify;
    uint16 eemterror;
    uint16 eempoison;
    uint16 eemdarksleep;
    uint16 eemblind;

    uint16 shieldSize;

};

std::vector<Pet_t*> g_PPetList;

namespace petutils
{

    /************************************************************************
    *																		*
    *  Загружаем список прототипов питомцев									*
    *																		*
    ************************************************************************/

    void LoadPetList()
    {
        FreePetList();

        const char* Query =
            "SELECT\
                pet_list.petid,\
                pet_list.name,\
                modelid,\
                minLevel,\
                maxLevel,\
                time,\
                mobsize,\
                systemid,\
                mob_pools.familyid,\
                mob_pools.mJob,\
                mob_pools.sJob,\
                pet_list.element,\
                (mob_family_system.HP / 100),\
                (mob_family_system.MP / 100),\
                mob_family_system.speed,\
                mob_family_system.STR,\
                mob_family_system.DEX,\
                mob_family_system.VIT,\
                mob_family_system.AGI,\
                mob_family_system.INT,\
                mob_family_system.MND,\
                mob_family_system.CHR,\
                mob_family_system.DEF,\
                mob_family_system.ATT,\
                mob_family_system.ACC, \
                mob_family_system.EVA, \
                hasSpellScript, spellList, \
                Slash, Pierce, H2H, Impact, \
                Fire, Ice, Wind, Earth, Lightning, Water, Light, Dark, \
                Amnesia, Virus, Silence, Gravity, Stun, LightSleep, Charm, Paralyze, Bind, Slow, Petrify, Terror, Poison, Darksleep, Blind, \
                cmbDelay, name_prefix, mob_pools.skill_list_id, mob_pools.shieldSize \
                FROM pet_list, mob_pools, mob_family_system \
                WHERE pet_list.poolid = mob_pools.poolid AND mob_pools.familyid = mob_family_system.familyid";

        if (Sql_Query(SqlHandle, Query) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                Pet_t* Pet = new Pet_t();

                Pet->PetID = (uint16)Sql_GetIntData(SqlHandle, 0);
                Pet->name.insert(0, (const char*)Sql_GetData(SqlHandle, 1));

                memcpy(&Pet->look, Sql_GetData(SqlHandle, 2), 20);
                Pet->minLevel = (uint8)Sql_GetIntData(SqlHandle, 3);
                Pet->maxLevel = (uint8)Sql_GetIntData(SqlHandle, 4);
                Pet->time = Sql_GetUIntData(SqlHandle, 5);
                Pet->size = Sql_GetUIntData(SqlHandle, 6);
                Pet->EcoSystem = (ECOSYSTEM)Sql_GetIntData(SqlHandle, 7);
                Pet->m_Family = (uint16)Sql_GetIntData(SqlHandle, 8);
                Pet->mJob = (uint8)Sql_GetIntData(SqlHandle, 9);
                Pet->sJob = (uint8)Sql_GetIntData(SqlHandle, 10);
                Pet->m_Element = (uint8)Sql_GetIntData(SqlHandle, 11);

                Pet->HPscale = Sql_GetFloatData(SqlHandle, 12);
                Pet->MPscale = Sql_GetFloatData(SqlHandle, 13);

                Pet->speed = (uint8)Sql_GetIntData(SqlHandle, 14);

                Pet->strRank = (uint8)Sql_GetIntData(SqlHandle, 15);
                Pet->dexRank = (uint8)Sql_GetIntData(SqlHandle, 16);
                Pet->vitRank = (uint8)Sql_GetIntData(SqlHandle, 17);
                Pet->agiRank = (uint8)Sql_GetIntData(SqlHandle, 18);
                Pet->intRank = (uint8)Sql_GetIntData(SqlHandle, 19);
                Pet->mndRank = (uint8)Sql_GetIntData(SqlHandle, 20);
                Pet->chrRank = (uint8)Sql_GetIntData(SqlHandle, 21);
                Pet->defRank = (uint8)Sql_GetIntData(SqlHandle, 22);
                Pet->attRank = (uint8)Sql_GetIntData(SqlHandle, 23);
                Pet->accRank = (uint8)Sql_GetIntData(SqlHandle, 24);
                Pet->evaRank = (uint8)Sql_GetIntData(SqlHandle, 25);

                Pet->hasSpellScript = (bool)Sql_GetIntData(SqlHandle, 26);

                Pet->spellList = (uint8)Sql_GetIntData(SqlHandle, 27);

                // resistances
                Pet->slashres = (uint16)(Sql_GetFloatData(SqlHandle, 28) * 1000);
                Pet->pierceres = (uint16)(Sql_GetFloatData(SqlHandle, 29) * 1000);
                Pet->hthres = (uint16)(Sql_GetFloatData(SqlHandle, 30) * 1000);
                Pet->impactres = (uint16)(Sql_GetFloatData(SqlHandle, 31) * 1000);

                Pet->firedef = 0;
                Pet->icedef = 0;
                Pet->winddef = 0;
                Pet->earthdef = 0;
                Pet->thunderdef = 0;
                Pet->waterdef = 0;
                Pet->lightdef = 0;
                Pet->darkdef = 0;

                //Pet->fireres = (uint16)((Sql_GetFloatData(SqlHandle, 31) - 1) * -100);
                //Pet->iceres = (uint16)((Sql_GetFloatData(SqlHandle, 32) - 1) * -100);
                //Pet->windres = (uint16)((Sql_GetFloatData(SqlHandle, 33) - 1) * -100);
                //Pet->earthres = (uint16)((Sql_GetFloatData(SqlHandle, 34) - 1) * -100);
                //Pet->thunderres = (uint16)((Sql_GetFloatData(SqlHandle, 35) - 1) * -100);
                //Pet->waterres = (uint16)((Sql_GetFloatData(SqlHandle, 36) - 1) * -100);
                //Pet->lightres = (uint16)((Sql_GetFloatData(SqlHandle, 37) - 1) * -100);
                //Pet->darkres = (uint16)((Sql_GetFloatData(SqlHandle, 38) - 1) * -100);
                Pet->fireresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 32) * 100);
                Pet->iceresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 33) * 100);
                Pet->windresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 34) * 100);
                Pet->earthresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 35) * 100);
                Pet->thunderresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 36) * 100);
                Pet->waterresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 37) * 100);
                Pet->lightresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 38) * 100);
                Pet->darkresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 39) * 100);

                Pet->eemamnesia =  (uint16)(Sql_GetUIntData(SqlHandle, 40)); 
                Pet->eemvirus = (uint16)(Sql_GetUIntData(SqlHandle, 41));
                Pet->eemsilence =  (uint16)(Sql_GetUIntData(SqlHandle, 42));
                Pet->eemgravity = (uint16)(Sql_GetUIntData(SqlHandle, 43));
                Pet->eemstun = (uint16)(Sql_GetUIntData(SqlHandle, 44));
                Pet->eemlightsleep = (uint16)(Sql_GetUIntData(SqlHandle, 45));
                Pet->eemcharm = (uint16)(Sql_GetUIntData(SqlHandle, 46));
                Pet->eemparalyze = (uint16)(Sql_GetUIntData(SqlHandle, 47));
                Pet->eembind = (uint16)(Sql_GetUIntData(SqlHandle, 48));
                Pet->eemslow = (uint16)(Sql_GetUIntData(SqlHandle, 49));
                Pet->eempetrify = (uint16)(Sql_GetUIntData(SqlHandle, 50));
                Pet->eemterror = (uint16)(Sql_GetUIntData(SqlHandle, 51));
                Pet->eempoison = (uint16)(Sql_GetUIntData(SqlHandle, 52));
                Pet->eemdarksleep =  (uint16)(Sql_GetUIntData(SqlHandle, 53));
                Pet->eemblind = (uint16)(Sql_GetUIntData(SqlHandle, 54));


                Pet->cmbDelay = (uint16)Sql_GetIntData(SqlHandle, 55);
                Pet->name_prefix = (uint8)Sql_GetUIntData(SqlHandle, 56);
                Pet->m_MobSkillList = (uint16)Sql_GetUIntData(SqlHandle, 57);
                Pet->shieldSize = Sql_GetUIntData(SqlHandle, 58);

                g_PPetList.push_back(Pet);
            }
        }
    }

    /************************************************************************
    *																		*
    *  Освобождаем список прототипов питомцев								*
    *																		*
    ************************************************************************/

    void FreePetList()
    {
        while (!g_PPetList.empty())
        {
            delete *g_PPetList.begin();
            g_PPetList.erase(g_PPetList.begin());
        }
    }

    void AttackTarget(CBattleEntity* PMaster, CBattleEntity* PTarget)
    {
        TPZ_DEBUG_BREAK_IF(PMaster->PPet == nullptr);

        CBattleEntity* PPet = PMaster->PPet;

        if (!PPet->StatusEffectContainer->HasPreventActionEffect(false))
        {
            PPet->PAI->Engage(PTarget->targid);
        }
    }

    void RetreatToMaster(CBattleEntity* PMaster)
    {
        TPZ_DEBUG_BREAK_IF(PMaster->PPet == nullptr);

        CBattleEntity* PPet = PMaster->PPet;

        if (!PPet->StatusEffectContainer->HasPreventActionEffect(false))
        {
            PPet->PAI->Disengage();
        }
    }

    uint16 GetJugWeaponDamage(CPetEntity* PPet, uint16 slot)
    {
        uint16 lvl = PPet->GetMLevel();
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

        // Some pets can have H2H skill but not be a MNK
        if (PPet->GetMJob() == JOB_MNK || PPet->GetMJob() == JOB_PUP || ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->getSkillType() == SKILL_HAND_TO_HAND)
        {
            uint16 h2hskill = battleutils::GetMaxSkill(SKILL_HAND_TO_HAND, JOB_MNK, PPet->GetMLevel());
            // https://ffxiclopedia.fandom.com/wiki/Category:Hand-to-Hand
            damage = 0.11f * h2hskill + 3 +
                     18 * PPet->GetMLevel() / 75; // basic h2h weapon dmg + scaling "weapon" for mnk mobs based on h2h skill (destroyers 18 dmg at 75)
        }

        // DW pets use 1h weapon damage instead of 2h
        if (PPet->getMobMod(MOBMOD_DUAL_WIELD) > 0)
        {
            damage = (lvl / 2) + bonus;
        }

        damage = (uint16)(damage * PPet->m_dmgMult / 100.0f);

        if (PPet->getMobMod(MOBMOD_WEAPON_BONUS) != 0)
        {
            damage += (uint16)(PPet->getMobMod(MOBMOD_WEAPON_BONUS));
        }

        return damage;
    }
    uint16 GetPetBase(CPetEntity * PMob, uint8 rank)
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
            case 6:
                return battleutils::GetMaxSkill(SKILL_THROWING, JOB_RDM, mlvl); // F Skill (6)
            case 7:
                return battleutils::GetMaxSkill(SKILL_SHIELD, JOB_RUN, mlvl); // G Skill (7)
        }

        ShowError("Petutils::GetBase rank (%d) is out of bounds for pet (%u) ", rank, PMob->id);
        return 0;
    }
    uint16 GetBaseToRank(uint8 rank, uint16 lvl)
    {
        switch (rank)
        {
        case 1: return (5 + ((lvl - 1) * 50) / 100);
        case 2: return (4 + ((lvl - 1) * 45) / 100);
        case 3: return (4 + ((lvl - 1) * 40) / 100);
        case 4: return (3 + ((lvl - 1) * 35) / 100);
        case 5: return (3 + ((lvl - 1) * 30) / 100);
        case 6: return (2 + ((lvl - 1) * 25) / 100);
        case 7: return (2 + ((lvl - 1) * 20) / 100);
        }
        return 0;
    }

    void LoadJugStats(CBattleEntity* PMaster, CPetEntity* PMob, Pet_t* petStats)
    {
        //follows monster formulas but jugs have no subjob

        float growth = 1.0;
        uint8 lvl = PMob->GetMLevel();

        //give hp boost every 10 levels after 25
        //special boosts at 25 and 50
        if (lvl > 75)
        {
            growth = 1.22f;
        }
        else if (lvl > 65)
        {
            growth = 1.20f;
        }
        else if (lvl > 55)
        {
            growth = 1.18f;
        }
        else if (lvl > 50)
        {
            growth = 1.16f;
        }
        else if (lvl > 45)
        {
            growth = 1.12f;
        }
        else if (lvl > 35)
        {
            growth = 1.09f;
        }
        else if (lvl > 25)
        {
            growth = 1.07f;
        }

        PMob->health.maxhp = (int16)(17.0 * pow(lvl, growth) * petStats->HPscale);

        switch (PMob->GetMJob())
        {
        case JOB_PLD:
        case JOB_WHM:
        case JOB_BLM:
        case JOB_RDM:
        case JOB_DRK:
        case JOB_BLU:
        case JOB_SCH:
        case JOB_GEO:
        case JOB_RUN:
            PMob->health.maxmp = (int16)(15.2 * pow(lvl, 1.1075) * petStats->MPscale);
            break;
        default:
            break;
        }

        PMob->speed = petStats->speed;
        PMob->speedsub = petStats->speed;

        PMob->UpdateHealth();
        PMob->health.tp = 0;
        PMob->health.hp = PMob->GetMaxHP();
        PMob->health.mp = PMob->GetMaxMP();

        PMob->setModifier(Mod::DEF, GetPetBase(PMob, petStats->defRank));
        PMob->setModifier(Mod::EVA, GetPetBase(PMob, petStats->evaRank));
        PMob->setModifier(Mod::ATT, GetPetBase(PMob, petStats->attRank));
        PMob->setModifier(Mod::ACC, GetPetBase(PMob, petStats->accRank));

        // Job Point bonuses
        if (PMaster != nullptr)
        {
            if (PMaster->objtype == TYPE_PC)
            {
                if (PMaster->GetMJob() == JOBTYPE::JOB_BST)
                {

                    CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
                    uint16 jpValue = PChar->PJobPoints->GetJobPointValue(JP_PET_ACC_BONUS);
                    PMob->addModifier(Mod::ACC, PChar->PJobPoints->GetJobPointValue(JP_PET_ACC_BONUS));
                    PMob->addModifier(Mod::MACC, PChar->PJobPoints->GetJobPointValue(JP_PET_MAGIC_ACC));
                }
            }
        }

        ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDamage(GetJugWeaponDamage(PMob, SLOT_MAIN));

        //reduce weapon delay of MNK
        if (PMob->GetMJob() == JOB_MNK)
        {
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->resetDelay();
        }

        uint16 fSTR = GetBaseToRank(petStats->strRank, PMob->GetMLevel());
        uint16 fDEX = GetBaseToRank(petStats->dexRank, PMob->GetMLevel());
        uint16 fVIT = GetBaseToRank(petStats->vitRank, PMob->GetMLevel());
        uint16 fAGI = GetBaseToRank(petStats->agiRank, PMob->GetMLevel());
        uint16 fINT = GetBaseToRank(petStats->intRank, PMob->GetMLevel());
        uint16 fMND = GetBaseToRank(petStats->mndRank, PMob->GetMLevel());
        uint16 fCHR = GetBaseToRank(petStats->chrRank, PMob->GetMLevel());

        uint16 mSTR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 2), PMob->GetMLevel());
        uint16 mDEX = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 3), PMob->GetMLevel());
        uint16 mVIT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 4), PMob->GetMLevel());
        uint16 mAGI = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 5), PMob->GetMLevel());
        uint16 mINT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 6), PMob->GetMLevel());
        uint16 mMND = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 7), PMob->GetMLevel());
        uint16 mCHR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 8), PMob->GetMLevel());

        // Add JP gift bonuses
        uint16 jpBonus = 0;
        if (PMob->PMaster != nullptr)
        {
            jpBonus = PMob->PMaster->getMod(Mod::PET_ATTR_BONUS);
        }

        PMob->stats.STR = (uint16)((fSTR + mSTR) * 0.9f) + jpBonus;
        PMob->stats.DEX = (uint16)((fDEX + mDEX) * 0.9f) + jpBonus;
        PMob->stats.VIT = (uint16)((fVIT + mVIT) * 0.9f) + jpBonus;
        PMob->stats.AGI = (uint16)((fAGI + mAGI) * 0.9f) + jpBonus;
        PMob->stats.INT = (uint16)((fINT + mINT) * 0.9f) + jpBonus;
        PMob->stats.MND = (uint16)((fMND + mMND) * 0.9f) + jpBonus;
        PMob->stats.CHR = (uint16)((fCHR + mCHR) * 0.9f) + jpBonus;

    }

    void LoadAutomatonStats(CCharEntity* PMaster, CPetEntity* PPet, Pet_t* petStats)
    {
        PPet->WorkingSkills.automaton_melee = std::min(puppetutils::getSkillCap(PMaster, SKILL_AUTOMATON_MELEE), PMaster->GetSkill(SKILL_AUTOMATON_MELEE));
        PPet->WorkingSkills.automaton_ranged = std::min(puppetutils::getSkillCap(PMaster, SKILL_AUTOMATON_RANGED), PMaster->GetSkill(SKILL_AUTOMATON_RANGED));
        PPet->WorkingSkills.automaton_magic = std::min(puppetutils::getSkillCap(PMaster, SKILL_AUTOMATON_MAGIC), PMaster->GetSkill(SKILL_AUTOMATON_MAGIC));

        // Set capped flags
        for (int i = 22; i <= 24; ++i)
            if (PPet->GetSkill(i) == (puppetutils::getSkillCap(PMaster, (SKILLTYPE)i)))
                PPet->WorkingSkills.skill[i] |= 0x8000;

        // Add mods/merits
        int32 meritbonus = PMaster->PMeritPoints->GetMeritValue(MERIT_AUTOMATON_SKILLS, PMaster);
        PPet->WorkingSkills.automaton_melee += PMaster->getMod(Mod::AUTO_MELEE_SKILL) + meritbonus;
        PPet->WorkingSkills.automaton_ranged += PMaster->getMod(Mod::AUTO_RANGED_SKILL) + meritbonus;
        // Share its magic skills to prevent needing separate spells or checks to see which skill to use
        uint16 amaSkill = PPet->WorkingSkills.automaton_magic + PMaster->getMod(Mod::AUTO_MAGIC_SKILL) + meritbonus;
        PPet->WorkingSkills.automaton_magic = amaSkill;
        PPet->WorkingSkills.healing = amaSkill;
        PPet->WorkingSkills.enhancing = amaSkill;
        PPet->WorkingSkills.enfeebling = amaSkill;
        PPet->WorkingSkills.elemental = amaSkill;
        PPet->WorkingSkills.dark = amaSkill;

        // Объявление переменных, нужных для рассчета.
        float raceStat = 0;			// конечное число HP для уровня на основе расы.
        float jobStat = 0;			// конечное число HP для уровня на основе первичной профессии.
        float sJobStat = 0;			// коенчное число HP для уровня на основе вторичной профессии.
        int32 bonusStat = 0;			// бонусное число HP которое добавляется при соблюдении некоторых условий.
        int32 baseValueColumn = 0;	// номер колонки с базовым количеством HP
        int32 scaleTo60Column = 1;	// номер колонки с модификатором до 60 уровня
        int32 scaleOver30Column = 2;	// номер колонки с модификатором после 30 уровня
        int32 scaleOver60Column = 3;	// номер колонки с модификатором после 60 уровня
        int32 scaleOver75Column = 4;	// номер колонки с модификатором после 75 уровня
        int32 scaleOver60 = 2;			// номер колонки с модификатором для расчета MP после 60 уровня
        // int32 scaleOver75 = 3;			// номер колонки с модификатором для расчета Статов после 75-го уровня

        uint8 grade;

        uint8 mlvl = PPet->GetMLevel();
        JOBTYPE mjob = PPet->GetMJob();
        JOBTYPE sjob = PPet->GetSJob();
        // Расчет прироста HP от main job
        int32 mainLevelOver30 = std::clamp(mlvl - 30, 0, 30);			// Расчет условия +1HP каждый лвл после 30 уровня
        int32 mainLevelUpTo60 = (mlvl < 60 ? mlvl - 1 : 59);			// Первый режим рассчета до 60 уровня (Используется так же и для MP)
        int32 mainLevelOver60To75 = std::clamp(mlvl - 60, 0, 15);		// Второй режим расчета после 60 уровня
        int32 mainLevelOver75 = (mlvl < 75 ? 0 : mlvl - 75);			// Третий режим расчета после 75 уровня

        //Расчет бонусного количества HP
        int32 mainLevelOver10 = (mlvl < 10 ? 0 : mlvl - 10);			// +2HP на каждом уровне после 10
        int32 mainLevelOver50andUnder60 = std::clamp(mlvl - 50, 0, 10);	// +2HP на каждом уровне в промежутке от 50 до 60 уровня
        int32 mainLevelOver60 = (mlvl < 60 ? 0 : mlvl - 60);

        // Расчет raceStat jobStat bonusStat sJobStat
        // Расчет по расе

        grade = 4;

        raceStat = grade::GetHPScale(grade, baseValueColumn) +
            (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
            (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) +
            (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
            (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // raceStat = (int32)(statScale[grade][baseValueColumn] + statScale[grade][scaleTo60Column] * (mlvl - 1));

        // Расчет по main job
        grade = grade::GetJobGrade(mjob, 0);

        jobStat = grade::GetHPScale(grade, baseValueColumn) +
            (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
            (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) +
            (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
            (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // Расчет бонусных HP
        bonusStat = (mainLevelOver10 + mainLevelOver50andUnder60) * 2;
        PPet->health.maxhp = (int32)((raceStat + jobStat + bonusStat + sJobStat) * petStats->HPscale);
        PPet->health.hp = PPet->health.maxhp;

        //Начало расчера MP
        raceStat = 0;
        jobStat = 0;
        sJobStat = 0;

        // Расчет MP расе.
        grade = 4;

        //Если у main job нет МП рейтинга, расчитиваем расовый бонус на основе уровня subjob уровня(при условии, что у него есть МП рейтинг)
        if (!(grade::GetJobGrade(mjob, 1) == 0 && grade::GetJobGrade(sjob, 1) == 0))
        {
            //Расчет нормального расового бонуса
            raceStat = grade::GetMPScale(grade, 0) +
                grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        //Для главной профессии
        grade = grade::GetJobGrade(mjob, 1);
        if (grade > 0)
        {
            jobStat = grade::GetMPScale(grade, 0) +
                grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        grade = grade::GetJobGrade(sjob, 1);
        if (grade > 0)
        {
            sJobStat = grade::GetMPScale(grade, 0) +
                grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        PPet->health.maxmp = (int32)((raceStat + jobStat + sJobStat) * petStats->MPscale);
        PPet->health.mp = PPet->health.maxmp;

        uint16 fSTR = GetBaseToRank(petStats->strRank, PPet->GetMLevel());
        uint16 fDEX = GetBaseToRank(petStats->dexRank, PPet->GetMLevel());
        uint16 fVIT = GetBaseToRank(petStats->vitRank, PPet->GetMLevel());
        uint16 fAGI = GetBaseToRank(petStats->agiRank, PPet->GetMLevel());
        uint16 fINT = GetBaseToRank(petStats->intRank, PPet->GetMLevel());
        uint16 fMND = GetBaseToRank(petStats->mndRank, PPet->GetMLevel());
        uint16 fCHR = GetBaseToRank(petStats->chrRank, PPet->GetMLevel());

        uint16 mSTR = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 2), PPet->GetMLevel());
        uint16 mDEX = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 3), PPet->GetMLevel());
        uint16 mVIT = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 4), PPet->GetMLevel());
        uint16 mAGI = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 5), PPet->GetMLevel());
        uint16 mINT = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 6), PPet->GetMLevel());
        uint16 mMND = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 7), PPet->GetMLevel());
        uint16 mCHR = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 8), PPet->GetMLevel());

        uint16 sSTR = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 2), PPet->GetSLevel());
        uint16 sDEX = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 3), PPet->GetSLevel());
        uint16 sVIT = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 4), PPet->GetSLevel());
        uint16 sAGI = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 5), PPet->GetSLevel());
        uint16 sINT = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 6), PPet->GetSLevel());
        uint16 sMND = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 7), PPet->GetSLevel());
        uint16 sCHR = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 8), PPet->GetSLevel());

        PPet->stats.STR = fSTR + mSTR + sSTR;
        PPet->stats.DEX = fDEX + mDEX + sDEX;
        PPet->stats.VIT = fVIT + mVIT + sVIT;
        PPet->stats.AGI = fAGI + mAGI + sAGI;
        PPet->stats.INT = fINT + mINT + sINT;
        PPet->stats.MND = fMND + mMND + sMND;
        PPet->stats.CHR = fCHR + mCHR + sCHR;

        ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setSkillType(SKILL_AUTOMATON_MELEE);
        ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDamage((PPet->GetSkill(SKILL_AUTOMATON_MELEE) / 9) * 2 + 3);

        ((CItemWeapon*)PPet->m_Weapons[SLOT_RANGED])->setSkillType(SKILL_AUTOMATON_RANGED);
        ((CItemWeapon*)PPet->m_Weapons[SLOT_RANGED])->setDamage((PPet->GetSkill(SKILL_AUTOMATON_RANGED) / 9) * 2 + 3);

        CAutomatonEntity* PAutomaton = (CAutomatonEntity*)PPet;

        // Automatons are hard to interrupt
        PPet->addModifier(Mod::SPELLINTERRUPT, 85);

        switch (PAutomaton->getFrame())
        {
            default: // case FRAME_HARLEQUIN:
                PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(2, mlvl > 99 ? 99 : mlvl);
                PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(10, mlvl > 99 ? 99 : mlvl));
                break;
            case FRAME_VALOREDGE:
                PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(5, mlvl > 99 ? 99 : mlvl);
                PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(5, mlvl > 99 ? 99 : mlvl));
                break;
            case FRAME_SHARPSHOT:
                PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(1, mlvl > 99 ? 99 : mlvl);
                PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(11, mlvl > 99 ? 99 : mlvl));
                break;
            case FRAME_STORMWAKER:
                PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(10, mlvl > 99 ? 99 : mlvl);
                PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(12, mlvl > 99 ? 99 : mlvl));
                break;
        }

        // Add Job Point Stat Bonuses
        if (PMaster->GetMJob() == JOB_PUP)
        {
            PPet->addModifier(Mod::ATT, PMaster->getMod(Mod::PET_ATK_DEF));
            PPet->addModifier(Mod::DEF, PMaster->getMod(Mod::PET_ATK_DEF));
            PPet->addModifier(Mod::ACC, PMaster->getMod(Mod::PET_ACC_EVA));
            PPet->addModifier(Mod::EVA, PMaster->getMod(Mod::PET_ACC_EVA));
            PPet->addModifier(Mod::MATT, PMaster->getMod(Mod::PET_MAB_MDB));
            PPet->addModifier(Mod::MDEF, PMaster->getMod(Mod::PET_MAB_MDB));
            PPet->addModifier(Mod::MACC, PMaster->getMod(Mod::PET_MACC_MEVA));
            PPet->addModifier(Mod::MEVA, PMaster->getMod(Mod::PET_MACC_MEVA));
        }
    }

    void LoadAvatarStats(CPetEntity* PPet)
    {
        // Объявление переменных, нужных для рассчета.
        float raceStat = 0;			// конечное число HP для уровня на основе расы.
        float jobStat = 0;			// конечное число HP для уровня на основе первичной профессии.
        float sJobStat = 0;			// коенчное число HP для уровня на основе вторичной профессии.
        int32 bonusStat = 0;			// бонусное число HP которое добавляется при соблюдении некоторых условий.
        int32 baseValueColumn = 0;	// номер колонки с базовым количеством HP
        int32 scaleTo60Column = 1;	// номер колонки с модификатором до 60 уровня
        int32 scaleOver30Column = 2;	// номер колонки с модификатором после 30 уровня
        int32 scaleOver60Column = 3;	// номер колонки с модификатором после 60 уровня
        int32 scaleOver75Column = 4;	// номер колонки с модификатором после 75 уровня
        int32 scaleOver60 = 2;			// номер колонки с модификатором для расчета MP после 60 уровня
        int32 scaleOver75 = 3;			// номер колонки с модификатором для расчета Статов после 75-го уровня

        uint8 grade;

        uint8 mlvl = PPet->GetMLevel();
        JOBTYPE mjob = PPet->GetMJob();
        uint8 race = 3;					//Tarutaru

        // Расчет прироста HP от main job
        int32 mainLevelOver30 = std::clamp(mlvl - 30, 0, 30);			// Расчет условия +1HP каждый лвл после 30 уровня
        int32 mainLevelUpTo60 = (mlvl < 60 ? mlvl - 1 : 59);			// Первый режим рассчета до 60 уровня (Используется так же и для MP)
        int32 mainLevelOver60To75 = std::clamp(mlvl - 60, 0, 15);		// Второй режим расчета после 60 уровня
        int32 mainLevelOver75 = (mlvl < 75 ? 0 : mlvl - 75);			// Третий режим расчета после 75 уровня

        //Расчет бонусного количества HP
        int32 mainLevelOver10 = (mlvl < 10 ? 0 : mlvl - 10);			// +2HP на каждом уровне после 10
        int32 mainLevelOver50andUnder60 = std::clamp(mlvl - 50, 0, 10);	// +2HP на каждом уровне в промежутке от 50 до 60 уровня
        int32 mainLevelOver60 = (mlvl < 60 ? 0 : mlvl - 60);

        // Расчет raceStat jobStat bonusStat sJobStat
        // Расчет по расе

        grade = grade::GetRaceGrades(race, 0);

        raceStat = grade::GetHPScale(grade, baseValueColumn) +
            (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
            (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) +
            (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
            (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // raceStat = (int32)(statScale[grade][baseValueColumn] + statScale[grade][scaleTo60Column] * (mlvl - 1));

        // Расчет по main job
        grade = grade::GetJobGrade(mjob, 0);

        jobStat = grade::GetHPScale(grade, baseValueColumn) +
            (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
            (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) +
            (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
            (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // Расчет бонусных HP
        bonusStat = (mainLevelOver10 + mainLevelOver50andUnder60) * 2;
        if (PPet->m_PetID == PETID_ODIN || PPet->m_PetID == PETID_ALEXANDER)
            bonusStat += 6800;
        PPet->health.maxhp = (int16)(raceStat + jobStat + bonusStat + sJobStat);
        PPet->health.hp = PPet->health.maxhp;

        //Начало расчера MP
        raceStat = 0;
        jobStat = 0;
        sJobStat = 0;

        // Расчет MP расе.
        grade = grade::GetRaceGrades(race, 1);

        //Если у main job нет МП рейтинга, расчитиваем расовый бонус на основе уровня subjob уровня(при условии, что у него есть МП рейтинг)
        if (grade::GetJobGrade(mjob, 1) == 0)
        {
            // empty
        }
        else
        {
            //Расчет нормального расового бонуса
            raceStat = grade::GetMPScale(grade, 0) +
                grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        //Для главной профессии
        grade = grade::GetJobGrade(mjob, 1);
        if (grade > 0)
        {
            jobStat = grade::GetMPScale(grade, 0) +
                grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        PPet->health.maxmp = (int16)(raceStat + jobStat + sJobStat); // результат расчета MP
        PPet->health.mp = PPet->health.maxmp;
        //add in evasion from skill
        int16 evaskill = PPet->GetSkill(SKILL_EVASION);
        int16 eva = evaskill;
        if (evaskill > 200){ //Evasion skill is 0.9 evasion post-200
            eva = (int16)(200 + (evaskill - 200) * 0.9);
        }
        PPet->setModifier(Mod::EVA, eva);


        //Начало расчета характеристик
        uint8 counter = 0;
        for (uint8 StatIndex = 2; StatIndex <= 8; ++StatIndex)
        {
            // расчет по расе
            grade = grade::GetRaceGrades(race, StatIndex);
            raceStat = grade::GetStatScale(grade, 0) + grade::GetStatScale(grade, scaleTo60Column) * mainLevelUpTo60;

            if (mainLevelOver60 > 0)
            {
                raceStat += grade::GetStatScale(grade, scaleOver60) * mainLevelOver60;
                if (mainLevelOver75 > 0)
                {
                    raceStat += grade::GetStatScale(grade, scaleOver75) * mainLevelOver75 - (mlvl >= 75 ? 0.01f : 0);
                }
            }

            // расчет по профессии
            grade = grade::GetJobGrade(mjob, StatIndex);
            jobStat = grade::GetStatScale(grade, 0) + grade::GetStatScale(grade, scaleTo60Column) * mainLevelUpTo60;

            if (mainLevelOver60 > 0)
            {
                jobStat += grade::GetStatScale(grade, scaleOver60) * mainLevelOver60;

                if (mainLevelOver75 > 0)
                {
                    jobStat += grade::GetStatScale(grade, scaleOver75) * mainLevelOver75 - (mlvl >= 75 ? 0.01f : 0);
                }
            }

            jobStat = jobStat * 1.5f; //stats from subjob (assuming BLM/BLM for avatars)

            // Вывод значения
            ref<uint16>(&PPet->stats, counter) = (uint16)(raceStat + jobStat);
            counter += 2;
        }
    }

    void CalculateAvatarStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        uint32 petID = PPet->m_PetID;

        // clang-format off
        Pet_t* PPetData = *std::find_if(g_PPetList.begin(), g_PPetList.end(), [petID](Pet_t* t)
        {
            return t->PetID == petID;
        });
        // clang-format on

        PPet->SetMJob(JOB_DRK);
        PPet->SetSJob(JOB_BLM);
        uint8 mLvl = PMaster->GetMLevel();
        // TODO: ILvl
        // uint8 iLvl = std::clamp(charutils::getMainhandItemLevel(static_cast<CCharEntity*>(PMaster)) - 99, 0, 20);
        // PPet->SetMLevel(mLvl + iLvl + PMaster->getMod(Mod::AVATAR_LVL_BONUS));

        if (PMaster->GetMJob() == JOB_SMN)
        {
            PPet->SetMLevel(mLvl + PMaster->getMod(Mod::AVATAR_LVL_BONUS));
            PPet->SetSLevel(mLvl + PMaster->getMod(Mod::AVATAR_LVL_BONUS));
        }
        else if (PMaster->GetSJob() == JOB_SMN)
        {
            mLvl = PMaster->GetSLevel();
            PPet->SetMLevel(mLvl + PMaster->getMod(Mod::AVATAR_LVL_BONUS));
            PPet->SetSLevel(mLvl + PMaster->getMod(Mod::AVATAR_LVL_BONUS));
        }
        else
        { // should never happen
            ShowDebug("%s summoned an avatar but is not SMN main or SMN sub! Please report. \n", PMaster->GetName());
            PPet->SetMLevel(1);
        }
        LoadAvatarStats(PPet); // follows PC calcs (w/o SJ)

        if (PPetData != nullptr && PPetData != (decltype(PPetData))0xFFFFFFFFFFFFFF99)
        {
            PPet->m_SpellListContainer = mobSpellList::GetMobSpellList(PPetData->spellList);
        }
        else
        { // should never happen
            ShowDebug("%s summoned an avatar but the petID was nil! Please report. \n", PMaster->GetName());
        }

        // High refresh so Elementals don't oom
        PPet->setModifier(Mod::REFRESH, 500);

        // Base delay
        uint16 WeaponDelay = 240;
        if (PPetData != nullptr)
        {
            WeaponDelay = PPetData->cmbDelay;
        }


        // Apply pet delay mod / job point reduction bonus
        if (PMaster->objtype == TYPE_PC)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
            WeaponDelay *= (100 - (PMaster->getMod(Mod::PET_DELAY) + PChar->PJobPoints->GetJobPointValue(JP_PET_ATK_SPD_BONUS)));
            WeaponDelay /= 100;
        }

        ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f * (WeaponDelay / 60.0f))));

        // In a 2014 update SE updated Avatar base damage
        // Based on testing this value appears to be Level now instead of Level * 0.74f
        uint16 weaponDamage = static_cast<uint16>(floor(PPet->GetMLevel() * 0.5f) + 10.0f);
        if (petID == PETID_CARBUNCLE || petID == PETID_CAIT_SITH)
        {
            weaponDamage = static_cast<uint16>(floor(PPet->GetMLevel() * 0.5f) + 3.0f);
        }

        // Carbuncle and Cait Sith are a WHM
        if (petID == PETID_CARBUNCLE || petID == PETID_CAIT_SITH)
        {
            PPet->SetMJob(JOB_WHM);
            PPet->SetSJob(JOB_BLM);
        }

        // Elemetal Spirits are BLM/RDM Light is WHM/RDM and Dark is DRK/RDM
        if (petID >= PETID_FIRESPIRIT && petID <= PETID_DARKSPIRIT)
        {
            PPet->SetMJob(JOB_BLM);
            PPet->SetSJob(JOB_RDM);
            // No elemental staff. Need bonus Macc or they struggle to land spells.
            PPet->addModifier(Mod::MACC, 30);
        }

        // Set global avatar mods
        PPet->addModifier(Mod::SUBTLE_BLOW, 25);

        uint16 petRegen = PPet->GetMLevel() / 3;
        uint16 petCrit = PPet->GetMLevel() / 3;
        uint16 petDA = PPet->GetMLevel() / 7;
        uint16 petMAB = PPet->GetMLevel() / 7;
        uint16 petEleRes = PPet->GetMLevel() / 1.5;

        // Specific stats and SDT for each Avatar / Elemental
        switch (petID)
        {
            default:
                break;
            case PETID_FIRESPIRIT:
                break;
            case PETID_ICESPIRIT:
                break;
            case PETID_AIRSPIRIT:
                break;
            case PETID_EARTHSPIRIT:
                break;
            case PETID_THUNDERSPIRIT:
                break;
            case PETID_WATERSPIRIT:
                PPet->m_Element = 0; // Water is 0 ElementID for some reason
                break;
            case PETID_LIGHTSPIRIT:
                PPet->SetMJob(JOB_WHM);
                PPet->SetSJob(JOB_RDM);
                break;
            case PETID_DARKSPIRIT:
                PPet->SetMJob(JOB_DRK);
                PPet->SetSJob(JOB_RDM);
                PPet->m_Element = 6; // Dark is 6 ElementID for some reason
                break;
            case PETID_CARBUNCLE:
                PPet->addModifier(Mod::REGEN, petRegen);
                break;
            case PETID_FENRIR:
                PPet->addModifier(Mod::FIRERES, petEleRes);
                PPet->addModifier(Mod::ICERES, petEleRes);
                PPet->addModifier(Mod::WINDRES, petEleRes);
                PPet->addModifier(Mod::EARTHRES, petEleRes);
                PPet->addModifier(Mod::THUNDERRES, petEleRes);
                PPet->addModifier(Mod::WATERRES, petEleRes);
                PPet->addModifier(Mod::LIGHTRES, petEleRes);
                PPet->addModifier(Mod::DARKRES, petEleRes);
                PPet->addModifier(Mod::ATTP, 30);
                PPet->m_Element = 6; // Dark is 6 ElementID for some reason
                break;
            case PETID_IFRIT:
                PPet->addModifier(Mod::DOUBLE_ATTACK, petDA);
                break;
            case PETID_TITAN:
                PPet->addModifier(Mod::ENMITY, 30);
                PPet->addModifier(Mod::UDMGPHYS, -50);
                break;
            case PETID_LEVIATHAN:
                PPet->addModifier(Mod::ENMITY, 30);
                PPet->addModifier(Mod::UDMGMAGIC, -50);
                PPet->m_Element = 0; // Water is 0 ElementID for some reason
                break;
            case PETID_GARUDA:
                PPet->addModifier(Mod::EVA, 50);
                break;
            case PETID_SHIVA:
                PPet->addModifier(Mod::MATT, petMAB);
                break;
            case PETID_RAMUH:
                PPet->addModifier(Mod::ACC, 50);
                break;
            case PETID_DIABOLOS:
                PPet->addModifier(Mod::MDEF, 24);
                PPet->setModifier(Mod::DEFP, 30);
                PPet->m_Element = 6; // Dark is 6 ElementID for some reason
                break;
            case PETID_CAIT_SITH:
                PPet->addModifier(Mod::REGEN, petRegen);
                break;
        }

        ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDamage(weaponDamage);

        // Set B+ weapon skill (assumed capped for level derp)
        // attack is madly high for avatars (roughly x2)
        // B attack, A+ acc
        PPet->setModifier(Mod::ATT, 2 * battleutils::GetMaxSkill(SKILL_CLUB, JOB_WHM, PPet->GetMLevel()));
        PPet->setModifier(Mod::RATT, 2 * battleutils::GetMaxSkill(SKILL_CLUB, JOB_WHM, PPet->GetMLevel()));
        PPet->setModifier(Mod::ACC, battleutils::GetMaxSkill(SKILL_HEALING_MAGIC, JOB_WHM, PPet->GetMLevel()));
        PPet->setModifier(Mod::RACC, battleutils::GetMaxSkill(SKILL_HEALING_MAGIC, JOB_WHM, PPet->GetMLevel()));
        // Set C evasion and def
        PPet->setModifier(Mod::EVA, battleutils::GetMaxSkill(SKILL_ENFEEBLING_MAGIC, JOB_WHM, PPet->GetMLevel()));
        PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(SKILL_ENFEEBLING_MAGIC, JOB_WHM, PPet->GetMLevel()));
        // cap all magic skills so they play nice with spell scripts
        for (int i = SKILL_DIVINE_MAGIC; i <= SKILL_BLUE_MAGIC; i++)
        {
            uint16 maxSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PPet->GetMJob(), PPet->GetMLevel());
            if (maxSkill != 0)
            {
                PPet->WorkingSkills.skill[i] = maxSkill;
            }
            else // if the mob is WAR/BLM and can cast spell
            {
                // set skill as high as main level, so their spells won't get resisted
                uint16 maxSubSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PPet->GetSJob(), PPet->GetMLevel());

                if (maxSubSkill != 0)
                {
                    PPet->WorkingSkills.skill[i] = maxSubSkill;
                }
            }
        }

        // Stats from "masters" gear/merits
        if (PMaster->objtype == TYPE_PC)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
            PPet->addModifier(Mod::MATT, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_MAGICAL_ATTACK, PChar));
            PPet->addModifier(Mod::ATT, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_PHYSICAL_ATTACK, PChar));
            PPet->addModifier(Mod::MACC, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_MAGICAL_ACCURACY, PChar));
            PPet->addModifier(Mod::ACC, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_PHYSICAL_ACCURACY, PChar));

            PPet->addModifier(Mod::ACC, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_ACC_BONUS));
            PPet->addModifier(Mod::MACC, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_MAGIC_ACC_BONUS));
            PPet->addModifier(Mod::ATT, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_PHYS_ATK_BONUS) * 2);
            PPet->addModifier(Mod::MAGIC_DAMAGE, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_MAGIC_DMG_BONUS) * 5);
            PPet->addModifier(Mod::BP_DAMAGE, PChar->PJobPoints->GetJobPointValue(JP_BLOOD_PACT_DMG_BONUS) * 3);
        }

        PMaster->addModifier(Mod::AVATAR_PERPETUATION, PerpetuationCost(petID, PPet->GetMLevel()));
    }

    void CalculateWyvernStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        uint32 petID = PPet->m_PetID;

        // clang-format off
        Pet_t* PPetData = *std::find_if(g_PPetList.begin(), g_PPetList.end(), [petID](Pet_t* t)
        {
            return t->PetID == petID;
        });
        // clang-format on

        // set the wyvern job based on master's SJ
        if (PMaster->GetSJob() != JOB_NON)
        {
            PPet->SetSJob(PMaster->GetSJob());
        }

        PPet->SetMJob(JOB_DRG);
        // https://www.bg-wiki.com/ffxi/Wyvern_(Dragoon_Pet)#About_the_Wyvern
        uint8 mLvl = PMaster->GetMLevel();
        // TODO: ILvl 
        // uint8 iLvl = std::clamp(charutils::getMainhandItemLevel(static_cast<CCharEntity*>(PMaster)) - 99, 0, 20);
        // PPet->SetMLevel(mLvl + iLvl + PMaster->getMod(Mod::WYVERN_LVL_BONUS));
        // PPet->SetSLevel(mLvl + iLvl + PMaster->getMod(Mod::WYVERN_LVL_BONUS));

        if (PMaster->GetMJob() == JOB_DRG)
        {
            PPet->SetMLevel(mLvl + PMaster->getMod(Mod::WYVERN_LVL_BONUS));
            PPet->SetSLevel(mLvl + PMaster->getMod(Mod::WYVERN_LVL_BONUS));
        }
        else
        {
            mLvl = PMaster->GetSLevel();
            PPet->SetMLevel(mLvl + PMaster->getMod(Mod::WYVERN_LVL_BONUS));
            PPet->SetSLevel(mLvl + PMaster->getMod(Mod::WYVERN_LVL_BONUS));
        }
        LoadAvatarStats(PPet); // TODO: LoadWyvernStats
        // follows PC calcs (w/o SJ)

        // Base delay
        uint16 WeaponDelay = 320;
        if (PPetData != nullptr)
        {
            WeaponDelay = PPetData->cmbDelay;
        }

        // Apply pet delay mod / job point reduction bonus
        if (PMaster->objtype == TYPE_PC)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
            WeaponDelay *= (100 - (PMaster->getMod(Mod::PET_DELAY) + PChar->PJobPoints->GetJobPointValue(JP_PET_ATK_SPD_BONUS)));
            WeaponDelay /= 100;
        }
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f * (WeaponDelay / 60.0f))));
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDamage((uint16)(floor(mLvl / 2) + 3));
        // Set A+ weapon skill
        PPet->setModifier(Mod::ATT, battleutils::GetMaxSkill(SKILL_GREAT_AXE, JOB_WAR, mLvl > 99 ? 99 : mLvl));
        PPet->setModifier(Mod::ACC, battleutils::GetMaxSkill(SKILL_GREAT_AXE, JOB_WAR, mLvl > 99 ? 99 : mLvl));
        // Set D evasion and def
        PPet->setModifier(Mod::EVA, battleutils::GetMaxSkill(SKILL_ARCHERY, JOB_WAR, mLvl > 99 ? 99 : mLvl));
        PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(SKILL_ARCHERY, JOB_WAR, mLvl > 99 ? 99 : mLvl));

        // https://www.bg-wiki.com/ffxi/Wyvern_(Dragoon_Pet)#Combat_Stats
        // innate -40 % DT, which does not contribute to the -50 % cap (this is a unique attribute to pets having a "higher" DT cap)
        PPet->addModifier(Mod::UDMGPHYS, -40);
        PPet->addModifier(Mod::UDMGBREATH, -40);
        PPet->addModifier(Mod::UDMGMAGIC, -40);
        PPet->addModifier(Mod::UDMGRANGE, -40);

        // innate + 40 subtle blow
        PPet->addModifier(Mod::SUBTLE_BLOW, 40);

        //Job Point: Wyvern Max HP
        if (PMaster->objtype == TYPE_PC)
        {
            uint8 jpValue = static_cast<CCharEntity*>(PMaster)->PJobPoints->GetJobPointValue(JP_WYVERN_MAX_HP_BONUS);
            if (jpValue > 0)
            {
                PPet->addModifier(Mod::HP, jpValue * 10);
            }

            if (PMaster->GetMJob() == JOBTYPE::JOB_DRG)
            {
                PPet->addModifier(Mod::ACC, PMaster->getMod(Mod::PET_ACC_EVA));
                PPet->addModifier(Mod::EVA, PMaster->getMod(Mod::PET_ACC_EVA));
                PPet->addModifier(Mod::MACC, PMaster->getMod(Mod::PET_MACC_MEVA));
                PPet->addModifier(Mod::MEVA, PMaster->getMod(Mod::PET_MACC_MEVA));
            }
        }
        FinalizePetStatistics(PMaster, PPet);
    }

    void CalculateJugPetStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        uint32 petID = PPet->m_PetID;

        // clang-format off
        Pet_t* PPetData = *std::find_if(g_PPetList.begin(), g_PPetList.end(), [petID](Pet_t* t)
        {
            return t->PetID == petID;
        });
        // clang-format on

        // Base delay
        uint16 WeaponDelay = 240;
        if (PPetData != nullptr)
        {
            WeaponDelay = PPetData->cmbDelay;
        }

        // Apply pet delay mod / job point reduction bonus
        if (PMaster->objtype == TYPE_PC)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
            WeaponDelay *= (100 - (PMaster->getMod(Mod::PET_DELAY) + PChar->PJobPoints->GetJobPointValue(JP_PET_ATK_SPD_BONUS)));
            WeaponDelay /= 100;
        }

        ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f * (WeaponDelay / 60.0f))));

        // innate -25 % DT, which does not contribute to the -50 % cap (this is a unique attribute to pets having a "higher" DT cap)
        PPet->addModifier(Mod::UDMGPHYS, -25);
        PPet->addModifier(Mod::UDMGBREATH, -25);
        PPet->addModifier(Mod::UDMGMAGIC, -25);
        PPet->addModifier(Mod::UDMGRANGE, -25);

        // innate + 40 subtle blow
        PPet->addModifier(Mod::SUBTLE_BLOW, 40);

        // Get the Jug pet cap level
        uint8 highestLvl = PPetData->maxLevel;

        // Increase the pet's level calc by the bonus given by BEAST AFFINITY merits.
        CCharEntity* PChar = (CCharEntity*)PMaster;
        // TODO: Does not work properly
        // And cap it to the master's level or weapon ilvl, whichever is greater
        auto capLevel = PMaster->GetMLevel();
        if (highestLvl > capLevel)
        {
            highestLvl = capLevel;
        }

        // Randomize: 0-2 lvls lower, less Monster Gloves(+1/+2) bonus
        highestLvl -= tpzrand::GetRandomNumber(3 - std::clamp<int16>(PChar->getMod(Mod::JUG_LEVEL_RANGE), 0, 2));

        // Increase the pets level from gear mod
        highestLvl += PChar->getMod(Mod::JUG_LVL_BONUS);

        // Increase the pets level from merits
        highestLvl += PChar->PMeritPoints->GetMeritValue(MERIT_BEAST_AFFINITY, PChar);

        PPet->SetMLevel(highestLvl);
        PPet->SetSLevel(highestLvl);
        LoadJugStats(PMaster, PPet, PPetData); // follow monster calcs (w/o SJ)
    }
    void CalculateAutomatonStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        uint32 petID = PPet->m_PetID;

        // clang-format off
        Pet_t* PPetData = *std::find_if(g_PPetList.begin(), g_PPetList.end(), [petID](Pet_t* t)
        {
            return t->PetID == petID;
        });
        // clang-format on

        // weapon damage = (floor(automaton ranged skill * 0.11) * 3)
        auto meleeSkill = PPet->GetSkill(SKILL_AUTOMATON_MELEE);
        auto rangedSkill = PPet->GetSkill(SKILL_AUTOMATON_RANGED);
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDamage((uint16)(floor(meleeSkill * 0.11) * 3));

        // Base delay
        uint16 WeaponDelay = 240;
        if (PPetData != nullptr)
        {
            WeaponDelay = PPetData->cmbDelay;
        }

        CAutomatonEntity* PAutomaton = (CAutomatonEntity*)PPet;
        switch (PAutomaton->getFrame())
        {
            default: // case FRAME_HARLEQUIN:
                PPet->SetMJob(JOB_WAR);
                PPet->SetSJob(JOB_RDM);

                // Apply pet delay mod / job point reduction bonus
                if (PMaster->objtype == TYPE_PC)
                {
                    WeaponDelay = 320;
                    CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
                    WeaponDelay *= (100 - (PMaster->getMod(Mod::PET_DELAY) + PChar->PJobPoints->GetJobPointValue(JP_PET_ATK_SPD_BONUS)));
                    WeaponDelay /= 100;
                }

                ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f * (WeaponDelay / 60.0f))));
                ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDmgType(DAMAGE_IMPACT);
                PPet->addModifier(Mod::ATTP, 10);
                PPet->addModifier(Mod::ACC, 10);
                PPet->addModifier(Mod::EVA, 10);
                PPet->addModifier(Mod::DEFP, 30);
                PPet->addModifier(Mod::DMG, -6);
                break;
            case FRAME_VALOREDGE:
                PPet->SetMJob(JOB_WAR);
                PPet->SetSJob(JOB_WAR);

                // Apply pet delay mod / job point reduction bonus
                if (PMaster->objtype == TYPE_PC)
                {
                    WeaponDelay = 360;
                    CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
                    WeaponDelay *= (100 - (PMaster->getMod(Mod::PET_DELAY) + PChar->PJobPoints->GetJobPointValue(JP_PET_ATK_SPD_BONUS)));
                    WeaponDelay /= 100;
                }

                ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0 * (WeaponDelay / 60.0f))));
                ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDmgType(DAMAGE_SLASHING);
                PPet->addModifier(Mod::HPP, 20);
                PPet->addModifier(Mod::ATTP, 10);
                PPet->addModifier(Mod::ACC, 10);
                PPet->addModifier(Mod::EVA, 10);
                PPet->addModifier(Mod::DEFP, 60);
                // innate -15 % DT, which does not contribute to the -50 % cap (this is a unique attribute to pets having a "higher" DT cap)
                PPet->addModifier(Mod::UDMGPHYS, -25);
                PPet->addModifier(Mod::UDMGBREATH, -25);
                PPet->addModifier(Mod::UDMGMAGIC, -25);
                PPet->addModifier(Mod::UDMGRANGE, -25);
                break;
            case FRAME_SHARPSHOT:
                PPet->SetMJob(JOB_RNG);
                PPet->SetSJob(JOB_RNG);

                // Apply pet delay mod / job point reduction bonus
                if (PMaster->objtype == TYPE_PC)
                {
                    WeaponDelay = 400;
                    CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
                    WeaponDelay *= (100 - (PMaster->getMod(Mod::PET_DELAY) + PChar->PJobPoints->GetJobPointValue(JP_PET_ATK_SPD_BONUS)));
                    WeaponDelay /= 100;
                }

                ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0 * (WeaponDelay / 60.0f))));
                ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDmgType(DAMAGE_IMPACT);

                // Apply pet delay mod / job point reduction bonus for ranged weapon
                if (PMaster->objtype == TYPE_PC)
                {
                    WeaponDelay = 360;
                    CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
                    WeaponDelay *= (100 - (PMaster->getMod(Mod::PET_DELAY) + PChar->PJobPoints->GetJobPointValue(JP_PET_ATK_SPD_BONUS)));
                    WeaponDelay /= 100;
                }
                static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_RANGED])->setDamage((uint16)(floor(rangedSkill * 0.11) * 3));
                ((CItemWeapon*)PPet->m_Weapons[SLOT_RANGED])->setDelay((uint16)(floor(1000.0 * (WeaponDelay / 60.0f))));
                ((CItemWeapon*)PPet->m_Weapons[SLOT_RANGED])->setDmgType(DAMAGE_RANGED);
                PPet->addModifier(Mod::HPP, -10);
                PPet->addModifier(Mod::ATTP, 10);
                PPet->addModifier(Mod::ACC, 10);
                PPet->addModifier(Mod::RATTP, 10);
                PPet->addModifier(Mod::RACC, 10);
                PPet->addModifier(Mod::EVA, 10);
                PPet->addModifier(Mod::DEFP, 20);
                PPet->addModifier(Mod::DMG, -13);
                break;
            case FRAME_STORMWAKER:
                PPet->SetMJob(JOB_RDM);
                PPet->SetSJob(JOB_RDM);

                // Apply pet delay mod / job point reduction bonus
                if (PMaster->objtype == TYPE_PC)
                {
                    WeaponDelay = 400;
                    CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
                    WeaponDelay *= (100 - (PMaster->getMod(Mod::PET_DELAY) + PChar->PJobPoints->GetJobPointValue(JP_PET_ATK_SPD_BONUS)));
                    WeaponDelay /= 100;
                }

                ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0 * (WeaponDelay / 60.0f))));
                ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDmgType(DAMAGE_IMPACT);
                PPet->addModifier(Mod::HPP, -20);
                PPet->addModifier(Mod::MPP, 20);
                PPet->addModifier(Mod::ATTP, 10);
                PPet->addModifier(Mod::ACC, 10);
                PPet->addModifier(Mod::EVA, 10);
                PPet->addModifier(Mod::DEFP, 10);
                PPet->addModifier(Mod::DMGMAGIC, -25);
                PPet->addModifier(Mod::DMGBREATH, -25);
                break;
        }
        // TEMP: should be MLevel when unsummoned, and PUP level when summoned
        uint8 mLvl = PMaster->GetMLevel();
        // TODO: ILvl
        // uint8 iLvl = std::clamp(charutils::getMainhandItemLevel(static_cast<CCharEntity*>(PMaster)) - 99, 0, 20);
        // PPet->SetMLevel(mLvl + iLvl + PMaster->getMod(Mod::AUTO_LVL_BONUS));

        if (PMaster->GetMJob() == JOB_PUP)
        {
            PPet->SetMLevel(mLvl + PMaster->getMod(Mod::AUTO_LVL_BONUS));
            PPet->SetSLevel(mLvl + PMaster->getMod(Mod::AUTO_LVL_BONUS));
        }
        else
        {
            mLvl = PMaster->GetSLevel();
            PPet->SetMLevel(mLvl + PMaster->getMod(Mod::AUTO_LVL_BONUS));
            PPet->SetSLevel(mLvl + PMaster->getMod(Mod::AUTO_LVL_BONUS));
        }
        LoadAutomatonStats((CCharEntity*)PMaster, PPet, g_PPetList.at(petID)); // temp
        if (PMaster->objtype == TYPE_PC)
        {
            CCharEntity* PChar = (CCharEntity*)PMaster;
            PPet->addModifier(Mod::ATTP, PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar));
            PPet->addModifier(Mod::DEFP, PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar));
            PPet->addModifier(Mod::MATT, PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar));
            PPet->addModifier(Mod::ACC, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
            PPet->addModifier(Mod::RACC, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
            PPet->addModifier(Mod::EVA, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
            PPet->addModifier(Mod::MDEF, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
        }
    }
    void CalculateLoupanStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        uint32 petID = PPet->m_PetID;

        // clang-format off
        Pet_t* PPetData = *std::find_if(g_PPetList.begin(), g_PPetList.end(), [petID](Pet_t* t)
        {
            return t->PetID == petID;
        });
        // clang-format on

        PPet->SetMLevel(PMaster->GetMLevel());
        PPet->health.maxhp = (uint32)floor((250 * PPet->GetMLevel()) / 15);

        if (PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_BOLSTER))
        {
            uint8 bolsterJPVal = dynamic_cast<CCharEntity*>(PMaster)->PJobPoints->GetJobPointValue(JP_BOLSTER_EFFECT);
            PPet->health.maxhp += (uint32)floor(PPet->health.maxhp * (0.03 * bolsterJPVal));
        }

        PPet->health.hp = PPet->health.maxhp;

        // This sets the correct visual size for the luopan as pets currently
        // do not make use of the entity flags in the database
        // TODO: make pets use entity flags
        PPet->m_flags = 0x0000008B;
        // Just sit, do nothing
        PPet->speed = 0;
        FinalizePetStatistics(PMaster, PPet);
    }

    /************************************************************************
    *																		*
    *																		*
    *																		*
    ************************************************************************/

    void SpawnPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone)
    {
        TPZ_DEBUG_BREAK_IF(PMaster->PPet != nullptr);
        if (PMaster->objtype == TYPE_PC && (PetID == PETID_HARLEQUINFRAME || PetID == PETID_VALOREDGEFRAME || PetID == PETID_SHARPSHOTFRAME || PetID == PETID_STORMWAKERFRAME))
        {
            puppetutils::LoadAutomaton(static_cast<CCharEntity*>(PMaster));
            PMaster->PPet = static_cast<CCharEntity*>(PMaster)->PAutomaton;
        }
        else
        {
            LoadPet(PMaster, PetID, spawningFromZone);
        }

        CPetEntity* PPet = (CPetEntity*)PMaster->PPet;
        if (PPet)
        {
            Pet_t* PPetData = g_PPetList.at(PetID);

            // Set jobs in sql for jug pets only
            if (PPet->getPetType() == PETTYPE_JUG_PET)
            {
                PPet->SetMJob(PPetData->mJob);
                PPet->SetSJob(PPetData->sJob);
            }

            // ALl non-automaton pets deal H2H damage
            if (PPet->getPetType() != PETTYPE_AUTOMATON)
            {
                ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDmgType(DAMAGE_HTH);
            }

            PPet->setModifier(Mod::SLASHRES, PPetData->slashres);
            PPet->setModifier(Mod::PIERCERES, PPetData->pierceres);
            PPet->setModifier(Mod::RANGEDRES, PPetData->pierceres);
            PPet->setModifier(Mod::HTHRES, PPetData->hthres);
            PPet->setModifier(Mod::IMPACTRES, PPetData->impactres);

            PPet->setModifier(Mod::FIREDEF, PPetData->firedef);       // These are stored as floating percentages
            PPet->setModifier(Mod::ICEDEF, PPetData->icedef);         // and need to be adjusted into modifier units.
            PPet->setModifier(Mod::WINDDEF, PPetData->winddef);       // Higher DEF = lower damage.
            PPet->setModifier(Mod::EARTHDEF, PPetData->earthdef);     // Negatives signify increased damage.
            PPet->setModifier(Mod::THUNDERDEF, PPetData->thunderdef); // Positives signify reduced damage.
            PPet->setModifier(Mod::WATERDEF, PPetData->waterdef);     // Ex: 125% damage would be 1.25, 50% damage would be 0.50
            PPet->setModifier(Mod::LIGHTDEF, PPetData->lightdef);     // (1.25 - 1) * -1000 = -250 DEF
            PPet->setModifier(Mod::DARKDEF, PPetData->darkdef);       // (0.50 - 1) * -1000 = 500 DEF

            PPet->setModifier(Mod::SDT_FIRE, PPetData->fireresSDT);
            PPet->setModifier(Mod::SDT_ICE, PPetData->iceresSDT);
            PPet->setModifier(Mod::SDT_WIND, PPetData->windresSDT);
            PPet->setModifier(Mod::SDT_EARTH, PPetData->earthresSDT);
            PPet->setModifier(Mod::SDT_THUNDER, PPetData->thunderresSDT);
            PPet->setModifier(Mod::SDT_WATER, PPetData->waterresSDT);
            PPet->setModifier(Mod::SDT_LIGHT, PPetData->lightresSDT);
            PPet->setModifier(Mod::SDT_DARK, PPetData->darkresSDT);

            PPet->setModifier(Mod::EEM_AMNESIA, PPetData->eemamnesia);
            PPet->setModifier(Mod::EEM_VIRUS, PPetData->eemvirus);
            PPet->setModifier(Mod::EEM_SILENCE, PPetData->eemsilence);
            PPet->setModifier(Mod::EEM_GRAVITY, PPetData->eemgravity);
            PPet->setModifier(Mod::EEM_STUN, PPetData->eemstun);
            PPet->setModifier(Mod::EEM_LIGHT_SLEEP, PPetData->eemlightsleep);
            PPet->setModifier(Mod::EEM_CHARM, PPetData->eemcharm);
            PPet->setModifier(Mod::EEM_PARALYZE, PPetData->eemparalyze);
            PPet->setModifier(Mod::EEM_BIND, PPetData->eembind);
            PPet->setModifier(Mod::EEM_SLOW, PPetData->eemslow);
            PPet->setModifier(Mod::EEM_PETRIFY, PPetData->eempetrify);
            PPet->setModifier(Mod::EEM_TERROR, PPetData->eemterror);
            PPet->setModifier(Mod::EEM_POISON, PPetData->eempoison);
            PPet->setModifier(Mod::EEM_DARK_SLEEP, PPetData->eemdarksleep);
            PPet->setModifier(Mod::EEM_BLIND, PPetData->eemblind);

            uint8 spawnLevel = UINT8_MAX;
            if (spawningFromZone)
            {
                spawnLevel = static_cast<uint8>(static_cast<CCharEntity*>(PMaster)->petZoningInfo.petLevel);
            }

            // Valoredge can parry
            if (PPet->getPetType() == PETTYPE_AUTOMATON && PetID == PETID_VALOREDGEFRAME)
            {
                PPet->setMobMod(MOBMOD_CAN_PARRY, 1);
                PPet->addModifier(Mod::PARRY, GetPetBase(PPet, PPet->getMobMod(MOBMOD_CAN_PARRY)));
            }

            // add traits for sub and main if a jug pet
            if (PPet->getPetType() != PETTYPE_AUTOMATON)
            {

                if (PPet->getMobMod(MOBMOD_CAN_PARRY) > 0)
                {
                    PPet->addModifier(Mod::PARRY, GetPetBase(PPet, PPet->getMobMod(MOBMOD_CAN_PARRY)));
                }
                battleutils::AddTraits(PPet, traits::GetTraits(PPetData->mJob), PPet->GetMLevel());
                if (PPetData->mJob != PPetData->sJob)
                {
                    battleutils::AddTraits(PPet, traits::GetTraits(PPetData->sJob), PPet->GetSLevel());
                }
                // WAR pets have 25% DA
                if (PPetData->mJob == JOB_WAR && PPet->GetMLevel() >= 25 || PPetData->sJob == JOB_WAR && PPet->GetSLevel() >= 25)
                {
                    PPet->setModifier(Mod::DOUBLE_ATTACK, 25);
                }
                // Pets shouldn't have Inquartata unless Rune Fencers(?)
                if (PPetData->mJob != JOB_RUN)
                {
                    PPet->setModifier(Mod::INQUARTATA, 0);
                }

                // Max [HP/MP] Boost traits
                PPet->UpdateHealth();
                PPet->health.tp = 0;
                PPet->health.hp = PPet->GetMaxHP();
                PPet->health.mp = PPet->GetMaxMP();
            }

            PPet->allegiance = PMaster->allegiance;
            PMaster->StatusEffectContainer->CopyConfrontationEffect(PPet);

            PPet->PMaster = PMaster;

            if (PMaster->PBattlefield)
            {
                PPet->PBattlefield = PMaster->PBattlefield;
            }

            if (PMaster->PInstance)
            {
                PPet->PInstance = PMaster->PInstance;
            }

            PMaster->loc.zone->InsertPET(PPet);

            PPet->Spawn();
            if (PMaster->objtype == TYPE_PC)
            {
                SetupPetWithMaster(PMaster, PPet);
            }

            // apply stats from previous zone if this pet is being transferred
            if (spawningFromZone)
            {
                PPet->loadPetZoningInfo();
            }
        }
        else if (PMaster->objtype == TYPE_PC)
        {
            static_cast<CCharEntity*>(PMaster)->resetPetZoningInfo();
        }
    }

    void SpawnMobPet(CBattleEntity* PMaster, uint32 PetID)
    {
        // this is ONLY used for mob smn elementals / avatars
        /*
        This should eventually be merged into one big spawn pet method.
        At the moment player pets and mob pets are totally different. We need a central place
        to manage pet families and spawn them.
        */

        CMobEntity* PPet = (CMobEntity*)PMaster->PPet;

        // clang-format off
        Pet_t* PPetData = *std::find_if(g_PPetList.begin(), g_PPetList.end(), [PetID](Pet_t* t)
        {
            return t->PetID == PetID;
        });
        // clang-format on

        PPet->look = PPetData->look;
        PPet->name = PPetData->name;
        PPet->SetMJob(PPetData->mJob);
        PPet->SetSJob(PPetData->sJob);
        PPet->m_EcoSystem = PPetData->EcoSystem;
        PPet->m_Family = PPetData->m_Family;
        PPet->m_Element = PPetData->m_Element;
        PPet->HPscale = PPetData->HPscale;
        PPet->MPscale = PPetData->MPscale;
        PPet->m_HasSpellScript = PPetData->hasSpellScript;

        PPet->allegiance = PMaster->allegiance;
        PMaster->StatusEffectContainer->CopyConfrontationEffect(PPet);

        PPet->m_SpellListContainer = mobSpellList::GetMobSpellList(PPetData->spellList);

        PPet->setModifier(Mod::SLASHRES, PPetData->slashres);
        PPet->setModifier(Mod::PIERCERES, PPetData->pierceres);
        PPet->setModifier(Mod::RANGEDRES, PPetData->pierceres);
        PPet->setModifier(Mod::HTHRES, PPetData->hthres);
        PPet->setModifier(Mod::IMPACTRES, PPetData->impactres);

        PPet->setModifier(Mod::FIREDEF, PPetData->firedef); // These are stored as floating percentages
        PPet->setModifier(Mod::ICEDEF, PPetData->icedef); // and need to be adjusted into modifier units.
        PPet->setModifier(Mod::WINDDEF, PPetData->winddef); // Higher DEF = lower damage.
        PPet->setModifier(Mod::EARTHDEF, PPetData->earthdef); // Negatives signify increased damage.
        PPet->setModifier(Mod::THUNDERDEF, PPetData->thunderdef); // Positives signify reduced damage.
        PPet->setModifier(Mod::WATERDEF, PPetData->waterdef); // Ex: 125% damage would be 1.25, 50% damage would be 0.50
        PPet->setModifier(Mod::LIGHTDEF, PPetData->lightdef); // (1.25 - 1) * -1000 = -250 DEF
        PPet->setModifier(Mod::DARKDEF, PPetData->darkdef); // (0.50 - 1) * -1000 = 500 DEF

        PPet->setModifier(Mod::SDT_FIRE, PPetData->fireresSDT);
        PPet->setModifier(Mod::SDT_ICE, PPetData->iceresSDT);
        PPet->setModifier(Mod::SDT_WIND, PPetData->windresSDT);
        PPet->setModifier(Mod::SDT_EARTH, PPetData->earthresSDT);
        PPet->setModifier(Mod::SDT_THUNDER, PPetData->thunderresSDT);
        PPet->setModifier(Mod::SDT_WATER, PPetData->waterresSDT);
        PPet->setModifier(Mod::SDT_LIGHT, PPetData->lightresSDT);
        PPet->setModifier(Mod::SDT_DARK, PPetData->darkresSDT);

        PPet->setModifier(Mod::EEM_AMNESIA, PPetData->eemamnesia);
        PPet->setModifier(Mod::EEM_VIRUS, PPetData->eemvirus);
        PPet->setModifier(Mod::EEM_SILENCE, PPetData->eemsilence);
        PPet->setModifier(Mod::EEM_GRAVITY, PPetData->eemgravity);
        PPet->setModifier(Mod::EEM_STUN, PPetData->eemstun);
        PPet->setModifier(Mod::EEM_LIGHT_SLEEP, PPetData->eemlightsleep);
        PPet->setModifier(Mod::EEM_CHARM, PPetData->eemcharm);
        PPet->setModifier(Mod::EEM_PARALYZE, PPetData->eemparalyze);
        PPet->setModifier(Mod::EEM_BIND, PPetData->eembind);
        PPet->setModifier(Mod::EEM_SLOW, PPetData->eemslow);
        PPet->setModifier(Mod::EEM_PETRIFY, PPetData->eempetrify);
        PPet->setModifier(Mod::EEM_TERROR, PPetData->eemterror);
        PPet->setModifier(Mod::EEM_POISON, PPetData->eempoison);
        PPet->setModifier(Mod::EEM_DARK_SLEEP, PPetData->eemdarksleep);
        PPet->setModifier(Mod::EEM_BLIND, PPetData->eemblind);
        ShowDebug("%s (%s) is summoning a pet petID(%s) \n", PMaster->GetName(), PMaster->id, PetID);
        if (PetID < 0)
        {
            ShowDebug("%s (%s) is summoning a pet without a petID(%s)! \n", PMaster->GetName(), PMaster->id, PetID);
        }
        // Calculate pet specific stats
        if (PetID <= PETID_CAIT_SITH)
        {
            CPetEntity* PPetEnt = (CPetEntity*)PPet;

            CalculateAvatarStats(PMaster, PPetEnt);
        }

        if (PetID >= PETID_HARLEQUINFRAME && PetID <= PETID_STORMWAKERFRAME)
        {
            CPetEntity* PPetEnt = (CPetEntity*)PPet;

            CalculateAutomatonStats(PMaster, PPetEnt);
        }


        if (PetID == PETID_WYVERN)
        {
            CPetEntity* PPetEnt = (CPetEntity*)PPet;

            CalculateWyvernStats(PMaster, PPetEnt);
        }
    }

    void DetachPet(CBattleEntity* PMaster)
    {
        if (PMaster == nullptr)
        {
            ShowWarning("PMaster is null.");
            return;
        }

        if (PMaster->PPet == nullptr)
        {
            ShowWarning("Pet is null for %s.", PMaster->GetName());
            return;
        }

        if (PMaster->objtype != TYPE_PC)
        {
            ShowWarning("Non-PC passed into function (%s)", PMaster->GetName());
            return;
        }

        CBattleEntity* PPet = PMaster->PPet;
        CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);


        if (PPet->objtype == TYPE_MOB)
        {
            CMobEntity* PMob = (CMobEntity*)PPet;

            if (!PMob->isDead())
            {
                PMob->PEnmityContainer->UpdateEnmity(PChar, 1, 1);
                PMob->PAI->ChangeTarget(PMaster->targid);
                PMob->SetBattleTargetID(PChar->targid);

                // dirty exp if not full
                PMob->m_giveExp = PMob->GetHPP() == 100;

                //master using leave command
                auto state = dynamic_cast<CAbilityState*>(PMaster->PAI->GetCurrentState());
                if ((state && state->GetAbility()->getID() == ABILITY_LEAVE) || PChar->loc.zoning || PChar->isDead())
                {
                    PMob->StatusEffectContainer->DelStatusEffect(EFFECT_HEALING); // Incase the pet was stayed before the BST used leave
                    PMob->PEnmityContainer->Clear();
                    PMob->m_OwnerID.clean();
                    PMob->updatemask |= UPDATE_STATUS;
                    PMob->loc.zone->UpdateEntityPacket(PMob, ENTITY_UPDATE, UPDATE_ALL_MOB);
                }

            }
            else
            {
                PMob->m_OwnerID.clean();
                PMob->updatemask |= UPDATE_STATUS;
            }

            PMob->isCharmed = false;
            PMob->allegiance = ALLEGIANCE_MOB;
            PMob->charmTime = time_point::min();
            PMob->PMaster = nullptr;

            PMob->PAI->SetController(std::make_unique<CMobController>(PMob));
            PMob->loc.zone->UpdateEntityPacket(PMob, ENTITY_UPDATE, UPDATE_ALL_MOB);
        }
        else if (PPet->objtype == TYPE_PET)
        {
            if (!PPet->isDead())
                PPet->Die();
            CPetEntity* PPetEnt = (CPetEntity*)PPet;

            if (PPetEnt->getPetType() == PETTYPE_AVATAR)
                PMaster->setModifier(Mod::AVATAR_PERPETUATION, 0);

            ((CCharEntity*)PMaster)->PLatentEffectContainer->CheckLatentsPetType();
            PMaster->ForParty([](CBattleEntity* PMember)
            {
                ((CCharEntity*)PMember)->PLatentEffectContainer->CheckLatentsPartyAvatar();
            });

            if (PPetEnt->getPetType() != PETTYPE_AUTOMATON)
            {
                PPetEnt->PMaster = nullptr;
            }
            else
            {
                PPetEnt->PAI->SetController(nullptr);
            }
            PChar->removePetModifiers(PPetEnt);
            charutils::BuildingCharPetAbilityTable(PChar, PPetEnt, 0);// blank the pet commands
        }

        charutils::BuildingCharAbilityTable(PChar);
        PChar->PPet = nullptr;
        PChar->pushPacket(new CCharUpdatePacket(PChar));
        PChar->pushPacket(new CCharAbilitiesPacket(PChar));
        PChar->pushPacket(new CPetSyncPacket(PChar));
    }

    /************************************************************************
    *																		*
    *																		*
    *																		*
    ************************************************************************/

    void DespawnPet(CBattleEntity* PMaster)
    {
        TPZ_DEBUG_BREAK_IF(PMaster == nullptr);
        TPZ_DEBUG_BREAK_IF(PMaster->PPet == nullptr);

        petutils::DetachPet(PMaster);
    }

    int16 PerpetuationCost(uint32 id, uint8 level)
    {
        int16 cost = 0;
        // Elementals
        if (id >= 0 && id <= 7)
        {
            if (level < 10)
                cost = 1;
            else if (level < 19)
                cost = 2;
            else if (level < 28)
                cost = 3;
            else if (level < 38)
                cost = 4;
            else if (level < 47)
                cost = 5;
            else if (level < 56)
                cost = 6;
            else if (level < 65)
                cost = 8;
            else if (level < 68)
                cost = 10;
            else if (level < 71)
                cost = 11;
            else if (level < 74)
                cost = 12;
            else if (level < 81)
                cost = 13;
            else if (level < 91)
                cost = 14;
            else
                cost = 15;
        }
        // Carbuncle and Cait Sith
        else if (id == 8 || id == 20)
        {
            if (level < 10)
                cost = 1;
            else if (level < 18)
                cost = 2;
            else if (level < 27)
                cost = 3;
            else if (level < 36)
                cost = 4;
            else if (level < 45)
                cost = 5;
            else if (level < 54)
                cost = 6;
            else if (level < 63)
                cost = 7;
            else if (level < 72)
                cost = 8;
            else if (level < 81)
                cost = 9;
            else if (level < 91)
                cost = 10;
            else
                cost = 11;
        }
        // Fenrir
        else if (id == 9)
        {
            if (level < 8)
                cost = 1;
            else if (level < 15)
                cost = 2;
            else if (level < 22)
                cost = 3;
            else if (level < 30)
                cost = 4;
            else if (level < 37)
                cost = 5;
            else if (level < 45)
                cost = 6;
            else if (level < 51)
                cost = 7;
            else if (level < 59)
                cost = 8;
            else if (level < 66)
                cost = 9;
            else if (level < 73)
                cost = 10;
            else if (level < 81)
                cost = 11;
            else if (level < 91)
                cost = 12;
            else
                cost = 13;
        }
        // Celestials
        else if (id <= 16)
        {
            if (level < 10)
                cost = 1;
            else if (level < 19)
                cost = 2;
            else if (level < 28)
                cost = 3;
            else if (level < 38)
                cost = 4;
            else if (level < 47)
                cost = 5;
            else if (level < 56)
                cost = 6;
            else if (level < 65)
                cost = 8;
            else if (level < 68)
                cost = 10;
            else if (level < 71)
                cost = 11;
            else if (level < 74)
                cost = 12;
            else if (level < 81)
                cost = 13;
            else if (level < 91)
                cost = 14;
            else
                cost = 15;
        }

        return cost;
    }

    /*
    Familiars a pet.
    */
    void Familiar(CBattleEntity* PPet, CBattleEntity* PMaster)
    {

        /*
            Boost HP by 10%
            Increase charm duration up to 30 mins
            boost stats by 10%
            */

        // only increase time for charmed mobs
        if (PPet->objtype == TYPE_MOB && PPet->isCharmed)
        {
            // increase charm duration
            // 30 mins - 1-5 mins
            PPet->charmTime += 30min - std::chrono::milliseconds(tpzrand::GetRandomNumber(300000u));
        }

        float rate = 0.10f;

        // boost hp by 10%
        uint16 boost = (uint16)(PPet->health.maxhp * rate);

        PPet->health.maxhp += boost;
        PPet->health.hp += boost;
        PPet->UpdateHealth();

        // boost stats
        PPet->addModifier(Mod::HASTE_ABILITY, 1000);
        PPet->addModifier(Mod::ATTP, 15);
        PPet->addModifier(Mod::ACC, 50);
        PPet->addModifier(Mod::RACC, 50);
        PPet->addModifier(Mod::MACC, 25);
        PPet->addModifier(Mod::EVA, 25);
        PPet->addModifier(Mod::DEFP, 50);
        PPet->addModifier(Mod::DMG, -50);

        // Familiar attriute bonus from JP
        if (PMaster->objtype == TYPE_PC)
        {
            if (PMaster->GetMJob() == JOBTYPE::JOB_BST)
            {
                CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
                uint16 jpValue = PChar->PJobPoints->GetJobPointValue(JP_FAMILIAR_EFFECT) * 3;

                if (jpValue > 0)
                {
                    PPet->addModifier(Mod::STR, jpValue);
                    PPet->addModifier(Mod::DEX, jpValue);
                    PPet->addModifier(Mod::VIT, jpValue);
                    PPet->addModifier(Mod::AGI, jpValue);
                    PPet->addModifier(Mod::INT, jpValue);
                    PPet->addModifier(Mod::MND, jpValue);
                    PPet->addModifier(Mod::CHR, jpValue);
                }
            }
        }

    }

    void LoadPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone)
    {
        TPZ_DEBUG_BREAK_IF(PMaster == nullptr);
        TPZ_DEBUG_BREAK_IF(PetID >= MAX_PETID);

        Pet_t* PPetData = *std::find_if(g_PPetList.begin(), g_PPetList.end(), [PetID](Pet_t* t) { return t->PetID == PetID; });
    
        if (PMaster->GetMJob() != JOB_DRG && PetID == PETID_WYVERN)
        {
            return;
        }

        if (PMaster->objtype == TYPE_PC)
        {
            ((CCharEntity*)PMaster)->petZoningInfo.petID = PetID;
        }

        PETTYPE petType = PETTYPE_JUG_PET;

        if (PetID <= PETID_CAIT_SITH)
        {
            petType = PETTYPE_AVATAR;
        }
        //TODO: move this out of modifying the global pet list
        else if (PetID == PETID_WYVERN)
        {
            petType = PETTYPE_WYVERN;

            const char* Query =
                "SELECT\
                pet_name.name,\
                char_pet.wyvernid\
                FROM pet_name, char_pet\
                WHERE pet_name.id = char_pet.wyvernid AND \
                char_pet.charid = %u";

            if (Sql_Query(SqlHandle, Query, PMaster->id) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
            {
                while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                {
                    uint16 wyvernid = (uint16)Sql_GetIntData(SqlHandle, 1);

                    if (wyvernid != 0)
                    {
                        PPetData->name.clear();
                        PPetData->name.insert(0, (const char*)Sql_GetData(SqlHandle, 0));
                    }
                }
            }
        }
        /*
        else if (PetID==PETID_ADVENTURING_FELLOW)
        {
            petType = PETTYPE_ADVENTURING_FELLOW;

            const char* Query =
            "SELECT\
            pet_name.name,\
            char_pet.adventuringfellowid\
            FROM pet_name, char_pet\
            WHERE pet_name.id = char_pet.adventuringfellowid";

            if ( Sql_Query(SqlHandle, Query) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
            {
                while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                {
                    uint16 adventuringfellowid = (uint16)Sql_GetIntData(SqlHandle, 1);

                    if (adventuringfellowid != 0)
                    {
                        PPetData->name.clear();
                        PPetData->name.insert(0, Sql_GetData(SqlHandle, 0));
                    }
                }
            }
        }
        */
        else if (PetID == PETID_CHOCOBO)
        {
            petType = PETTYPE_CHOCOBO;

            const char* Query =
                "SELECT\
                char_pet.chocoboid\
                FROM char_pet\
                char_pet.charid = %u";

            if (Sql_Query(SqlHandle, Query, PMaster->id) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
            {
                while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                {
                    uint32 chocoboid = (uint32)Sql_GetIntData(SqlHandle, 0);

                    if (chocoboid != 0)
                    {
                        uint16 chocoboname1 = chocoboid & 0x0000FFFF;
                        uint16 chocoboname2 = chocoboid >>= 16;

                        PPetData->name.clear();

                        Query =
                            "SELECT\
                            pet_name.name\
                            FROM pet_name\
                            WHERE pet_name.id = %u OR pet_name.id = %u";

                        if (Sql_Query(SqlHandle, Query, chocoboname1, chocoboname2) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
                        {
                            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                            {
                                if (chocoboname1 != 0 && chocoboname2 != 0)
                                {
                                    PPetData->name.insert(0, (const char*)Sql_GetData(SqlHandle, 0));
                                }
                            }
                        }
                    }
                }
            }
        }
        else if (PetID == PETID_HARLEQUINFRAME || PetID == PETID_VALOREDGEFRAME || PetID == PETID_SHARPSHOTFRAME || PetID == PETID_STORMWAKERFRAME)
        {
            petType = PETTYPE_AUTOMATON;
        }
        else if (PetID == PETID_LUOPAN)
        {
            petType = PETTYPE_LUOPAN;
        }

        CPetEntity* PPet = nullptr;
        if (petType == PETTYPE_AUTOMATON && PMaster->objtype == TYPE_PC)
        {
            PPet = ((CCharEntity*)PMaster)->PAutomaton;
            PPet->PAI->SetController(std::make_unique<CAutomatonController>(static_cast<CAutomatonEntity*>(PPet)));
        }
        else
        {
            PPet = new CPetEntity(petType);
            PPet->saveModifiers();
        }

        PPet->loc = PMaster->loc;

        if (petType != PETTYPE_LUOPAN)
        {
            // spawn me randomly around master
            PPet->loc.p = nearPosition(PMaster->loc.p, CPetController::PetRoamDistance, (float)M_PI);
        }

        if (petType != PETTYPE_AUTOMATON)
        {
            PPet->look = PPetData->look;
            PPet->name = PPetData->name;
        }
        else
        {
            PPet->look.size = MODEL_AUTOMATON;
        }
        PPet->m_name_prefix = PPetData->name_prefix;
        PPet->m_Family = PPetData->m_Family;
        PPet->m_MobSkillList = PPetData->m_MobSkillList;
        PPet->m_Element = PPetData->m_Element;
        PPet->m_PetID = PPetData->PetID;
        PPet->setMobMod(MOBMOD_BLOCK, PPetData->shieldSize); // TODO: Probably turn into a member(m_shieldSize)
        // add special mob mods

        // this only has to be added once
        mobutils::AddCustomMods(PPet);

        if (PPet->getPetType() == PETTYPE_AVATAR)
        {
            CalculateAvatarStats(PMaster, PPet);
        }
        else if (PPet->getPetType() == PETTYPE_JUG_PET)
        {
            uint8 spawnLevel = static_cast<CCharEntity*>(PMaster)->petZoningInfo.petLevel;
            PPet->setSpawnLevel(spawnLevel > 0 ? spawnLevel : UINT8_MAX);
            PPet->setJugDuration(static_cast<int32>(PPetData->time));
            CalculateJugPetStats(PMaster, PPet);
        }
        else if (PPet->getPetType() == PETTYPE_WYVERN)
        {
            CalculateWyvernStats(PMaster, PPet);
        }
        else if (PPet->getPetType() == PETTYPE_AUTOMATON && PMaster->objtype == TYPE_PC)
        {
            CalculateAutomatonStats(PMaster, PPet);
        }
        else if (PPet->getPetType() == PETTYPE_LUOPAN && PMaster->objtype == TYPE_PC)
        {
            CalculateLoupanStats(PMaster, PPet);
        }

        FinalizePetStatistics(PMaster, PPet);
        if (PPet->getPetType() != PETTYPE_JUG_PET)
        {
            PPet->setSpawnLevel(PPet->GetMLevel());
        }
        PPet->status = STATUS_NORMAL;
        PPet->m_ModelSize = PPetData->size;
        PPet->m_EcoSystem = PPetData->EcoSystem;

        PMaster->PPet = PPet;
    }

    void FinalizePetStatistics(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        PPet->health.tp = 0;
        PMaster->applyPetModifiers(PPet);
        PPet->UpdateHealth();
        PPet->health.hp = PPet->GetMaxHP();
        PPet->health.mp = PPet->GetMaxMP();

        // Stout Servant - Can't really tie it ot a real mod since it applies to the pet
        if (CCharEntity* PCharMaster = dynamic_cast<CCharEntity*>(PMaster))
        {
            if (charutils::hasTrait(PCharMaster, TRAIT_STOUT_SERVANT))
            {
                for (CTrait* trait : PCharMaster->TraitList)
                {
                    if (trait->getID() == TRAIT_STOUT_SERVANT)
                    {
                        PPet->addModifier(Mod::DMG, -trait->getValue());
                        break;
                    }
                }
            }
        }
    }

    void SetupPetWithMaster(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        charutils::BuildingCharAbilityTable(static_cast<CCharEntity*>(PMaster));
        charutils::BuildingCharPetAbilityTable(static_cast<CCharEntity*>(PMaster), PPet, PPet->m_PetID);
        static_cast<CCharEntity*>(PMaster)->pushPacket(new CCharUpdatePacket(static_cast<CCharEntity*>(PMaster)));
        static_cast<CCharEntity*>(PMaster)->pushPacket(new CPetSyncPacket(static_cast<CCharEntity*>(PMaster)));

        // check latents affected by pets
        static_cast<CCharEntity*>(PMaster)->PLatentEffectContainer->CheckLatentsPetType();

        // clang-format off
                PMaster->ForParty([](CBattleEntity* PMember)
                {
                    static_cast<CCharEntity*>(PMember)->PLatentEffectContainer->CheckLatentsPartyAvatar();
                });
        // clang-format on
        if (PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_DEBILITATION))
        {
            PPet->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_DEBILITATION, EFFECT_DEBILITATION,
                                                                           PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_DEBILITATION)->GetPower(), 0,
                                                                           PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_DEBILITATION)->GetDuration()),
                                                         true);
        }
        if (PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_OMERTA))
        {
            PPet->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_OMERTA, EFFECT_OMERTA,
                                                                           PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_OMERTA)->GetPower(), 0,
                                                                           PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_OMERTA)->GetDuration()),
                                                         true);
        }
        if (PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_IMPAIRMENT))
        {
            PPet->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_IMPAIRMENT, EFFECT_IMPAIRMENT,
                                                                           PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetPower(), 0,
                                                                           PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetDuration()),
                                                         true);
        }
    }


    bool CheckPetModType(CBattleEntity* PPet, PetModType petmod)
    {
        if (petmod == PetModType::All)
            return true;

        if (auto PPetEntity = dynamic_cast<CPetEntity*>(PPet))
        {
            if (petmod == PetModType::Avatar && PPetEntity->getPetType() == PETTYPE_AVATAR)
            {
                return true;
            }
            if (petmod == PetModType::Wyvern && PPetEntity->getPetType() == PETTYPE_WYVERN)
            {
                return true;
            }
            if (petmod >= PetModType::Automaton && petmod <= PetModType::Stormwaker && PPetEntity->getPetType() == PETTYPE_AUTOMATON)
            {
                if (petmod == PetModType::Automaton || (uint16)petmod + 28 == (uint16)static_cast<CAutomatonEntity*>(PPetEntity)->getFrame())
                {
                    return true;
                }
            }
            if (petmod >= PetModType::Firespirit && petmod <= PetModType::Darkspirit && PPetEntity->m_PetID >= PETID_FIRESPIRIT &&
                PPetEntity->m_PetID >= PETID_DARKSPIRIT) // Elementals
            {
                return true;
            }
            if (petmod == PetModType::Carbuncle && PPetEntity->m_PetID == PETID_CARBUNCLE)
            {
                return true;
            }
            if (petmod == PetModType::Fenrir && PPetEntity->m_PetID == PETID_FENRIR)
            {
                return true;
            }
            if (petmod == PetModType::Ifrit && PPetEntity->m_PetID == PETID_IFRIT)
            {
                return true;
            }
            if (petmod == PetModType::Titan && PPetEntity->m_PetID == PETID_TITAN)
            {
                return true;
            }
            if (petmod == PetModType::Leviathan && PPetEntity->m_PetID == PETID_LEVIATHAN)
            {
                return true;
            }
            if (petmod == PetModType::Garuda && PPetEntity->m_PetID == PETID_GARUDA)
            {
                return true;
            }
            if (petmod == PetModType::Shiva && PPetEntity->m_PetID == PETID_SHIVA)
            {
                return true;
            }
            if (petmod == PetModType::Ramuh && PPetEntity->m_PetID == PETID_RAMUH)
            {
                return true;
            }
            if (petmod == PetModType::Diabolos && PPetEntity->m_PetID == PETID_DIABOLOS)
            {
                return true;
            }
            if (petmod == PetModType::Cait_sith && PPetEntity->m_PetID == PETID_CAIT_SITH)
            {
                return true;
            }
            if (petmod == PetModType::Adventuring_fellow && PPetEntity->m_PetID == PETID_ADVENTURING_FELLOW)
            {
                return true;
            }
            if (petmod == PetModType::Chocobo && PPetEntity->m_PetID == PETID_CHOCOBO)
            {
                return true;
            }
            if (petmod == PetModType::Luopan && PPetEntity->m_PetID == PETID_LUOPAN)
            {
                return true;
            }
        }
        else
        {
            return true;
        }
        return false;
    }
}; // namespace petutils

﻿#include "trustutils.h"

#include "../../common/timer.h"
#include "../../common/utils.h"

#include <algorithm>
#include <cmath>
#include <cstring>
#include <vector>

#include "battleutils.h"
#include "charutils.h"
#include "mobutils.h"
#include "zoneutils.h"

#include "../grades.h"
#include "../map.h"
#include "../mob_modifier.h"
#include "../mob_spell_list.h"

#include "../ai/ai_container.h"
#include "../ai/controllers/trust_controller.h"
#include "../ai/helpers/gambits_container.h"
#include "../entities/mobentity.h"
#include "../entities/trustentity.h"
#include "../items/item_weapon.h"
#include "../packets/char_sync.h"
#include "../packets/entity_update.h"
#include "../packets/message_standard.h"
#include "../packets/trust_sync.h"
#include "../mobskill.h"
#include "../status_effect_container.h"
#include "../weapon_skill.h"
#include "../zone_instance.h"

struct TrustSpell_ID
{
    uint32 spellID;
};

std::vector<TrustSpell_ID*> g_PTrustIDList;

struct Trust_t
{
    uint32 trustID;
    uint32 pool;
    look_t look;          // appearance data
    string_t name;        // script name string
    string_t packet_name; // packet name string
    ECOSYSTEM EcoSystem;  // ecosystem

    uint8 name_prefix;
    uint8 radius; // Model Radius - affects melee range etc.
    uint8 size; // размер модели
    uint16 m_Family;

    uint16 behaviour;

    uint8 mJob;
    uint8 sJob;
    float HPscale; // HP boost percentage
    float MPscale; // MP boost percentage

    uint8 cmbSkill;
    uint16 cmbDmgMult;
    uint16 cmbDelay;
    uint8 speed;
    // stat ranks
    uint8 strRank;
    uint8 dexRank;
    uint8 vitRank;
    uint8 agiRank;
    uint8 intRank;
    uint8 mndRank;
    uint8 chrRank;
    uint8 attRank;
    uint8 defRank;
    uint8 evaRank;
    uint8 accRank;

    uint16 m_MobSkillList;

    // magic stuff
    bool hasSpellScript;
    uint16 spellList;

    // resists
    int16 slashres;
    int16 pierceres;
    int16 hthres;
    int16 impactres;

    int16 firedef;
    int16 icedef;
    int16 winddef;
    int16 earthdef;
    int16 thunderdef;
    int16 waterdef;
    int16 lightdef;
    int16 darkdef;

    int16 fireres;
    int16 iceres;
    int16 windres;
    int16 earthres;
    int16 thunderres;
    int16 waterres;
    int16 lightres;
    int16 darkres;

    int16 shieldSize;
};

std::vector<Trust_t*> g_PTrustList;

namespace trustutils
{
void LoadTrustList()
{
    FreeTrustList();

    const char* Query = "SELECT \
                 spell_list.spellid, mob_pools.poolid \
                 FROM spell_list, mob_pools \
                 WHERE spell_list.spellid >= 896 AND mob_pools.poolid = (spell_list.spellid+5000) ORDER BY spell_list.spellid";

    if (Sql_Query(SqlHandle, Query) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            TrustSpell_ID* trustID = new TrustSpell_ID();

            trustID->spellID = (uint32)Sql_GetIntData(SqlHandle, 0);

            g_PTrustIDList.push_back(trustID);
        }
    }

    for (auto& index : g_PTrustIDList)
    {
        BuildTrust(index->spellID);
    }
}

void BuildTrust(uint32 TrustID)
{
    const char* Query = "SELECT \
                mob_pools.name,\
                mob_pools.packet_name,\
                mob_pools.modelid,\
                mob_pools.familyid,\
                mob_pools.mJob,\
                mob_pools.sJob,\
                mob_pools.hasSpellScript, mob_pools.spellList, \
                mob_pools.cmbSkill, mob_pools.cmbDmgMult, mob_pools.cmbDelay, mob_pools.name_prefix, \
                mob_pools.behavior, mob_pools.skill_list_id, \
                spell_list.spellid, \
                mob_family_system.mobsize, mob_family_system.systemid, \
                (mob_family_system.HP / 100), \
                (mob_family_system.MP / 100), \
                mob_family_system.speed, \
                mob_family_system.STR, \
                mob_family_system.DEX, \
                mob_family_system.VIT, \
                mob_family_system.AGI, \
                mob_family_system.INT, \
                mob_family_system.MND, \
                mob_family_system.CHR, \
                mob_family_system.DEF, \
                mob_family_system.ATT, \
                mob_family_system.ACC, \
                mob_family_system.EVA, \
                mob_family_system.Slash, mob_family_system.Pierce, \
                mob_family_system.H2H, mob_family_system.Impact, \
                mob_family_system.Fire, mob_family_system.Ice, \
                mob_family_system.Wind, mob_family_system.Earth, \
                mob_family_system.Lightning, mob_family_system.Water, \
                mob_family_system.Light, mob_family_system.Dark, \
                mob_pools.shieldSize \
                FROM spell_list, mob_pools, mob_family_system WHERE spell_list.spellid = %u \
                AND (spell_list.spellid+5000) = mob_pools.poolid AND mob_pools.familyid = mob_family_system.familyid ORDER BY spell_list.spellid";

    auto ret = Sql_Query(SqlHandle, Query, TrustID);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            Trust_t* trust = new Trust_t();

            trust->trustID = TrustID;
            trust->name.insert(0, (const char*)Sql_GetData(SqlHandle, 0));
            trust->packet_name.insert(0, (const char*)Sql_GetData(SqlHandle, 1));
            memcpy(&trust->look, Sql_GetData(SqlHandle, 2), 20);
            trust->m_Family = (uint16)Sql_GetIntData(SqlHandle, 3);
            trust->mJob = (uint8)Sql_GetIntData(SqlHandle, 4);
            trust->sJob = (uint8)Sql_GetIntData(SqlHandle, 5);
            trust->hasSpellScript = (bool)Sql_GetIntData(SqlHandle, 6);
            trust->spellList = (uint16)Sql_GetIntData(SqlHandle, 7);
            trust->cmbSkill = (uint16)Sql_GetIntData(SqlHandle, 8);
            trust->cmbDmgMult = (uint16)Sql_GetIntData(SqlHandle, 9);
            trust->cmbDelay = (uint16)Sql_GetIntData(SqlHandle, 10);
            trust->name_prefix = (uint8)Sql_GetUIntData(SqlHandle, 11);
            trust->behaviour = (uint16)Sql_GetUIntData(SqlHandle, 12);
            trust->m_MobSkillList = (uint16)Sql_GetUIntData(SqlHandle, 13);
            // SpellID
            trust->size = Sql_GetUIntData(SqlHandle, 15);
            trust->EcoSystem = (ECOSYSTEM)Sql_GetIntData(SqlHandle, 16);
            trust->HPscale = Sql_GetFloatData(SqlHandle, 17);
            trust->MPscale = Sql_GetFloatData(SqlHandle, 18);
            trust->speed = (uint8)Sql_GetIntData(SqlHandle, 19);
            trust->strRank = (uint8)Sql_GetIntData(SqlHandle, 20);
            trust->dexRank = (uint8)Sql_GetIntData(SqlHandle, 21);
            trust->vitRank = (uint8)Sql_GetIntData(SqlHandle, 22);
            trust->agiRank = (uint8)Sql_GetIntData(SqlHandle, 23);
            trust->intRank = (uint8)Sql_GetIntData(SqlHandle, 24);
            trust->mndRank = (uint8)Sql_GetIntData(SqlHandle, 25);
            trust->chrRank = (uint8)Sql_GetIntData(SqlHandle, 26);
            trust->defRank = (uint8)Sql_GetIntData(SqlHandle, 27);
            trust->attRank = (uint8)Sql_GetIntData(SqlHandle, 28);
            trust->accRank = (uint8)Sql_GetIntData(SqlHandle, 29);
            trust->evaRank = (uint8)Sql_GetIntData(SqlHandle, 30);

            // resistances
            trust->slashres = (uint16)(Sql_GetFloatData(SqlHandle, 31) * 1000);
            trust->pierceres = (uint16)(Sql_GetFloatData(SqlHandle, 32) * 1000);
            trust->hthres = (uint16)(Sql_GetFloatData(SqlHandle, 33) * 1000);
            trust->impactres = (uint16)(Sql_GetFloatData(SqlHandle, 34) * 1000);

            trust->firedef = 0;
            trust->icedef = 0;
            trust->winddef = 0;
            trust->earthdef = 0;
            trust->thunderdef = 0;
            trust->waterdef = 0;
            trust->lightdef = 0;
            trust->darkdef = 0;

            trust->fireres = (uint16)((Sql_GetFloatData(SqlHandle, 35) - 1) * -100);
            trust->iceres = (uint16)((Sql_GetFloatData(SqlHandle, 36) - 1) * -100);
            trust->windres = (uint16)((Sql_GetFloatData(SqlHandle, 37) - 1) * -100);
            trust->earthres = (uint16)((Sql_GetFloatData(SqlHandle, 38) - 1) * -100);
            trust->thunderres = (uint16)((Sql_GetFloatData(SqlHandle, 39) - 1) * -100);
            trust->waterres = (uint16)((Sql_GetFloatData(SqlHandle, 40) - 1) * -100);
            trust->lightres = (uint16)((Sql_GetFloatData(SqlHandle, 41) - 1) * -100);
            trust->darkres = (uint16)((Sql_GetFloatData(SqlHandle, 42) - 1) * -100);
            trust->shieldSize = (uint16)(Sql_GetUIntData(SqlHandle, 43)); // TODO: Probably turn into a member(m_shieldSize)

            g_PTrustList.push_back(trust);
        }
    }
}

void FreeTrustList()
{
    g_PTrustIDList.clear();
}

void SpawnTrust(CCharEntity* PMaster, uint32 TrustID)
{
    if (PMaster->PParty == nullptr)
    {
        PMaster->PParty = new CParty(PMaster);
    }

    CTrustEntity* PTrust = LoadTrust(PMaster, TrustID);
    PMaster->PTrusts.insert(PMaster->PTrusts.end(), PTrust);
    PMaster->StatusEffectContainer->CopyConfrontationEffect(PTrust);

    if (PMaster->PBattlefield)
    {
        PTrust->PBattlefield = PMaster->PBattlefield;
    }

    if (PMaster->PInstance)
    {
        PTrust->PInstance = PMaster->PInstance;
    }

    PMaster->loc.zone->InsertTRUST(PTrust);
    PTrust->Spawn();

    PMaster->PParty->ReloadParty();
}

CTrustEntity* LoadTrust(CCharEntity* PMaster, uint32 TrustID)
{
    auto* PTrust = new CTrustEntity(PMaster);

    // clang-format off
    auto maybeTrustData = std::find_if(g_PTrustList.begin(), g_PTrustList.end(), [TrustID](Trust_t* t)
    {
        return t->trustID == TrustID;
    });
    // clang-format on

    if (maybeTrustData == g_PTrustList.end())
    {
        ShowError(fmt::format("Could not look up trust data for id: {}", TrustID));
        return PTrust;
    }

    auto* trustData = *maybeTrustData;

    PTrust->loc = PMaster->loc;
    PTrust->m_OwnerID.id = PMaster->id;
    PTrust->m_OwnerID.targid = PMaster->targid;

    // spawn me randomly around master
    PTrust->loc.p = nearPosition(PMaster->loc.p, CTrustController::SpawnDistance + (PMaster->PTrusts.size() * CTrustController::SpawnDistance), (float)M_PI);
    PTrust->look = trustData->look;
    PTrust->name = trustData->name;

    PTrust->m_Pool = trustData->pool;
    PTrust->packetName = trustData->packet_name;
    PTrust->m_name_prefix = trustData->name_prefix;
    PTrust->m_Family = trustData->m_Family;
    PTrust->m_MobSkillList = trustData->m_MobSkillList;
    PTrust->HPscale = trustData->HPscale;
    PTrust->MPscale = trustData->MPscale;
    // PTrust->speed = trustData->speed; Unneeded, all trusts should be 50 speed
    PTrust->m_TrustID = trustData->trustID;
    PTrust->status = STATUS_NORMAL;
    PTrust->m_ModelSize = trustData->radius;
    PTrust->m_EcoSystem = trustData->EcoSystem;

    PTrust->SetMJob(trustData->mJob);
    PTrust->SetSJob(trustData->sJob);

    // assume level matches master
    PTrust->SetMLevel(PMaster->GetMLevel());
    PTrust->SetSLevel(std::floor(PMaster->GetMLevel() / 2));

    PTrust->setModifier(Mod::SLASHRES, trustData->slashres);
    PTrust->setModifier(Mod::PIERCERES, trustData->pierceres);
    PTrust->setModifier(Mod::RANGEDRES, trustData->pierceres);
    PTrust->setModifier(Mod::HTHRES, trustData->hthres);
    PTrust->setModifier(Mod::IMPACTRES, trustData->impactres);

    PTrust->setModifier(Mod::FIRERES, trustData->fireres);
    PTrust->setModifier(Mod::ICERES, trustData->iceres);
    PTrust->setModifier(Mod::WINDRES, trustData->windres);
    PTrust->setModifier(Mod::EARTHRES, trustData->earthres);
    PTrust->setModifier(Mod::THUNDERRES, trustData->thunderres);
    PTrust->setModifier(Mod::WATERRES, trustData->waterres);
    PTrust->setModifier(Mod::LIGHTRES, trustData->lightres);
    PTrust->setModifier(Mod::DARKRES, trustData->darkres);

    PTrust->setMobMod(MOBMOD_BLOCK, trustData->shieldSize); // TODO: Probably turn into a member(m_shieldSize)
    PTrust->setMobMod(MOBMOD_CAN_PARRY, 1); // All trusts have the ability to parry if their weapon is capable of doing so

    PTrust->saveModifiers();
    PTrust->saveMobModifiers();

    LoadTrustStatsAndSkills(PTrust);

    // Use Mob formulas to work out base "weapon" damage, but scale down to reasonable values.
    auto mobStyleDamage = static_cast<float>(mobutils::GetWeaponDamage(PTrust, SLOT_MAIN));
    auto baseDamage = mobStyleDamage * 0.5f;
    auto damageMultiplier = static_cast<float>(trustData->cmbDmgMult) / 100.0f;
    auto adjustedDamage = baseDamage * damageMultiplier;
    auto finalDamage = static_cast<uint16>(std::max(adjustedDamage, 1.0f));

    // Trust do not really have weapons, but they are modelled internally as
    // if they do.
    if (auto* mainWeapon = dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_MAIN]))
    {
        mainWeapon->setMaxHit(1);
        mainWeapon->setSkillType(trustData->cmbSkill);

        // 2H Weapons should deal more damage
        if (mainWeapon->isTwoHanded())
        {
            finalDamage = finalDamage * 2;
        }

        mainWeapon->setDamage(finalDamage);

        // 1h weapons should be faster
        if (!mainWeapon->isTwoHanded() && !mainWeapon->isHandToHand())
        {
            mainWeapon->setDelay(((trustData->cmbDelay * 1000) / 60) / 2);
            mainWeapon->setBaseDelay(((trustData->cmbDelay * 1000) / 60) / 2);
        }
        else
        {
            mainWeapon->setDelay((trustData->cmbDelay * 1000) / 60);
            mainWeapon->setBaseDelay((trustData->cmbDelay * 1000) / 60);
        }
    }

    if (auto* subWeapon = dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_SUB]))
    {
        subWeapon->setDamage(finalDamage);
        subWeapon->setDelay(((trustData->cmbDelay * 1000) / 60) / 2);
        subWeapon->setBaseDelay(((trustData->cmbDelay * 1000) / 60) / 2);
    }

    if (auto* rangedWeapon = dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_RANGED]))
    {
        auto rangedWepDelay = 540;
        rangedWeapon->setDamage(finalDamage * 3);
        rangedWeapon->setDelay((rangedWepDelay * 1000) / 60);
        rangedWeapon->setBaseDelay((trustData->cmbDelay * 1000) / 60);
    }

    if (auto* ammoWeapon = dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_AMMO]))
    {
        auto rangedAmmoDelay = 90;

        ammoWeapon->setDamage(finalDamage);
        ammoWeapon->setDelay((trustData->cmbDelay * 1000) / 60);
        ammoWeapon->setBaseDelay((trustData->cmbDelay * 1000) / 60);
    }

    if (trustData->m_Family == 971) 
    {
        PTrust->m_dualWield = true;
    }

    if (auto* spellList = mobSpellList::GetMobSpellList(trustData->spellList); spellList != nullptr)
    {
        mobutils::SetSpellList(PTrust, trustData->spellList);
    }

    return PTrust;
}

void LoadTrustStatsAndSkills(CTrustEntity* PTrust)
{
    JOBTYPE mJob = PTrust->GetMJob();
    JOBTYPE sJob = PTrust->GetSJob();
    uint8   mLvl = PTrust->GetMLevel();
    uint8   sLvl = PTrust->GetSLevel();

    // Helpers to map HP/MPScale around 100 to 1-7 grades
    // std::clamp doesn't play nice with uint8, so -> unsigned int
    auto mapRanges = [](unsigned int inputStart, unsigned int inputEnd, unsigned int outputStart, unsigned int outputEnd, unsigned int inputVal) -> unsigned int
    {
        unsigned int inputRange = inputEnd - inputStart;
        unsigned int outputRange = outputEnd - outputStart;

        unsigned int output = (inputVal - inputStart) * outputRange / inputRange + outputStart;

        return std::clamp(output, outputStart, outputEnd);
    };

    auto scaleToGrade = [mapRanges](float input) -> unsigned int
    {
        unsigned int multipliedInput = static_cast<unsigned int>(input * 100U);
        unsigned int reverseMappedGrade = mapRanges(70U, 140U, 1U, 7U, multipliedInput);
        unsigned int outputGrade = std::clamp(7U - reverseMappedGrade, 1U, 7U);
        return outputGrade;
    };

    // HP/MP ========================
    // This is the same system as used in charutils.cpp, but modified
    // to use parts from mob_family_system instead of hardcoded player
    // race tables.

    // http://ffxi-stat-calc.sourceforge.net/cgi-bin/ffxistats.cgi?mode=document

    // HP
    float raceStat = 0;
    float jobStat = 0;
    float sJobStat = 0;
    int32 bonusStat = 0;

    int32 baseValueColumn = 0;
    int32 scaleTo60Column = 1;
    int32 scaleOver30Column = 2;
    int32 scaleOver60Column = 3;
    int32 scaleOver75Column = 4;
    int32 scaleOver60 = 2;
    int32 scaleOver75 = 3;

    uint8 grade;

    int32 mainLevelOver30 = std::clamp(mLvl - 30, 0, 30);
    int32 mainLevelUpTo60 = (mLvl < 60 ? mLvl - 1 : 59);
    int32 mainLevelOver60To75 = std::clamp(mLvl - 60, 0, 15);
    int32 mainLevelOver75 = (mLvl < 75 ? 0 : mLvl - 75);

    int32 mainLevelOver10 = (mLvl < 10 ? 0 : mLvl - 10);
    int32 mainLevelOver50andUnder60 = std::clamp(mLvl - 50, 0, 10);
    int32 mainLevelOver60 = (mLvl < 60 ? 0 : mLvl - 60);

    int32 subLevelOver10 = std::clamp(sLvl - 10, 0, 20);
    int32 subLevelOver30 = (sLvl < 30 ? 0 : sLvl - 30);

    grade = scaleToGrade(PTrust->HPscale);

    raceStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
               (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
               (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

    grade = grade = grade::GetJobGrade(mJob, 0);

    jobStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
              (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
              (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

    bonusStat = (mainLevelOver10 + mainLevelOver50andUnder60) * 2;

    if (sLvl > 0)
    {
        grade = grade::GetJobGrade(sJob, 0);

        sJobStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * (sLvl - 1)) +
                   (grade::GetHPScale(grade, scaleOver30Column) * subLevelOver30) + subLevelOver30 + subLevelOver10;
    }

    PTrust->health.maxhp = (int16)(map_config.alter_ego_hp_multiplier * (raceStat + jobStat + bonusStat + sJobStat));

    // MP
    raceStat = 0;
    jobStat = 0;
    sJobStat = 0;

    grade = scaleToGrade(PTrust->MPscale);

    if (grade::GetJobGrade(mJob, 1) == 0)
    {
        if (grade::GetJobGrade(sJob, 1) != 0 && sLvl > 0)
        {
            raceStat = (grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * (sLvl - 1)) / map_config.sj_mp_divisor;
        }
    }
    else
    {
        raceStat =
            grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 + grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
    }

    grade = grade::GetJobGrade(mJob, 1);

    if (grade > 0)
    {
        jobStat =
            grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 + grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
    }

    if (sLvl > 0)
    {
        grade = grade::GetJobGrade(sJob, 1);
        sJobStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column);
    }

    PTrust->health.maxmp = (int16)(map_config.alter_ego_mp_multiplier * (raceStat + jobStat + sJobStat));

    PTrust->health.tp = 0;
    PTrust->UpdateHealth();
    PTrust->health.hp = PTrust->GetMaxHP();
    PTrust->health.mp = PTrust->GetMaxMP();

    // Stats ========================
    uint16 fSTR = mobutils::GetBaseToRank(PTrust->strRank, mLvl);
    uint16 fDEX = mobutils::GetBaseToRank(PTrust->dexRank, mLvl);
    uint16 fVIT = mobutils::GetBaseToRank(PTrust->vitRank, mLvl);
    uint16 fAGI = mobutils::GetBaseToRank(PTrust->agiRank, mLvl);
    uint16 fINT = mobutils::GetBaseToRank(PTrust->intRank, mLvl);
    uint16 fMND = mobutils::GetBaseToRank(PTrust->mndRank, mLvl);
    uint16 fCHR = mobutils::GetBaseToRank(PTrust->chrRank, mLvl);

    uint16 mSTR = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetMJob(), 2), mLvl);
    uint16 mDEX = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetMJob(), 3), mLvl);
    uint16 mVIT = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetMJob(), 4), mLvl);
    uint16 mAGI = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetMJob(), 5), mLvl);
    uint16 mINT = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetMJob(), 6), mLvl);
    uint16 mMND = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetMJob(), 7), mLvl);
    uint16 mCHR = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetMJob(), 8), mLvl);

    uint16 sSTR = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetSJob(), 2), sLvl);
    uint16 sDEX = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetSJob(), 3), sLvl);
    uint16 sVIT = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetSJob(), 4), sLvl);
    uint16 sAGI = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetSJob(), 5), sLvl);
    uint16 sINT = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetSJob(), 6), sLvl);
    uint16 sMND = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetSJob(), 7), sLvl);
    uint16 sCHR = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetSJob(), 8), sLvl);

    if (sLvl > 15)
    {
        sSTR /= 2;
        sDEX /= 2;
        sAGI /= 2;
        sINT /= 2;
        sMND /= 2;
        sCHR /= 2;
        sVIT /= 2;
    }
    else
    {
        sSTR = 0;
        sDEX = 0;
        sAGI = 0;
        sINT = 0;
        sMND = 0;
        sCHR = 0;
        sVIT = 0;
    }

    PTrust->stats.STR = static_cast<uint16>((fSTR + mSTR + sSTR) * map_config.alter_ego_stat_multiplier);
    PTrust->stats.DEX = static_cast<uint16>((fDEX + mDEX + sDEX) * map_config.alter_ego_stat_multiplier);
    PTrust->stats.VIT = static_cast<uint16>((fVIT + mVIT + sVIT) * map_config.alter_ego_stat_multiplier);
    PTrust->stats.AGI = static_cast<uint16>((fAGI + mAGI + sAGI) * map_config.alter_ego_stat_multiplier);
    PTrust->stats.INT = static_cast<uint16>((fINT + mINT + sINT) * map_config.alter_ego_stat_multiplier);
    PTrust->stats.MND = static_cast<uint16>((fMND + mMND + sMND) * map_config.alter_ego_stat_multiplier);
    PTrust->stats.CHR = static_cast<uint16>((fCHR + mCHR + sCHR) * map_config.alter_ego_stat_multiplier);

    // Skills =======================
    int8 mlvl = PTrust->GetMLevel();
    int evasionRank = GetEvasionRankForJob(PTrust->GetMJob()); // Get rank for Trust's job

    BuildingTrustSkillsTable(PTrust);

    PTrust->addModifier(Mod::DEF, mobutils::GetBase(PTrust, PTrust->defRank));
    PTrust->addModifier(Mod::EVA, battleutils::GetMaxSkill(evasionRank, mlvl > 99 ? 99 : mlvl));
    PTrust->addModifier(Mod::ATT, mobutils::GetBase(PTrust, PTrust->attRank));
    PTrust->addModifier(Mod::ACC, mobutils::GetBase(PTrust, PTrust->accRank));
    PTrust->addModifier(Mod::RATT, mobutils::GetBase(PTrust, PTrust->attRank));
    PTrust->addModifier(Mod::RACC, mobutils::GetBase(PTrust, PTrust->accRank));

    PTrust->addModifier(Mod::PARRY, battleutils::GetMaxSkill(SKILL_SINGING, JOB_BRD, mLvl)); // C Rank parrying

    // Add shield skill(A+) if block mod > 0
    if (PTrust->getMobMod(MOBMOD_BLOCK) > 0) // TODO: MOBMOD_CAN_BLOCK ?
    {
        PTrust->addModifier(Mod::SHIELD, battleutils::GetMaxSkill(SKILL_ENFEEBLING_MAGIC, JOB_RDM, mLvl));
    }

    // Add traits for sub and main
    battleutils::AddTraits(PTrust, traits::GetTraits(mJob), mLvl);
    battleutils::AddTraits(PTrust, traits::GetTraits(sJob), sLvl);

    // Max [HP/MP] Boost traits
    PTrust->UpdateHealth();
    PTrust->health.tp = 0;
    PTrust->health.hp = PTrust->GetMaxHP();
    PTrust->health.mp = PTrust->GetMaxMP();

    mobutils::SetupJob(PTrust);

    // Skills
    using namespace gambits;
    auto* controller = dynamic_cast<CTrustController*>(PTrust->PAI->GetController());

    // Default TP selectors
    controller->m_GambitsContainer->tp_trigger = G_TP_TRIGGER::ASAP;
    controller->m_GambitsContainer->tp_select = G_SELECT::RANDOM;

    auto skillList = battleutils::GetMobSkillList(PTrust->m_MobSkillList);
    for (uint16 skill_id : skillList)
    {
        TrustSkill_t skill;
        if (skill_id <= 240) // Player WSs
        {
            CWeaponSkill* PWeaponSkill = battleutils::GetWeaponSkill(skill_id);
            if (!PWeaponSkill)
            {
                ShowWarning("LoadTrustStatsAndSkills: Error loading WeaponSkill id %d for trust %s\n", skill_id, PTrust->name);
                break;
            }

            skill = TrustSkill_t{
                G_REACTION::WS, skill_id, PWeaponSkill->getPrimarySkillchain(), PWeaponSkill->getSecondarySkillchain(), PWeaponSkill->getTertiarySkillchain(),
            };
        }
        else // MobSkills
        {
            CMobSkill* PMobSkill = battleutils::GetMobSkill(skill_id);
            if (!PMobSkill)
            {
                ShowWarning("LoadTrustStatsAndSkills: Error loading MobSkill id %d for trust %s\n", skill_id, PTrust->name);
                break;
            }
            skill = {
                G_REACTION::MS, skill_id, PMobSkill->getPrimarySkillchain(), PMobSkill->getSecondarySkillchain(), PMobSkill->getTertiarySkillchain(),
            };
        }

        // Only get access to skills that produce Lv3 SCs after Lv60
        bool canFormLv3Skillchain = skill.primary >= SC_GRAVITATION || skill.secondary >= SC_GRAVITATION || skill.tertiary >= SC_GRAVITATION;

        // Special case for Zeid II and others who only have Lv3+ skills
        bool onlyHasLv3Skillchains = canFormLv3Skillchain && controller->m_GambitsContainer->tp_skills.empty();

        // If level 60+, only use high level WS
        if (PTrust->GetMLevel() >= 60)
        {
            if (canFormLv3Skillchain || IsHighLevelWS(skill_id))
            {
                controller->m_GambitsContainer->tp_skills.emplace_back(skill);
            }
        }
        else // Use low level weaponskills
        {
            // Check for high-level weapon skills and level 60+ requirement
            if ((!canFormLv3Skillchain || PTrust->GetMLevel() >= 60 || onlyHasLv3Skillchains) && (PTrust->GetMLevel() >= 60 || !IsHighLevelWS(skill_id)))
            {
                controller->m_GambitsContainer->tp_skills.emplace_back(skill);
            }
        }
    }
}

void BuildingTrustSkillsTable(CTrustEntity* PTrust)
{
    JOBTYPE mJob = PTrust->GetMJob();
    JOBTYPE sJob = PTrust->GetSJob();
    uint8 mLvl = PTrust->GetMLevel();
    uint8 sLvl = PTrust->GetSLevel();
    int32 skillBonus = 0;

    // Spells
    // Set base skills for all magic skills
    for (int i = SKILL_DIVINE_MAGIC; i <= SKILL_HANDBELL; i++)
    {
        uint16 maxSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PTrust->GetMJob(), PTrust->GetMLevel() > 99 ? 99 : PTrust->GetMLevel());
        if (maxSkill != 0)
        {
            PTrust->WorkingSkills.skill[i] = static_cast<uint16>(maxSkill * map_config.alter_ego_skill_multiplier);
        }
        else
        {
            // Check subjob skill if main job has no skill
            uint16 maxSubSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PTrust->GetSJob(), PTrust->GetMLevel() > 99 ? 99 : PTrust->GetMLevel());

            if (maxSubSkill != 0)
            {
                PTrust->WorkingSkills.skill[i] = static_cast<uint16>(maxSubSkill * map_config.alter_ego_skill_multiplier);
            }
        }
    }

    for (int32 i = 1; i < 48; ++i)
    {
        // ignore unused skills
        if ((i >= 13 && i <= 21) || (i >= 46 && i <= 47))
        {
            PTrust->WorkingSkills.skill[i] = 0x8000;
            continue;
        }
        uint16 MaxMSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PTrust->GetMJob(), PTrust->GetMLevel());
        uint16 MaxSSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PTrust->GetSJob(), PTrust->GetSLevel());
        int32 skillBonus = 0;
        // apply arts bonuses
        if ((i >= 32 && i <= 35 && PTrust->StatusEffectContainer->HasStatusEffect({ EFFECT_LIGHT_ARTS, EFFECT_ADDENDUM_WHITE })) ||
            (i >= 35 && i <= 37 && PTrust->StatusEffectContainer->HasStatusEffect({ EFFECT_DARK_ARTS, EFFECT_ADDENDUM_BLACK })))
        {
            uint16 artsSkill = battleutils::GetMaxSkill(SKILL_ENHANCING_MAGIC, JOB_RDM, PTrust->GetMLevel()); // B+ skill
            uint16 skillCapD = battleutils::GetMaxSkill((SKILLTYPE)i, JOB_SCH, PTrust->GetMLevel());          // D skill cap
            uint16 skillCapE = battleutils::GetMaxSkill(SKILL_DARK_MAGIC, JOB_RDM, PTrust->GetMLevel());      // E skill cap
            auto currentSkill = MaxMSkill;
            uint16 artsBaseline = 0; // Level based baseline to which to raise skills
            uint8 mLevel = PTrust->GetMLevel();
            if (mLevel < 51)
            {
                artsBaseline = (uint16)(5 + 2.7 * (mLevel - 1));
            }
            else if ((mLevel > 50) && (mLevel < 61))
            {
                artsBaseline = (uint16)(137 + 4.7 * (mLevel - 50));
            }
            else if ((mLevel > 60) && (mLevel < 71))
            {
                artsBaseline = (uint16)(184 + 3.7 * (mLevel - 60));
            }
            else if ((mLevel > 70) && (mLevel < 75))
            {
                artsBaseline = (uint16)(221 + 5.0 * (mLevel - 70));
            }
            else if (mLevel >= 75)
            {
                artsBaseline = skillCapD + 36;
            }
            if (currentSkill < skillCapE)
            {
                // If the Trusts's skill is below the E cap
                // give enough bonus points to raise it to the arts baseline
                skillBonus += std::max(artsBaseline - currentSkill, 0);
            }
            else if (currentSkill < skillCapD)
            {
                // if the skill is at or above the E cap but below the D cap
                //  raise it up to the B+ skill cap minus the difference between the current skill rank and the scholar base skill cap (D)
                //  i.e. give a bonus of the difference between the B+ skill cap and the D skill cap
                skillBonus += std::max((artsSkill - skillCapD), 0);
            }
            else if (currentSkill < artsSkill)
            {
                // If the Trusts's skill is at or above the D cap but below the B+ cap
                // give enough bonus points to raise it to the B+ cap
                skillBonus += std::max(artsSkill - currentSkill, 0);
            }

            if (PTrust->StatusEffectContainer->HasStatusEffect({ EFFECT_LIGHT_ARTS, EFFECT_ADDENDUM_WHITE }))
            {
                skillBonus += PTrust->getMod(Mod::LIGHT_ARTS_SKILL);
            }
            else
            {
                skillBonus += PTrust->getMod(Mod::DARK_ARTS_SKILL);
            }

            if (MaxMSkill != 0)
            {
                PTrust->WorkingSkills.skill[i] = static_cast<uint16>(MaxMSkill + skillBonus * map_config.alter_ego_skill_multiplier);
            }
            else if (MaxSSkill != 0)
            {
                PTrust->WorkingSkills.skill[i] = static_cast<uint16>(MaxSSkill + skillBonus * map_config.alter_ego_skill_multiplier);
            }
            else
            {
                PTrust->WorkingSkills.skill[i] = std::max(static_cast<uint16>(0), static_cast<uint16>(skillBonus * map_config.alter_ego_skill_multiplier)) | 0x8000;
            }

            skillBonus += PTrust->getMod(static_cast<Mod>(i + 79));
        }
    }

    // Melee
    for (int i = SKILL_HAND_TO_HAND; i <= SKILL_STAFF; i++)
    {
        uint16 maxSkill = battleutils::GetMaxSkill((SKILLTYPE)i, mLvl > 99 ? 99 : mLvl);
        int32 skillBonus = 0;
        if (maxSkill != 0)
        {
            skillBonus += PTrust->getMod(static_cast<Mod>(i + 79));
            PTrust->WorkingSkills.skill[i] = static_cast<uint16>(maxSkill + skillBonus * map_config.alter_ego_skill_multiplier);
        }
    }

    // Ranged
    for (int i = SKILL_ARCHERY; i <= SKILL_THROWING; i++)
    {
        uint16 maxSkill = battleutils::GetMaxSkill((SKILLTYPE)i, mLvl > 99 ? 99 : mLvl);
        int32 skillBonus = 0;
        if (maxSkill != 0)
        {
            skillBonus += PTrust->getMod(static_cast<Mod>(i + 79));
            PTrust->WorkingSkills.skill[i] = static_cast<uint16>(maxSkill + skillBonus * map_config.alter_ego_skill_multiplier);
        }
    }
}

bool IsHighLevelWS(uint16 skill_id)
{
    switch (skill_id)
    {
        case WS_RAGING_FISTS:
        case WS_DANCING_EDGE:
        case WS_VORPAL_BLADE:
        case WS_SICKLE_MOON:
        case WS_RAMPAGE:
        case WS_RAGING_RUSH:
        case WS_GUILLOTINE:
        case WS_PENTA_THRUST:
        case WS_BLADE_JIN:
        case WS_TACHI_YUKIKAZE:
        case WS_SIDEWINDER:
        case WS_SLUG_SHOT:
        case 3285: // CHOREOGRAPHED_CARNAGE
        case 3469: // TWIRLING_DERVISH
            return true;
        default:
            break;
    }
    return false;
}

int GetEvasionRankForJob(uint8 job)
{
    switch (job)
    {
        case JOB_WAR:
            return 7;
        case JOB_MNK:
            return 3;
        case JOB_WHM:
            return 10;
        case JOB_BLM:
            return 10;
        case JOB_RDM:
            return 9;
        case JOB_THF:
            return 1;
        case JOB_PLD:
            return 7;
        case JOB_DRK:
            return 7;
        case JOB_BST:
            return 2;
        case JOB_BRD:
            return 9;
        case JOB_RNG:
            return 10;
        case JOB_SAM:
            return 3;
        case JOB_NIN:
            return 2;
        case JOB_DRG:
            return 4;
        case JOB_SMN:
            return 10;
        case JOB_BLU:
            return 8;
        case JOB_COR:
            return 9;
        case JOB_PUP:
            return 4;
        case JOB_DNC:
            return 3;
        case JOB_SCH:
            return 10;
        case JOB_GEO:
            return 9;
        case JOB_RUN:
            return 3;
        default:
            return 7; // Default to C rank if no Job. Shouldn't happen.
    }
}

}; // namespace trustutils

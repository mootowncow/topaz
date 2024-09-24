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
#include <array>

#include "lua/luautils.h"

#include "map.h"
#include "spell.h"
#include "blue_spell.h"
#include "status_effect_container.h"
#include "utils/blueutils.h"
#include "items/item_weapon.h"


CSpell::CSpell(SpellID id)
{
    m_ID = id;
}

  std::unique_ptr<CSpell> CSpell::clone()
  {
      //no make_unique because it requires the copy constructor to be public
      return std::unique_ptr<CSpell>(new CSpell(*this));
  }

void CSpell::setTotalTargets(uint16 total)
{
    m_totalTargets = total;
}

uint16 CSpell::getTotalTargets()
{
    return m_totalTargets;
}

void CSpell::setID(SpellID id)
{
    m_ID = id;
}

SpellID CSpell::getID()
{
    return m_ID;
}

void CSpell::setPrimaryTargetID(uint32 targid)
{
    m_primaryTargetID = targid;
}

uint32 CSpell::getPrimaryTargetID() const
{
    return m_primaryTargetID;
}

uint8 CSpell::getJob(JOBTYPE JobID)
{
    return (m_job[JobID] == CANNOT_USE_SPELL ? 255 : m_job[JobID]);
}

void CSpell::setJob(int8* jobs)
{
    memcpy(&m_job[1], jobs, 22);
}

uint32 CSpell::getCastTime()
{
    return m_castTime;
}

void CSpell::setCastTime(uint32 CastTime)
{
    m_castTime = CastTime;
}

uint32 CSpell::getRecastTime()
{
    return m_recastTime;
}

void CSpell::setRecastTime(uint32 RecastTime)
{
    m_recastTime = RecastTime;
}

const int8* CSpell::getName()
{
    return (const int8*)m_name.c_str();
}

void CSpell::setName(int8* name)
{
    m_name.clear();
    m_name.insert(0, (const char*)name);
}

SPELLGROUP CSpell::getSpellGroup()
{
    return m_spellGroup;
}

SPELLFAMILY CSpell::getSpellFamily()
{
    return m_spellFamily;
}

void CSpell::setSpellGroup(SPELLGROUP SpellGroup)
{
    m_spellGroup = SpellGroup;
}

void CSpell::setSpellFamily(SPELLFAMILY SpellFamily)
{
    m_spellFamily = SpellFamily;
}

uint8 CSpell::getSkillType()
{
    return m_skillType;
}

void CSpell::setSkillType(uint8 SkillType)
{
    m_skillType = SkillType;
}

bool CSpell::isBuff()
{
    return (getValidTarget() & TARGET_SELF) && !(getValidTarget() & TARGET_ENEMY);
}

bool CSpell::tookEffect()
{
    if(m_message == 75 || m_message == 284 || m_message == 283 || m_message == 85){
        return false;
    }
    return true;
}

bool CSpell::hasMPCost()
{
    return m_spellGroup != SPELLGROUP_SONG && m_spellGroup != SPELLGROUP_NINJUTSU && m_spellGroup != SPELLGROUP_TRUST;
}

bool CSpell::isHeal()
{
    return ((getValidTarget() & TARGET_SELF) && getSkillType() == SKILL_HEALING_MAGIC) || m_ID == SpellID::Pollen || m_ID == SpellID::Wild_Carrot || m_ID == SpellID::Healing_Breeze || m_ID == SpellID::Magic_Fruit;
}


bool CSpell::isCure()
{
    return ((static_cast<uint16>(m_ID) >= 1 && static_cast<uint16>(m_ID) <= 11) || m_ID == SpellID::Cura || m_ID == SpellID::Cura_II || m_ID == SpellID::Cura_III);
}

bool CSpell::isDebuff()
{
    return ((getValidTarget() & TARGET_ENEMY) && getSkillType() == SKILL_ENFEEBLING_MAGIC) ||
        m_spellFamily == SPELLFAMILY_ELE_DOT || m_spellFamily == SPELLFAMILY_BIO || m_ID == SpellID::Stun || m_ID == SpellID::Curse;
}

bool CSpell::isNonDamaging()
{
    return ((getValidTarget() & TARGET_ENEMY) && getSkillType() == SKILL_ENFEEBLING_MAGIC) || m_spellFamily == SPELLFAMILY_ELE_DOT ||
           m_spellFamily == SPELLFAMILY_ABSORB || m_spellFamily == SPELLFAMILY_JUBAKU || m_spellFamily == SPELLFAMILY_HOJO ||
           m_spellFamily == SPELLFAMILY_KURAYAMI || m_spellFamily == SPELLFAMILY_DOKUMORI || m_spellFamily == SPELLFAMILY_ASPIR ||
           m_ID == SpellID::Stun || m_ID == SpellID::Curse || m_ID == SpellID::Flash;
}

bool CSpell::isNa()
{
    return (static_cast<uint16>(m_ID) >= 14 && static_cast<uint16>(m_ID) <= 20) || m_ID == SpellID::Erase;
}

bool CSpell::isSevere()
{
    return m_ID == SpellID::Death || m_ID == SpellID::Impact || m_ID == SpellID::Meteor || m_ID == SpellID::Meteor_II || m_ID == SpellID::Comet;
}

bool CSpell::canHitShadow()
{
    return m_ID != SpellID::Meteor_II && canTargetEnemy();
}

bool CSpell::dealsDamage()
{
    //damage or drain hp
    return m_message == 2 || m_message == 227 || m_message == 252 || m_message == 265 || m_message == 274;
}

float CSpell::getRadius()
{
    return m_radius;
}

uint16 CSpell::getZoneMisc()
{
    return m_zoneMisc;
}

void CSpell::setZoneMisc(uint16 Misc)
{
    m_zoneMisc = Misc;
}

uint16 CSpell::getAnimationID()
{
    return m_animation;
}

void CSpell::setAnimationID(uint16 AnimationID)
{
    m_animation = AnimationID;
}

uint16 CSpell::getAnimationTime()
{
    return m_animationTime;
}

void CSpell::setAnimationTime(uint16 AnimationTime)
{
    m_animationTime = AnimationTime;
}

uint16 CSpell::getMPCost()
{
    return m_mpCost;
}

void CSpell::setMPCost(uint16 MP)
{
    m_mpCost = MP;
}

bool CSpell::canTargetEnemy()
{
    return (getValidTarget() & TARGET_ENEMY) && !(getValidTarget() & TARGET_SELF);
}

uint8 CSpell::getAOE()
{
    return m_AOE;
}

void CSpell::setAOE(uint8 AOE)
{
    m_AOE = AOE;
}

uint16 CSpell::getBase()
{
    return m_base;
}

void CSpell::setBase(uint16 base)
{
    m_base = base;
}

uint8 CSpell::getValidTarget()
{
    return m_ValidTarget;
}

void CSpell::setValidTarget(uint8 ValidTarget)
{
    m_ValidTarget = ValidTarget;
}

float CSpell::getMultiplier()
{
    return m_multiplier;
}

void CSpell::setMultiplier(float multiplier)
{
    m_multiplier = multiplier;
}

uint16 CSpell::getMessage()
{
    return m_message;
}

uint16 CSpell::getAoEMessage()
{
    switch(m_message){
        case MSGBASIC_MAGIC_TELEPORT:
            return MSGBASIC_TARGET_VANISHES;
        case MSGBASIC_MAGIC_RESIST:
            return MSGBASIC_MAGIC_RESIST;
        case MSGBASIC_MAGIC_GAIN_EFFECT:
            return MSGBASIC_MAGIC_AOE_GAIN_EFFECT;
        case MSGBASIC_MAGIC_ENFEEB_IS: 
            // return 203;
            return MSGBASIC_IS_EFFECT;
            // 279
        case MSGBASIC_MAGIC_ENFEEB:
            return MSGBASIC_MAGIC_ENFEEB_2;
        case MSGBASIC_MAGIC_DMG:
            return MSGBASIC_DAMAGE_SECONDARY;
        default:
            return m_message;
    }
}

void CSpell::setMessage(uint16 message)
{
    m_message = message;
}

uint16 CSpell::getMagicBurstMessage()
{
    return m_MagicBurstMessage;
}

void CSpell::setMagicBurstMessage(uint16 message)
{
    m_MagicBurstMessage = message;
}

uint16 CSpell::getElement()
{
    return m_element;
}

void CSpell::setElement(uint16 element)
{
    m_element = element;
}

void CSpell::setCE(uint16 ce)
{
    m_CE = ce;
}

uint16 CSpell::getCE()
{
    return m_CE;
}

void CSpell::setRadius(float radius)
{
    m_radius = radius;
}

void CSpell::setVE(uint16 ve)
{
    m_VE = ve;
}

uint16 CSpell::getVE()
{
    return m_VE;
}

void CSpell::setModifiedRecast(uint32 mrec)
{
    m_modifiedRecastTime = mrec;
}

uint32 CSpell::getModifiedRecast()
{
    return m_modifiedRecastTime;
}

uint8 CSpell::getRequirements()
{
    return m_requirements;
}

void CSpell::setRequirements(uint8 requirements)
{
    m_requirements = requirements;
}

uint16 CSpell::getMeritId()
{
    return m_meritId;
}

void CSpell::setMeritId(uint16 meritId)
{
    m_meritId = meritId;
}

uint8 CSpell::getFlag()
{
    return m_flag;
}

void CSpell::setFlag(uint8 flag)
{
    m_flag = flag;
}

int8* CSpell::getContentTag()
{
    return m_contentTag;
}

float CSpell::getRange()
{
    return m_range;
}

void CSpell::setContentTag(int8* contentTag)
{
    m_contentTag = contentTag;
}

void CSpell::setRange(float range)
{
    m_range = range;
}

EFFECT CSpell::getEffectForSpell(SpellID SpellId)
{
    CSpell* spell = spell::GetSpell(SpellId);

    // Search by spell
    switch (SpellId)
    {
        case SpellID::Blink:
            return EFFECT_BLINK;
        case SpellID::Stoneskin:
            return EFFECT_STONESKIN;
        case SpellID::Aquaveil:
            return EFFECT_AQUAVEIL;
        default:
            break;
    }
    // Search by spell family
    switch (spell->getSpellFamily())
    {
        case SPELLFAMILY_PROTECT:
            return EFFECT_PROTECT;
        case SPELLFAMILY_SHELL:
            return EFFECT_SHELL;
        case SPELLFAMILY_HASTE:
            return EFFECT_HASTE;
        case SPELLFAMILY_REFRESH:
            return EFFECT_REFRESH;
        case SPELLFAMILY_REGEN:
            return EFFECT_REGEN;
        case SPELLFAMILY_PHALANX:
            return EFFECT_PHALANX;
        case SPELLFAMILY_SPIKES:
        {
            switch (m_ID)
            {
                case SpellID::Blaze_Spikes:
                    return EFFECT_BLAZE_SPIKES;
                case SpellID::Ice_Spikes:
                    return EFFECT_ICE_SPIKES;
                case SpellID::Shock_Spikes:
                    return EFFECT_SHOCK_SPIKES;
                case SpellID::Dread_Spikes:
                    return EFFECT_DREAD_SPIKES;
                default:
                    return EFFECT_NONE;
            }
        }
        case SPELLFAMILY_ENFIRE:
            return EFFECT_ENFIRE;
        case SPELLFAMILY_ENBLIZZARD:
            return EFFECT_ENBLIZZARD;
        case SPELLFAMILY_ENAERO:
            return EFFECT_ENAERO;
        case SPELLFAMILY_ENSTONE:
            return EFFECT_ENSTONE;
        case SPELLFAMILY_ENTHUNDER:
            return EFFECT_ENTHUNDER;
        case SPELLFAMILY_ENWATER:
            return EFFECT_ENWATER;
        case SPELLFAMILY_RERAISE:
            return EFFECT_RERAISE;
        case SPELLFAMILY_FIRE_THRENODY:
            return EFFECT_THRENODY;
        case SPELLFAMILY_ICE_THRENODY:
            return EFFECT_THRENODY;
        case SPELLFAMILY_WIND_THRENODY:
            return EFFECT_THRENODY;
        case SPELLFAMILY_EARTH_THRENODY:
            return EFFECT_THRENODY;
        case SPELLFAMILY_LIGHT_THRENODY:
            return EFFECT_THRENODY;
        case SPELLFAMILY_DARK_THRENODY:
            return EFFECT_THRENODY;
        case SPELLFAMILY_LIGHTNING_THRENODY:
            return EFFECT_THRENODY;
        case SPELLFAMILY_WATER_THRENODY:
            return EFFECT_THRENODY;
        case SPELLFAMILY_GAIN:
        {
            switch (m_ID)
            {
                case SpellID::Gain_STR:
                    return EFFECT_STR_BOOST;
                case SpellID::Gain_DEX:
                    return EFFECT_DEX_BOOST;
                case SpellID::Gain_VIT:
                    return EFFECT_VIT_BOOST;
                case SpellID::Gain_AGI:
                    return EFFECT_AGI_BOOST;
                case SpellID::Gain_INT:
                    return EFFECT_INT_BOOST;
                case SpellID::Gain_MND:
                    return EFFECT_MND_BOOST;
                case SpellID::Gain_CHR:
                    return EFFECT_CHR_BOOST;
                default:
                    return EFFECT_NONE;
            }
        }
        case SPELLFAMILY_TEMPER:
            return EFFECT_MULTI_STRIKES;
        case SPELLFAMILY_FLURRY:
            return EFFECT_FLURRY;
        case SPELLFAMILY_BOOST:
            return EFFECT_BOOST;
        case SPELLFAMILY_ENLIGHT:
            return EFFECT_ENLIGHT;
        case SPELLFAMILY_ENDARK:
            return EFFECT_ENDARK;
        case SPELLFAMILY_SLOW:
            return EFFECT_SLOW;
        case SPELLFAMILY_PARALYZE:
            return EFFECT_PARALYSIS;
        case SPELLFAMILY_STATUS_BAR:
        {
            switch (m_ID)
            {
                case SpellID::Barsleep:
                    return EFFECT_BARSLEEP;
                case SpellID::Barpoison:
                    return EFFECT_BARPOISON;
                case SpellID::Barparalyze:
                    return EFFECT_BARPARALYZE;
                case SpellID::Barblind:
                    return EFFECT_BARBLIND;
                case SpellID::Barsilence:
                    return EFFECT_BARSILENCE;
                case SpellID::Barpetrify:
                    return EFFECT_BARPETRIFY;
                case SpellID::Barvirus:
                    return EFFECT_BARVIRUS;
                case SpellID::Baramnesia:
                    return EFFECT_BARAMNESIA;
                default:
                    return EFFECT_NONE;
            }
        }
        case SPELLFAMILY_STATUS_BAR_RA:
        {
            switch (m_ID)
            {
                case SpellID::Barsleepra:
                    return EFFECT_BARSLEEP;
                case SpellID::Barpoisonra:
                    return EFFECT_BARPOISON;
                case SpellID::Barparalyzra:
                    return EFFECT_BARPARALYZE;
                case SpellID::Barblindra:
                    return EFFECT_BARBLIND;
                case SpellID::Barsilencera:
                    return EFFECT_BARSILENCE;
                case SpellID::Barpetra:
                    return EFFECT_BARPETRIFY;
                case SpellID::Barvira:
                    return EFFECT_BARVIRUS;
                case SpellID::Baramnesra:
                    return EFFECT_BARAMNESIA;
                default:
                    return EFFECT_NONE;
            }
        }
        case SPELLFAMILY_ELE_BAR:
        {
            switch (m_ID)
            {
                case SpellID::Barfire:
                    return EFFECT_BARFIRE;
                case SpellID::Barblizzard:
                    return EFFECT_BARBLIZZARD;
                case SpellID::Baraero:
                    return EFFECT_BARAERO;
                case SpellID::Barstone:
                    return EFFECT_BARSTONE;
                case SpellID::Barthunder:
                    return EFFECT_BARTHUNDER;
                case SpellID::Barwater:
                    return EFFECT_BARWATER;
                default:
                    return EFFECT_NONE;
            }
        }
        case SPELLFAMILY_ELE_BAR_RA:
        {
            switch (m_ID)
            {
                case SpellID::Barfira:
                    return EFFECT_BARFIRE;
                case SpellID::Barblizzara:
                    return EFFECT_BARBLIZZARD;
                case SpellID::Baraera:
                    return EFFECT_BARAERO;
                case SpellID::Barstonra:
                    return EFFECT_BARSTONE;
                case SpellID::Barthundra:
                    return EFFECT_BARTHUNDER;
                case SpellID::Barwatera:
                    return EFFECT_BARWATER;
                default:
                    return EFFECT_NONE;
            }
        }
            // Add other spell families and their corresponding effects here

        default:
            return EFFECT_NONE; // Default for unhandled spell families
    }
}

//Implement namespace to work with spells
namespace spell
{
    std::array<CSpell*, MAX_SPELL_ID> PSpellList; // spell list
    std::map<uint16, uint16> PMobSkillToBlueSpell; // maps the skill id (key) to spell id (value).

    //Load a list of spells
    void LoadSpellList()
    {
        const char* Query = "SELECT spellid, name, jobs, `group`, family, validTargets, skill, castTime, recastTime, animation, animationTime, mpCost, \
                             AOE, base, element, zonemisc, multiplier, message, magicBurstMessage, CE, VE, requirements, content_tag, spell_range \
                             FROM spell_list;";

        int32 ret = Sql_Query(SqlHandle, Query);

        if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while(Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                char* contentTag;
                CSpell* PSpell = nullptr;
                SpellID id = (SpellID)Sql_GetUIntData(SqlHandle,0);

                if ((SPELLGROUP)Sql_GetIntData(SqlHandle, 3) == SPELLGROUP_BLUE)
                {
                    PSpell = new CBlueSpell(id);
                }
                else
                {
                    PSpell = new CSpell(id);
                }

                PSpell->setName(Sql_GetData(SqlHandle,1));
                PSpell->setJob(Sql_GetData(SqlHandle,2));
                PSpell->setSpellGroup((SPELLGROUP)Sql_GetIntData(SqlHandle,3));
                PSpell->setSpellFamily((SPELLFAMILY)Sql_GetIntData(SqlHandle, 4));
                PSpell->setValidTarget(Sql_GetIntData(SqlHandle,5));
                PSpell->setSkillType(Sql_GetIntData(SqlHandle,6));
                PSpell->setCastTime(Sql_GetIntData(SqlHandle,7));
                PSpell->setRecastTime(Sql_GetIntData(SqlHandle,8));
                PSpell->setAnimationID(Sql_GetIntData(SqlHandle,9));
                PSpell->setAnimationTime(Sql_GetIntData(SqlHandle,10));
                PSpell->setMPCost(Sql_GetIntData(SqlHandle,11));
                PSpell->setAOE(Sql_GetIntData(SqlHandle,12));
                PSpell->setBase(Sql_GetIntData(SqlHandle,13));
                PSpell->setElement(Sql_GetIntData(SqlHandle,14));
                PSpell->setZoneMisc(Sql_GetIntData(SqlHandle,15));
                PSpell->setMultiplier((float)Sql_GetIntData(SqlHandle,16));
                PSpell->setMessage(Sql_GetIntData(SqlHandle,17));
                PSpell->setMagicBurstMessage(Sql_GetIntData(SqlHandle,18));
                PSpell->setCE(Sql_GetIntData(SqlHandle,19));
                PSpell->setVE(Sql_GetIntData(SqlHandle,20));
                PSpell->setRequirements(Sql_GetIntData(SqlHandle,21));

                Sql_GetData(SqlHandle, 22, &contentTag, nullptr);
                PSpell->setContentTag((int8*)contentTag);

                PSpell->setRange(static_cast<float>(Sql_GetIntData(SqlHandle, 23)) / 10);

                if(PSpell->getAOE())
                {
                    // default radius
                    PSpell->setRadius(10);
                }

                PSpellList[static_cast<uint16>(PSpell->getID())] = PSpell;
            }
        }

        const char* blueQuery = "SELECT blue_spell_list.spellid, blue_spell_list.mob_skill_id, blue_spell_list.set_points, \
                                blue_spell_list.trait_category, blue_spell_list.trait_category_weight, blue_spell_list.primary_sc, \
                                blue_spell_list.secondary_sc, spell_list.content_tag \
                             FROM blue_spell_list JOIN spell_list on blue_spell_list.spellid = spell_list.spellid;";

        ret = Sql_Query(SqlHandle, blueQuery);

        if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while(Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                char* contentTag;
                Sql_GetData(SqlHandle, 7, &contentTag, nullptr);

                if (luautils::IsContentEnabled(contentTag) == false){
                    continue;
                }

                // Sanity check the spell ID
                uint16 spellId = Sql_GetIntData(SqlHandle,0);

                if(PSpellList[spellId] == nullptr)
                {
                    ShowWarning("spell::LoadSpellList Tried to load nullptr blue spell (%u)\n", spellId);
                    continue;
                }

                ((CBlueSpell*)PSpellList[spellId])->setMonsterSkillId(Sql_GetIntData(SqlHandle,1));
                ((CBlueSpell*)PSpellList[spellId])->setSetPoints(Sql_GetIntData(SqlHandle,2));
                ((CBlueSpell*)PSpellList[spellId])->setTraitCategory(Sql_GetIntData(SqlHandle,3));
                ((CBlueSpell*)PSpellList[spellId])->setTraitWeight(Sql_GetIntData(SqlHandle,4));
                ((CBlueSpell*)PSpellList[spellId])->setPrimarySkillchain(Sql_GetIntData(SqlHandle,5));
                ((CBlueSpell*)PSpellList[spellId])->setSecondarySkillchain(Sql_GetIntData(SqlHandle,6));
                PMobSkillToBlueSpell.insert(std::make_pair(Sql_GetIntData(SqlHandle,1), spellId));
            }
        }
        ret = Sql_Query(SqlHandle,"SELECT spellId, modId, value FROM blue_spell_mods WHERE spellId IN (SELECT spellId FROM spell_list LEFT JOIN blue_spell_list USING (spellId))");

        if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while(Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                uint16 spellId = (uint16)Sql_GetUIntData(SqlHandle,0);
                Mod modID  = static_cast<Mod>(Sql_GetUIntData(SqlHandle,1));
                int16  value  = (int16) Sql_GetIntData (SqlHandle,2);

                if (PSpellList[spellId])
                {
                    ((CBlueSpell*)PSpellList[spellId])->addModifier(CModifier(modID,value));
                }
            }
        }

        ret = Sql_Query(SqlHandle,"SELECT spellId, meritId, content_tag FROM spell_list INNER JOIN merits ON spell_list.name = merits.name;");

        if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while(Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                char* contentTag;
                Sql_GetData(SqlHandle, 2, &contentTag, nullptr);

                if (luautils::IsContentEnabled(contentTag) == false){
                    continue;
                }

                uint16 spellId = (uint16)Sql_GetUIntData(SqlHandle,0);

                if (PSpellList[spellId])
                {
                    PSpellList[spellId]->setMeritId(Sql_GetUIntData(SqlHandle,1));
                }
            }
        }
    }

    CSpell* GetSpellByMonsterSkillId(uint16 SkillID) {
        std::map<uint16,uint16>::iterator it = PMobSkillToBlueSpell.find(SkillID);
        if (it == PMobSkillToBlueSpell.end()) {
            return nullptr;
        }
        else {
            uint16 spellId = it->second;
            return PSpellList[spellId];
        }
    }

    //Get Spell By ID
    CSpell* GetSpell(SpellID SpellID)
    {
        TPZ_DEBUG_BREAK_IF(static_cast<uint16>(SpellID) >= MAX_SPELL_ID);

        auto id = static_cast<uint16>(SpellID);
        if (id >= MAX_SPELL_ID)
        {
            return nullptr;
        }
        return PSpellList[id];
    }

    bool CanUseSpell(CBattleEntity* PCaster, SpellID SpellID)
    {
        CSpell* spell = GetSpell(SpellID);
        return CanUseSpell(PCaster, spell);
    }

    //Check If user can cast spell
    bool CanUseSpell(CBattleEntity* PCaster, CSpell* spell)
    {
        bool usable = false;

        if (spell != nullptr)
        {
            uint8 JobMLVL = spell->getJob(PCaster->GetMJob());
            uint8 JobSLVL = spell->getJob(PCaster->GetSJob());
            uint8 requirements = spell->getRequirements();

            if (PCaster->objtype == TYPE_MOB || (PCaster->objtype == TYPE_PET && static_cast<CPetEntity*>(PCaster)->getPetType() == PETTYPE_AUTOMATON) || PCaster->objtype == TYPE_TRUST)
            {
                // cant cast cause im hidden or untargetable
                if (PCaster->IsNameHidden() || static_cast<CMobEntity*>(PCaster)->IsUntargetable())
                {
                    return false;
                }

                // ensure trust level is appropriate+
                if (PCaster->objtype == TYPE_TRUST && PCaster->GetMLevel() < JobMLVL && PCaster->GetSLevel() < JobSLVL)
                {
                    //printf("Trust %s cannot cast spell %d due to level requirement!\n",PCaster->name, spell->getID());
                    return false;
                }

                // Mobs can cast any non-given char spell
                return true;
            }

            if (PCaster->objtype == TYPE_PC && spell->getSpellGroup() == SPELLGROUP_TRUST)
            {
                return true; // every PC can use trusts
            }

            if(PCaster->GetMLevel() >= JobMLVL)
            {
                usable = true;
                if (requirements & SPELLREQ_TABULA_RASA)
                {
                    if (!PCaster->StatusEffectContainer->HasStatusEffect(EFFECT_TABULA_RASA))
                    {
                        usable = false;
                    }
                }
                if (requirements & SPELLREQ_ADDENDUM_BLACK && PCaster->GetMJob() == JOB_SCH)
                {
                    if (!PCaster->StatusEffectContainer->HasStatusEffect({EFFECT_ADDENDUM_BLACK, EFFECT_ENLIGHTENMENT}))
                    {
                        usable = false;
                    }
                }
                else if (requirements & SPELLREQ_ADDENDUM_WHITE && PCaster->GetMJob() == JOB_SCH)
                {
                    if (!PCaster->StatusEffectContainer->HasStatusEffect({EFFECT_ADDENDUM_WHITE, EFFECT_ENLIGHTENMENT}))
                    {
                        usable = false;
                    }
                }
                else if (spell->getSpellGroup() == SPELLGROUP_BLUE)
                {
                    // return early
                    auto blueSpellsLastChanged = PCaster->GetLocalVar("BlueSpellsLastChanged");
                    auto timeSinceLastChanged = time(nullptr) - blueSpellsLastChanged;
                    if (timeSinceLastChanged < 60)
                    {
                        return false;
                    }

                    if (PCaster->objtype == TYPE_PC)
                    {
                        if (requirements & SPELLREQ_UNBRIDLED_LEARNING)
                        {
                            if (!PCaster->StatusEffectContainer->HasStatusEffect({EFFECT_UNBRIDLED_LEARNING, EFFECT_UNBRIDLED_WISDOM}))
                            {
                                usable = false;
                            }
                        }
                        else if (!blueutils::IsSpellSet((CCharEntity*)PCaster, (CBlueSpell*)spell))
                        {
                            usable = false;
                        }
                    }
                }
                if (usable) { return true; }
            }
            if(PCaster->GetSLevel() >= JobSLVL)
            {
                usable = true;
                if (requirements & SPELLREQ_TABULA_RASA)
                {
                    if (!PCaster->StatusEffectContainer->HasStatusEffect(EFFECT_TABULA_RASA))
                    {
                        usable = false;
                    }
                }
                if (requirements & SPELLREQ_ADDENDUM_BLACK && PCaster->GetSJob() == JOB_SCH)
                {
                    if (!PCaster->StatusEffectContainer->HasStatusEffect({EFFECT_ADDENDUM_BLACK, EFFECT_ENLIGHTENMENT}))
                    {
                        usable = false;
                    }
                }
                else if (requirements & SPELLREQ_ADDENDUM_WHITE && PCaster->GetSJob() == JOB_SCH)
                {
                    if (!PCaster->StatusEffectContainer->HasStatusEffect({EFFECT_ADDENDUM_WHITE, EFFECT_ENLIGHTENMENT}))
                    {
                        usable = false;
                    }
                }
                else if (spell->getSpellGroup() == SPELLGROUP_BLUE)
                {
                    if (PCaster->objtype == TYPE_PC)
                    {
                        if (requirements & SPELLREQ_UNBRIDLED_LEARNING)
                        {
                            if (!PCaster->StatusEffectContainer->HasStatusEffect({EFFECT_UNBRIDLED_LEARNING, EFFECT_UNBRIDLED_WISDOM}))
                            {
                                usable = false;
                            }
                        }
                        else if (!blueutils::IsSpellSet((CCharEntity*)PCaster, (CBlueSpell*)spell))
                        {
                            usable = false;
                        }
                    }
                }
            }
        }
        return usable;
    }

    // This is a utility method for mobutils, when we want to work out if we can give monsters a spell
    // but they are on an odd job (e.g. PLDs getting -ga3)
    bool CanUseSpellWith(SpellID spellId, JOBTYPE job, uint8 level)
    {
        if (GetSpell(spellId) != nullptr)
        {
            uint8 jobMLevel = PSpellList[static_cast<size_t>(spellId)]->getJob(job);

            return level > jobMLevel;
        }
        return false;
    }

    float GetSpellRadius(CSpell* spell, CBattleEntity* entity)
    {
        float total = spell->getRadius(); // Default 10 for most spells

        // -Ga Enfeebles are 15 yalms
        if (spell->getID() >= SpellID::Paralyga && spell->getID() <= SpellID::Graviga)
        {
            total = 15.0f;
        }

        // Horde Lullaby AOE is small
        if (spell->getID() == SpellID::Horde_Lullaby || spell->getID() == SpellID::Horde_Lullaby_II)
        {
            total = 9.0f;
        }

        // brd gets bonus radius from string skill
        if(spell->getSpellGroup() == SPELLGROUP_SONG && (spell->getValidTarget() & TARGET_SELF)){
            if(entity->objtype == TYPE_MOB || (entity->GetMJob() == JOB_BRD &&
                entity->objtype == TYPE_PC && ((CCharEntity*)entity)->getEquip(SLOT_RANGED) &&
                ((CItemWeapon*)((CCharEntity*)entity)->getEquip(SLOT_RANGED))->getSkillType() == SKILL_STRING_INSTRUMENT))
            {
                total += ((float)entity->GetSkill(SKILL_STRING_INSTRUMENT) / 276) * 10;
            }

            if (total > 20.0f)
            {
                total = 20.0f;
            }
        }

        return total;
    }
};

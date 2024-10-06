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

#include "mob_spell_container.h"
#include "../map/ai/ai_container.h"
#include "utils/battleutils.h"
#include "status_effect_container.h"
#include "recast_container.h"
#include "mob_modifier.h"

CMobSpellContainer::CMobSpellContainer(CMobEntity* PMob)
{
    m_PMob = PMob;
    m_hasSpells = false;
}

void CMobSpellContainer::ClearSpells()
{
    m_gaList.clear();
    m_damageList.clear();
    m_buffList.clear();
    m_debuffList.clear();
    m_healList.clear();
    m_naList.clear();
    m_hasSpells = false;
}

void CMobSpellContainer::AddSpell(SpellID spellId)
{
    // get spell
    CSpell* spell = spell::GetSpell(spellId);

    if(spell == nullptr){
        ShowDebug("Missing spellID = %d, given to mob. Check spell_list.sql\n", static_cast<uint16>(spellId));
        return;
    }

    m_hasSpells = true;

    // add spell to correct vector
    // try to add it to ga list first
    uint8 aoe = battleutils::GetSpellAoEType(m_PMob, spell);
    if(aoe > 0 && spell->canTargetEnemy())
    {
        m_gaList.push_back(spellId);
    }
    else if (spell->isSevere())
    {
        // select spells like death and impact
        m_severeList.push_back(spellId);
    }
    else if (spell->canTargetEnemy() && !spell->isSevere())
    {
        // add to damage list
        m_damageList.push_back(spellId);
    }
    else if (spell->isDebuff())
    {
        m_debuffList.push_back(spellId);
    }
    else if(spell->isNa())
    {
        // na spell and erase
        m_naList.push_back(spellId);
    }
    else if(spell->isHeal()){ // includes blue mage healing spells, wild carrot etc
   // add to healing
        m_healList.push_back(spellId);

    }
    else if(spell->isBuff()){
        // buff
        m_buffList.push_back(spellId);

    }
    else {
        ShowDebug("Where does this spell go? %d\n", static_cast<uint16>(spellId));
    }
}

void CMobSpellContainer::RemoveSpell(SpellID spellId)
{
    auto findAndRemove = [](std::vector<SpellID>& list, SpellID id)
    {
        list.erase(std::remove(list.begin(), list.end(), id), list.end());
    };

    findAndRemove(m_gaList, spellId);
    findAndRemove(m_damageList, spellId);
    findAndRemove(m_buffList, spellId);
    findAndRemove(m_debuffList, spellId);
    findAndRemove(m_healList, spellId);
    findAndRemove(m_naList, spellId);

    m_hasSpells = !(m_gaList.empty() && m_damageList.empty() && m_buffList.empty() && m_debuffList.empty() && m_healList.empty() && m_naList.empty());
}

std::optional<SpellID> CMobSpellContainer::GetAvailable(SpellID spellId)
{
    auto spell = spell::GetSpell(spellId);
    auto skillType = spell->getSkillType();
    bool hasEnoughMP = spell->getMPCost() <= m_PMob->health.mp || skillType == SKILL_NINJUTSU;
    bool isNotInRecast = !m_PMob->PRecastContainer->Has(RECAST_MAGIC, static_cast<uint16>(spellId));

    return  (isNotInRecast && hasEnoughMP) ? std::optional<SpellID>(spellId) : std::nullopt;
}

std::optional<SpellID> CMobSpellContainer::GetBestAvailable(SPELLFAMILY family)
{
    std::vector<SpellID> matches;
    auto searchInList = [&](std::vector<SpellID>& list)
    {
        for (auto id : list)
        {
            auto spell = spell::GetSpell(id);
            bool sameFamily = (family == SPELLFAMILY_NONE) ? true : spell->getSpellFamily() == family;
            auto skillType = spell->getSkillType();
            bool hasEnoughMP = spell->getMPCost() <= m_PMob->health.mp || skillType == SKILL_NINJUTSU;
            bool isNotInRecast = !m_PMob->PRecastContainer->Has(RECAST_MAGIC, static_cast<uint16>(id));

            // Exclude helix spells
            bool isNotHelix = !(id >= SpellID::Geohelix && id <= SpellID::Luminohelix) && !(id >= SpellID::Geohelix_II && id <= SpellID::Luminohelix_II);

            if (sameFamily && hasEnoughMP && isNotInRecast && isNotHelix)
            {
                matches.push_back(id);
            }
        }
    };

    if (family == SPELLFAMILY_NONE)
    {
        searchInList(m_damageList);
    }
    else
    {
        searchInList(m_gaList);
        searchInList(m_damageList);
        searchInList(m_buffList);
        searchInList(m_debuffList);
        searchInList(m_healList);
        searchInList(m_naList);
    }

    return (!matches.empty()) ? std::optional<SpellID>{ matches.back() } : std::nullopt;
}

std::optional<SpellID> CMobSpellContainer::GetBestIndiSpell(CBattleEntity* PTarget)
{
    auto mJob = PTarget->GetMJob();

    auto mTarget = PTarget->GetBattleTarget();
    auto hitrate = battleutils::GetHitRate(PTarget, mTarget);
    bool accBuffNeeded = hitrate < 65 ? true : false;

    auto mInt = PTarget->getMod(Mod::INT);
    auto tInt = mTarget->getMod(Mod::INT);
    auto intDiff = mInt - tInt + 10;
    auto macc = PTarget->getMod(Mod::MACC);
    auto tMaeva = mTarget->getMod(Mod::MEVA);
    auto mSkill = PTarget->GetSkill(SKILL_ELEMENTAL_MAGIC);
    auto maccFromInt = mInt;


    if (mInt > tInt + 10)
    {
        maccFromInt = tInt + ((mInt - intDiff) * 0.5);
    }

    auto totalMacc = mSkill + maccFromInt + macc;
    auto magicHitRate = float(totalMacc - tMaeva) / 10;
    bool mAccBuffNeeded = magicHitRate < 10 ? true : false;

    std::optional<SpellID> choice = std::nullopt;
    std::optional<SpellID> subChoice = SpellID::Indi_Regen;

    switch (mJob)
    {
        case JOB_WAR:
        case JOB_MNK:
        case JOB_THF:
        case JOB_DRK:
        case JOB_BST:
        case JOB_RNG:
        case JOB_SAM:
        case JOB_DRG:
        case JOB_BLU:
        case JOB_COR:
        case JOB_PUP:
        case JOB_DNC:
        {
            if (accBuffNeeded)
            {
                choice = SpellID::Indi_Precision;
            }
            else
            {
                choice = SpellID::Indi_Fury;
            }
            subChoice = SpellID::Indi_Regen;
            break;
        }
        case JOB_WHM:
        case JOB_BRD:
        case JOB_SMN:
        case JOB_GEO:
        {
            choice = SpellID::Indi_Refresh;
            subChoice = SpellID::Indi_Refresh;
            break;
        }
        case JOB_BLM:
        case JOB_RDM:
        case JOB_SCH:
        {
            if (mAccBuffNeeded)
            {
                choice = SpellID::Indi_Focus;
            }
            else
            {
                choice = SpellID::Indi_Acumen;
            }
            subChoice = SpellID::Indi_Refresh;
            break;
        }
        case JOB_PLD:
        case JOB_RUN:
        case JOB_NIN:
        {
            choice = SpellID::Indi_Haste;
            subChoice = SpellID::Indi_Regen;
            break;
        }
        default:
            break;
    }


    if (choice == SpellID::Indi_Haste && PTarget->GetMLevel() < 93)
    {
        choice = SpellID::Indi_Fury;
    }

    if (choice == SpellID::Indi_Acumen && PTarget->GetMLevel() < 46)
    {
        choice = SpellID::Indi_Refresh;
    }

    if (choice == SpellID::Indi_Fury && PTarget->GetMLevel() < 34)
    {
        choice = SpellID::Indi_Precision;
    }

    if (choice == SpellID::Indi_Refresh && PTarget->GetMLevel() < 30)
    {
        choice = SpellID::Indi_Regen;
    }

    if (choice == SpellID::Indi_Focus && PTarget->GetMLevel() < 22)
    {
        choice = SpellID::Indi_Regen;
    }

    if (PTarget->GetMLevel() < 10)
    {
        choice = SpellID::Indi_Regen;
    }


    return choice;
}

std::optional<SpellID> CMobSpellContainer::GetBestEntrustedSpell(CBattleEntity* PTarget)
{
    auto mastersJob = PTarget->GetMJob();
    std::optional<SpellID> choice = std::nullopt;

    switch (mastersJob)
    {
        case JOB_WAR:
        case JOB_MNK:
        case JOB_THF:
        case JOB_DRK:
        case JOB_BST:
        case JOB_RNG:
        case JOB_SAM:
        case JOB_DRG:
        case JOB_BLU:
        case JOB_COR:
        case JOB_PUP:
        case JOB_DNC:
            choice = SpellID::Indi_Barrier;
            // choice = SpellID::Indi_Frailty; Requiers level 76
            break;
        case JOB_WHM:
        case JOB_BRD:
        case JOB_SMN:
            choice = SpellID::Indi_Acumen;
            break;
        case JOB_BLM:
        case JOB_RDM:
        case JOB_SCH:
        case JOB_PLD:
        case JOB_RUN:
            choice = SpellID::Indi_Refresh;
            break;
        case JOB_NIN:
            choice = SpellID::Indi_Regen;
            break;
        case JOB_GEO:
            break;
        default:
            break;
    }

    return choice;
}

std::optional<SpellID> CMobSpellContainer::GetBestAgainstTargetWeakness(CBattleEntity* PMob, CBattleEntity* PTarget)
{
    // Look up what the target has the _least resistance to_:
    // clang-format off
    std::vector<int16> resistances
    {
        PTarget->getMod(Mod::SDT_FIRE),
        PTarget->getMod(Mod::SDT_ICE),
        PTarget->getMod(Mod::SDT_WIND),
        PTarget->getMod(Mod::SDT_EARTH),
        PTarget->getMod(Mod::SDT_THUNDER),
        PTarget->getMod(Mod::SDT_WATER),
        PTarget->getMod(Mod::SDT_LIGHT),
        PTarget->getMod(Mod::SDT_DARK),
    };
    // clang-format on

    // Check if all resistances are equal
    bool allEqual = std::all_of(resistances.begin(), resistances.end(), [&](int16 value) { return value == resistances[0]; });

    std::size_t strongestIndex  = std::distance(resistances.begin(), std::max_element(resistances.begin(), resistances.end()));

    // TODO: Figure this out properly:
    std::optional<SpellID> choice = std::nullopt;
    std::size_t dotwIndex = battleutils::GetDayElement();
    std::size_t weatherIndex = battleutils::GetWeather(PMob, false);
    switch (strongestIndex  + 1) // Adjust to ignore ELEMENT_NONE
    {
        case ELEMENT_FIRE:
        {
            choice = GetBestAvailable(SPELLFAMILY_FIRE);
            break;
        }
        case ELEMENT_ICE:
        {
            choice = GetBestAvailable(SPELLFAMILY_BLIZZARD);
            break;
        }
        case ELEMENT_WIND:
        {
            choice = GetBestAvailable(SPELLFAMILY_AERO);
            break;
        }
        case ELEMENT_EARTH:
        {
            choice = GetBestAvailable(SPELLFAMILY_STONE);
            break;
        }
        case ELEMENT_THUNDER:
        {
            choice = GetBestAvailable(SPELLFAMILY_THUNDER);
            break;
        }
        case ELEMENT_WATER:
        {
            choice = GetBestAvailable(SPELLFAMILY_WATER);
            break;
        }
        case ELEMENT_LIGHT:
        {
            choice = GetBestAvailable(SPELLFAMILY_BANISH);
            break;
        }
        case ELEMENT_DARK:
        {
            choice = GetBestAvailable(SPELLFAMILY_DRAIN);
            break;
        }
    }

    // All equal weakness, pick a spell based on day
    if (allEqual)
    {
        switch (dotwIndex)
        {
            case ELEMENT_FIRE:
            {
                choice = GetBestAvailable(SPELLFAMILY_FIRE);
                break;
            }
            case ELEMENT_ICE:
            {
                choice = GetBestAvailable(SPELLFAMILY_BLIZZARD);
                break;
            }
            case ELEMENT_WIND:
            {
                choice = GetBestAvailable(SPELLFAMILY_AERO);
                break;
            }
            case ELEMENT_EARTH:
            {
                choice = GetBestAvailable(SPELLFAMILY_STONE);
                break;
            }
            case ELEMENT_THUNDER:
            {
                choice = GetBestAvailable(SPELLFAMILY_THUNDER);
                break;
            }
            case ELEMENT_WATER:
            {
                choice = GetBestAvailable(SPELLFAMILY_WATER);
                break;
            }
            case ELEMENT_LIGHT:
            {
                choice = GetBestAvailable(SPELLFAMILY_BANISH);
                break;
            }
            case ELEMENT_DARK:
            {
                choice = GetBestAvailable(SPELLFAMILY_DRAIN);
                break;
            }
        }
    }
    // All equal weakness, check if weather is active, pick a spell based on weather
    if (allEqual)
    {
        switch (weatherIndex)
        {
            case WEATHER_HOT_SPELL:
            case WEATHER_HEAT_WAVE:
            {
                choice = GetBestAvailable(SPELLFAMILY_FIRE);
                break;
            }
            case WEATHER_SNOW:
            case WEATHER_BLIZZARDS:
            {
                choice = GetBestAvailable(SPELLFAMILY_BLIZZARD);
                break;
            }
            case WEATHER_WIND:
            case WEATHER_GALES:
            {
                choice = GetBestAvailable(SPELLFAMILY_AERO);
                break;
            }
            case WEATHER_DUST_STORM:
            case WEATHER_SAND_STORM:
            {
                choice = GetBestAvailable(SPELLFAMILY_STONE);
                break;
            }
            case WEATHER_THUNDER:
            case WEATHER_THUNDERSTORMS:
            {
                choice = GetBestAvailable(SPELLFAMILY_THUNDER);
                break;
            }
            case WEATHER_RAIN:
            case WEATHER_SQUALL:
            {
                choice = GetBestAvailable(SPELLFAMILY_WATER);
                break;
            }
            case WEATHER_AURORAS:
            case WEATHER_STELLAR_GLARE:
            {
                choice = GetBestAvailable(SPELLFAMILY_BANISH);
                break;
            }
            case WEATHER_GLOOM:
            case WEATHER_DARKNESS:
            {
                choice = GetBestAvailable(SPELLFAMILY_DRAIN);
                break;
            }
        }
    }

    // TODO: Compare the spell family picked to make sure the absorb mod on enemy isnt >= 50

    // struct AbsorbInfo
    //{
    //     Mod absorb;
    // };

    //// Map SpellFamily to AbsorbInfo (absorb)
    // const std::unordered_map<SPELLFAMILY, AbsorbInfo> absorbInfoMap = {
    //     { SPELLFAMILY_FIRE,          { Mod::FIRE_ABSORB     } },
    //     { SPELLFAMILY_BLIZZARD,      { Mod::ICE_ABSORB      } },
    //     { SPELLFAMILY_AERO,          { Mod::WIND_ABSORB     } },
    //     { SPELLFAMILY_STONE,         { Mod::EARTH_ABSORB    } },
    //     { SPELLFAMILY_THUNDER,       { Mod::LTNG_ABSORB     } },
    //     { SPELLFAMILY_WATER,         { Mod::WATER_ABSORB    } },
    //     { SPELLFAMILY_FIRAGA,        { Mod::FIRE_ABSORB     } },
    //     { SPELLFAMILY_BLIZZAGA,      { Mod::ICE_ABSORB      } },
    //     { SPELLFAMILY_AEROGA,        { Mod::WIND_ABSORB     } },
    //     { SPELLFAMILY_STONEGA,       { Mod::EARTH_ABSORB    } },
    //     { SPELLFAMILY_THUNDAGA,      { Mod::LTNG_ABSORB     } },
    //     { SPELLFAMILY_WATERGA,       { Mod::WATER_ABSORB    } },
    //     { SPELLFAMILY_FLARE,         { Mod::FIRE_ABSORB     } },
    //     { SPELLFAMILY_FREEZE,        { Mod::ICE_ABSORB      } },
    //     { SPELLFAMILY_TORNADO,       { Mod::WIND_ABSORB     } },
    //     { SPELLFAMILY_QUAKE,         { Mod::EARTH_ABSORB    } },
    //     { SPELLFAMILY_BURST,         { Mod::LTNG_ABSORB     } },
    //     { SPELLFAMILY_FLOOD,         { Mod::WATER_ABSORB    } },
    //     { SPELLFAMILY_GEOHELIX,      { Mod::EARTH_ABSORB    } },
    //     { SPELLFAMILY_HYDROHELIX,    { Mod::WATER_ABSORB    } },
    //     { SPELLFAMILY_ANEMOHELIX,    { Mod::WIND_ABSORB     } },
    //     { SPELLFAMILY_PYROHELIX,     { Mod::FIRE_ABSORB     } },
    //     { SPELLFAMILY_CRYOHELIX,     { Mod::ICE_ABSORB      } },
    //     { SPELLFAMILY_IONOHELIX,     { Mod::LTNG_ABSORB     } },
    //     { SPELLFAMILY_NOCTOHELIX,    { Mod::DARK_ABSORB     } },
    //     { SPELLFAMILY_LUMINOHELIX,   { Mod::LIGHT_ABSORB    } }
    // };

    //// Check if the spell family is in the absorbInfoMap and if the absorb mod is >= 50
    //// Check if mob has JA Autos
    // SpellID PSpell = static_cast<SpellID>(spellId);
    // auto spellData = spell::GetSpell(PSpell);

    // if (spellData)
    //{
    //     SPELLFAMILY spellFamily = spellData->getSpellFamily();
    //     auto absorbIt = absorbInfoMap.find(spellFamily);
    //     if (absorbIt != absorbInfoMap.end())
    //     {
    //         const AbsorbInfo& absorbInfo = absorbIt->second;

    //        if (PTarget->getMod(absorbInfo.absorb) >= 50)
    //        {
    //            return true;
    //        }
    //    }
    //}

    // If all else fails, just cast the best you have!
    return !choice ? GetBestAvailable(SPELLFAMILY_NONE) : choice;
}

std::optional<SpellID> CMobSpellContainer::GetStormDay()
{
    std::optional<SpellID> choice = std::nullopt;
    std::size_t dotwIndex = battleutils::GetDayElement();
    switch (dotwIndex)
    {
        case ELEMENT_FIRE:
        {
            choice = GetBestAvailable(SPELLFAMILY_FIRESTORM);
            break;
        }
        case ELEMENT_ICE:
        {
            choice = GetBestAvailable(SPELLFAMILY_HAILSTORM);
            break;
        }
        case ELEMENT_WIND:
        {
            choice = GetBestAvailable(SPELLFAMILY_WINDSTORM);
            break;
        }
        case ELEMENT_EARTH:
        {
            choice = GetBestAvailable(SPELLFAMILY_SANDSTORM);
            break;
        }
        case ELEMENT_THUNDER:
        {
            choice = GetBestAvailable(SPELLFAMILY_THUNDERSTORM);
            break;
        }
        case ELEMENT_WATER:
        {
            choice = GetBestAvailable(SPELLFAMILY_RAINSTORM);
            break;
        }
        case ELEMENT_LIGHT:
        {
            choice = GetBestAvailable(SPELLFAMILY_AURORASTORM);
            break;
        }
        case ELEMENT_DARK:
        {
            choice = GetBestAvailable(SPELLFAMILY_VOIDSTORM);
            break;
        }
    }
    return choice;
}

std::optional<SpellID> CMobSpellContainer::GetHelixDay(CBattleEntity* PMob)
{
    std::optional<SpellID> choice = std::nullopt;
    std::size_t dotwIndex = battleutils::GetDayElement();
    std::size_t weatherIndex = battleutils::GetWeather(PMob, false);

    switch (dotwIndex)
    {
        case ELEMENT_FIRE:
        {
            choice = GetBestAvailable(SPELLFAMILY_PYROHELIX);
            break;
        }
        case ELEMENT_ICE:
        {
            choice = GetBestAvailable(SPELLFAMILY_CRYOHELIX);
            break;
        }
        case ELEMENT_WIND:
        {
            choice = GetBestAvailable(SPELLFAMILY_ANEMOHELIX);
            break;
        }
        case ELEMENT_EARTH:
        {
            choice = GetBestAvailable(SPELLFAMILY_GEOHELIX);
            break;
        }
        case ELEMENT_THUNDER:
        {
            choice = GetBestAvailable(SPELLFAMILY_IONOHELIX);
            break;
        }
        case ELEMENT_WATER:
        {
            choice = GetBestAvailable(SPELLFAMILY_HYDROHELIX);
            break;
        }
        case ELEMENT_LIGHT:
        {
            choice = GetBestAvailable(SPELLFAMILY_LUMINOHELIX);
            break;
        }
        case ELEMENT_DARK:
        {
            choice = GetBestAvailable(SPELLFAMILY_NOCTOHELIX);
            break;
        }
    }

    switch (weatherIndex)
    {
        case WEATHER_HOT_SPELL:
        case WEATHER_HEAT_WAVE:
        {
            choice = GetBestAvailable(SPELLFAMILY_PYROHELIX);
            break;
        }
        case WEATHER_SNOW:
        case WEATHER_BLIZZARDS:
        {
            choice = GetBestAvailable(SPELLFAMILY_CRYOHELIX);
            break;
        }
        case WEATHER_WIND:
        case WEATHER_GALES:
        {
            choice = GetBestAvailable(SPELLFAMILY_ANEMOHELIX);
            break;
        }
        case WEATHER_DUST_STORM:
        case WEATHER_SAND_STORM:
        {
            choice = GetBestAvailable(SPELLFAMILY_GEOHELIX);
            break;
        }
        case WEATHER_THUNDER:
        case WEATHER_THUNDERSTORMS:
        {
            choice = GetBestAvailable(SPELLFAMILY_IONOHELIX);
            break;
        }
        case WEATHER_RAIN:
        case WEATHER_SQUALL:
        {
            choice = GetBestAvailable(SPELLFAMILY_HYDROHELIX);
            break;
        }
        case WEATHER_AURORAS:
        case WEATHER_STELLAR_GLARE:
        {
            choice = GetBestAvailable(SPELLFAMILY_LUMINOHELIX);
            break;
        }
        case WEATHER_GLOOM:
        case WEATHER_DARKNESS:
        {
            choice = GetBestAvailable(SPELLFAMILY_NOCTOHELIX);
            break;
        }
    }

    return choice;
}

std::optional<SpellID> CMobSpellContainer::StormWeakness(CBattleEntity* PMob, CBattleEntity* PTarget)
{
    // Look up what the target has the _least resistance to_:
    std::vector<int16> resistances
    {
        PTarget->getMod(Mod::SDT_FIRE),
        PTarget->getMod(Mod::SDT_ICE),
        PTarget->getMod(Mod::SDT_WIND),
        PTarget->getMod(Mod::SDT_EARTH),
        PTarget->getMod(Mod::SDT_THUNDER),
        PTarget->getMod(Mod::SDT_WATER),
        PTarget->getMod(Mod::SDT_LIGHT),
        PTarget->getMod(Mod::SDT_DARK),
    };

    std::size_t strongestIndex = std::distance(resistances.begin(), std::max_element(resistances.begin(), resistances.end()));

    // Define spell levels
    const std::map<int16, SpellID> levelToSpell = {
        {41, SpellID::Sandstorm},
        {42, SpellID::Rainstorm},
        {43, SpellID::Windstorm},
        {44, SpellID::Firestorm},
        {45, SpellID::Hailstorm},
        {46, SpellID::Thunderstorm},
        {47, SpellID::Voidstorm},
        {48, SpellID::Aurorastorm}
    };

    // Determine the spell level required for the strongest element
    int16 requiredLevel = 0;
    switch (strongestIndex + 1) // Adjust to ignore ELEMENT_NONE
    {
        case ELEMENT_FIRE:
            requiredLevel = 44;
            break;
        case ELEMENT_ICE:
            requiredLevel = 45;
            break;
        case ELEMENT_WIND:
            requiredLevel = 43;
            break;
        case ELEMENT_EARTH:
            requiredLevel = 41;
            break;
        case ELEMENT_THUNDER:
            requiredLevel = 46;
            break;
        case ELEMENT_WATER:
            requiredLevel = 42;
            break;
        case ELEMENT_LIGHT:
            requiredLevel = 48;
            break;
        case ELEMENT_DARK:
            requiredLevel = 47;
            break;
        default:
            return std::nullopt;
    }

    // Default to Sandstorm if not high enough level to cast the weakness helix and level is at least 18
    if (PMob->GetMLevel() >= 41 && PMob->GetMLevel() < requiredLevel)
    {
        return SpellID::Sandstorm;
    }

    // Otherwise, return nothing
    if (PTarget->GetMLevel() < requiredLevel)
    {
        return std::nullopt;
    }

    // Check if all resistances are equal
    bool allEqual = std::all_of(resistances.begin(), resistances.end(), [&](int16 value) { return value == resistances[0]; });

    // If all resistances are equal, choose the storm based on the current day
    if (allEqual)
    {
        return GetStormDay();
    }

    // Return the appropriate SpellID
    auto it = levelToSpell.find(requiredLevel);
    if (it != levelToSpell.end())
    {
        return it->second;
    }

    return std::nullopt;
}

std::optional<SpellID> CMobSpellContainer::HelixWeakness(CBattleEntity* PMob, CBattleEntity* PTarget)
{
    // Look up what the target has the _least resistance to_:
    std::vector<int16> resistances
    {
        PTarget->getMod(Mod::SDT_FIRE),
        PTarget->getMod(Mod::SDT_ICE),
        PTarget->getMod(Mod::SDT_WIND),
        PTarget->getMod(Mod::SDT_EARTH),
        PTarget->getMod(Mod::SDT_THUNDER),
        PTarget->getMod(Mod::SDT_WATER),
        PTarget->getMod(Mod::SDT_LIGHT),
        PTarget->getMod(Mod::SDT_DARK),
    };

    std::size_t strongestIndex  = std::distance(resistances.begin(), std::max_element(resistances.begin(), resistances.end()));

    // Define spell levels
    const std::map<int16, SpellID> levelToSpell = {
        {18, SpellID::Geohelix},
        {20, SpellID::Hydrohelix},
        {22, SpellID::Anemohelix},
        {24, SpellID::Pyrohelix},
        {26, SpellID::Cryohelix},
        {28, SpellID::Ionohelix},
        {30, SpellID::Noctohelix},
        {32, SpellID::Luminohelix}
    };

    // Determine the spell level required for the strongest element
    int16 requiredLevel = 0;
    switch (strongestIndex + 1) // Adjust to ignore ELEMENT_NONE
    {
        case ELEMENT_FIRE:
            requiredLevel = 24;
            break;
        case ELEMENT_ICE:
            requiredLevel = 26;
            break;
        case ELEMENT_WIND:
            requiredLevel = 22;
            break;
        case ELEMENT_EARTH:
            requiredLevel = 18;
            break;
        case ELEMENT_THUNDER:
            requiredLevel = 28;
            break;
        case ELEMENT_WATER:
            requiredLevel = 20;
            break;
        case ELEMENT_LIGHT:
            requiredLevel = 32;
            break;
        case ELEMENT_DARK:
            requiredLevel = 30;
            break;
        default:
            return std::nullopt;
    }

    // Default to GeoHelix if not high enough level to cast the weakness helix and level is at least 18
    if (PMob->GetMLevel() >= 18 && PMob->GetMLevel() < requiredLevel)
    {
        return SpellID::Geohelix;
    }

    // Otherwise, return nothing
    if (PMob->GetMLevel() < requiredLevel)
    {
        return std::nullopt;
    }

    // Check if all resistances are equal
    bool allEqual = std::all_of(resistances.begin(), resistances.end(), [&](int16 value) { return value == resistances[0]; });

    // If all resistances are equal, choose the helix based on the current day
    if (allEqual)
    {
        return GetHelixDay(PMob);
    }

    // Return the appropriate SpellID
    auto it = levelToSpell.find(requiredLevel);
    if (it != levelToSpell.end())
    {
        return it->second;
    }

    return std::nullopt;
}


bool CMobSpellContainer::HasSpells() const
{
    return m_hasSpells;
}

bool CMobSpellContainer::HasMPSpells() const
{
    for(auto spell : m_damageList)
    {
        if(spell::GetSpell(spell)->hasMPCost()){
            return true;
        }
    }

    for(auto spell : m_buffList)
    {
        if(spell::GetSpell(spell)->hasMPCost()){
            return true;
        }
    }

    return false;
}

std::optional<SpellID> CMobSpellContainer::GetAggroSpell()
{
    // high chance to return ga spell
    if(HasGaSpells() && tpzrand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_GA_CHANCE)){
        return GetGaSpell();
    }

    // else to return damage spell
    return GetDamageSpell();
}

std::optional<SpellID> CMobSpellContainer::GetSpell()
{
    // prioritize curing if health low enough
    if(HasHealSpells() && m_PMob->GetHPP() <= m_PMob->getMobMod(MOBMOD_HP_HEAL_CHANCE) && tpzrand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_HEAL_CHANCE)){
        return GetHealSpell();
    }

    // See if a nearby ally is low enough HP to cure
    if (HasHealSpells())
    {
        CBattleEntity* PCureTarget = nullptr;
        m_PMob->PAI->TargetFind->reset();
        m_PMob->PAI->TargetFind->findWithinArea(m_PMob, AOERADIUS_ATTACKER, 20.0f);

        // Iterate through all targets and find the lowest HP target
        for (auto& target : m_PMob->PAI->TargetFind->m_targets)
        {
            if (target->GetHPP() < m_PMob->getMobMod(MOBMOD_HP_HEAL_CHANCE) && target->PAI->IsEngaged()) // Don't heal targets out of combat
            {
                if (PCureTarget == nullptr || target->GetHPP() < PCureTarget->GetHPP())
                {
                    PCureTarget = target;
                }
            }
        }

        if (PCureTarget != nullptr && PCureTarget->GetHPP() <= m_PMob->getMobMod(MOBMOD_HP_HEAL_CHANCE) && tpzrand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_HEAL_CHANCE))
        {
            return GetHealSpell();
        }
    }

    // almost always use na if I can
    if(HasNaSpells() && tpzrand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_NA_CHANCE)){
        // will return -1 if no proper na spell exists
        auto naSpell = GetNaSpell();
        if(naSpell){
            return naSpell.value();
        }
    }

    // try something really destructive
    if (HasSevereSpells() && tpzrand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_SEVERE_SPELL_CHANCE))
    {
        return GetSevereSpell();
    }

    // try ga spell
    if(HasGaSpells() && tpzrand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_GA_CHANCE)){
        return GetGaSpell();
    }

    if(HasBuffSpells() && tpzrand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_BUFF_CHANCE)){
        return GetBuffSpell();
    }

    // Grab whatever spell can be found
    // starting from damage spell
    if(HasDamageSpells())
    {
        // try damage spell
        return GetDamageSpell();
    }

    if (HasDebuffSpells())
    {
        return GetDebuffSpell();
    }

    if(HasBuffSpells())
    {
        return GetBuffSpell();
    }

    if(HasGaSpells())
    {
        return GetGaSpell();
    }

    if(HasHealSpells())
    {
        return GetHealSpell();
    }

    // Got no spells to use
    return {};
}

std::optional<SpellID> CMobSpellContainer::GetGaSpell()
{
    if(m_gaList.empty()) return {};

    return m_gaList[tpzrand::GetRandomNumber(m_gaList.size())];
}

std::optional<SpellID> CMobSpellContainer::GetDamageSpell()
{
    if(m_damageList.empty()) return {};

    return m_damageList[tpzrand::GetRandomNumber(m_damageList.size())];
}

std::optional<SpellID> CMobSpellContainer::GetBuffSpell()
{
    if (m_buffList.empty())
        return {};

    std::vector<SpellID> availableBuffs;

    // Iterate through the buff list and check if the corresponding effect is already active
    for (SpellID spellId : m_buffList)
    {
        CSpell* spell = spell::GetSpell(spellId);
        EFFECT effect = spell->getEffectForSpell(spellId);

        if (m_PMob->StatusEffectContainer->HasStatusEffect(effect))
        {
        }
        else
        {
            availableBuffs.push_back(spellId);
        }
    }

    // If no available buffs, return empty
    if (availableBuffs.empty())
        return {};

    // Randomly pick a buff from the available buffs
    return availableBuffs[tpzrand::GetRandomNumber(availableBuffs.size())];
}

std::optional<SpellID> CMobSpellContainer::GetDebuffSpell()
{
    if (m_debuffList.empty()) return {};

    return m_debuffList[tpzrand::GetRandomNumber(m_debuffList.size())];
}

std::optional<SpellID> CMobSpellContainer::GetHealSpell()
{
    if(m_PMob->m_EcoSystem == SYSTEM_UNDEAD || m_healList.empty()) return {};

    return m_healList[tpzrand::GetRandomNumber(m_healList.size())];
}

std::optional<SpellID> CMobSpellContainer::GetNaSpell()
{
    if(m_naList.empty()) return {};

    // paralyna
    if(HasNaSpell(SpellID::Paralyna) && m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_PARALYSIS)) {
        return SpellID::Paralyna;
    }

    // cursna
    if(HasNaSpell(SpellID::Cursna) && m_PMob->StatusEffectContainer->HasStatusEffect({EFFECT_CURSE, EFFECT_CURSE_II})){
        return SpellID::Cursna;
    }

    // erase
    if(HasNaSpell(SpellID::Erase) && m_PMob->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_ERASABLE)){
        return SpellID::Erase;
    }

    // blindna
    if(HasNaSpell(SpellID::Blindna) && m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_BLINDNESS)){
        return SpellID::Blindna;
    }

    // poisona
    if(HasNaSpell(SpellID::Poisona) && m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_POISON)){
        return SpellID::Poisona;
    }

    // viruna? whatever ignore
    // silena ignore
    // stona ignore

    return {};
}

std::optional<SpellID> CMobSpellContainer::GetSevereSpell()
{
    if(m_severeList.empty()) return {};

    return m_severeList[tpzrand::GetRandomNumber(m_severeList.size())];
}

bool CMobSpellContainer::HasGaSpells() const
{
    return !m_gaList.empty();
}

bool CMobSpellContainer::HasDamageSpells() const
{
    return !m_damageList.empty();
}

bool CMobSpellContainer::HasBuffSpells() const
{
    return !m_buffList.empty();
}

bool CMobSpellContainer::HasHealSpells() const
{
    return !m_healList.empty();
}

bool CMobSpellContainer::HasNaSpells() const
{
    return !m_naList.empty();
}

bool CMobSpellContainer::HasDebuffSpells() const
{
    return !m_debuffList.empty();
}

bool CMobSpellContainer::HasSevereSpells() const
{
    return !m_severeList.empty();
}

bool CMobSpellContainer::HasNaSpell(SpellID spellId) const
{
    for(auto spell : m_naList)
    {
        if(spell == spellId)
        {
            return true;
        }
    }
    return false;
}

bool CMobSpellContainer::IsImmune(CBattleEntity* PTarget, SpellID spellId)
{
    struct SpellInfo
    {
        EFFECT effect;
        int immunity; // Using an int type to allow bitwise operations on immunities
        Mod eem;
    };

    // Map SpellID to SpellInfo (effect, immunity, EEM)
    const std::unordered_map<SpellID, SpellInfo> spellInfoMap = {
        { SpellID::Paralyze,           { EFFECT_PARALYSIS,  IMMUNITY_PARALYZE,   Mod::EEM_PARALYZE   } },
        { SpellID::Paralyze_II,        { EFFECT_PARALYSIS,  IMMUNITY_PARALYZE,   Mod::EEM_PARALYZE   } },
        { SpellID::Slow,               { EFFECT_SLOW,       IMMUNITY_SLOW,       Mod::EEM_SLOW       } },
        { SpellID::Slow_II,            { EFFECT_SLOW,       IMMUNITY_SLOW,       Mod::EEM_SLOW       } },
        { SpellID::Blind,              { EFFECT_BLINDNESS,  IMMUNITY_BLIND,      Mod::EEM_BLIND      } },
        { SpellID::Blind_II,           { EFFECT_BLINDNESS,  IMMUNITY_BLIND,      Mod::EEM_BLIND      } },
        { SpellID::Silence,            { EFFECT_SILENCE,    IMMUNITY_SILENCE,    Mod::EEM_SILENCE    } },
        { SpellID::Gravity,            { EFFECT_WEIGHT,     IMMUNITY_GRAVITY,    Mod::EEM_GRAVITY    } },
        { SpellID::Gravity_II,         { EFFECT_WEIGHT,     IMMUNITY_GRAVITY,    Mod::EEM_GRAVITY    } },
        { SpellID::Poison,             { EFFECT_POISON,     IMMUNITY_POISON,     Mod::EEM_POISON     } },
        { SpellID::Poison_II,          { EFFECT_POISON,     IMMUNITY_POISON,     Mod::EEM_POISON     } },
        { SpellID::Poison_III,         { EFFECT_POISON,     IMMUNITY_POISON,     Mod::EEM_POISON     } },
        { SpellID::Poison_IV,          { EFFECT_POISON,     IMMUNITY_POISON,     Mod::EEM_POISON     } },
        { SpellID::Stun,               { EFFECT_STUN,       IMMUNITY_STUN,       Mod::EEM_STUN       } },
        { SpellID::Sleep,              { EFFECT_SLEEP,      IMMUNITY_SLEEP,      Mod::EEM_DARK_SLEEP } },
        { SpellID::Sleep_II,           { EFFECT_SLEEP_II,   IMMUNITY_SLEEP,      Mod::EEM_DARK_SLEEP } },
        { SpellID::Sleepga,            { EFFECT_SLEEP,      IMMUNITY_SLEEP,      Mod::EEM_DARK_SLEEP } },
        { SpellID::Sleepga_II,         { EFFECT_SLEEP_II,   IMMUNITY_SLEEP,      Mod::EEM_DARK_SLEEP } },
        { SpellID::Foe_Lullaby,        { EFFECT_SLEEP,      IMMUNITY_SLEEP,      Mod::EEM_LIGHT_SLEEP} },
        { SpellID::Foe_Lullaby_II,     { EFFECT_SLEEP,      IMMUNITY_SLEEP,      Mod::EEM_LIGHT_SLEEP} },
        { SpellID::Horde_Lullaby,      { EFFECT_SLEEP,      IMMUNITY_SLEEP,      Mod::EEM_LIGHT_SLEEP} },
        { SpellID::Horde_Lullaby_II,   { EFFECT_SLEEP,      IMMUNITY_SLEEP,      Mod::EEM_LIGHT_SLEEP} },
        { SpellID::Battlefield_Elegy,  { EFFECT_ELEGY,      IMMUNITY_ELEGY,      Mod::EEM_SLOW       } },
        { SpellID::Carnage_Elegy,      { EFFECT_ELEGY,      IMMUNITY_ELEGY,      Mod::EEM_SLOW       } },
        { SpellID::Massacre_Elegy,     { EFFECT_ELEGY,      IMMUNITY_ELEGY,      Mod::EEM_SLOW       } },
        { SpellID::Dispel,             { EFFECT_NONE,       IMMUNITY_NONE,       Mod::SDT_DARK       } },
        { SpellID::Dispelga,           { EFFECT_NONE,       IMMUNITY_NONE,       Mod::SDT_DARK       } },
        { SpellID::Magic_Finale,       { EFFECT_NONE,       IMMUNITY_NONE,       Mod::SDT_LIGHT      } },
        { SpellID::Addle,              { EFFECT_NONE,       IMMUNITY_NONE,       Mod::SDT_FIRE       } }
    };

    const std::unordered_set<SPELLFAMILY> jaAutosSpellFamilies = {
        SPELLFAMILY_PARALYZE,
        SPELLFAMILY_SLOW
    };

    // Check for magic immunity buffs
    if (PTarget->objtype == TYPE_MOB)
    {
        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_MAGIC_SHIELD))
        {
            CStatusEffect* magicShield = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_MAGIC_SHIELD, 0);
            uint16 magicShieldPower = magicShield->GetPower();

            if (magicShieldPower < 2)
            {
                return true;
            }
        }

        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_ELEMENTAL_SFORZO))
        {
            return true;
        }

        // Check immunities
        auto it = spellInfoMap.find(spellId);
        if (it != spellInfoMap.end())
        {
            const SpellInfo& spell = it->second;

            // Check if hard immune
            if (PTarget->hasImmunity(static_cast<uint32>(spell.immunity)))
            {
                return true;
            }

            // Check if immune due to EEM
            if (PTarget->getMod(static_cast<Mod>(spell.eem)) <= 5)
            {
                return true;
            }
        }

        // Check if mob has JA Autos
        SpellID PSpell = static_cast<SpellID>(spellId);
        auto spellData = spell::GetSpell(PSpell);

        if (spellData)
        {
            SPELLFAMILY spellFamily = spellData->getSpellFamily();

            if (jaAutosSpellFamilies.count(spellFamily))
            {
                if (((CMobEntity*)PTarget)->getMobMod(MOBMOD_ATTACK_SKILL_LIST) > 0)
                {
                    return true;
                }
            }
        }
    }

    return false;
}

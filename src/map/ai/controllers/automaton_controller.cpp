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

#include "automaton_controller.h"
#include "../../../common/utils.h"
#include "../../enmity_container.h"
#include "../../entities/trustentity.h"
#include "../../lua/luautils.h"
#include "../../mobskill.h"
#include "../../mob_spell_container.h"
#include "../../recast_container.h"
#include "../../status_effect_container.h"
#include "../../utils/battleutils.h"
#include "../../utils/itemutils.h"
#include "../../utils/petutils.h"
#include "../../utils/puppetutils.h"
#include "../ai_container.h"
#include "../states/ability_state.h"
#include "../states/magic_state.h"
#include "../states/weaponskill_state.h"
#include "../states/mobskill_state.h"

CAutomatonController::CAutomatonController(CAutomatonEntity* PPet)
    : CPetController(PPet)
    , PAutomaton(PPet)
{
    setCooldowns();
}

void CAutomatonController::setCooldowns()
{
    switch (PAutomaton->getFrame())
    {
    case FRAME_SHARPSHOT:
    {
        switch (PAutomaton->getHead())
        {
        case HEAD_SHARPSHOT:
            m_rangedCooldown = 20s;
            break;
        case HEAD_HARLEQUIN:
            m_rangedCooldown = 25s;
            break;
        default:
            m_rangedCooldown = 36s;
        }
    }
    break;
    case FRAME_HARLEQUIN:
    {
        setMagicCooldowns();
    }
    break;
    case FRAME_STORMWAKER:
    {
        setMagicCooldowns();
    }
    break;
    case FRAME_VALOREDGE:
    {
        m_shieldbashCooldown = 3min;
    }
    }
}

// New retail Automaton magic AI (Needs more information to accurately recreate)
void CAutomatonController::setMagicCooldowns()
{
    switch (PAutomaton->getHead())
    {
    case HEAD_HARLEQUIN:
    {
        m_magicCooldown = 10s;
        m_singCooldown = 6s;
        m_enfeebleCooldown = 15s;
        m_healCooldown = 18s;
    }
    break;
    case HEAD_VALOREDGE:
    {
        m_magicCooldown = 12s;
        m_healCooldown = 12s;
    }
    break;
    case HEAD_SHARPSHOT:
    {
        m_magicCooldown = 12s;
        m_enfeebleCooldown = 12s;
        m_healCooldown = 18s;
    }
    break;
    case HEAD_STORMWAKER:
    {
        m_magicCooldown = 6s;
        m_enfeebleCooldown = 6s;
        m_healCooldown = 8s;
        m_elementalCooldown = 45s;
        m_enhanceCooldown = 6s;
    }
    break;
    case HEAD_SOULSOOTHER:
    {
        m_magicCooldown = 6s;
        m_enfeebleCooldown = 9s;
        m_healCooldown = 6s;
        m_regenCooldown = 18s;
        m_enhanceCooldown = 6s;
        m_statusCooldown = 6s;
        m_absorbCooldown = 30s;
    }
    break;
    case HEAD_SPIRITREAVER:
    {
        m_magicCooldown = 6s;
        m_enfeebleCooldown = 20s;
        m_elementalCooldown = 20s;
        m_absorbCooldown = 15s;
    }
    }
}

void CAutomatonController::ResetCastDelay()
{
    m_LastMagicTime = m_Tick - m_magicCooldown;
}

bool CAutomatonController::isRanged()
{
    switch (PAutomaton->getHead())
    {
    case HEAD_SHARPSHOT:
    case HEAD_STORMWAKER:
    case HEAD_SOULSOOTHER:
    case HEAD_SPIRITREAVER:
        return true;
    default:
        return false;
    }
}

bool CAutomatonController::TryBestSpell(uint16 targid, SPELLFAMILY spellfamily)
{
    if (auto spell = autoSpell::GetBestUsableSpell(PAutomaton, spellfamily))
        return Cast(targid, *spell);

    return false;
}

CurrentManeuvers CAutomatonController::GetCurrentManeuvers() const
{
    auto& statuses = PAutomaton->PMaster->StatusEffectContainer;
    return {
    statuses->GetEffectsCount(EFFECT_FIRE_MANEUVER),
    statuses->GetEffectsCount(EFFECT_ICE_MANEUVER),
    statuses->GetEffectsCount(EFFECT_WIND_MANEUVER),
    statuses->GetEffectsCount(EFFECT_EARTH_MANEUVER),
    statuses->GetEffectsCount(EFFECT_THUNDER_MANEUVER),
    statuses->GetEffectsCount(EFFECT_WATER_MANEUVER),
    statuses->GetEffectsCount(EFFECT_LIGHT_MANEUVER),
    statuses->GetEffectsCount(EFFECT_DARK_MANEUVER)
    };
}

void CAutomatonController::DoCombatTick(time_point tick)
{
    if ((PAutomaton->PMaster == nullptr || PAutomaton->PMaster->isDead()) && PAutomaton->isAlive()) {
        PAutomaton->Die();
        return;
    }

    PTarget = static_cast<CBattleEntity*>(PAutomaton->GetEntity(PAutomaton->GetBattleTargetID()));

    // Auto-target logic for pets
    if (petutils::TryAutoTarget(PAutomaton, PTarget))
    {
        return;
    }

    if (TryDeaggro())
    {
        Disengage();
        return;
    }

    Move();

    // Automatons only attempt actions in 3 second intervals (Reduced by the Tactical Processor)
    if (TryAction())
    {
        auto maneuvers = GetCurrentManeuvers();

        if (TryShieldBash())
        {
            m_LastShieldBashTime = m_Tick;
            return;
        }
        else if (TrySpellcast(maneuvers))
        {
            m_LastMagicTime = m_Tick;
            return;
        }
        else if (TryTPMove())
        {
            return;
        }
        else if (TryAttachment())
        {
            return;
        }
        else if (TryRangedAttack())
        {
            m_LastRangedTime = m_Tick;
            return;
        }
    }
}

void CAutomatonController::Move()
{
    float currentDistance = distanceSquared(PAutomaton->loc.p, PTarget->loc.p);
    // Forcibly enable standback and stay 15 yards from target if the automaton has the AUTO_STANDBACK mod
    if (isRanged() && PAutomaton->getMod(Mod::AUTO_STANDBACK) && (currentDistance < 225))
    {
        FaceTarget();
        return;
    }

    if (currentDistance >= 30.0f)
    {
        Disengage();
        return;
    }

    CPetController::Move();
}

bool CAutomatonController::TryAction()
{
    if (m_Tick > m_LastActionTime + (m_actionCooldown - std::chrono::milliseconds(PAutomaton->getMod(Mod::AUTO_DECISION_DELAY) * 10)))
    {
        m_LastActionTime = m_Tick;
        PAutomaton->PAI->EventHandler.triggerListener("AUTOMATON_AI_TICK", PAutomaton, PTarget);
        return true;
    }
    return false;
}

bool CAutomatonController::TryShieldBash()
{
    bool shouldShieldBash = false;

    // Only usable by Valoredge https://www.bg-wiki.com/ffxi/Automaton
    if (PAutomaton->getFrame() != FRAME_VALOREDGE)
        return false;

    if (PTarget->getMod(Mod::EEM_STUN) <= 5)
        return false;

    if (PTarget->hasImmunity(IMMUNITY_STUN))
        return false;

    // Only interrupt -ga/cures/severe spells
    CState* currentState = PTarget->PAI->GetCurrentState();
    if (currentState)
    {
        // Check for valid Mobskills to stun (not 2 hours, not job abilities, not attack replacements, not special)
        CMobSkillState* msState = dynamic_cast<CMobSkillState*>(currentState);
        if (msState)
        {
            CMobSkill* skill = msState->GetSkill();
            if (skill)
            {
                bool isTwoHour = skill->isTwoHour();
                bool isJobAbility = skill->isJobAbility();
                bool isAttackReplacement = skill->isAttackReplacement();
                bool isSpecial = skill->isSpecial();
                if (!isTwoHour && !isJobAbility && !isAttackReplacement && !isSpecial)
                    shouldShieldBash = true;
            }
        }

        // Check for valid Magic to stun (-gas, severe, heals)
        CMagicState* maState = dynamic_cast<CMagicState*>(currentState);
        if (maState)
        {
            CSpell* spell = maState->GetSpell();
            if (spell)
            {
                bool isAOE = false;
                bool isHeal = spell->isHeal();
                bool isSevere = spell->isSevere();
                uint8 aoe = battleutils::GetSpellAoEType(PTarget, spell);
                if (aoe > 0)
                    isAOE = true;

                if (isAOE || isHeal || isSevere)
                    shouldShieldBash = true;
            }
        }
    }

    // Check WS / JA state
    if (PTarget->PAI->IsCurrentState<CWeaponSkillState>() || PTarget->PAI->IsCurrentState<CAbilityState>())
        shouldShieldBash = true;

    float currentDistance = distance(PAutomaton->loc.p, PTarget->loc.p);
    if (currentDistance <= static_cast<float>(PAutomaton->GetMeleeRange()) + static_cast<float>(PTarget->m_ModelSize))
    {
        if (m_shieldbashCooldown > 0s && shouldShieldBash &&
            m_Tick > m_LastShieldBashTime + (m_shieldbashCooldown - std::chrono::seconds(PAutomaton->getMod(Mod::AUTO_SHIELD_BASH_DELAY))))
        {
            return MobSkill(PTarget->targid, m_ShieldBashAbility);
        }
    }

    return false;
}

bool CAutomatonController::TrySpellcast(const CurrentManeuvers& maneuvers)
{
    if (!PAutomaton->PMaster || m_magicCooldown == 0s ||
        m_Tick <= m_LastMagicTime + (m_magicCooldown - std::chrono::seconds(PAutomaton->getMod(Mod::AUTO_MAGIC_DELAY))) || !CanCastSpells())
        return false;

    switch (PAutomaton->getHead())
    {
    case HEAD_VALOREDGE:
    {
        if (TryHeal(maneuvers))
        {
            m_LastHealTime = m_Tick;
            return true;
        }
    }
    break;
    case HEAD_SHARPSHOT:
    {
        if (maneuvers.light && TryHeal(maneuvers)) // Light -> Heal
        {
            m_LastHealTime = m_Tick;
            return true;
        }

        if (TryEnfeeble(maneuvers))
        {
            m_LastEnfeebleTime = m_Tick;
            return true;
        }
        else if (!maneuvers.light && TryHeal(maneuvers))
        {
            m_LastHealTime = m_Tick;
            return true;
        }
    }
    break;
    case HEAD_HARLEQUIN:
    {
        if (maneuvers.light && TryHeal(maneuvers)) // Light -> Heal
        {
            m_LastHealTime = m_Tick;
            return true;
        }

        if (TrySing(maneuvers))
        {
            m_LastSingTime = m_Tick;
            return true;
        }
        else if (TryEnfeeble(maneuvers))
        {
            m_LastEnfeebleTime = m_Tick;
            return true;
        }
        else if (!maneuvers.light && TryHeal(maneuvers))
        {
            m_LastHealTime = m_Tick;
            return true;
        }
    }
    break;
    case HEAD_STORMWAKER:
    {
        bool lowHP = PTarget->GetHPP() <= 30 && PTarget->health.hp <= 300;
        if (lowHP && TryElemental(maneuvers))  // Mob low HP -> Nuke
        {
            m_LastElementalTime = m_Tick;
            return true;
        }

        if (maneuvers.light && TryHeal(maneuvers)) // Light -> Heal
        {
            m_LastHealTime = m_Tick;
            return true;
        }
        else if (!lowHP && maneuvers.ice && TryElemental(maneuvers))  // Ice -> Nuke
        {
            m_LastElementalTime = m_Tick;
            return true;
        }

        if (TryEnhance())
        {
            m_LastEnhanceTime = m_Tick;
            return true;
        }
        else if (TryEnfeeble(maneuvers))
        {
            m_LastEnfeebleTime = m_Tick;
            return true;
        }
        else if (!maneuvers.light && TryHeal(maneuvers))
        {
            m_LastHealTime = m_Tick;
            return true;
        }
        else if (!lowHP && !maneuvers.ice && TryElemental(maneuvers))
        {
            m_LastElementalTime = m_Tick;
            return true;
        }
    }
    break;
    case HEAD_SOULSOOTHER:
    {
        if (maneuvers.light && TryHeal(maneuvers)) // Light -> Heal
        {
            m_LastHealTime = m_Tick;
            return true;
        }

        if (TryStatusRemoval(maneuvers))
        {
            m_LastStatusTime = m_Tick;
            return true;
        }
        else if (!maneuvers.light && TryHeal(maneuvers))
        {
            m_LastHealTime = m_Tick;
            return true;
        }
        else if (TryRegen())
        {
            m_LastRegenTime = m_Tick;
            return true;
        }
        else if (TryEnhance())
        {
            m_LastEnhanceTime = m_Tick;
            return true;
        }
        else if (TryAbsorb(maneuvers))
        {
            m_LastAbsorbTime = m_Tick;
            return true;
        }
        else if (TryEnfeeble(maneuvers))
        {
            m_LastEnfeebleTime = m_Tick;
            return true;
        }
    }
    break;
    case HEAD_SPIRITREAVER:
    {
        if (maneuvers.ice && TryElemental(maneuvers))  // Ice -> Nuke
        {
            m_LastElementalTime = m_Tick;
            return true;
        }
        else if (TryAbsorb(maneuvers))
        {
            m_LastAbsorbTime = m_Tick;
            return true;
        }
        else if (maneuvers.dark && TryEnfeeble(maneuvers)) // Dark -> Enfeeble
        {
            m_LastEnfeebleTime = m_Tick;
            return true;
        }

        if (!maneuvers.ice && TryElemental(maneuvers))
        {
            m_LastElementalTime = m_Tick;
            return true;
        }
    }
    }
    return false;
}

bool CAutomatonController::TryHeal(const CurrentManeuvers& maneuvers)
{
    if (!PAutomaton->PMaster || m_healCooldown == 0s ||
        m_Tick <= m_LastHealTime + (m_healCooldown - std::chrono::seconds(PAutomaton->getMod(Mod::AUTO_HEALING_DELAY))))
        return false;

    float threshold = 30.0f;
    switch (maneuvers.light) // Light -> Higher healing threshold
    {
    case 1:
        threshold = 40.0f;
        break;
    case 2:
        threshold = 50.0f;
        break;
    case 3:
        threshold = 75.0f;
        break;
    default:
        threshold = 30.0f;
        break;
    }

    threshold = std::clamp<float>(threshold + PAutomaton->getMod(Mod::AUTO_HEALING_THRESHOLD), 30.0f, 90.0f);
    CBattleEntity* PCastTarget = nullptr;

    bool haveHate = false;
    EnmityList_t* enmityList;

    auto PMob = dynamic_cast<CMobEntity*>(PTarget);
    if (PMob)
    {
        enmityList = PMob->PEnmityContainer->GetEnmityList();
        auto masterEnmity_obj = enmityList->find(PAutomaton->PMaster->id);
        auto selfEnmity_obj = enmityList->find(PAutomaton->id);

        if (masterEnmity_obj == enmityList->end())
            haveHate = true;
        else if (selfEnmity_obj == enmityList->end())
            haveHate = false;
        else
        {
            uint16 selfEnmity = selfEnmity_obj->second.CE + selfEnmity_obj->second.VE;
            uint16 masterEnmity = masterEnmity_obj->second.CE + masterEnmity_obj->second.VE;
            haveHate = selfEnmity > masterEnmity ? true : false;
        }
    }

    // Prioritize healing self if tanking the mob and below threshold
    if (haveHate)
    {
        if (PAutomaton->GetHPP() <= threshold)
            PCastTarget = PAutomaton;
    }

    // Heal party members, priotorizing whoever is tanking the mob
    if (!PCastTarget && PAutomaton->PMaster->PParty) // Light + Soulsoother head -> Heal party
    {
        // If engaged to a mob, only cure people on the mobs entity list
        if (PMob)
        {
            uint16 highestEnmity = 0;
            static_cast<CCharEntity*>(PAutomaton->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember) {
                auto enmity_obj = enmityList->find(PMember->id);
                if (enmity_obj != enmityList->end() && highestEnmity < enmity_obj->second.CE + enmity_obj->second.VE && PMember->GetHPP() < threshold &&
                    distance(PAutomaton->loc.p, PAutomaton->PMaster->loc.p) < 20)
                {
                    highestEnmity = enmity_obj->second.CE + enmity_obj->second.VE;
                    PCastTarget = PMember;
                }
            });
        }
        else
        {
            static_cast<CCharEntity*>(PAutomaton->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember) {
                if (distance(PAutomaton->loc.p, PAutomaton->PMaster->loc.p) < 20)
                {
                    if (PMember->GetHPP() < threshold)
                    {
                        PCastTarget = PMember;
                    }
                }
            });
        }
    }

    // Heal self if below threshold
    if (!PCastTarget)
    {
        if (PAutomaton->GetHPP() <= threshold)
            PCastTarget = PAutomaton;
    }

    if (PCastTarget)
    {
        auto missinghp = PCastTarget->GetMaxHP() - PCastTarget->health.hp;
        if (missinghp >= 900 && Cast(PCastTarget->targid, SpellID::Cure_VI))
            return true;
        else if (missinghp >= 600 && Cast(PCastTarget->targid, SpellID::Cure_V))
            return true;
        else if (missinghp > 180 && Cast(PCastTarget->targid, SpellID::Cure_IV))
            return true;
        else if (missinghp > 80 && Cast(PCastTarget->targid, SpellID::Cure_III))
            return true;
        else if (missinghp > 30 && Cast(PCastTarget->targid, SpellID::Cure_II))
            return true;
        else if (Cast(PCastTarget->targid, SpellID::Cure))
            return true;
    }

    return false;
}

inline bool resistanceComparator(const std::pair<SpellID, int16>& firstElem, const std::pair<SpellID, int16>& secondElem) {
    return firstElem.second < secondElem.second;
}

bool CAutomatonController::TryElemental(const CurrentManeuvers& maneuvers)
{
    if (!PAutomaton->PMaster || m_elementalCooldown == 0s ||
        m_Tick <= m_LastElementalTime + (m_elementalCooldown - std::chrono::seconds(PAutomaton->getMod(Mod::AUTO_ELEMENTAL_DELAY))) || !PTarget)
        return false;

    std::vector<SpellID> castPriority;
    std::vector<SpellID> defaultPriority;

    int8 tier = 4;
    int32 hp = PTarget->health.hp;
    int32 selfmp = PAutomaton->health.mp; // Shortcut for wasting less time
    if (selfmp < 4)
        return false;
    else if (hp <= 50 || selfmp < 16)
        tier = 0;
    else if (hp <= 150 || selfmp < 40)
        tier = 1;
    else if (hp <= 200 || selfmp < 88)
        tier = 2;
    else if (hp <= 600 || selfmp < 156)
        tier = 3;

    if (tpzrand::GetRandomNumber(100) < PAutomaton->getMod(Mod::AUTO_SCAN_RESISTS))
    {
        //std::vector<std::pair<SpellID, int16>> reslist{
        //    std::make_pair(SpellID::Fire, PTarget->getMod(Mod::FIRERES)),
        //    std::make_pair(SpellID::Blizzard, PTarget->getMod(Mod::ICERES)),
        //    std::make_pair(SpellID::Aero, PTarget->getMod(Mod::WINDRES)),
        //    std::make_pair(SpellID::Stone, PTarget->getMod(Mod::EARTHRES)),
        //    std::make_pair(SpellID::Thunder, PTarget->getMod(Mod::THUNDERRES)),
        //    std::make_pair(SpellID::Water, PTarget->getMod(Mod::WATERRES))
        //};
        std::vector<std::pair<SpellID, int16>> reslist{
            std::make_pair(SpellID::Fire, 1000 / PTarget->getMod(Mod::SDT_FIRE)),
            std::make_pair(SpellID::Blizzard, 1000 / PTarget->getMod(Mod::SDT_ICE)),
            std::make_pair(SpellID::Aero, 1000 / PTarget->getMod(Mod::SDT_WIND)),
            std::make_pair(SpellID::Stone, 1000 / PTarget->getMod(Mod::SDT_EARTH)),
            std::make_pair(SpellID::Thunder, 1000 / PTarget->getMod(Mod::SDT_THUNDER)),
            std::make_pair(SpellID::Water, 1000 / PTarget->getMod(Mod::SDT_WATER)),
        };
        std::stable_sort(reslist.begin(), reslist.end(), resistanceComparator);
        for (std::pair<SpellID, int16>& res : reslist)
            castPriority.push_back(res.first);
    }
    else if (PAutomaton->getHead() == HEAD_SPIRITREAVER)
    {
        if (maneuvers.thunder) // Thunder -> Thunder spells
            castPriority.push_back(SpellID::Thunder);
        else
            defaultPriority.push_back(SpellID::Thunder);

        if (maneuvers.ice) // Ice -> Blizzard spells
            castPriority.push_back(SpellID::Blizzard);
        else
            defaultPriority.push_back(SpellID::Blizzard);

        if (maneuvers.fire) // Fire -> Fire spells
            castPriority.push_back(SpellID::Fire);
        else
            defaultPriority.push_back(SpellID::Fire);

        if (maneuvers.wind) // Wind -> Aero spells
            castPriority.push_back(SpellID::Aero);
        else
            defaultPriority.push_back(SpellID::Aero);

        if (maneuvers.water) // Water -> Water spells
            castPriority.push_back(SpellID::Water);
        else
            defaultPriority.push_back(SpellID::Water);

        if (maneuvers.earth) // Earth -> Stone spells
            castPriority.push_back(SpellID::Stone);
        else
            defaultPriority.push_back(SpellID::Stone);
    }
    else
    {
        defaultPriority = { SpellID::Thunder, SpellID::Blizzard, SpellID::Fire, SpellID::Aero, SpellID::Water, SpellID::Stone };
    }

    for (int8 i = tier; i >= 0; --i)
    {
        for (SpellID& id : castPriority)
            if (Cast(PTarget->targid, static_cast<SpellID>(static_cast<uint16>(id) + i)))
                return true;

        for (SpellID& id : defaultPriority)
            if (Cast(PTarget->targid, static_cast<SpellID>(static_cast<uint16>(id) + i)))
                return true;
    }

    return false;
}

bool CAutomatonController::TryAbsorb(const CurrentManeuvers& maneuvers)
{
    if (!PAutomaton->PMaster || m_absorbCooldown == 0s || m_Tick <= m_LastAbsorbTime + m_absorbCooldown || !PTarget)
        return false;

    std::vector<SpellID> castPriority;
    std::vector<SpellID> defaultPriority;

    if (PAutomaton->getHead() == HEAD_SPIRITREAVER)
    {

        if (PTarget->m_EcoSystem != SYSTEM_UNDEAD && PAutomaton->GetMPP() <= 75 && PTarget->health.mp > 0) // MPP <= 75 -> Aspir
        {
            castPriority.push_back(SpellID::Aspir_II);
            castPriority.push_back(SpellID::Aspir);
        }

        if (!PAutomaton->StatusEffectContainer->HasStatusEffect(EFFECT_INT_BOOST)) // Use it ASAP
            castPriority.push_back(SpellID::Absorb_INT);

        if (PTarget->m_EcoSystem != SYSTEM_UNDEAD) // Always use Drain off cooldown
            castPriority.push_back(SpellID::Drain);

        if (!PAutomaton->StatusEffectContainer->HasStatusEffect(EFFECT_DREAD_SPIKES)) // Keep up Dread Spikes
        {
            if (Cast(PAutomaton->targid, SpellID::Dread_Spikes))
            {
                return true;
            }
        }
    }

    for (SpellID& id : castPriority)
    {
        if (Cast(PTarget->targid, id))
            return true;
    }

    for (SpellID& id : defaultPriority)
    {
        if (Cast(PTarget->targid, id))
            return true;
    }

    return false;
}

bool CAutomatonController::TryEnfeeble(const CurrentManeuvers& maneuvers)
{
    if (!PAutomaton->PMaster || m_enfeebleCooldown == 0s || m_Tick <= m_LastEnfeebleTime + m_enfeebleCooldown || !PTarget)
        return false;

    std::vector<SpellID> castPriority;
    std::vector<SpellID> defaultPriority;

    switch (PAutomaton->getHead())
    {
    case HEAD_STORMWAKER:
    {
        bool dispel = false;
        PTarget->StatusEffectContainer->ForEachEffect([&dispel](CStatusEffect* PStatus) {
            if (!dispel && PStatus->GetDuration() > 0)
            {
                if (PStatus->GetFlag() & EFFECTFLAG_DISPELABLE)
                {
                    dispel = true;
                    return;
                }
            }
        });
        if (dispel)
            castPriority.push_back(SpellID::Dispel);
    [[fallthrough]];
    }
    default:
    {
        if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_BIO))
        {
            if (maneuvers.light)
            {
                castPriority.push_back(SpellID::Dia_III);
                castPriority.push_back(SpellID::Dia_II);
                castPriority.push_back(SpellID::Dia);
            }
            else
            {
                defaultPriority.push_back(SpellID::Dia_III);
                defaultPriority.push_back(SpellID::Dia_II);
                defaultPriority.push_back(SpellID::Dia);
            }
        }

        if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DIA))
        {
            if (maneuvers.dark && maneuvers.light < 2) // Dark -> Bio
            {
                castPriority.push_back(SpellID::Bio_III);
                castPriority.push_back(SpellID::Bio_II);
                castPriority.push_back(SpellID::Bio);
            }
            else
            {
                defaultPriority.push_back(SpellID::Bio_III);
                defaultPriority.push_back(SpellID::Bio_II);
                defaultPriority.push_back(SpellID::Bio);
            }
        }

        if (maneuvers.water) // Water -> Poison
        {
            castPriority.push_back(SpellID::Poison_II);
            castPriority.push_back(SpellID::Poison);
        }
        else
        {
            defaultPriority.push_back(SpellID::Poison_II);
            defaultPriority.push_back(SpellID::Poison);
        }

        if ((static_cast<CMobEntity*>(PTarget))->SpellContainer->HasSpells())
        {
            if (maneuvers.wind) // Wind -> Silence
                castPriority.push_back(SpellID::Silence);
            else
                defaultPriority.push_back(SpellID::Silence);
        }

        if (maneuvers.earth) // Earth -> Slow
        {
            castPriority.push_back(SpellID::Slow_II);
            castPriority.push_back(SpellID::Slow);
        }
        else
        {
            defaultPriority.push_back(SpellID::Slow_II);
            defaultPriority.push_back(SpellID::Slow);
        }

        if (maneuvers.dark) // Dark -> Blind
        {
            castPriority.push_back(SpellID::Blind_II);
            castPriority.push_back(SpellID::Blind);
        }
        else
        {
            defaultPriority.push_back(SpellID::Blind_II);
            defaultPriority.push_back(SpellID::Blind);
        }

        if (maneuvers.ice) // Ice -> Paralyze
        {
            castPriority.push_back(SpellID::Paralyze_II);
            castPriority.push_back(SpellID::Paralyze);
        }
        else
        {
            defaultPriority.push_back(SpellID::Paralyze_II);
            defaultPriority.push_back(SpellID::Paralyze);
        }

        if (maneuvers.fire) // Fire -> Addle
            castPriority.push_back(SpellID::Addle);
        else
            defaultPriority.push_back(SpellID::Addle);

        defaultPriority.push_back(SpellID::Inundation);
    }
    break;
    case HEAD_SPIRITREAVER:
    {
        if (maneuvers.dark) // Dark -> Access to Enfeebles
        {
            // Not prioritizable since it requires 1 Dark to access Enfeebles and requires 2 of another element to prioritize another
            defaultPriority.push_back(SpellID::Blind);

            if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DIA))
            {
                defaultPriority.push_back(SpellID::Bio_II);
                defaultPriority.push_back(SpellID::Bio);
            }

            if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_BIO))
            {
                if (maneuvers.light >= 2) // 2 Light -> Dia
                {
                    castPriority.push_back(SpellID::Dia_II);
                    castPriority.push_back(SpellID::Dia);
                }
                else
                {
                    defaultPriority.push_back(SpellID::Dia_II);
                    defaultPriority.push_back(SpellID::Dia);
                }
            }

            if (maneuvers.water >= 2) // 2 Water -> Poison
            {
                castPriority.push_back(SpellID::Poison_II);
                castPriority.push_back(SpellID::Poison);
            }
            else
            {
                defaultPriority.push_back(SpellID::Poison_II);
                defaultPriority.push_back(SpellID::Poison);
            }

            if ((static_cast<CMobEntity*>(PTarget))->SpellContainer->HasSpells())
            {
                if (maneuvers.wind) // Wind -> Silence
                    castPriority.push_back(SpellID::Silence);
                else
                    defaultPriority.push_back(SpellID::Silence);
            }

            if (maneuvers.earth >= 2) // 2 Earth -> Slow
                castPriority.push_back(SpellID::Slow);
            else
                defaultPriority.push_back(SpellID::Slow);

            if (maneuvers.ice >= 2) // 2 Ice -> Paralyze
                castPriority.push_back(SpellID::Paralyze);
            else
                defaultPriority.push_back(SpellID::Paralyze);

            if (maneuvers.fire >= 2) // 2 Fire -> Addle
                castPriority.push_back(SpellID::Addle);
            else
                defaultPriority.push_back(SpellID::Addle);
        }
    }
    break;
    case HEAD_SOULSOOTHER:
    {
        if (maneuvers.earth) // Earth -> Slow
            castPriority.push_back(SpellID::Slow);
        else
            defaultPriority.push_back(SpellID::Slow);

        if (maneuvers.water) // 2 Water -> Poison
        {
            castPriority.push_back(SpellID::Poison_II);
            castPriority.push_back(SpellID::Poison);
        }
        else
        {
            defaultPriority.push_back(SpellID::Poison_II);
            defaultPriority.push_back(SpellID::Poison);
        }

        if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_BIO))
        {
            if (maneuvers.light) // Light -> Dia
            {
                castPriority.push_back(SpellID::Dia_II);
                castPriority.push_back(SpellID::Dia);
            }
            else
            {
                defaultPriority.push_back(SpellID::Dia_II);
                defaultPriority.push_back(SpellID::Dia);
            }
        }

        if (maneuvers.dark) // Dark -> Blind > Bio
        {
            castPriority.push_back(SpellID::Blind);

            if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DIA))
            {
                castPriority.push_back(SpellID::Bio_II);
                castPriority.push_back(SpellID::Bio);
            }
        }
        else
        {
            defaultPriority.push_back(SpellID::Blind);

            if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DIA))
            {
                defaultPriority.push_back(SpellID::Bio_II);
                defaultPriority.push_back(SpellID::Bio);
            }
        }

        if ((static_cast<CMobEntity*>(PTarget))->SpellContainer->HasSpells())
        {
            if (maneuvers.wind) // Wind -> Silence
                castPriority.push_back(SpellID::Silence);
            else
                defaultPriority.push_back(SpellID::Silence);
        }

        if (maneuvers.ice) // Ice -> Paralyze
            castPriority.push_back(SpellID::Paralyze);
        else
            defaultPriority.push_back(SpellID::Paralyze);

        if (maneuvers.fire) // Fire -> Addle
            castPriority.push_back(SpellID::Addle);
        else
            defaultPriority.push_back(SpellID::Addle);
    }
    }

    for (SpellID& id : castPriority)
    {
        if (autoSpell::CanUseEnfeeble(PTarget, id) && Cast(PTarget->targid, id))
            return true;
    }

    for (SpellID& id : defaultPriority)
    {
        if (autoSpell::CanUseEnfeeble(PTarget, id) && Cast(PTarget->targid, id))
            return true;
    }

    return false;
}

bool CAutomatonController::TryStatusRemoval(const CurrentManeuvers& maneuvers)
{
    if (!PAutomaton->PMaster || m_statusCooldown == 0s || m_Tick <= m_LastStatusTime + m_statusCooldown)
        return false;

    std::vector<SpellID> castPriority;

    PAutomaton->PMaster->StatusEffectContainer->ForEachEffect([&castPriority](CStatusEffect* PStatus) {
        if (PStatus->GetDuration() > 0)
        {
            auto id = autoSpell::FindNaSpell(PStatus);
            if (id.has_value())
            {
                castPriority.push_back(id.value());
            }
        }
    });

    for (SpellID& id : castPriority)
        if (Cast(PAutomaton->PMaster->targid, id))
            return true;

    castPriority.clear();

    PAutomaton->StatusEffectContainer->ForEachEffect([&castPriority](CStatusEffect* PStatus) {
        if (PStatus->GetDuration() > 0)
        {
            auto id = autoSpell::FindNaSpell(PStatus);
            if (id.has_value())
            {
                castPriority.push_back(id.value());
            }
        }
    });

    for (SpellID& id : castPriority)
        if (Cast(PAutomaton->targid, id))
            return true;

    if (maneuvers.water && PAutomaton->getHead() == HEAD_SOULSOOTHER && PAutomaton->PMaster->PParty) // Water + Soulsoother head -> Remove party's statuses
    {
        for (uint8 i = 0; i < PAutomaton->PMaster->PParty->members.size(); ++i)
        {
            CBattleEntity* member = PAutomaton->PMaster->PParty->members.at(i);
            if (member->id != PAutomaton->PMaster->id)
            {
                castPriority.clear();

                member->StatusEffectContainer->ForEachEffect([&castPriority](CStatusEffect* PStatus) {
                    if (PStatus->GetDuration() > 0)
                    {
                        auto id = autoSpell::FindNaSpell(PStatus);
                        if (id.has_value())
                        {
                            castPriority.push_back(id.value());
                        }
                    }
                });

                for (auto id : castPriority)
                    if (Cast(member->targid, id))
                        return true;
            }
        }
    }

    return false;
}

bool CAutomatonController::TryRegen()
{
    if (!PAutomaton->PMaster || m_regenCooldown == 0s || m_Tick <= m_LastRegenTime + m_regenCooldown || !PTarget)
        return false;

    EnmityList_t* enmityList;
    auto PMob = dynamic_cast<CMobEntity*>(PTarget);
    if (PMob)
        enmityList = PMob->PEnmityContainer->GetEnmityList();

    uint16 highestEnmity = 0;

    CBattleEntity* PRegenTarget = nullptr;

    bool isEngaged = false;

    if (distance(PAutomaton->loc.p, PAutomaton->PMaster->loc.p) < 20)
    {
        if (PMob)
        {
            auto enmity_obj = enmityList->find(PAutomaton->PMaster->id);
            if (enmity_obj != enmityList->end())
            {
                isEngaged = true;
                if (highestEnmity < enmity_obj->second.CE + enmity_obj->second.VE)
                {
                    highestEnmity = enmity_obj->second.CE + enmity_obj->second.VE;
                    PRegenTarget = PAutomaton->PMaster;
                }
            }
        }
        else
        {
            isEngaged = true; // Assume everyone is engaged if the target isn't a mob
        }
    }
    if (PMob)
    {
        auto enmity_obj = enmityList->find(PAutomaton->id);
        if (enmity_obj != enmityList->end() && highestEnmity < enmity_obj->second.CE + enmity_obj->second.VE)
        {
            highestEnmity = enmity_obj->second.CE + enmity_obj->second.VE;
            PRegenTarget = PAutomaton;
        }
    }

    size_t members = 0;

    // Unknown whether it only applies buffs to other members if they have hate or if the Soulsoother head is needed
    if (PAutomaton->PMaster->PParty)
    {
        members = PAutomaton->PMaster->PParty->members.size();
        static_cast<CCharEntity*>(PAutomaton->PMaster)
            ->ForPartyWithTrusts(
                [&](CBattleEntity* PMember)
                {
                    if (PMember->id != PAutomaton->PMaster->id && distance(PAutomaton->loc.p, PMember->loc.p) < 20)
                    {
                        isEngaged = false;

                        if (PMob)
                        {
                            auto enmity_obj = enmityList->find(PMember->id);
                            if (enmity_obj != enmityList->end())
                            {
                                isEngaged = true;
                                if (highestEnmity < enmity_obj->second.CE + enmity_obj->second.VE)
                                {
                                    highestEnmity = enmity_obj->second.CE + enmity_obj->second.VE;
                                    PRegenTarget = PMember;
                                }
                            }
                        }
                        else
                        {
                            isEngaged = true; // Assume everyone is engaged if the target isn't a mob
                        }
                    }
                });
    }

    if (PRegenTarget &&
        !(PRegenTarget->StatusEffectContainer->HasStatusEffect(EFFECT_REGEN)))
        if (TryBestSpell(PRegenTarget->targid, SPELLFAMILY_REGEN))
            return true;

    return false;
}

bool CAutomatonController::TryEnhance()
{
    if (!PAutomaton->PMaster || m_enhanceCooldown == 0s || m_Tick <= m_LastEnhanceTime + m_enhanceCooldown)
        return false;

    if (!PAutomaton->PMaster->PParty)
        return false;

    if (ShouldProtectra())
    {
        if (TryBestSpell(PAutomaton->targid, SPELLFAMILY_PROTECTRA))
            return true;
    }

    if (ShouldShellra())
    {
        if (TryBestSpell(PAutomaton->targid, SPELLFAMILY_SHELLRA))
            return true;
    }

    bool casted = false;

    // Keep buffs up on self first if possible (Refresh / Protect / Shell)
    if (auto spell = autoSpell::GetBestEnhanceForTarget(PAutomaton, PAutomaton))
        casted = Cast(PAutomaton->targid, *spell);

    // Try to cast on party member tanking the current enemy
    static_cast<CCharEntity*>(PAutomaton->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
    {
        if (casted)
            return;

        if (distance(PAutomaton->loc.p, PMember->loc.p) > 20)
            return;

        if (!battleutils::IsTopEnmity(PMember, PMember->GetBattleTarget()))
            return;

        if (auto spell = autoSpell::GetBestEnhanceForTarget(PAutomaton, PMember))
            casted = Cast(PMember->targid, *spell);
    });

    // Didn't cast on a party member tanking the current enemy, cast on other party members
    if (!casted)
    {
        static_cast<CCharEntity*>(PAutomaton->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
        {
            if (casted)
                return;

            if (distance(PAutomaton->loc.p, PMember->loc.p) > 20)
                return;

            if (auto spell = autoSpell::GetBestEnhanceForTarget(PAutomaton, PMember))
                casted = Cast(PMember->targid, *spell);
        });
    }

    if (casted)
    {
        return true;
    }

    return false;
}

bool CAutomatonController::ShouldProtectra()
{
    auto memberMissingProtectra = 0;
    // clang-format off
    static_cast<CCharEntity*>(PAutomaton->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
    {
        if (!PMember->StatusEffectContainer->HasStatusEffect(EFFECT_PROTECT))
        {
            float distanceToMember = distance(PAutomaton->loc.p, PMember->loc.p);
            if (distanceToMember <= 10.0f)
            {
                memberMissingProtectra ++;
            }
        }
    });
    // clang-format on

    if (memberMissingProtectra >= 3)
    {
        return true;
    }

    return false;
}

bool CAutomatonController::ShouldShellra()
{
    auto memberMissingShellra = 0;
    // clang-format off
    static_cast<CCharEntity*>(PAutomaton->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
    {
        if (!PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SHELL))
        {
            float distanceToMember = distance(PAutomaton->loc.p, PMember->loc.p);
            if (distanceToMember <= 10.0f)
            {
                memberMissingShellra ++;
            }
        }
    });
    // clang-format on

    if (memberMissingShellra >= 3)
    {
        return true;
    }

    return false;
}

bool CAutomatonController::TrySing(const CurrentManeuvers& maneuvers)
{
    // TODO: Threnodies?
    if (!PAutomaton->PMaster || m_singCooldown == 0s || m_Tick <= m_LastSingTime + m_singCooldown)
        return false;

    std::vector<SPELLFAMILY> castPriority;
    std::vector<SPELLFAMILY> defaultPriority;

    // Finale Highest Priority
    bool finale = false;
    PTarget->StatusEffectContainer->ForEachEffect(
        [&finale](CStatusEffect* PStatus)
        {
            if (!finale && PStatus->GetDuration() > 0)
            {
                if (PStatus->GetFlag() & EFFECTFLAG_DISPELABLE)
                {
                    finale = true;
                    return;
                }
            }
        });

    if (finale)
    {
        if (Cast(PTarget->targid, SpellID::Magic_Finale))
            return true;
    }

    // Elegy 2nd highest priority
    if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_ELEGY))
    {
        if (auto spell = autoSpell::GetBestUsableSpell(PAutomaton, SPELLFAMILY_ELEGY))
        {
            if (autoSpell::CanUseEnfeeble(PTarget, *spell) && Cast(PTarget->targid, *spell))
                return true;
        }
    }

    // Buff Songs
    if (PAutomaton->StatusEffectContainer->GetTotalBuffSongCount() < 2)
    {
        // Wind -> March
        if (!PAutomaton->StatusEffectContainer->HasStatusEffect(EFFECT_MARCH))
            if (maneuvers.wind)
                castPriority.push_back(SPELLFAMILY_MARCH);
            else
                defaultPriority.push_back(SPELLFAMILY_MARCH);

        // Fire -> Minuet
        if (!PAutomaton->StatusEffectContainer->HasStatusEffect(EFFECT_MINUET))
        {
            if (maneuvers.fire)
            {
                castPriority.push_back(SPELLFAMILY_VALOR_MINUET);
            }
            else if (battleutils::GetHitRate(PAutomaton->PMaster, PTarget) >= 75)
            {
                defaultPriority.push_back(SPELLFAMILY_VALOR_MINUET);
            }
        }

        // Thunder -> Madrigal
        if (!PAutomaton->StatusEffectContainer->HasStatusEffect(EFFECT_MADRIGAL))
            if (maneuvers.thunder)
                castPriority.push_back(SPELLFAMILY_MADRIGAL);
            else
                defaultPriority.push_back(SPELLFAMILY_MADRIGAL);

        // Earth -> Minne
        if (!PAutomaton->StatusEffectContainer->HasStatusEffect(EFFECT_MINNE))
            if (maneuvers.earth)
                castPriority.push_back(SPELLFAMILY_KNIGHTS_MINNE);
            else
                defaultPriority.push_back(SPELLFAMILY_KNIGHTS_MINNE);

        // Dark -> Ballad
        if (!PAutomaton->StatusEffectContainer->HasStatusEffect(EFFECT_BALLAD))
            if (maneuvers.dark)
                castPriority.push_back(SPELLFAMILY_MAGES_BALLAD);
            else
                defaultPriority.push_back(SPELLFAMILY_MAGES_BALLAD);

        // Light -> Paeon
        if (!PAutomaton->StatusEffectContainer->HasStatusEffect(EFFECT_PAEON))
            if (maneuvers.light)
                castPriority.push_back(SPELLFAMILY_ARMYS_PAEON);
            else
                defaultPriority.push_back(SPELLFAMILY_ARMYS_PAEON);
    }


    for (SPELLFAMILY& id : castPriority)
        if (TryBestSpell(PAutomaton->targid, id))
            return true;

    for (SPELLFAMILY& id : defaultPriority)
        if (TryBestSpell(PAutomaton->targid, id))
            return true;

    // Foe Requiem lowest priority
    if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_REQUIEM))
    {
        if (auto spell = autoSpell::GetBestUsableSpell(PAutomaton, SPELLFAMILY_FOE_REQUIEM))
        {
            if (autoSpell::CanUseEnfeeble(PTarget, *spell) && Cast(PTarget->targid, *spell))
                return true;
        }
    }

    return false;
}

bool CAutomatonController::TryTPMove()
{
    if (PAutomaton->health.tp >= 1000)
    {
        auto* PChar = dynamic_cast<CCharEntity*>(PAutomaton->PMaster);
        if (!PChar)
            return false;

        const auto& FamilySkills = battleutils::GetMobSkillList(PAutomaton->m_Family);

        std::vector<CMobSkill*> validSkills;

        //load the skills that the automaton has access to with it's skill
        SKILLTYPE skilltype = SKILL_AUTOMATON_MELEE;

        if (PAutomaton->getFrame() == FRAME_SHARPSHOT)
            skilltype = SKILL_AUTOMATON_RANGED;

        for (auto skillid : FamilySkills)
        {
            auto PSkill = battleutils::GetMobSkill(skillid);
            auto skillLvl = PAutomaton->GetSkill(skilltype);
            int32 meritbonus = PChar->PMeritPoints->GetMeritValue(MERIT_AUTOMATON_SKILLS, PChar);

            if (skilltype == SKILL_AUTOMATON_MELEE)
                skillLvl += PChar->getMod(Mod::AUTO_MELEE_SKILL) + meritbonus;
            else
                skillLvl += PChar->getMod(Mod::AUTO_RANGED_SKILL) + meritbonus;

            if (PSkill && skillLvl > PSkill->getParam() && PSkill->getParam() != -1 &&
                distance(PAutomaton->loc.p, PTarget->loc.p) <= PSkill->getDistance())
            {
                validSkills.push_back(PSkill);
            }
        }

        int16 currentSkill = -1;
        CMobSkill* PWSkill = nullptr;
        int8 currentManeuvers = -1;

        // Inhibitor Attachment
        bool attemptChain = (PAutomaton->getMod(Mod::AUTO_TP_EFFICIENCY) != 0);

        if (attemptChain)
        {
            CStatusEffect* PSCEffect = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0);
            if (PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now())
            {
                std::list<SKILLCHAIN_ELEMENT> resonanceProperties;
                if (PSCEffect->GetStartTime() + 3s < m_Tick)
                {
                    if (uint16 power = PSCEffect->GetPower())
                    {
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power & 0xF));
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 4 & 0xF));
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 8));
                    }
                }

                for (auto PSkill : validSkills)
                {
                    if (PSkill->getParam() > currentSkill)
                    {
                        std::list<SKILLCHAIN_ELEMENT> skillProperties;
                        skillProperties.push_back((SKILLCHAIN_ELEMENT)PSkill->getPrimarySkillchain());
                        skillProperties.push_back((SKILLCHAIN_ELEMENT)PSkill->getSecondarySkillchain());
                        skillProperties.push_back((SKILLCHAIN_ELEMENT)PSkill->getTertiarySkillchain());
                        if (battleutils::FormSkillchain(resonanceProperties, skillProperties) != SC_NONE)
                        {
                            currentManeuvers = 1;
                            currentSkill = PSkill->getParam();
                            PWSkill = PSkill;
                        }
                    }
                }
            }
        }

        int16 tpThreshold = std::clamp<int16>(PAutomaton->getMod(Mod::AUTO_TP_EFFICIENCY), 0, 1000);
        bool targetHasSC = PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_SKILLCHAIN);
        bool shouldWeaponSkill = !targetHasSC && currentManeuvers == -1 && PAutomaton->PMaster && PAutomaton->PMaster->health.tp < tpThreshold;

        // If Inhibitor isn't equipped, use a TP move
        // If Inhibitor is equipped and masters TP >= 900, use a TP move
        // If My TP is >= 1500, use a TP move
        if (!attemptChain || shouldWeaponSkill || PAutomaton->health.tp >= 1500)
        {
            for (auto PSkill : validSkills)
            {
                int8 maneuvers = luautils::OnMobAutomatonSkillCheck(PTarget, PAutomaton, PSkill);
                if (maneuvers > -1 && (maneuvers > currentManeuvers || (maneuvers == currentManeuvers && PSkill->getParam() > currentSkill)))
                {
                    currentManeuvers = maneuvers;
                    currentSkill = PSkill->getParam();
                    PWSkill = PSkill;
                }
            }
        }

        // No WS was chosen (waiting on master's TP to skillchain probably)
        if (currentManeuvers == -1)
            return false;

        if (PWSkill)
            return MobSkill(PTarget->targid, PWSkill->getID());
    }
    return false;
}

bool CAutomatonController::TryRangedAttack()
{
    if (!PTarget)
        return false;

    if (PAutomaton->getFrame() == FRAME_SHARPSHOT)
    {
        float currentDistance = distance(PAutomaton->loc.p, PTarget->loc.p);
        if (currentDistance <= 25.0f)
        {
            if (m_rangedCooldown > 0s && m_Tick > m_LastRangedTime + (m_rangedCooldown - std::chrono::seconds(PAutomaton->getMod(Mod::AUTO_RANGED_DELAY))))
                return MobSkill(PTarget->targid, m_RangedAbility);
        }
    }

    return false;
}

bool CAutomatonController::TryAttachment()
{
    if (!PAutomaton->PAI->CanChangeState())
        return false;
    PAutomaton->PAI->EventHandler.triggerListener("AUTOMATON_ATTACHMENT_CHECK", PAutomaton, PTarget);
    return false;
}

bool CAutomatonController::CanCastSpells()
{
    // Check for spell blockers e.g. silence
    if (PAutomaton->StatusEffectContainer->HasStatusEffect({ EFFECT_SILENCE, EFFECT_MUTE }))
        return false;

    // Check if we can change states!
    return PAutomaton->PAI->CanChangeState();
}

bool CAutomatonController::Cast(uint16 targid, SpellID spellid)
{
    if (!autoSpell::CanUseSpell(PAutomaton, spellid) || PAutomaton->PRecastContainer->HasRecast(RECAST_MAGIC, static_cast<uint16>(spellid), 0))
        return false;

    return CPetController::Cast(targid, spellid);
}

bool CAutomatonController::MobSkill(uint16 targid, uint16 wsid)
{
    if (PAutomaton->PRecastContainer->HasRecast(RECAST_ABILITY, wsid, 0))
        return false;
    return CPetController::MobSkill(targid, wsid);
}

bool CAutomatonController::Disengage()
{
    PTarget = nullptr;
    return CMobController::Disengage();
}

namespace autoSpell
{
    std::unordered_map<SpellID, AutomatonSpell, EnumClassHash> autoSpellList;
    std::vector<SpellID> naSpells;

    void LoadAutomatonSpellList()
    {
        const char* Query = "SELECT spellid, skilllevel, heads, enfeeble, immunity, removes FROM automaton_spells;";

        int32 ret = Sql_Query(SqlHandle, Query);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                SpellID id = (SpellID)Sql_GetUIntData(SqlHandle, 0);
                AutomatonSpell PSpell {
                    (uint16)Sql_GetUIntData(SqlHandle, 1),
                    (uint8)Sql_GetUIntData(SqlHandle, 2),
                    (EFFECT)Sql_GetUIntData(SqlHandle, 3),
                    (IMMUNITY)Sql_GetUIntData(SqlHandle, 4)
                };

                uint32 removes = Sql_GetUIntData(SqlHandle, 5);
                while (removes > 0)
                {
                    PSpell.removes.push_back((EFFECT)(removes & 0xFF));
                    removes = removes >> 8;
                }

                if (!PSpell.removes.empty())
                {
                    naSpells.push_back(id);
                }

                autoSpellList[id] = std::move(PSpell);
            }
        }
    }

    bool CanUseSpell(CAutomatonEntity* PCaster, SpellID spellid)
    {
        const AutomatonSpell& PSpell = autoSpellList[spellid];
        return ((PCaster->GetSkill(SKILL_AUTOMATON_MAGIC) >= PSpell.skilllevel) && (PSpell.heads & (1 << ((uint8)PCaster->getHead() - 1))));
    }

    bool CanUseEnfeeble(CBattleEntity* PTarget, SpellID spell)
    {
        const AutomatonSpell& PSpell = autoSpellList[spell];
        auto& statuses = PTarget->StatusEffectContainer;
        return (!statuses->HasStatusEffect(PSpell.enfeeble) && !PTarget->hasImmunity(PSpell.immunity));
    }

    std::optional<SpellID> FindNaSpell(CStatusEffect* PStatus)
    {
        for (auto spell : naSpells)
        {
            const AutomatonSpell& PSpell = autoSpellList[spell];
            if (std::find(PSpell.removes.begin(), PSpell.removes.end(), PStatus->GetStatusID()) != PSpell.removes.end())
                return spell;
        }

        if (PStatus->GetFlag() & EFFECTFLAG_ERASABLE)
            return SpellID::Erase;
        else
            // TODO: -Wno-maybe-uninitialized - possible false positive (anonymous may be used)
            return {};
    }

    std::optional<SpellID> GetBestUsableSpell(CAutomatonEntity* PAutomaton, SPELLFAMILY family)
    {
        uint8 maxTier = 0;

        // Find highest tier learned and usable (ignoring recast)
        for (auto& [id, spellData] : autoSpellList)
        {
            CSpell* spell = spell::GetSpell(id);

            if (!CanUseSpell(PAutomaton, id))
                continue;

            if (family != SPELLFAMILY_NONE && spell->getSpellFamily() != family)
                continue;

            if (spell->getMPCost() > PAutomaton->health.mp)
                continue;

            maxTier = std::max(maxTier, static_cast<uint8>(spell->getTier()));
        }

        // Only allow that exact tier, and check recast
        for (auto& [id, spellData] : autoSpellList)
        {
            CSpell* spell = spell::GetSpell(id);

            if (!CanUseSpell(PAutomaton, id))
                continue;

            if (family != SPELLFAMILY_NONE && spell->getSpellFamily() != family)
                continue;

            if (spell->getTier() != maxTier)
                continue;

            if (PAutomaton->PRecastContainer->HasRecast(RECAST_MAGIC, static_cast<uint16>(id), 0))
                continue;

            return id;
        }

        // Highest tier exists but is on cooldown (or nothing available)
        return std::nullopt;
    }

    std::optional<SpellID> GetBestEnhanceForTarget(CAutomatonEntity* PAutomaton, CBattleEntity* PTarget)
    {
        std::unordered_map<EFFECT, SpellID> bestPerEffect;
        std::unordered_map<EFFECT, uint16> bestSkill;
        std::unordered_map<EFFECT, uint16> maxKnownSkill;

        // Build a list of highest tier of that spell family
        for (auto& [id, spellData] : autoSpellList)
        {
            CSpell* spell = spell::GetSpell(id);

            if (spell->getSkillType() != SKILL_ENHANCING_MAGIC)
                continue;

            if (!CanUseSpell(PAutomaton, id))
                continue;

            EFFECT effect = spell->getEffectForSpell(id);

            maxKnownSkill[effect] = std::max(maxKnownSkill[effect], spellData.skilllevel);
        }

        for (auto& [id, spellData] : autoSpellList)
        {
            CSpell* spell = spell::GetSpell(id);

            if (spell->getSkillType() != SKILL_ENHANCING_MAGIC)
                continue;

            if (!CanUseSpell(PAutomaton, id))
                continue;

            if (spell->getMPCost() > PAutomaton->health.mp)
                continue;

            if (PAutomaton->PRecastContainer->HasRecast(RECAST_MAGIC, static_cast<uint16>(id), 0))
                continue;

            EFFECT eff = spell->getEffectForSpell(id);

            // Only cast highest tier of that spell family learned
            if (spellData.skilllevel < maxKnownSkill[eff])
                continue;

            if (PTarget->StatusEffectContainer->HasStatusEffect(eff))
                continue;

            if (!IsBuffRelevantForJob(PAutomaton, eff, PTarget))
                continue;

            auto it = bestPerEffect.find(eff);
            if (it == bestPerEffect.end() || spellData.skilllevel > bestSkill[eff])
            {
                bestPerEffect[eff] = id;
                bestSkill[eff] = spellData.skilllevel;
            }
        }

        // Order of which to apply the buffs. i.e. haste/flurry is always first, then refresh
        static std::vector<EFFECT> priority = {
            EFFECT_HASTE, EFFECT_FLURRY_II, EFFECT_REFRESH, EFFECT_MULTI_STRIKES, EFFECT_PHALANX, EFFECT_PROTECT, EFFECT_SHELL,
            EFFECT_STONESKIN,
        };

        for (EFFECT eff : priority)
        {
            if (bestPerEffect.find(eff) != bestPerEffect.end())
                return bestPerEffect[eff];
        }

        return std::nullopt;
    }

    bool IsBuffRelevantForJob(CAutomatonEntity* PAutomaton, EFFECT effect, CBattleEntity* PTarget)
    {
        JOBTYPE job = PTarget->GetMJob();

        switch (effect)
        {
            case EFFECT_HASTE:
            case EFFECT_MULTI_STRIKES:
                return melee_jobs.find(job) != melee_jobs.end();

            case EFFECT_FLURRY_II:
                return job == JOB_RNG || job == JOB_COR;

            case EFFECT_REFRESH:
                return PTarget == PAutomaton || refresh_jobs.find(job) != refresh_jobs.end();

            case EFFECT_STONESKIN:
                return PTarget == PAutomaton->PMaster;

            case EFFECT_PHALANX:
                return battleutils::IsTopEnmity(PTarget, PTarget->GetBattleTarget());

            case EFFECT_PROTECT:
            case EFFECT_SHELL:
                return true;

            default:
                return false;
        }
    }
}

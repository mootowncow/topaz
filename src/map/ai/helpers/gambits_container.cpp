/*
===========================================================================

    Copyright (c) 2020 Project Topaz

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

    ---

    ADDITIONAL RESTRICTIONS PERTAINING TO ATTRIBUTION AND MISREPRESENTATION
    APPLY TO THIS SOFTWARE.

    ADDITIONAL PERMISSIONS MAY APPLY TO THIS SOFTWARE.

    You should have received a full copy of these additional terms included
    in a license along with this program. If not, see:
    <http://project-topaz.com/blob/release/LICENSE>

===========================================================================
*/

#include "gambits_container.h"

#include "../../ability.h"
#include "../../enmity_container.h"
#include "../../spell.h"
#include "../../mobskill.h"
#include "../../weapon_skill.h"
#include "../../ai/states/ability_state.h"
#include "../../ai/states/mobskill_state.h"
#include "../../ai/states/magic_state.h"
#include "../../ai/states/range_state.h"
#include "../../ai/states/weaponskill_state.h"
#include "../../utils/battleutils.h"
#include "../../utils/trustutils.h"

#include "../controllers/player_controller.h"
#include "../../weapon_skill.h"
#include "../../mob_modifier.h"
#include "../../items/item_weapon.h"

namespace gambits
{

// Validate gambit before it's inserted into the gambit list
// Check levels, etc.
void CGambitsContainer::AddGambit(Gambit_t gambit)
{
    TracyZoneScoped;

    bool available = true;
    for (auto& action : gambit.actions)
    {
        if (action.reaction == G_REACTION::MA && action.select == G_SELECT::SPECIFIC)
        {
            if (!spell::CanUseSpell(static_cast<CBattleEntity*>(POwner), static_cast<SpellID>(action.select_arg)))
            {
                //ShowDebug("%s cannot cast %u!\n", POwner->name, action.select_arg);
                available = false;
            }
        }
    }
    if (available)
    {
        gambits.push_back(gambit);
    }
}

void CGambitsContainer::Tick(time_point tick)
{
    TracyZoneScoped;

    auto* controller = static_cast<CTrustController*>(POwner->PAI->GetController());
    uint8 currentPartyPos = controller->GetPartyPosition();
    auto position_offset = static_cast<std::chrono::milliseconds>(currentPartyPos * 10);

    if ((tick + position_offset) < m_lastAction)
    {
        return;
    }

    if (POwner->PAI->PathFind->IsFollowingPath())
    {
        return;
    }

    if (POwner->StatusEffectContainer->HasPreventActionEffect(false))
    {
        return;
    }

    if (POwner->PAI->IsCurrentState<CAbilityState>() ||
        POwner->PAI->IsCurrentState<CRangeState>() ||
        POwner->PAI->IsCurrentState<CMagicState>() ||
        POwner->PAI->IsCurrentState<CWeaponSkillState>() ||
        POwner->PAI->IsCurrentState<CMobSkillState>())
    {
        return;
    }

    if (!POwner->PAI->CanChangeState())
    {
        return;
    }

    auto random_offset = static_cast<std::chrono::milliseconds>(tpzrand::GetRandomNumber(1000, 2500));
    m_lastAction = tick + random_offset;


    // Deal with TP skills before any gambits
    // TODO: Should this be its own special gambit?
    if (POwner->health.tp >= 1000 && TryTrustSkill())
    {
        return;
    }

    auto runPredicate = [&](Predicate_t& predicate) -> bool
    {
        auto isValidMember = [&](CBattleEntity* PPartyTarget) -> bool
        {
            return PPartyTarget->isAlive() && POwner->loc.zone == PPartyTarget->loc.zone && distance(POwner->loc.p, PPartyTarget->loc.p) <= 20.0f;
        };

        if (predicate.target == G_TARGET::SELF)
        {
            return CheckTrigger(POwner, predicate);
        }
        else if (predicate.target == G_TARGET::TARGET)
        {
            return CheckTrigger(POwner->GetBattleTarget(), predicate);
        }
        else if (predicate.target == G_TARGET::PARTY)
        {
            auto result = false;
            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
            {
                if (isValidMember(PMember) && CheckTrigger(PMember, predicate))
                {
                    result = true;
                }
            });
            return result;
        }
        else if (predicate.target == G_TARGET::MASTER)
        {
            return CheckTrigger(POwner->PMaster, predicate);
        }
        else if (predicate.target == G_TARGET::PARTY_DEAD)
        {
            auto result = false;
            // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (PMember->isDead())
                    {
                        result = true;
                    }
                });
            // clang-format on
            return result;
        }
        else if (predicate.target == G_TARGET::TANK)
        {
            auto result = false;
            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
            {
                if (isValidMember(PMember) && CheckTrigger(PMember, predicate) && (PMember->GetMJob() == JOB_PLD || PMember->GetMJob() == JOB_RUN))
                {
                    result = true;
                }
            });
            return result;
        }
        else if (predicate.target == G_TARGET::MELEE)
        {
            auto result = false;
            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
            {
                if (isValidMember(PMember) && CheckTrigger(PMember, predicate) && melee_jobs.find(PMember->GetMJob()) != melee_jobs.end())
                {
                    result = true;
                }
            });
            return result;
        }
        else if (predicate.target == G_TARGET::RANGED)
        {
            auto result = false;
            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
            {
                if (isValidMember(PMember) && CheckTrigger(PMember, predicate) && (PMember->GetMJob() == JOB_RNG || PMember->GetMJob() == JOB_COR))
                {
                    result = true;
                }
            });
            return result;
        }
        else if (predicate.target == G_TARGET::CASTER)
        {
            auto result = false;
            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
            {
                if (isValidMember(PMember) && CheckTrigger(PMember, predicate) && caster_jobs.find(PMember->GetMJob()) != caster_jobs.end())
                {
                    result = true;
                }
            });
            return result;
        }
        else if (predicate.target == G_TARGET::TOP_ENMITY)
        {
            auto result = false;
            if (auto PMob = dynamic_cast<CMobEntity*>(POwner->GetBattleTarget()))
            {
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(PMember) && CheckTrigger(PMember, predicate) && PMob->PEnmityContainer->GetHighestEnmity() == PMember)
                    {
                        result = true;
                    }
                });
            }
            return result;
        }
        else if (predicate.target == G_TARGET::CURILLA)
        {
            auto result = false;
            // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(PMember) && CheckTrigger(PMember, predicate))
                    {
                        auto name = PMember->name;
                        if (name == "curilla") // TODO: Unsure if this works
                        {
                            result = true;
                        }
                    }
                });
            // clang-format on
            return result;
        }
        else if (predicate.target == G_TARGET::PARTY_MULTI)
        {
            uint8 count = 0;
            // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(PMember) && CheckTrigger(PMember, predicate))
                    {
                        ++count;
                    }
                });
            // clang-format on
            return count > 1;
        }

        // Fallthrough
        return false;
    };

    // Didn't WS/MS, go for other Gambits
    for (auto gambit : gambits)
    {
        if (tick < gambit.last_used + std::chrono::seconds(gambit.retry_delay))
        {
            continue;
        }

        for (auto& action : gambit.actions)
        {
            // Make sure that the predicates remain true for each action in a gambit
            bool all_predicates_true = true;
            for (auto& predicate : gambit.predicates)
            {
                if (!runPredicate(predicate))
                {
                    all_predicates_true = false;
                }
            }
            if (!all_predicates_true) { break; }

            auto isValidMember = [this](CBattleEntity* PSettableTarget, CBattleEntity* PPartyTarget)
            {
                return !PSettableTarget && PPartyTarget->isAlive() && POwner->loc.zone == PPartyTarget->loc.zone && distance(POwner->loc.p, PPartyTarget->loc.p) <= 20.0f;
            };

            // TODO: This whole section is messy and bonkers
            // Try and extract target out the first predicate
            CBattleEntity* target = nullptr;
            if (gambit.predicates[0].target == G_TARGET::SELF)
            {
                POwner->StatusEffectContainer->DelStatusEffect(EFFECT_PIANISSIMO);
                target = CheckTrigger(POwner, gambit.predicates[0]) ? POwner : nullptr;
            }
            else if (gambit.predicates[0].target == G_TARGET::TARGET)
            {
                auto mob = POwner->GetBattleTarget();
                target = CheckTrigger(mob, gambit.predicates[0]) ? mob : nullptr;
            }
            else if (gambit.predicates[0].target == G_TARGET::PARTY)
            {
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]))
                    {
                        target = PMember;
                    }
                });
            }
            else if (gambit.predicates[0].target == G_TARGET::MASTER)
            {
                target = POwner->PMaster;
            }
            else if (gambit.predicates[0].target == G_TARGET::TANK)
            {
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]) && (PMember->GetMJob() == JOB_PLD || PMember->GetMJob() == JOB_RUN))
                    {
                        target = PMember;
                    }
                });
            }
            else if (gambit.predicates[0].target == G_TARGET::MELEE)
            {
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]) && melee_jobs.find(PMember->GetMJob()) != melee_jobs.end())
                    {
                        target = PMember;
                    }
                });
            }
            else if (gambit.predicates[0].target == G_TARGET::RANGED)
            {
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]) && (PMember->GetMJob() == JOB_RNG || PMember->GetMJob() == JOB_COR))
                    {
                        target = PMember;
                    }
                });
            }
            else if (gambit.predicates[0].target == G_TARGET::CASTER)
            {
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]) && caster_jobs.find(PMember->GetMJob()) != caster_jobs.end())
                    {
                        target = PMember;
                    }
                });
            }
            else if (gambit.predicates[0].target == G_TARGET::TOP_ENMITY)
            {
                if (auto PMob = dynamic_cast<CMobEntity*>(POwner->GetBattleTarget()))
                {
                    static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                    {
                        if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]) && PMob->PEnmityContainer->GetHighestEnmity() == PMember)
                        {
                            target = PMember;
                        }
                    });
                }
            }
            else if (gambit.predicates[0].target == G_TARGET::CURILLA)
            {
                // clang-format off
                    static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                    {
                        if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]))
                        {
                            auto name = PMember->name;
                            if (name == "curilla") // TODO: Unsure if this works
                            {
                                target = PMember;
                            }
                        }
                    });
                // clang-format on
            }

            if (!target)
            {
                break;
            }

            if (action.reaction == G_REACTION::RATTACK)
            {
                controller->RangedAttack(target->targid);
            }
            else if (action.reaction == G_REACTION::MA)
            {
                if (tick < controller->m_NextMagicTime)
                {
                    return;
                }


                if (action.select == G_SELECT::SPECIFIC)
                {
                    auto spell_id = POwner->SpellContainer->GetAvailable(static_cast<SpellID>(action.select_arg));
                    if (spell_id.has_value())
                    {
                        if (!POwner->SpellContainer->IsImmune(target, static_cast<SpellID>(spell_id.value())))
                        {
                            controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                            return;
                        }
                    }
                }
                else if (action.select == G_SELECT::HIGHEST)
                {
                    auto spell_id = POwner->SpellContainer->GetBestAvailable(static_cast<SPELLFAMILY>(action.select_arg));

                    if (spell_id.has_value())
                    {
                        SpellID PSpell = static_cast<SpellID>(spell_id.value());
                        auto spell = spell::GetSpell(PSpell);

                        if (spell)
                        {
                            SPELLFAMILY family = spell->getSpellFamily();

                            if (family == SPELLFAMILY_PROTECTRA)
                            {
                                if (!ShouldProtectra())
                                {
                                    spell_id = POwner->SpellContainer->GetBestAvailable(SPELLFAMILY_PROTECT);
                                }
                            }
                            else if (family == SPELLFAMILY_SHELLRA)
                            {
                                if (!ShouldShellra())
                                {
                                    spell_id = POwner->SpellContainer->GetBestAvailable(SPELLFAMILY_SHELL);
                                }
                            }

                            // After updating spell_id, ensure it still has a value
                            if (spell_id.has_value())
                            {
                                PSpell = static_cast<SpellID>(spell_id.value());
                                if (!POwner->SpellContainer->IsImmune(target, PSpell))
                                {
                                    controller->Cast(target->targid, PSpell);
                                    return;
                                }
                            }
                        }
                    }
                }
                else if (action.select == G_SELECT::LOWEST)
                {
                    //TODO
                    //auto spell_id = POwner->SpellContainer->GetWorstAvailable(static_cast<SPELLFAMILY>(gambit.action.select_arg));
                    //if (spell_id.has_value())
                    //{
                    //if (!POwner->SpellContainer->IsImmune(target, static_cast<SpellID>(spell_id.value())))
                    //    {
                    //        controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                    //        return;
                    //    }
                    //}
                }
                else if (action.select == G_SELECT::BEST_INDI)
                {
                    auto* PMaster = static_cast<CCharEntity*>(POwner->PMaster);
                    auto spell_id = POwner->SpellContainer->GetBestIndiSpell(PMaster);
                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, spell_id.value());
                        return;
                    }
                }
                else if (action.select == G_SELECT::ENTRUSTED)
                {
                    auto* PMaster = static_cast<CCharEntity*>(POwner->PMaster);
                    auto spell_id = POwner->SpellContainer->GetBestEntrustedSpell(PMaster);
                    target = PMaster;
                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, spell_id.value());
                        return;
                    }
                }
                else if (action.select == G_SELECT::BEST_AGAINST_TARGET)
                {
                    auto spell_id = POwner->SpellContainer->GetBestAgainstTargetWeakness(POwner, target);
                    if (spell_id.has_value())
                    {
                        if (!POwner->SpellContainer->IsImmune(target, spell_id.value()))
                        {
                            controller->Cast(target->targid, spell_id.value());
                            return;
                        }
                    }
                }
                else if (action.select == G_SELECT::STORM_DAY)
                {
                    auto spell_id = POwner->SpellContainer->GetStormDay();
                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, spell_id.value());
                        return;
                    }
                }
                else if (action.select == G_SELECT::HELIX_DAY)
                {
                    auto spell_id = POwner->SpellContainer->GetHelixDay(POwner);
                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, spell_id.value());
                        return;
                    }
                }
                else if (action.select == G_SELECT::STORM_WEAKNESS)
                {
                    auto PTarget = POwner->GetBattleTarget();
                    if (PTarget)
                    {
                        auto spell_id = POwner->SpellContainer->StormWeakness(POwner, PTarget);
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
                            return;
                        }
                    }
                }
                else if (action.select == G_SELECT::HELIX_WEAKNESS)
                {
                    auto spell_id = POwner->SpellContainer->HelixWeakness(POwner, target);
                    if (spell_id.has_value())
                    {
                        if (!POwner->SpellContainer->IsImmune(target, spell_id.value()))
                        {
                            controller->Cast(target->targid, spell_id.value());
                            return;
                        }
                    }
                }
                else if (action.select == G_SELECT::RANDOM)
                {
                    auto spell_id = POwner->SpellContainer->GetSpell();
                    if (spell_id.has_value())
                    {
                        if (!POwner->SpellContainer->IsImmune(target, static_cast<SpellID>(spell_id.value())))
                        {
                            controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                            return;
                        }
                    }
                }
                else if (action.select == G_SELECT::MB_ELEMENT)
                {
                    CStatusEffect* PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0);
                    std::list<SKILLCHAIN_ELEMENT> resonanceProperties;
                    if (uint16 power = PSCEffect->GetPower())
                    {
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power & 0xF));
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 4 & 0xF));
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 8));
                    }

                    std::optional<SpellID> spell_id;
                    for (auto& resonance_element : resonanceProperties)
                    {
                        for (auto& chain_element : battleutils::GetSkillchainMagicElement(resonance_element))
                        {
                            // TODO: SpellContianer->GetBestByElement(ELEMENT)
                            // NOTE: Iterating this list in reverse guarantees finding the best match
                            for (size_t i = POwner->SpellContainer->m_damageList.size(); i > 0 ; --i)
                            {
                                auto spell = POwner->SpellContainer->m_damageList[i-1];
                                auto spell_element = spell::GetSpell(spell)->getElement();
                                if (spell_element == chain_element)
                                {
                                    spell_id = spell;
                                    break;
                                }
                            }
                        }
                    }

                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                        return;
                    }
                }
            }
            else if (action.reaction == G_REACTION::JA)
            {
                CAbility* PAbility = ability::GetAbility(action.select_arg);
                auto mLevel = POwner->GetMLevel();

                if (action.select == G_SELECT::HIGHEST_WALTZ)
                {
                    auto currentTP = POwner->health.tp;

                    // clang-format off
                        ABILITY wlist[5] =
                        {
                            ABILITY_CURING_WALTZ_V,
                            ABILITY_CURING_WALTZ_IV,
                            ABILITY_CURING_WALTZ_III,
                            ABILITY_CURING_WALTZ_II,
                            ABILITY_CURING_WALTZ,
                        };
                    // clang-format on

                    for (ABILITY const& waltz : wlist)
                    {
                        auto waltzLevel = ability::GetAbility(waltz)->getLevel();
                        uint16 tpCost = 0;

                        if (mLevel >= waltzLevel)
                        {
                            switch (ability::GetAbility(waltz)->getID())
                            {
                                case ABILITY_CURING_WALTZ_V:
                                    tpCost = 800;
                                    break;
                                case ABILITY_CURING_WALTZ_IV:
                                    tpCost = 650;
                                    break;
                                case ABILITY_CURING_WALTZ_III:
                                    tpCost = 500;
                                    break;
                                case ABILITY_CURING_WALTZ_II:
                                    tpCost = 350;
                                    break;
                                case ABILITY_CURING_WALTZ:
                                    tpCost = 200;
                                    break;
                                default:
                                    break;
                            }

                            if (tpCost != 0 && currentTP >= tpCost)
                            {
                                PAbility = ability::GetAbility(waltz);
                                controller->Ability(target->targid, PAbility->getID());
                            }
                        }
                    }
                }

                if (action.select == G_SELECT::LOWEST_WALTZ)
                                {
                                    auto currentTP = POwner->health.tp;

                                    // clang-format off
                    ABILITY wlist[5] =
                    {
                        ABILITY_CURING_WALTZ,
                        ABILITY_CURING_WALTZ_II,
                        ABILITY_CURING_WALTZ_III,
                        ABILITY_CURING_WALTZ_IV,
                        ABILITY_CURING_WALTZ_V,
                    };
                    // clang-format on

                    for (ABILITY const& waltz : wlist)
                    {
                        auto waltzLevel = ability::GetAbility(waltz)->getLevel();
                        uint16 tpCost = 0;

                        if (mLevel >= waltzLevel)
                        {
                            switch (ability::GetAbility(waltz)->getID())
                            {
                                case ABILITY_CURING_WALTZ:
                                    tpCost = 200;
                                    break;
                                case ABILITY_CURING_WALTZ_II:
                                    tpCost = 350;
                                    break;
                                case ABILITY_CURING_WALTZ_III:
                                    tpCost = 500;
                                    break;
                                case ABILITY_CURING_WALTZ_IV:
                                    tpCost = 650;
                                    break;
                                case ABILITY_CURING_WALTZ_V:
                                    tpCost = 800;
                                    break;
                                default:
                                    break;
                            }

                            if (tpCost != 0 && currentTP >= tpCost)
                            {
                                PAbility = ability::GetAbility(waltz);
                                controller->Ability(target->targid, PAbility->getID());
                                break;
                            }
                        }
                    }
                }


                if (PAbility->getValidTarget() == TARGET_SELF)
                {
                    target = POwner;
                }
                else
                {
                    target = POwner->GetBattleTarget();
                }

                if (action.select == G_SELECT::SPECIFIC)
                {
                    controller->Ability(target->targid, PAbility->getID());
                }

                if (action.select == G_SELECT::BEST_SAMBA)
                {
                    auto currentTP = POwner->health.tp;
                    uint16 tpCost = 0;

                    if (mLevel >= 5)
                    {
                        if (mLevel > 65)
                        {
                            if (PartyHasHealer())
                            {
                                PAbility = ability::GetAbility(ABILITY_HASTE_SAMBA);
                                tpCost = 350;
                            }
                            else
                            {
                                PAbility = ability::GetAbility(ABILITY_DRAIN_SAMBA_III);
                                tpCost = 400;
                            }
                        }
                        else if (mLevel < 65 && mLevel > 45)
                        {
                            if (PartyHasHealer())
                            {
                                PAbility = ability::GetAbility(ABILITY_HASTE_SAMBA);
                                tpCost = 350;
                            }
                            else
                            {
                                PAbility = ability::GetAbility(ABILITY_DRAIN_SAMBA_II);
                                tpCost = 250;
                            }
                        }
                        else if (mLevel < 45 && mLevel > 35)
                        {
                            PAbility = ability::GetAbility(ABILITY_DRAIN_SAMBA_II);
                            tpCost = 250;
                        }
                        else
                        {
                            PAbility = ability::GetAbility(ABILITY_DRAIN_SAMBA);
                            tpCost = 100;
                        }
                    }

                    if (tpCost != 0 && (currentTP >= tpCost))
                    {
                        controller->Ability(target->targid, PAbility->getID());
                        return;
                    }
                }
            }
            else if (action.reaction == G_REACTION::MSG)
            {
                if (action.select == G_SELECT::SPECIFIC)
                {
                    //trustutils::SendTrustMessage(POwner, action.select_arg);
                }
            }

            // Assume success
            if (gambit.retry_delay != 0)
            {
                gambit.last_used = tick;
            }
        }
    }
}

bool CGambitsContainer::CheckTrigger(CBattleEntity* trigger_target, Predicate_t& predicate)
{
    TracyZoneScoped;

    auto controller = static_cast<CTrustController*>(POwner->PAI->GetController());
    switch (predicate.condition)
    {
        case G_CONDITION::ALWAYS:
        {
            return true;
            break;
        }
        case G_CONDITION::HPP_LT:
        {
            return trigger_target->GetHPP() < predicate.condition_arg;
            break;
        }
        case G_CONDITION::HPP_GTE:
        {
            return trigger_target->GetHPP() >= predicate.condition_arg;
            break;
        }
        case G_CONDITION::MPP_LT:
        {
            return trigger_target->GetMPP() < predicate.condition_arg;
            break;
        }
        case G_CONDITION::TP_LT:
        {
            return trigger_target->health.tp < (int16)predicate.condition_arg;
            break;
        }
        case G_CONDITION::TP_GTE:
        {
            return trigger_target->health.tp >= (int16)predicate.condition_arg;
            break;
        }
        case G_CONDITION::STATUS:
        {
            return trigger_target->StatusEffectContainer->HasStatusEffect(static_cast<EFFECT>(predicate.condition_arg));
            break;
        }
        case G_CONDITION::NOT_STATUS:
        {
            return !trigger_target->StatusEffectContainer->HasStatusEffect(static_cast<EFFECT>(predicate.condition_arg));
            break;
        }
        case G_CONDITION::NO_SAMBA:
        {
            bool noSamba = true;
            if (trigger_target->StatusEffectContainer->HasStatusEffect(EFFECT_DRAIN_SAMBA) ||
                trigger_target->StatusEffectContainer->HasStatusEffect(EFFECT_HASTE_SAMBA))
            {
                noSamba = false;
            }
            return noSamba;
            break;
        }
        case G_CONDITION::NO_STORM:
        {
            bool noStorm = true;
            // clang-format off
                if (trigger_target->StatusEffectContainer->HasStatusEffect(
                {
                    EFFECT_FIRESTORM,
                    EFFECT_HAILSTORM,
                    EFFECT_WINDSTORM,
                    EFFECT_SANDSTORM,
                    EFFECT_THUNDERSTORM,
                    EFFECT_RAINSTORM,
                    EFFECT_AURORASTORM,
                    EFFECT_VOIDSTORM,
                    EFFECT_FIRESTORM_II,
                    EFFECT_HAILSTORM_II,
                    EFFECT_WINDSTORM_II,
                    EFFECT_SANDSTORM_II,
                    EFFECT_THUNDERSTORM_II,
                    EFFECT_RAINSTORM_II,
                    EFFECT_AURORASTORM_II,
                    EFFECT_VOIDSTORM_II,
                }))
                {
                    noStorm = false;
                }
            // clang-format on
            return noStorm;
            break;
        }
        case G_CONDITION::PT_HAS_TANK:
        {
            return PartyHasTank();
            break;
        }
        case G_CONDITION::NOT_PT_HAS_TANK:
        {
            return !PartyHasTank();
            break;
        }
        case G_CONDITION::PT_HAS_WHM:
        {
            return PartyHasWHM();
            break;
        }
        case G_CONDITION::PROTECTRA:
        {
            return PartyHasWHM();
            break;
        }
        case G_CONDITION::SHELLRA:
        {
            return PartyHasWHM();
            break;
        }
        case G_CONDITION::STATUS_FLAG:
        {
            return trigger_target->StatusEffectContainer->HasStatusEffectByFlag(static_cast<EFFECTFLAG>(predicate.condition_arg));
            break;
        }
        case G_CONDITION::HAS_TOP_ENMITY:
        {
            return (controller->GetTopEnmity()) ? controller->GetTopEnmity()->targid == POwner->targid : false;
            break;
        }
        case G_CONDITION::NOT_HAS_TOP_ENMITY:
        {
            return (controller->GetTopEnmity()) ? controller->GetTopEnmity()->targid != POwner->targid : false;
            break;
        }
        case G_CONDITION::SC_AVAILABLE:
        {
            auto PSCEffect = trigger_target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
            return PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now() && PSCEffect->GetTier() == 0;
            break;
        }
        case G_CONDITION::NOT_SC_AVAILABLE:
        {
            auto PSCEffect = trigger_target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
            return PSCEffect == nullptr;
            break;
        }
        case G_CONDITION::MB_AVAILABLE:
        {
            auto PSCEffect = trigger_target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
            return PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now() && PSCEffect->GetTier() > 0;
            break;
        }
        case G_CONDITION::READYING_WS:
        {
            if (IsStunImmune(trigger_target))
            {
                return false;
            }

            return trigger_target->PAI->IsCurrentState<CWeaponSkillState>();
            break;
        }
        case G_CONDITION::READYING_MS:
        {
            if (IsStunImmune(trigger_target))
            {
                return false;
            }

            CState* currentState = trigger_target->PAI->GetCurrentState();
            if (currentState)
            {
                // Attempt to cast to CMobSkillState
                CMobSkillState* msState = dynamic_cast<CMobSkillState*>(currentState);
                if (msState)
                {
                    CMobSkill* skill = msState->GetSkill();
                    if (skill)
                    {
                        bool isTwoHour              = skill->isTwoHour();
                        bool isJobAbility           = skill->isJobAbility();
                        bool isAttackReplacement    = skill->isAttackReplacement();
                        bool isSpecial              = skill->isSpecial();
                        if (!isTwoHour && !isJobAbility && !isAttackReplacement && !isSpecial)
                        {
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    }
                }
            }

            return false;
            break;
        }

        case G_CONDITION::READYING_JA:
        {
            if (IsStunImmune(trigger_target))
            {
                return false;
            }

            return trigger_target->PAI->IsCurrentState<CAbilityState>();
            break;
        }
        case G_CONDITION::CASTING_MA:
        {
            if (IsStunImmune(trigger_target))
            {
                return false;
            }

            // Only interrupt -ga/cures/severe spells
            CState* currentState = trigger_target->PAI->GetCurrentState();
            if (currentState)
            {
                // Attempt to cast to CMagicState
                CMagicState* maState = dynamic_cast<CMagicState*>(currentState);
                if (maState)
                {
                    CSpell* spell = maState->GetSpell();
                    if (spell)
                    {
                        bool isAOE = false;
                        bool isHeal = spell->isHeal();
                        bool isSevere = spell->isSevere();
                        uint8 aoe = battleutils::GetSpellAoEType(trigger_target, spell);
                        if (aoe > 0) { isAOE = true; }

                        if (isAOE || isHeal || isSevere)
                        {
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    }
                }
            }
            break;
        }
        case G_CONDITION::CASTING_SPECIFIC:
        {
            CState* currentState = trigger_target->PAI->GetCurrentState();
            if (currentState)
            {
                // Attempt to cast to CMagicState
                CMagicState* maState = dynamic_cast<CMagicState*>(currentState);
                if (maState)
                {
                    CSpell* spell = maState->GetSpell();
                    if (spell)
                    {
                        if (spell->getID() == static_cast<SpellID>(predicate.condition_arg))
                        {
                            return true;
                        }
                    }
                }
            }
            return false;
            break;
        }
        case G_CONDITION::IS_ECOSYSTEM:
        {
            return trigger_target->m_EcoSystem == ECOSYSTEM(predicate.condition_arg);
            break;
        }
        case G_CONDITION::CAN_DRAIN:
        {
            if (trigger_target->m_EcoSystem == SYSTEM_UNDEAD)
            {
                return false;
            }
            return POwner->GetHPP() <= predicate.condition_arg;
            break;
        }
        case G_CONDITION::CAN_ASPIR:
        {
            if (trigger_target->m_EcoSystem == SYSTEM_UNDEAD)
            {
                return false;
            }
            if (trigger_target->health.mp == 0)
            {
                return false;
            }
            return POwner->GetMPP() <= predicate.condition_arg;
            break;
        }
        case G_CONDITION::REFRESH:
        {
            if (trigger_target->StatusEffectContainer->HasStatusEffect({ EFFECT_REFRESH, EFFECT_SUBLIMATION_ACTIVATED, EFFECT_SUBLIMATION_COMPLETE }))
            {
                return false;
            }
            return true;
            break;
        }
        case G_CONDITION::DETECT_MIJIN:
        {
            for (int i = 1; i <= 99; ++i)
            {
                std::string ability_key = "[jobSpecial]ability_" + std::to_string(i);
                std::string hpp_key = "[jobSpecial]hpp_" + std::to_string(i);
                std::string cooldown_key = "[jobSpecial]cooldown_" + std::to_string(i);

                if (trigger_target->GetLocalVar(ability_key.c_str()) == 731)
                {
                    int32 hp_Trigger = trigger_target->GetLocalVar(hpp_key.c_str());
                    hp_Trigger += 5;
                    if (trigger_target->GetHPP() <= hp_Trigger)
                    {
                        if (trigger_target->GetLocalVar(cooldown_key.c_str()) == 0)
                        {
                            return true;
                        }
                    }
                }
            }

            return false;
            break;
        }
        case G_CONDITION::RESISTS_DMGTYPE:
        {
            return trigger_target->getMod(static_cast<Mod>(predicate.condition_arg)) < 1000;
            break;
        }
        case G_CONDITION::CAN_SNEAK_ATTACK:
        {
            return CanSneakAttack();
            break;
        }
        case G_CONDITION::RANDOM:
        {
            return tpzrand::GetRandomNumber<uint16>(100) < (int16)predicate.condition_arg;
            break;
        }
        case G_CONDITION::HP_MISSING:
        {
            return (trigger_target->health.maxhp - trigger_target->health.hp) >= (int16)predicate.condition_arg;
            break;
        }
        default: { return false;  break; }
    }
}

bool CGambitsContainer::TryTrustSkill()
{
    TracyZoneScoped;

    auto target = POwner->GetBattleTarget();

    auto checkTPTrigger = [&]() -> bool
    {
        auto tpThreshold = POwner->getMobMod(MOBMOD_TP_USE);
        if (tpThreshold > 0 && POwner->health.tp >= tpThreshold) { return true; } // Go, go, go!
        if (POwner->health.tp >= 3000) { return true; } // Go, go, go!

        switch (tp_trigger)
        {
        case G_TP_TRIGGER::ASAP:
        {
            return true;
            break;
        }
        case G_TP_TRIGGER::OPENER:
        {
            bool result = false;
            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&result](CBattleEntity* PMember)
            {
                if (PMember->health.tp >= 1000)
                {
                    result = true;
                }
            });
            return result;
            break;
        }
        case G_TP_TRIGGER::CLOSER:
        {
            auto PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);

            // TODO: ...and has a valid WS...

            return PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now() && PSCEffect->GetTier() == 0;
            break;
        }
        case G_TP_TRIGGER::CLOSER_UNTIL_TP: // Will hold TP to close a SC, but WS immediately once specified value is reached.
        {
            if (tp_value <= 1500) // If the value provided by the script is missing or too low
            {
                tp_value = 1500; // Apply the minimum TP Hold Threshold
            }
            if (POwner->health.tp >= tp_value) // tp_value reached
            {
                return true; // Time to WS!
            }
            auto* PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);

            // TODO: ...and has a valid WS...

            return PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now() && PSCEffect->GetTier() == 0;
            break;
        }
        default:
        {
            return false;
            break;
        }
        }
    };

    std::optional<TrustSkill_t> chosen_skill;
    SKILLCHAIN_ELEMENT chosen_skillchain = SC_NONE;
    if (checkTPTrigger() && !tp_skills.empty())
    {
        switch (tp_select)
        {
            case G_SELECT::RANDOM:
            {
                chosen_skill = tpzrand::GetRandomElement(tp_skills);
                break;
            }
            case G_SELECT::HIGHEST: // Form the best possible skillchain
            {
                auto PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);

                if (!PSCEffect) // Opener
                {
                    // TODO: This relies on the skills being passed in in some kind of correct order...
                    // Probably best to do this another way
                    chosen_skill = tp_skills.at(tp_skills.size() - 1);
                    break;
                }

                // Closer
                for (auto& skill : tp_skills)
                {
                    std::list<SKILLCHAIN_ELEMENT> resonanceProperties;
                    if (uint16 power = PSCEffect->GetPower())
                    {
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power & 0xF));
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 4 & 0xF));
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 8));
                    }

                    std::list<SKILLCHAIN_ELEMENT> skillProperties;
                    skillProperties.push_back((SKILLCHAIN_ELEMENT)skill.primary);
                    skillProperties.push_back((SKILLCHAIN_ELEMENT)skill.secondary);
                    skillProperties.push_back((SKILLCHAIN_ELEMENT)skill.tertiary);
                    if (SKILLCHAIN_ELEMENT possible_skillchain = battleutils::FormSkillchain(resonanceProperties, skillProperties); possible_skillchain != SC_NONE)
                    {
                        if (possible_skillchain >= chosen_skillchain)
                        {
                            chosen_skill = skill;
                            chosen_skillchain = possible_skillchain;
                        }
                    }
                }
                break;
            }
            case G_SELECT::SPECIAL_AYAME:
            {
                auto PMaster = static_cast<CCharEntity*>(POwner->PMaster);
                auto PMasterController = static_cast<CPlayerController*>(PMaster->PAI->GetController());
                auto PMasterLastWeaponSkill = PMasterController->getLastWeaponSkill();

                if (PMasterLastWeaponSkill != nullptr)
                {
                    for (auto& skill : tp_skills)
                    {
                        std::list<SKILLCHAIN_ELEMENT> resonanceProperties;
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)PMasterLastWeaponSkill->getPrimarySkillchain());
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)PMasterLastWeaponSkill->getSecondarySkillchain());
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)PMasterLastWeaponSkill->getTertiarySkillchain());

                        std::list<SKILLCHAIN_ELEMENT> skillProperties;
                        skillProperties.push_back((SKILLCHAIN_ELEMENT)skill.primary);
                        skillProperties.push_back((SKILLCHAIN_ELEMENT)skill.secondary);
                        skillProperties.push_back((SKILLCHAIN_ELEMENT)skill.tertiary);
                        if (SKILLCHAIN_ELEMENT possible_skillchain = battleutils::FormSkillchain(resonanceProperties, skillProperties); possible_skillchain != SC_NONE)
                        {
                            if (possible_skillchain >= chosen_skillchain)
                            {
                                chosen_skill = skill;
                                chosen_skillchain = possible_skillchain;
                            }
                        }
                    }
                }
                else
                {
                    chosen_skill = tp_skills.at(tp_skills.size() - 1);
                }

                break;
            }
            default: { break; }
        }
    }

    if (chosen_skill)
    {
        auto controller = static_cast<CTrustController*>(POwner->PAI->GetController());
        float currentDistance = distance(POwner->loc.p, target->loc.p);
        auto isMelee = melee_jobs.find(POwner->GetMJob()) != melee_jobs.end();
        auto isRanged = POwner->GetMJob() == JOB_RNG || POwner->GetMJob() == JOB_COR;
        auto isCaster = caster_jobs.find(POwner->GetMJob()) != caster_jobs.end();

        if (POwner->StatusEffectContainer->HasStatusEffect({ EFFECT_AMNESIA, EFFECT_IMPAIRMENT }))
        {
            return false;
        }

        if (chosen_skill->skill_type == G_REACTION::WS)
        {
            CWeaponSkill* PWeaponSkill = battleutils::GetWeaponSkill(chosen_skill->skill_id);
            if (battleutils::isValidSelfTargetWeaponskill(PWeaponSkill->getID()))
            {
                target = POwner;
            }
            else
            {
                target = POwner->GetBattleTarget();
            }

            // Melee jobs shouldn't MS/WS into Perfect Dodge
            if (isMelee && target->StatusEffectContainer->HasStatusEffect(EFFECT_PERFECT_DODGE))
            {
                return false;
            }

            // Melee and Ranged jobs shouldn't MS/WS into Invincible
            if ((isMelee || isRanged) && target->StatusEffectContainer->HasStatusEffect(EFFECT_INVINCIBLE))
            {
                return false;
            }

            // Caster jobs shouldn't MS/WS into Elemental Sforzo or Magic Immunity
            if (isCaster)
            {
                if (target->StatusEffectContainer->HasStatusEffect(EFFECT_ELEMENTAL_SFORZO))
                {
                    return false;
                }

                if (target->StatusEffectContainer->HasStatusEffect(EFFECT_MAGIC_SHIELD))
                {
                    CStatusEffect* magicShield = target->StatusEffectContainer->GetStatusEffect(EFFECT_MAGIC_SHIELD, 0);
                    uint16 magicShieldPower = magicShield->GetPower();

                    if (magicShieldPower < 2)
                    {
                        return false;
                    }
                }
            }

            if (currentDistance <= (static_cast<float>(PWeaponSkill->getRange())))
            {
                int16 tp = POwner->health.tp;
                // Add Fencer TP Bonus
                CTrustEntity* PTrust = static_cast<CTrustEntity*>(POwner);
                CItemWeapon* PMain = dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_MAIN]);
                if (PMain && !PMain->isTwoHanded() && !PMain->isHandToHand())
                {
                    if (!PTrust->m_dualWield)
                    {
                        tp += PTrust->getMod(Mod::FENCER_TP_BONUS);
                    }
                }
                tp = std::min(static_cast<int>(tp), 3000);
                POwner->SetLocalVar("tp", tp);
                controller->WeaponSkill(target->targid, PWeaponSkill->getID());
            }
            else
            {
                return false;
            }
        }
        else // Mobskill
        {
            CMobSkill* skill = battleutils::GetMobSkill(chosen_skill->skill_id);
            if (skill->getValidTargets() == TARGET_SELF) // self
            {
                target = POwner;
            }
            else if (skill->getValidTargets() == TARGET_ENEMY) // enemy
            {
                target = POwner->GetBattleTarget();
            }

            // Melee jobs shouldn't MS/WS into Perfect Dodge
            if (isMelee && target->StatusEffectContainer->HasStatusEffect(EFFECT_PERFECT_DODGE))
            {
                return false;
            }

            // Melee and Ranged jobs shouldn't MS/WS into Invincible
            if ((isMelee || isRanged) && target->StatusEffectContainer->HasStatusEffect(EFFECT_INVINCIBLE))
            {
                return false;
            }

            // Caster jobs shouldn't MS/WS into Elemental Sforzo or Magic Immunity
            if (isCaster)
            {
                if (target->StatusEffectContainer->HasStatusEffect(EFFECT_ELEMENTAL_SFORZO))
                {
                    return false;
                }

                if (target->StatusEffectContainer->HasStatusEffect(EFFECT_MAGIC_SHIELD))
                {
                    CStatusEffect* magicShield = target->StatusEffectContainer->GetStatusEffect(EFFECT_MAGIC_SHIELD, 0);
                    uint16 magicShieldPower = magicShield->GetPower();

                    if (magicShieldPower < 2)
                    {
                        return false;
                    }
                }
            }

            if (currentDistance <= (skill->getDistance()))
            {
                int16 tp = POwner->health.tp;
                // Add Fencer TP Bonus
                CTrustEntity* PTrust = static_cast<CTrustEntity*>(POwner);
                CItemWeapon* PMain = dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_MAIN]);
                if (PMain && !PMain->isTwoHanded() && !PMain->isHandToHand())
                {
                    if (!PTrust->m_dualWield)
                    {
                        tp += PTrust->getMod(Mod::FENCER_TP_BONUS);
                    }
                }
                tp = std::min(static_cast<int>(tp), 3000);
                POwner->SetLocalVar("tp", tp);

                // Set message for "Player" and Fomor TP moves, and Prishe/Tenzen TP moves
                if (skill && skill->isReadiesException())
                {
                    POwner->loc.zone->PushPacket(POwner, CHAR_INRANGE, new CMessageBasicPacket(POwner, target, 0, skill->getID(), MSGBASIC_READIES_WS));
                }
                controller->MobSkill(target->targid, chosen_skill->skill_id);
            }
            else
            {
                return false;
            }
        }
        return true;
    }
    return false;
}

    // currently only used for Uka Totlihn to determin what samba to use.
    bool CGambitsContainer::PartyHasHealer()
    {
        bool hasHealer = false;
        // clang-format off
            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
            {
                auto jobType = PMember->GetMJob();

                if (jobType == JOB_WHM || jobType == JOB_RDM || jobType == JOB_PLD || jobType == JOB_SCH)
                {
                    hasHealer = true;
                }
            });
        // clang-format on
        return hasHealer;
    }
    // used to check for tanks in party (Volker, AA Hume)
    bool CGambitsContainer::PartyHasTank()
    {
        bool hasTank = false;
        // clang-format off
            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
            {
                auto jobType = PMember->GetMJob();

                if (jobType == JOB_NIN || jobType == JOB_PLD || jobType == JOB_RUN)
                {
                    hasTank = true;
                }
            });
        // clang-format on
        return hasTank;
    }

    // used to check if party has a WHM
    bool CGambitsContainer::PartyHasWHM()
    {
        bool hasWHM = false;
        // clang-format off
            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
            {
                auto jobType = PMember->GetMJob();

                if (jobType == JOB_WHM)
                {
                    hasWHM = true;
                }
            });
        // clang-format on
        return hasWHM;
    }

    // Sneak Attack will land
    bool CGambitsContainer::CanSneakAttack()
    {
        bool canSA = false;
        auto PTarget = POwner->GetBattleTarget();
        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DOUBT))
        {
            canSA = true;
        }
        if (behind(POwner->loc.p, PTarget->loc.p, 64))
        {
            canSA = true;
        }
        return canSA;
    }

    bool CGambitsContainer::ShouldProtectra()
    {
        auto memberMissingProtectra = 0;
        // clang-format off
        static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
        {
            if (!PMember->StatusEffectContainer->HasStatusEffect(EFFECT_PROTECT))
            {
                float distanceToMember = distance(POwner->loc.p, PMember->loc.p);
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

    bool CGambitsContainer::ShouldShellra()
    {
        auto memberMissingShellra = 0;
        // clang-format off
        static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
        {
            if (!PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SHELL))
            {
                float distanceToMember = distance(POwner->loc.p, PMember->loc.p);
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

    bool CGambitsContainer::IsStunImmune(CBattleEntity* trigger_target)
    {
        if (trigger_target->getMod(Mod::EEM_STUN) <= 5)
        {
            return true;
        }

        if (trigger_target->hasImmunity(IMMUNITY_STUN))
        {
            return true;
        }

        return false;
    }

} // namespace gambits
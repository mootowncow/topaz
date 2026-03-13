/*
===========================================================================

Copyright (c) 2018 Darkstar Dev Teams

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

#include "trust_controller.h"
#include "player_controller.h"

#include "../../ability.h"
#include "../ai_container.h"
#include "../../status_effect_container.h"
#include "../../enmity_container.h"
#include "../../ai/states/despawn_state.h"
#include "../../ai/states/ability_state.h"
#include "../../ai/states/mobskill_state.h"
#include "../../ai/states/magic_state.h"
#include "../../ai/states/range_state.h"
#include "../../ai/states/weaponskill_state.h"
#include "../../ai/states/item_state.h"
#include "../../ai/helpers/gambits_container.h"
#include "../../entities/charentity.h"
#include "../../entities/trustentity.h"
#include "../../packets/char.h"
#include "../../recast_container.h"
#include "../../mob_spell_container.h"
#include "../../ai/states/magic_state.h"
#include "../../ai/states/range_state.h"
#include "../../items/item_weapon.h"
#include "../../mob_modifier.h"
#include "../../item_container.h"

namespace
{
    enum TRUST_MOVEMENT_TYPE
    {
        // NOTE: If you need to add special movement types, add descending into the minus values.
        //     : All of the positive values are taken for the ranged movement range.
        // NOTE: You can use any positive value as a distance, and it will act as MID_RANGE or LONG_RANGE, but with the value you've provided.
        //     : For example:
        //     :     mob:setMobMod(xi.mobMod.TRUST_DISTANCE, 20)
        //     : Will set the combat distance the trust tries to stick to to 20'
        // NOTE: If a Trust doesn't immediately sprint to a certain distance at the start of battle, it's probably NO_MOVE or MELEE.

        FOLLOW_MASTER   = -2,       // Follows master very closely
        NO_MOVE         = -1,       // Will stand still providing they're within casting distance of their master and target when the fight starts. Otherwise will reposition to
                                    // be within 18.0' of both
        MELEE           = 0,        // Default: will continually reposition to stay within melee range of the target
        MID_RANGE       = 6,        // Will path at the start of battle to 6' away from the target, and try to stay at that distance
        LONG_RANGE      = 12,       // Will path at the start of battle to 12' away from the target, and try to stay at that distance
    };
} // namespace

CTrustController::CTrustController(CCharEntity* PMaster, CTrustEntity* PTrust)
: CMobController(PTrust)
, m_GambitsContainer(std::make_unique<gambits::CGambitsContainer>(PTrust))
, m_LastTopEnmity(nullptr)
, m_failedRepositionAttempts(0)
, m_outOfLosChecks(0)
, m_numberOfWarps(0)
, m_InTransit(false)
, m_CombatEndTime(0s)
{
}

CTrustController::~CTrustController()
{
    if (POwner->PAI->IsEngaged())
    {
        POwner->PAI->Internal_Disengage();
    }
    POwner->PAI->PathFind.reset();
    POwner->allegiance = ALLEGIANCE_PLAYER;
    POwner->status = STATUS_DISAPPEAR;
    m_LastTopEnmity = nullptr;
    m_failedRepositionAttempts = 0;  // Unsure if needed
    m_InTransit = false;  // Unsure if needed
}

void CTrustController::Despawn()
{
    POwner->PMaster = nullptr;
    POwner->animation = ANIMATION_DESPAWN;
    CMobController::Despawn();
}

void CTrustController::Tick(time_point tick)
{
    TracyZoneScoped;
    TracyZoneIString(POwner->GetName());

    m_Tick = tick;
    CCharEntity* PMaster = static_cast<CCharEntity*>(POwner->PMaster);

    if (!PMaster)
    {
        return;
    }

    if (POwner->StatusEffectContainer->HasPreventActionEffect(false))
    {
        return;
    }

    if (auto PTrust = dynamic_cast<CTrustEntity*>(POwner))
    {
        if (PTrust->m_isDead)
        {
            return;
        }
    }

    // Match owners speed +10
    uint8 mastersSpeed = PMaster->GetSpeed();
    if (POwner->speed > 0)
    {
        if (PMaster->isMounted())
        {
            POwner->speed = 100;
        }
        else
        {
            POwner->speed = std::clamp(mastersSpeed + 10, 50, 255); // 50 Minimum 255 max
        }
    }

    // Match owners status
    if (!PMaster->isDead() && POwner->isAlive())
    {
        POwner->status = PMaster->status;
    }

    if (POwner->PAI->IsEngaged())
    {
        DoCombatTick(tick);
    }
    else if (!POwner->isDead())
    {
        DoRoamTick(tick);
    }
}

void CTrustController::DoCombatTick(time_point tick)
{
    TracyZoneScoped;

    CCharEntity* PMaster = static_cast<CCharEntity*>(POwner->PMaster);
    auto masterLastAttackTime = static_cast<CPlayerController*>(PMaster->PAI->GetController())->getLastAttackTime();
    bool masterMeleeSwing = masterLastAttackTime > server_clock::now() - 1s;
    auto mastersLastTargetHit = PMaster->GetLocalVar("LastTargetHit");
    bool trustEngageCondition = PMaster->GetBattleTarget() && masterMeleeSwing && mastersLastTargetHit == PMaster->GetBattleTarget()->id;
    bool masterWeakened = PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_WEAKNESS);
    bool masterCharmed = PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_CHARM) || PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_CHARM_II);


    if (PMaster && !PMaster->PAI->IsEngaged() && PMaster->isAlive() && !masterWeakened)
    {
        POwner->PAI->Internal_Disengage();
        m_LastTopEnmity = nullptr;
        m_CombatEndTime = m_Tick;
        m_outOfLosChecks = 0;
        m_numberOfWarps = 0;
    }

    if (PMaster &&
        PMaster->GetBattleTargetID() != POwner->GetBattleTargetID()
        && trustEngageCondition &&
        !masterCharmed)
    {
        POwner->PAI->Internal_ChangeTarget(PMaster->GetBattleTargetID());
        m_LastTopEnmity = nullptr;
        m_failedRepositionAttempts = 0;
        m_InTransit = false;
        m_outOfLosChecks = 0;
        m_numberOfWarps = 0;
    }

    // If busy, don't run around!
    if (POwner->PAI->IsCurrentState<CAbilityState>() ||
        POwner->PAI->IsCurrentState<CRangeState>() ||
        POwner->PAI->IsCurrentState<CMagicState>() ||
        POwner->PAI->IsCurrentState<CWeaponSkillState>() ||
        POwner->PAI->IsCurrentState<CMobSkillState>() ||
        POwner->PAI->IsCurrentState<CItemState>())
    {
        return;
    }

    CTrustEntity* PTrust = static_cast<CTrustEntity*>(POwner);
    PTarget = POwner->GetBattleTarget();

    if (PTarget)
    {
        if (POwner->PAI->CanFollowPath() &&
            POwner->speed > 0 &&
            !POwner->StatusEffectContainer->HasPreventActionEffect())
        {
            // Path close to the enemy if unable to see the enemy.
            if (POwner->CanSeeTarget(PMaster) && !POwner->CanSeeTarget(PTarget))
            {
                if (m_numberOfWarps < 3)
                {
                    if (m_Tick - m_LastLosCheckTime > 3s)
                    {
                        m_LastLosCheckTime = m_Tick;

                        // Checked once per 3 seconds
                        if (m_outOfLosChecks < 2)
                        {
                            ++m_outOfLosChecks;
                            POwner->PAI->PathFind->StepTo(PTarget->loc.p, false);
                        }
                        else
                        {
                            m_outOfLosChecks = 0;
                            ++m_numberOfWarps;
                            float warpOffset = 0.0f;

                            // Record original movement distance (only once)
                            if (m_OriginalMovementDistance == -1)
                            {
                                m_OriginalMovementDistance = PTrust->getMobMod(MOBMOD_TRUST_DISTANCE);
                            }

                            // Record last warp time
                            m_LastWarpTime = server_clock::now();

                            float currentDistanceToTarget = distance(POwner->loc.p, PTarget->loc.p) + static_cast<float>(PTarget->m_ModelSize);

                            // Don't warp to a target > combat distance away (30 yalms)
                            if (currentDistanceToTarget < CombatDistance)
                                POwner->PAI->PathFind->PathTo(PTarget->loc.p, PATHFLAG_WALLHACK);
                        }
                    }
                }
                else
                {
                    float currentDistanceToTarget = distance(POwner->loc.p, PTarget->loc.p) + static_cast<float>(PTarget->m_ModelSize);
                    float warpOffset = 0.0f;

                    // Don't warp to a target > combat distance away (30 yalms)
                    if (currentDistanceToTarget < CombatDistance)
                        POwner->PAI->PathFind->PathTo(PTarget->loc.p, PATHFLAG_WALLHACK);
                }
            }
            else
            {
                float currentDistanceToTarget = distance(POwner->loc.p, PTarget->loc.p) + static_cast<float>(PTarget->m_ModelSize);
                float currentDistanceToMaster = distance(POwner->loc.p, PMaster->loc.p) + static_cast<float>(PMaster->m_ModelSize);

                // Target out of range, disengage
                if (currentDistanceToTarget >= CombatDistance)
                {
                    POwner->PAI->Internal_Disengage();
                    m_LastTopEnmity = nullptr;
                    m_outOfLosChecks = 0;
                    m_numberOfWarps = 0;
                }

                POwner->PAI->PathFind->LookAt(PTarget->loc.p);

                int16 movementDistance = PTrust->getMobMod(MOBMOD_TRUST_DISTANCE);

                // Set trust movement based on the number of warps if trust isn't melee
                if (movementDistance > TRUST_MOVEMENT_TYPE::MELEE)
                {
                    if (m_numberOfWarps >= 3)
                    {
                        movementDistance = TRUST_MOVEMENT_TYPE::FOLLOW_MASTER;
                    }
                    else if (m_numberOfWarps > 0)
                    {
                        movementDistance = TRUST_MOVEMENT_TYPE::MID_RANGE;
                    }
                }


                // If WHM, don't move until Protectra / Shellra has been casted
                if (POwner->GetMJob() == JOB_WHM)
                {
                    bool hasProtect = POwner->StatusEffectContainer->HasStatusEffect(EFFECT_PROTECT);
                    bool hasShell = POwner->StatusEffectContainer->HasStatusEffect(EFFECT_SHELL);

                    if (POwner->GetMLevel() < 17)
                    {
                        if (!hasProtect)
                        {
                            movementDistance = TRUST_MOVEMENT_TYPE::FOLLOW_MASTER;
                        }
                    }
                    else
                    {
                        if (!hasProtect || !hasShell)
                        {
                            movementDistance = TRUST_MOVEMENT_TYPE::FOLLOW_MASTER;
                        }
                    }
                }

                // Restore original movement distance after 30s since last warp
                if (m_OriginalMovementDistance != -1)
                {
                    auto now = server_clock::now();
                    auto timeSinceLastWarp = std::chrono::duration_cast<std::chrono::seconds>(now - m_LastWarpTime).count();

                    if (timeSinceLastWarp >= 30)
                    {
                        // Restore the trust’s movement distance
                        PTrust->setMobMod(MOBMOD_TRUST_DISTANCE, m_OriginalMovementDistance);

                        // Reset tracking variables
                        m_OriginalMovementDistance = -1;
                        m_numberOfWarps = 0;
                    }
                }

                switch (movementDistance)
                {
                    case TRUST_MOVEMENT_TYPE::NO_MOVE:
                    {
                        // Don't move unless master is out of LOS or moves further than casting distance
                        if (!POwner->CanSeeTarget(PMaster))
                            POwner->PAI->PathFind->PathInRange(PMaster->loc.p, PMaster->m_ModelSize, PATHFLAG_WALLHACK);
                        else if (currentDistanceToTarget > CastingDistance)
                            POwner->PAI->PathFind->PathInRange(PTarget->loc.p, 18.0f + PTarget->m_ModelSize, PATHFLAG_RUN);
                        break;
                    }
                    case TRUST_MOVEMENT_TYPE::MELEE:
                    {
                        std::unique_ptr<CBasicPacket> err;
                        if (!POwner->CanAttack(PTarget, err) && POwner->speed > 0)
                        {
                            // Check if target is within range to follow path
                            float attack_range = POwner->GetMeleeRange() + PTarget->m_ModelSize;

                            if (currentDistanceToTarget > attack_range - 1.0f && POwner->PAI->CanFollowPath())
                            {
                                if (!POwner->PAI->PathFind->IsFollowingPath() ||
                                    distanceSquared(POwner->PAI->PathFind->GetDestination(), PTarget->loc.p) > 10 * 10)
                                {
                                    POwner->PAI->PathFind->PathInRange(PTarget->loc.p, attack_range - 1.0f, PATHFLAG_RUN);
                                }
                                POwner->PAI->PathFind->FollowPath();

                                // Check for stuck scenario
                                if (tick - m_StuckTick >= 2s)
                                {
                                    m_StuckTick = tick;
                                    UpdateLastKnownPosition();
                                    if (IsStuck() && PTarget)
                                    {
                                        POwner->PAI->PathFind->StepTo(PTarget->loc.p, false);
                                    }
                                }
                            }
                            else
                            {
                                // Handle case where entity is within melee range
                                if (!POwner->PAI->PathFind->IsFollowingPath() ||
                                    distanceSquared(POwner->PAI->PathFind->GetDestination(), PTarget->loc.p) > 10 * 10)
                                {
                                    POwner->PAI->PathFind->PathTo(PTarget->loc.p, PATHFLAG_RUN);
                                }
                                POwner->PAI->PathFind->FollowPath();
                            }
                        }
                        break;
                    }
                    case TRUST_MOVEMENT_TYPE::FOLLOW_MASTER:
                    {
                        if (currentDistanceToMaster > FollowDistance)
                        {
                            POwner->PAI->PathFind->PathInRange(PMaster->loc.p, PMaster->m_ModelSize, PATHFLAG_RUN);
                        }
                        break;
                    }
                    case TRUST_MOVEMENT_TYPE::MID_RANGE:
                        [[fallthrough]];
                    case TRUST_MOVEMENT_TYPE::LONG_RANGE:
                        [[fallthrough]];
                    default: // Using the positive-non-zero movementDistance mobMod value
                    {
                        // Path closer to Master if unable to see due to LOS
                        if (!POwner->CanSeeTarget(PMaster))
                            POwner->PAI->PathFind->PathInRange(PMaster->loc.p, PMaster->m_ModelSize, PATHFLAG_WALLHACK);
                        else
                            PathOutToDistance(PTarget, static_cast<float>(movementDistance));
                        break;
                    }
                }

                if (!POwner->PAI->PathFind->IsFollowingPath())
                {
                    Declump(PMaster, PTarget);
                }
            }
        }


        if (!m_InTransit)
        {
            POwner->PAI->PathFind->FollowPath();

            m_GambitsContainer->Tick(tick);

            POwner->PAI->EventHandler.triggerListener("COMBAT_TICK", POwner, POwner->PMaster, PTarget);
            luautils::OnMobFight(POwner, PTarget);
        }
    }
}

void CTrustController::DoRoamTick(time_point tick)
{
    TracyZoneScoped;

    auto PMaster = static_cast<CCharEntity*>(POwner->PMaster);
    auto masterLastAttackTime = static_cast<CPlayerController*>(PMaster->PAI->GetController())->getLastAttackTime();
    bool masterMeleeSwing = masterLastAttackTime > server_clock::now() - 1s;
    bool trustEngageCondition = PMaster->GetBattleTarget() && masterMeleeSwing;

    if (PMaster && !PMaster->PAI->IsEngaged() && PMaster->isAlive())
    {
        POwner->PAI->Internal_Disengage();
        m_LastTopEnmity = nullptr;
        m_outOfLosChecks = 0;
        m_numberOfWarps = 0;
    }

    if (PMaster->PAI->IsEngaged() && trustEngageCondition)
    {
        POwner->PAI->Internal_Engage(PMaster->GetBattleTargetID());
    }

    if (POwner->CanRest() && m_Tick - POwner->LastAttacked > m_tickDelays.at(0) && m_Tick - m_CombatEndTime > m_tickDelays.at(0) &&
        m_Tick - m_LastHealTickTime > m_tickDelays.at(m_NumHealingTicks))
    {
        if (POwner->health.hp != POwner->health.maxhp || POwner->health.mp != POwner->health.maxmp)
        {
            // recover 2% HP & MP (3% on retail - tested)
            uint32 recoverHP = (uint32)(POwner->health.maxhp * 0.02);
            uint32 recoverMP = (uint32)(POwner->health.maxmp * 0.02);
            // POwner->addHP(recoverHP);
            POwner->addMP(recoverMP);
            m_LastHealTickTime = m_Tick;
            POwner->updatemask |= UPDATE_HP;
            m_NumHealingTicks = std::clamp(m_NumHealingTicks + 1, static_cast<std::size_t>(0U), m_tickDelays.size() - 1U);
        }
    }

    // Unable to move due to hard CC (Sleep, stun, terror, etc)
    if (POwner->StatusEffectContainer->HasPreventActionEffect(false) || POwner->StatusEffectContainer->HasStatusEffect(EFFECT_BIND))
    {
        return;
    }

    // Currently doing another action
    if (POwner->PAI->IsCurrentState<CAbilityState>() ||
        POwner->PAI->IsCurrentState<CRangeState>() ||
        POwner->PAI->IsCurrentState<CMagicState>() ||
        POwner->PAI->IsCurrentState<CWeaponSkillState>() ||
        POwner->PAI->IsCurrentState<CMobSkillState>() ||
        POwner->PAI->IsCurrentState<CItemState>())
    {
        return;
    }

    if (TrustIsHealing())
    {
        return;
    }

    auto* controller = static_cast<CTrustController*>(POwner->PAI->GetController());

    if (PMaster &&
        !PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_MOUNTED) &&
        controller &&
        POwner->PAI->CanChangeState())
    {
        if (TryUseFood(PMaster, controller))
        {
            return;
        }

        if (TryUseOOCAbilities(PMaster, controller))
        {
            return;
        }

        if (TryCastOOCSpells(PMaster, controller))
        {
            return;
        }
    }

    // Currently doing another action
    if (POwner->PAI->IsCurrentState<CAbilityState>() ||
        POwner->PAI->IsCurrentState<CRangeState>() ||
        POwner->PAI->IsCurrentState<CMagicState>() ||
        POwner->PAI->IsCurrentState<CWeaponSkillState>() ||
        POwner->PAI->IsCurrentState<CMobSkillState>() ||
        POwner->PAI->IsCurrentState<CItemState>())
    {
        return;
    }

    uint8 currentPartyPos = GetPartyPosition();
    CBattleEntity* PFollowTarget = nullptr;

    // If this is the first trust, follow the player/master
    if (currentPartyPos == 0)
    {
        PFollowTarget = POwner->PMaster;
    }
    else
    {
        // Start by assuming we’ll follow the one right before us
        for (int8 i = currentPartyPos - 1; i >= 0; --i)
        {
            auto* PTrustBeingFollowed = PMaster->PTrusts.at(i);
            if (!PTrustBeingFollowed)
                continue;

            // Skip this trust if it's dead, cannot act or has 0 movement
            if (PTrustBeingFollowed->health.hp <= 0 ||
                PTrustBeingFollowed->StatusEffectContainer->HasPreventActionEffect(false) ||
                PTrustBeingFollowed->speed <= 0)
            {
                continue; // try the next one further up
            }

            // Found a valid one to follow
            PFollowTarget = PTrustBeingFollowed;
            break;
        }

        // If we didn’t find any valid Trusts above us, fallback to the player
        if (!PFollowTarget)
        {
            PFollowTarget = POwner->PMaster;
        }
    }

    float currentDistance = distance(POwner->loc.p, PFollowTarget->loc.p);

    if (currentDistance > RoamDistance)
    {
        if (currentDistance < RoamDistance * 3.0f && POwner->PAI->PathFind->PathAround(PFollowTarget->loc.p, RoamDistance, PATHFLAG_RUN))
        {
            POwner->PAI->PathFind->FollowPath();
        }
        else if (POwner->GetSpeed() > 0)
        {
            POwner->PAI->PathFind->StepTo(PFollowTarget->loc.p, true);
        }
    }
}

void CTrustController::Declump(CCharEntity * PMaster, CBattleEntity * PTarget)
{
    TracyZoneScoped;

    if (POwner->StatusEffectContainer->HasStatusEffect({ EFFECT_SNEAK_ATTACK, EFFECT_TRICK_ATTACK }))
    {
        return;
    }

    // Don't declump if currently tanking (Top enmity)
    if (PTarget && GetTopEnmity() == POwner)
    {
        return;
    }

    // If WHM, don't move until Protectra / Shellra has been casted
    if (POwner->GetMJob() == JOB_WHM)
    {
        bool hasProtect = POwner->StatusEffectContainer->HasStatusEffect(EFFECT_PROTECT);
        bool hasShell = POwner->StatusEffectContainer->HasStatusEffect(EFFECT_SHELL);

        if (POwner->GetMLevel() < 17)
        {
            if (!hasProtect)
            {
                return;
            }
        }
        else
        {
            if (!hasProtect || !hasShell)
            {
                return;
            }
        }
    }

    uint8 currentPartyPos = GetPartyPosition();
    for (auto* POtherTrust : PMaster->PTrusts)
    {
        if (POtherTrust != POwner && !POtherTrust->PAI->PathFind->IsFollowingPath() && distance(POtherTrust->loc.p, POwner->loc.p) < 1.5f)
        {
            auto diffAngle = worldAngle(POwner->loc.p, PTarget->loc.p) + 64;
            auto moveAmount = tpzrand::GetRandomNumber(0.0f, 1.5f) * ((currentPartyPos % 2) ? 1.0f : -1.0f);

            // clang-format off
            position_t newPos =
            {
                POwner->loc.p.x - (cosf(rotationToRadian(diffAngle)) * moveAmount),
                PTarget->loc.p.y,
                POwner->loc.p.z + (sinf(rotationToRadian(diffAngle)) * moveAmount),
                0,
                0,
            };
            // clang-format on

            if (POwner->PAI->PathFind->ValidPosition(newPos))
            {
                POwner->PAI->PathFind->PathTo(newPos, PATHFLAG_RUN);
            }
            break;
        }
    }
}

void CTrustController::PathOutToDistance(CBattleEntity* PTarget, float amount)
{
    TracyZoneScoped;
    CCharEntity* PMaster = static_cast<CCharEntity*>(POwner->PMaster);

    if (!PMaster)
        return;

    float currentDistanceToTarget = distance(POwner->loc.p, PTarget->loc.p);
    float currentDistanceToMaster = distance(POwner->loc.p, PMaster->loc.p) + static_cast<float>(PMaster->m_ModelSize);
    position_t target_position = POwner->loc.p;

    // If the current enemy is targetting us, move to our master and stand still until aggro is gotten off us
    if (GetTopEnmity() == POwner)
    {
        if (currentDistanceToMaster > FollowDistance)
        {
            POwner->PAI->PathFind->PathInRange(PMaster->loc.p, PMaster->m_ModelSize, PATHFLAG_RUN);
        }
        return;
    }
    else
    {
        m_failedRepositionAttempts = 0;
    }

    // Invalidate position and pick new one (limit: every 3s)
    if ((currentDistanceToTarget < amount - 2.5f || currentDistanceToTarget > amount + 2.5f || !POwner->PAI->PathFind->ValidPosition(POwner->loc.p)) &&
        m_Tick - m_LastRepositionTime > 3s &&
        !m_InTransit)
    {
        std::vector<position_t> positions(5);
        for (unsigned int i = 0; i < positions.size(); ++i)
        {
            int random_angle = tpzrand::GetRandomNumber(255);
            position_t potential_position = {
                PTarget->loc.p.x - (cosf(rotationToRadian(random_angle)) * amount),
                PTarget->loc.p.y,
                PTarget->loc.p.z + (sinf(rotationToRadian(random_angle)) * amount),
                0,
                0,
            };
            positions[i] = potential_position;
        }

        bool position_found = false;
        for (auto& potential_position : positions)
        {
            // Validate position
            if (!position_found &&
                POwner->PAI->PathFind->ValidPosition(potential_position) &&
                POwner->CanSeeTarget(potential_position, true))
            {
                position_found = true;
                target_position = potential_position;
                m_InTransit = true;
            }
        }

        m_LastRepositionTime = m_Tick;
    }

    // Get somewhat close to the target destination
    if (distance(POwner->loc.p, target_position) > 2.0f && m_failedRepositionAttempts < 3)
    {
        POwner->PAI->PathFind->PathTo(target_position, PATHFLAG_RUN);
    }
    else
    {
        FaceTarget(PTarget->targid);
        m_InTransit = false;
    }
}

bool CTrustController::TrustIsHealing()
{
    bool isMasterHealing = (POwner->PMaster->animation == ANIMATION_HEALING);
    bool isTrustHealing = (POwner->animation == ANIMATION_HEALING);

    if (isMasterHealing && !isTrustHealing && !POwner->StatusEffectContainer->HasPreventActionEffect(false))
    {
        // animation down
        POwner->animation = ANIMATION_HEALING;
        POwner->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_HEALING, 0, 0, map_config.healing_tick_delay, 0));
        POwner->updatemask |= UPDATE_HP;
        return true;
    }
    else if (!isMasterHealing && isTrustHealing)
    {
        // animation up
        POwner->animation = ANIMATION_NONE;
        POwner->StatusEffectContainer->DelStatusEffect(EFFECT_HEALING);
        POwner->updatemask |= UPDATE_HP;
        return false;
    }

    return isMasterHealing;
}

bool CTrustController::TryUseFood(CCharEntity* PMaster, CTrustController* Controller)
{
    JOBTYPE job = POwner->GetMJob();
    uint8 mobLvl = POwner->GetMLevel();

    // Determine role
    std::string role = "Melee";
    if (job == JOB_PLD || job == JOB_RUN)
        role = "Tank";
    else if (job == JOB_RNG || job == JOB_COR)
        role = "Ranged";
    else if (job == JOB_BLM || job == JOB_SCH)
        role = "Caster";
    else if (job == JOB_WHM || job == JOB_RDM || job == JOB_GEO)
        role = "Healer";
    else if (job == JOB_NIN)
        role = "Ninja";
    else if (job == JOB_COR || job == JOB_BRD)
        role = "Support";

    // Food entry struct must be defined *before* using it in std::map
    struct FoodEntry { uint8 Lvl; uint16 ItemID; };

    // Food table
    static const std::map<std::string, std::vector<FoodEntry>> foodData = {
        { "Tank", {
            FoodEntry{ 1,   static_cast<uint16>(ItemID::SAUSAGE) },
            FoodEntry{ 30,  static_cast<uint16>(ItemID::DHALMEL_STEAK) },
            FoodEntry{ 50,  static_cast<uint16>(ItemID::PLATE_OF_DORADO_SUSHI) },
            FoodEntry{ 75,  static_cast<uint16>(ItemID::TAVNAZIAN_TACO) }
        }},
        { "Melee", {
            FoodEntry{ 1,   static_cast<uint16>(ItemID::SAUSAGE) },
            FoodEntry{ 30,  static_cast<uint16>(ItemID::DHALMEL_STEAK) },
            FoodEntry{ 40,  static_cast<uint16>(ItemID::MARINARA_PIZZA) }
        }},
        { "Ranged", {
            FoodEntry{ 1,   static_cast<uint16>(ItemID::SAUSAGE) },
            FoodEntry{ 30,  static_cast<uint16>(ItemID::SIS_KEBABI) },
            FoodEntry{ 55,  static_cast<uint16>(ItemID::POT_AU_FEU) }
        }},
        { "Caster", {
            FoodEntry{ 1,   static_cast<uint16>(ItemID::MELON_PIE) },
            FoodEntry{ 75,  static_cast<uint16>(ItemID::CREAM_PUFF) }
        }},
        { "Healer", {
            FoodEntry{ 1,   static_cast<uint16>(ItemID::ROAST_MUSHROOM) },
            FoodEntry{ 50,  static_cast<uint16>(ItemID::BOWL_OF_MUSHROOM_SOUP) },
            FoodEntry{ 75,  static_cast<uint16>(ItemID::BOWL_OF_MUSHROOM_STEW) }
        }},
        { "Support", {
            FoodEntry{ 1,   static_cast<uint16>(ItemID::PUMPKIN_PIE) }
        }},
        { "Ninja", {
            FoodEntry{ 1,   static_cast<uint16>(ItemID::SAUSAGE) },
            FoodEntry{ 30,  static_cast<uint16>(ItemID::DHALMEL_STEAK) },
            FoodEntry{ 50,  static_cast<uint16>(ItemID::PLATE_OF_DORADO_SUSHI) }
        }},
    };

    // Pick highest valid food
    uint16 selectedFood = 0;
    auto it = foodData.find(role);
    if (it != foodData.end())
    {
        for (const auto& entry : it->second)
        {
            if (mobLvl >= entry.Lvl)
                selectedFood = entry.ItemID;
            else
                break;
        }
    }

    // If food found and trust has no food effect, use it
    if (selectedFood && !POwner->StatusEffectContainer->HasStatusEffect(EFFECT_FOOD))
    {
        UseItem(POwner->targid, LOC_INVENTORY, selectedFood);
        return true;
    }

    return false;
}

bool CTrustController::TryCastOOCSpells(CCharEntity* PMaster, CTrustController* Controller)
{
    if (TryCastRaise(PMaster, Controller))
    {
        return true;
    }

    if (TryCastReraise(PMaster, Controller))
    {
        return true;
    }

    if (TryCastProtectraShellra(PMaster, Controller))
    {
        return true;
    }

    if (TryCastUtsusemi(PMaster, Controller))
    {
        return true;
    }

    if (TryCastMazurka(PMaster, Controller))
    {
        return true;
    }

    return false;
}

bool CTrustController::TryUseOOCAbilities(CCharEntity* PMaster, CTrustController* Controller)
{
    if (TryUseBoltersRoll(PMaster, Controller))
    {
        return true;
    }

    if (TryUseChocoboJig(PMaster, Controller))
    {
        return true;
    }

    return false;
}

bool CTrustController::TryCastRaise(CCharEntity* PMaster, CTrustController* Controller)
{
    bool casted = false;

    PMaster->ForPartyWithTrusts(
        [&](CBattleEntity* PMember)
        {
            if (!PMember->isDead())
            {
                return;
            }

            float distanceToMember = distance(POwner->loc.p, PMember->loc.p);
            if (distanceToMember > 20.0f)
            {
                return;
            }

            if (auto* PTrust = dynamic_cast<CTrustEntity*>(POwner))
            {
                auto raise = PTrust->SpellContainer->GetBestAvailable(SPELLFAMILY_RAISE);

                if (raise.has_value())
                {
                    SpellID raiseId = *raise;

                    if (auto* PSpell = spell::GetSpell(raiseId))
                    {
                        if (POwner->health.mp >= PSpell->getMPCost())
                        {
                            if (PMember->objtype == TYPE_PC)
                            {
                                if (auto* PChar = dynamic_cast<CCharEntity*>(PMember))
                                {
                                    if (!PChar->m_hasRaise)
                                    {
                                        Controller->Cast(PMember->targid, *raise);
                                        casted = true;
                                        return;
                                    }
                                }
                            }
                            else
                            {
                                Controller->Cast(PMember->targid, *raise);
                                casted = true;
                                return;
                            }
                        }
                    }
                }
            }
        });

    return casted;
}

bool CTrustController::TryCastReraise(CCharEntity* PMaster, CTrustController* Controller)
{
    if (POwner->StatusEffectContainer->HasStatusEffect(EFFECT_RERAISE))
    {
        return false;
    }

    if (auto* PTrust = dynamic_cast<CTrustEntity*>(POwner))
    {
        auto reraise = PTrust->SpellContainer->GetBestAvailable(SPELLFAMILY_RERAISE);

        if (reraise.has_value())
        {
            SpellID reraiseId = *reraise;

            if (auto* PSpell = spell::GetSpell(reraiseId))
            {
                if (POwner->health.mp >= PSpell->getMPCost())
                {
                    Controller->Cast(POwner->targid, *reraise);
                    return true;
                }
            }
        }
    }

    return false;
}

bool CTrustController::TryCastProtectraShellra(CCharEntity* PMaster, CTrustController* Controller)
{
    if (POwner->StatusEffectContainer->HasStatusEffect(EFFECT_PROTECT) && POwner->StatusEffectContainer->HasStatusEffect(EFFECT_SHELL))
    {
        return false;
    }

    auto membersInRange = 0;
    bool casted = false;

    PMaster->ForPartyWithTrusts(
        [&](CBattleEntity* PMember)
        {
            // Make sure all party members are in range before casting protectra/shellra
            float distanceToMember = distance(POwner->loc.p, PMember->loc.p);
            if (distanceToMember <= 5.0f)
            {
                membersInRange++;
            }

            if (membersInRange < 6)
            {
                return;
            }

            if (auto* PTrust = dynamic_cast<CTrustEntity*>(POwner))
            {
                auto protectra = PTrust->SpellContainer->GetBestAvailable(SPELLFAMILY_PROTECTRA);
                auto shellra   = PTrust->SpellContainer->GetBestAvailable(SPELLFAMILY_SHELLRA);

                if (protectra && !POwner->StatusEffectContainer->HasStatusEffect(EFFECT_PROTECT))
                {
                    SpellID spellId = *protectra;
                    if (auto* PSpell = spell::GetSpell(spellId))
                    {
                        if (POwner->health.mp >= PSpell->getMPCost())
                        {
                            Controller->Cast(POwner->targid, spellId);
                            casted = true;
                            return;
                        }
                    }
                }

                if (shellra && !POwner->StatusEffectContainer->HasStatusEffect(EFFECT_SHELL))
                {
                    SpellID spellId = *shellra;
                    if (auto* PSpell = spell::GetSpell(spellId))
                    {
                        if (POwner->health.mp >= PSpell->getMPCost())
                        {
                            Controller->Cast(POwner->targid, spellId);
                            casted = true;
                            return;
                        }
                    }
                }
            }
        });

    return casted;
}

bool CTrustController::TryCastUtsusemi(CCharEntity* PMaster, CTrustController* Controller)
{
    if (POwner->StatusEffectContainer->HasStatusEffect({EFFECT_COPY_IMAGE, EFFECT_COPY_IMAGE_1, EFFECT_COPY_IMAGE_2, EFFECT_COPY_IMAGE_3, EFFECT_COPY_IMAGE_4}))
    {
        return false;
    }

    if (auto* PTrust = dynamic_cast<CTrustEntity*>(POwner))
    {
        auto utsusemi = PTrust->SpellContainer->GetBestAvailable(SPELLFAMILY_UTSUSEMI);

        if (utsusemi)
        {
            Controller->Cast(POwner->targid, *utsusemi);
            return true;
        }
    }

    return false;
}
 
bool CTrustController::TryCastMazurka(CCharEntity* PMaster, CTrustController* Controller)
{
    if (m_Tick - m_CombatEndTime < 30s)
    {
        return false;
    }

    if (POwner->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_SONG))
    {
        return false;
    }

    if (POwner->StatusEffectContainer->HasStatusEffect(EFFECT_PIANISSIMO))
    {
        return false;
    }

    if (PMaster->PAI->IsEngaged())
    {
        return false;
    }

    // Make sure master is within song distance
    float distanceToMaster = distance(POwner->loc.p, PMaster->loc.p);
    if (distanceToMaster > 2.0f)
    {
        return false;
    }

    bool casted = false;

    PMaster->ForPartyWithTrusts(
        [&](CBattleEntity* PMember)
        {
            if (auto* PTrust = dynamic_cast<CTrustEntity*>(POwner))
            {
                auto mazurka = PTrust->SpellContainer->GetBestAvailable(SPELLFAMILY_MAZURKA);

                if (mazurka)
                {
                    Controller->Cast(POwner->targid, *mazurka);
                    casted = true;
                    return;
                }
            }
        });

    return casted;
}

bool CTrustController::TryUseBoltersRoll(CCharEntity* PMaster, CTrustController* Controller)
{
    if (m_Tick - m_CombatEndTime < 30s)
    {
        return false;
    }

    if (POwner->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_ROLL))
    {
        return false;
    }

    // Make sure master is near
    float distanceToMaster = distance(POwner->loc.p, PMaster->loc.p);
    if (distanceToMaster > 2.0f)
    {
        return false;
    }

    bool abilityUsed = false;

    PMaster->ForPartyWithTrusts(
        [&](CBattleEntity* PMember)
        {
            // Check if can use Bolters Roll
            ABILITY ability = ABILITY_NONE;

            if (ability::CanUseAbility(static_cast<CBattleEntity*>(POwner), ability::GetAbility(ABILITY_BOLTERS_ROLL)))
                ability = ABILITY_BOLTERS_ROLL;

            if (ability != ABILITY_NONE)
            {
                Controller->Ability(POwner->targid, ability);
                abilityUsed = true;
                return;
            }
        });

    return abilityUsed;
}

bool CTrustController::TryUseChocoboJig(CCharEntity* PMaster, CTrustController* Controller)
{
    if (m_Tick - m_CombatEndTime < 30s)
    {
        return false;
    }

    if (POwner->StatusEffectContainer->HasStatusEffect(EFFECT_QUICKENING))
    {
        return false;
    }

    // Make sure master is near
    float distanceToMaster = distance(POwner->loc.p, PMaster->loc.p);
    if (distanceToMaster > 5.0f)
    {
        return false;
    }

    bool abilityUsed = false;

    PMaster->ForPartyWithTrusts(
        [&](CBattleEntity* PMember)
        {
            // Check if can use Chocobo Jig
            ABILITY ability = ABILITY_NONE;

            if (ability::CanUseAbility(static_cast<CBattleEntity*>(POwner), ability::GetAbility(ABILITY_CHOCOBO_JIG_II)))
                ability = ABILITY_CHOCOBO_JIG_II;
            else if (ability::CanUseAbility(static_cast<CBattleEntity*>(POwner), ability::GetAbility(ABILITY_CHOCOBO_JIG)))
                ability = ABILITY_CHOCOBO_JIG;

            if (ability != ABILITY_NONE)
            {
                Controller->Ability(POwner->targid, ability);
                abilityUsed = true;
                return;
            }
        });

    return abilityUsed;
}

bool CTrustController::Ability(uint16 targid, uint16 abilityid)
{
    TracyZoneScoped;

    CAbility* PAbility = ability::GetAbility(abilityid);
    if (static_cast<CMobEntity*>(POwner)->PRecastContainer->HasRecast(RECAST_ABILITY, PAbility->getRecastId(), PAbility->getRecastTime()))
    {
        return false;
    }

    if (POwner->StatusEffectContainer->HasStatusEffect({ EFFECT_AMNESIA, EFFECT_IMPAIRMENT, EFFECT_PARALYSIS, EFFECT_GEO_PARALYSIS }))
    {
        return false;
    }

    if (POwner->PAI->CanChangeState())
    {
        return POwner->PAI->Internal_Ability(targid, abilityid);
    }

    return false;
}

bool CTrustController::RangedAttack(uint16 targid)
{
    TracyZoneScoped;

    if (!m_InTransit && m_Tick > m_LastRepositionTime)
    {
        FaceTarget(PTarget->targid);
        if (POwner->PAI->CanChangeState() && POwner->PAI->Internal_RangedAttack(targid))
        {
            return true;
        }
    }
    return false;
}

bool CTrustController::Cast(uint16 targid, SpellID spellid)
{
    TracyZoneScoped;

    FaceTarget(targid);

    if (auto target = POwner->GetEntity(targid); target && !POwner->CanSeeTarget(target))
        ++m_outOfLosChecks;

    if (static_cast<CMobEntity*>(POwner)->PRecastContainer->Has(RECAST_MAGIC, static_cast<uint16>(spellid)))
        return false;

    auto PSpell = spell::GetSpell(spellid);
    if (PSpell->getValidTarget() == TARGET_SELF)
        targid = POwner->targid;

    return CController::Cast(targid, spellid);
}

void CTrustController::OnCastStopped(CMagicState& state, action_t& action)
{
    int32 magicCool = 0;
    CState* currentState = POwner->PAI->GetCurrentState();
    if (currentState)
    {
        // Attempt to cast to CMagicState
        CMagicState* maState = dynamic_cast<CMagicState*>(currentState);
        if (maState)
        {
            CSpell* PSpell = maState->GetSpell();
            if (PSpell)
            {
                auto spellCastTime = PSpell->getCastTime();
                auto skillType = PSpell->getSkillType();
                // printf("spellid %d, PSpell %p, spellCastTime: %d, skillType: %d \n", static_cast<int>(spellid), static_cast<void*>(PSpell), spellCastTime,
                // skillType);

                switch (skillType)
                {
                    case SKILLTYPE::SKILL_DIVINE_MAGIC:
                    case SKILLTYPE::SKILL_HEALING_MAGIC:
                    case SKILLTYPE::SKILL_ENHANCING_MAGIC:
                    case SKILLTYPE::SKILL_ENFEEBLING_MAGIC:
                    case SKILLTYPE::SKILL_DARK_MAGIC:
                    case SKILLTYPE::SKILL_SUMMONING_MAGIC:
                    case SKILLTYPE::SKILL_NINJUTSU:
                    case SKILLTYPE::SKILL_SINGING:
                    case SKILLTYPE::SKILL_STRING_INSTRUMENT:
                    case SKILLTYPE::SKILL_WIND_INSTRUMENT:
                    case SKILLTYPE::SKILL_BLUE_MAGIC:
                    case SKILLTYPE::SKILL_GEOMANCY:
                    case SKILLTYPE::SKILL_HANDBELL:
                        magicCool = spellCastTime + 3000;
                        // ShowDebug("Adding 3s to spell recast timer!\n");
                        break;
                    case SKILLTYPE::SKILL_ELEMENTAL_MAGIC:
                        // ShowDebug("Adding 13s to spell recast timer!\n");
                        magicCool = spellCastTime + 13000;
                        break;
                    default:
                        // ShowDebug("Adding 3s to spell recast timer!\n");
                        magicCool = spellCastTime + 3000;
                        break;
                }
            }
        }
    }

    m_NextMagicTime = m_Tick + std::chrono::milliseconds(magicCool);
}

CBattleEntity* CTrustController::GetTopEnmity()
{
    TracyZoneScoped;

    CBattleEntity* PEntity = nullptr;
    if (auto PTrust = dynamic_cast<CMobEntity*>(POwner->PMaster->GetBattleTarget()))
    {
        return PTrust->PEnmityContainer->GetHighestEnmity();
    }
    return PEntity;
}

uint8 CTrustController::GetPartyPosition()
{
    TracyZoneScoped;

    auto& trustList = static_cast<CCharEntity*>(POwner->PMaster)->PTrusts;
    for (std::size_t i = 0; i < trustList.size(); ++i)
    {
        if (trustList.at(i)->id == POwner->id)
        {
            return static_cast<uint8>(i);
        }
    }
    return 0;
}

bool CTrustController::UseItem(uint16 targid, uint8 loc, uint16 slotid)
{
    auto PTrust = static_cast<CMobEntity*>(POwner);
    if (PTrust->PAI->CanChangeState())
    {
        if (PTrust->StatusEffectContainer->HasStatusEffect(EFFECT_MUDDLE))
        {
            return false;
        }
        return PTrust->PAI->Internal_UseItem(targid, loc, slotid);
    }
    return false;
}
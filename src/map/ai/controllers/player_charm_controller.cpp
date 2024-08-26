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

#include "player_charm_controller.h"

#include "../ai_container.h"
#include "../../status_effect_container.h"
#include "../../entities/charentity.h"
#include "../../packets/char.h"
#include "../../../common/utils.h"

CPlayerCharmController::CPlayerCharmController(CCharEntity* PChar)
    : CPlayerController(PChar)
{
    POwner->PAI->PathFind = std::make_unique<CPathFind>(PChar);
}

CPlayerCharmController::~CPlayerCharmController()
{
    if (POwner->PAI->IsEngaged())
    {
        POwner->PAI->Internal_Disengage();
    }
    POwner->PAI->PathFind.reset();
    POwner->allegiance = ALLEGIANCE_PLAYER;
}

void CPlayerCharmController::Tick(time_point tick)
{
    m_Tick = tick;
    if (POwner->PMaster == nullptr || !POwner->PMaster->isAlive()) {
        POwner->StatusEffectContainer->DelStatusEffect(EFFECT_CHARM);
        return;
    }

    if (POwner->PAI->IsEngaged())
    {
        DoCombatTick(tick);
    }
    else
    {
        DoRoamTick(tick);
    }
}

bool CPlayerCharmController::IsStuck()
{
    return m_Stuck;
}

void CPlayerCharmController::UpdateLastKnownPosition()
{
    // Mob is considered "Stuck" if:
    // 1. Last Pos && Current Pos are <= 1.5
    // 2. Distance to Target > Melee Range
    // 3. Mob is not bound or asleep
    auto PTarget = POwner->GetBattleTarget();
    m_Stuck = distanceSquared(m_LastPos, POwner->loc.p) <= 1.5f && distanceSquared(POwner->loc.p, PTarget->loc.p) > POwner->GetMeleeRange() &&
              POwner->StatusEffectContainer->GetStatusEffect(EFFECT_BIND) == nullptr && POwner->StatusEffectContainer->GetStatusEffect(EFFECT_SLEEP) == nullptr &&
              POwner->StatusEffectContainer->GetStatusEffect(EFFECT_SLEEP_II) == nullptr;
    m_LastPos = POwner->loc.p;
}

void CPlayerCharmController::DoCombatTick(time_point tick)
{
    if (!POwner->PMaster->PAI->IsEngaged())
    {
        POwner->PAI->Internal_Disengage();
    }

    if (POwner->PMaster->GetBattleTargetID() != POwner->GetBattleTargetID())
    {
        POwner->PAI->Internal_ChangeTarget(POwner->PMaster->GetBattleTargetID());
    }

    auto PTarget = POwner->GetBattleTarget();
    if (PTarget)
    {
        // Update target position
        POwner->PAI->PathFind->LookAt(PTarget->loc.p);

        // Check if target is within range to follow path
        float currentDistance = distance(POwner->loc.p, PTarget->loc.p);
        float attack_range = POwner->GetMeleeRange() + PTarget->m_ModelSize;

        if (currentDistance > attack_range - 0.2f && POwner->PAI->CanFollowPath())
        {
            if (!POwner->PAI->PathFind->IsFollowingPath() || distanceSquared(POwner->PAI->PathFind->GetDestination(), PTarget->loc.p) > 10 * 10)
            {
                POwner->PAI->PathFind->PathInRange(PTarget->loc.p, attack_range - 0.2f, PATHFLAG_WALLHACK | PATHFLAG_RUN);
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
            if (!POwner->PAI->PathFind->IsFollowingPath() || distanceSquared(POwner->PAI->PathFind->GetDestination(), PTarget->loc.p) > 10 * 10)
            {
                POwner->PAI->PathFind->PathTo(PTarget->loc.p, PATHFLAG_WALLHACK | PATHFLAG_RUN);
            }
            POwner->PAI->PathFind->FollowPath();
        }
    }
}

void CPlayerCharmController::DoRoamTick(time_point tick)
{
    auto PTarget = POwner->PMaster->GetBattleTarget();
    float currentDistance = distance(POwner->loc.p, PTarget->loc.p);

    // Check if the target is within 30 yalms before engaging
    if (POwner->PMaster->PAI->IsEngaged() && currentDistance < 30.0f)
    {
        POwner->PAI->Internal_Engage(POwner->PMaster->GetBattleTargetID());
    }
    float currentDistanceSquared = distanceSquared(POwner->loc.p, POwner->PMaster->loc.p);

    if (currentDistanceSquared > RoamDistance * RoamDistance)
    {
        if (!POwner->PAI->PathFind->IsFollowingPath() || distanceSquared(POwner->PAI->PathFind->GetDestination(), POwner->PMaster->loc.p) > 10 * 10)
        { // recalculate path only if owner moves more than X yalms
            if (!POwner->PAI->PathFind->PathAround(POwner->PMaster->loc.p, RoamDistance, PATHFLAG_RUN | PATHFLAG_WALLHACK))
            {
                POwner->PAI->PathFind->PathInRange(POwner->PMaster->loc.p, RoamDistance, PATHFLAG_RUN | PATHFLAG_WALLHACK);
            }
        }
        POwner->PAI->PathFind->FollowPath();
    }
}

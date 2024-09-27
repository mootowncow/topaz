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

#include "pet_controller.h"

#include "../ai_container.h"
#include "../../status_effect_container.h"
#include "../../entities/petentity.h"
#include "../../utils/petutils.h"
#include "../../../common/utils.h"

CPetController::CPetController(CPetEntity* _PPet) :
    CMobController(_PPet), PPet(_PPet)
{
    //#TODO: this probably will have to depend on pet type (automaton does WS on its own..)
    SetWeaponSkillEnabled(false);
}

void CPetController::Tick(time_point tick)
{
    TracyZoneScoped;
    TracyZoneIString(PPet->GetName());

    CBattleEntity* PMaster = static_cast<CBattleEntity*>(PPet->PMaster);

    if (!PMaster)
    {
        return;
    }

    // Match owners speed
    uint8 mastersSpeed = PMaster->GetSpeed();
    uint8 trustsSpeed = PPet->speed;
    ShowDebug("[%s] masters speed %u\n", PMaster->name, PMaster->speed);
    ShowDebug("[%s] speed before changing %u\n", PPet->name, PPet->speed);
    if (PMaster->isMounted())
    {
        PPet->speed = 100;
    }
    else
    {
        PPet->speed = std::clamp(mastersSpeed + 10, 50, 255); // 50 Minimum 255 max
    }
    ShowDebug("[%s] speed after changing %u\n", PPet->name, PPet->speed);
    if (PPet->shouldDespawn(tick))
    {
        petutils::DespawnPet(PPet->PMaster);
        return;
    }
    CMobController::Tick(tick);
}

void CPetController::DoRoamTick(time_point tick)
{
    if ((PPet->PMaster == nullptr || PPet->PMaster->isDead()) && PPet->isAlive()) {
        PPet->Die();
        return;
    }

    // Pet is unable to move due to hard CC(Sleep, stun, terror, etc)
    if (PPet->StatusEffectContainer->HasPreventActionEffect(false) || PPet->StatusEffectContainer->HasStatusEffect(EFFECT_BIND))
    {
        return;
    }

    //automaton, wyvern
    if (PPet->getPetType() == PETTYPE_WYVERN || PPet->getPetType() == PETTYPE_AUTOMATON) {
        if (PetIsHealing()) {
            return;
        }
    }
    else if (PPet->isBstPet() && PPet->StatusEffectContainer->HasStatusEffect(EFFECT_HEALING))
    {
        return;
    }

    float currentDistanceSquared = distanceSquared(PPet->loc.p, PPet->PMaster->loc.p);

    if (currentDistanceSquared > PetRoamDistance * PetRoamDistance)
    {
        if (!PPet->PAI->PathFind->IsFollowingPath() || distanceSquared(PPet->PAI->PathFind->GetDestination(), PPet->PMaster->loc.p) > 10 * 10)
        { // recalculate path only if owner moves more than X yalms
            if (!PPet->PAI->PathFind->PathAround(PPet->PMaster->loc.p, PetRoamDistance, PATHFLAG_RUN | PATHFLAG_WALLHACK))
            {
                PPet->PAI->PathFind->PathInRange(PPet->PMaster->loc.p, PetRoamDistance, PATHFLAG_RUN | PATHFLAG_WALLHACK);
            }
        }
        PPet->PAI->PathFind->FollowPath();
    }
}

bool CPetController::PetIsHealing()
{
    bool isMasterHealing = (PPet->PMaster->animation == ANIMATION_HEALING);
    bool isPetHealing = (PPet->animation == ANIMATION_HEALING);

    if (isMasterHealing && !isPetHealing && !PPet->StatusEffectContainer->HasPreventActionEffect(false)) {
        //animation down
        PPet->animation = ANIMATION_HEALING;
        PPet->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_HEALING, 0, 0, map_config.healing_tick_delay, 0));
        PPet->updatemask |= UPDATE_HP;
        return true;
    }
    else if (!isMasterHealing && isPetHealing) {
        //animation up
        PPet->animation = ANIMATION_NONE;
        PPet->StatusEffectContainer->DelStatusEffect(EFFECT_HEALING);
        PPet->updatemask |= UPDATE_HP;
        return false;
    }
    return isMasterHealing;
}

bool CPetController::TryDeaggro()
{
    if (PTarget == nullptr)
    {
        return true;
    }

    // target is no longer valid, so wipe them from our enmity list
    if (PTarget->isDead() ||
        PTarget->isMounted() ||
        PTarget->loc.zone->GetID() != PPet->loc.zone->GetID() ||
        PPet->StatusEffectContainer->GetConfrontationEffect() != PTarget->StatusEffectContainer->GetConfrontationEffect())
    {
        return true;
    }
    return false;
}

bool CPetController::Ability(uint16 targid, uint16 abilityid)
{
    if (PPet->StatusEffectContainer->HasStatusEffect({ EFFECT_AMNESIA, EFFECT_IMPAIRMENT }))
    {
        return false;
    }

    if (PPet->PAI->CanChangeState())
    {
        return PPet->PAI->Internal_Ability(targid, abilityid);
    }

    return false;
}

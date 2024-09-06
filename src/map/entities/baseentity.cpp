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

#include "baseentity.h"
#include "../map.h"
#include "../zone.h"
#include "../ai/ai_container.h"
#include "../instance.h"
#include "../battlefield.h"

CBaseEntity::CBaseEntity()
{
    id = 0;
    targid = 0;
    objtype = ENTITYTYPE::TYPE_NONE;
    status = STATUS_DISAPPEAR;
    m_TargID = 0;
    memset(&look, 0, sizeof(look));
    memset(&mainlook, 0, sizeof(mainlook));
    memset(&loc, 0, sizeof(loc));
    animation = ANIMATION_NONE;
    animationsub = 0;
    spawnAnimation = SPAWN_ANIMATION::NORMAL;
    speed = 50 + map_config.speed_mod;
    speedsub = 50 + map_config.speed_mod;
    namevis = 1;
    allegiance = 0;
    updatemask = 0;
    PAI = nullptr;
    PBattlefield = nullptr;
    PInstance = nullptr;
    animStart = false;
    animPath = 0;
    animBegin = 0;
}

CBaseEntity::~CBaseEntity()
{
    if (PBattlefield)
        PBattlefield->RemoveEntity(this, BATTLEFIELD_LEAVE_CODE_WARPDC);
}

void CBaseEntity::Spawn()
{
    status = allegiance == ALLEGIANCE_MOB ? STATUS_MOB : STATUS_NORMAL;
    updatemask |= UPDATE_HP;
    ResetLocalVars();
    PAI->Reset();
    PAI->EventHandler.triggerListener("SPAWN", this);
}

void CBaseEntity::FadeOut()
{
    status = STATUS_DISAPPEAR;
    updatemask |= UPDATE_HP;
}

const int8* CBaseEntity::GetName()
{
	return (const int8*)name.c_str();
}

uint16 CBaseEntity::getZone()
{
    return loc.zone != nullptr ? loc.zone->GetID() : loc.destination;
}

float CBaseEntity::GetXPos()
{
	return loc.p.x;
}

float CBaseEntity::GetYPos()
{
	return loc.p.y;
}

float CBaseEntity::GetZPos()
{
	return loc.p.z;
}

uint8 CBaseEntity::GetRotPos()
{
	return loc.p.rotation;
}

void CBaseEntity::HideName(bool hide)
{
	if(hide)
	{
		// I totally guessed this number
		namevis |= FLAG_HIDE_NAME;
	}
	else
	{
		namevis &= ~FLAG_HIDE_NAME;
	}
    updatemask |= UPDATE_HP;
}

bool CBaseEntity::IsNameHidden()
{
	return namevis & FLAG_HIDE_NAME;
}

bool CBaseEntity::IsTargetable()
{
    return (namevis & FLAG_UNTARGETABLE) == 0;
}

bool CBaseEntity::isWideScannable()
{
    return status != STATUS_DISAPPEAR && !IsNameHidden() && IsTargetable();
}

bool CBaseEntity::CanSeeTarget(CBaseEntity* target, bool fallbackNavMesh)
{
    return CanSeeTarget(target->loc.p, fallbackNavMesh);
}

bool CBaseEntity::CanSeeTarget(const position_t& targetPointBase, bool fallbackNavMesh)
{
    if (loc.zone->lineOfSight)
    {
                return loc.zone->lineOfSight->CanEntitySee(this, targetPointBase);
    }
    else if (fallbackNavMesh && loc.zone->m_navMesh)
    {
                return loc.zone->m_navMesh->raycast(loc.p, targetPointBase);
    }

    return true;
}

CBaseEntity* CBaseEntity::GetEntity(uint16 targid, uint8 filter)
{
    if (targid == 0)
        return nullptr;
    else if (PInstance)
        return PInstance->GetEntity(targid, filter);
    else
        return loc.zone->GetEntity(targid, filter);
}

void CBaseEntity::ResetLocalVars()
{
    m_localVars.clear();
}

int32 CBaseEntity::GetLocalVar(const char* var)
{
    return m_localVars[var];
}

void CBaseEntity::SetLocalVar(const char* var, int32 val)
{
    m_localVars[var] = val;
}

void CBaseEntity::SetModelId(uint16 modelid)
{
    look.modelid = modelid;
}

uint16 CBaseEntity::GetModelId()
{
    return look.modelid;
}

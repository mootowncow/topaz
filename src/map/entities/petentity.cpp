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

#include "petentity.h"
#include "../mob_spell_container.h"
#include "../mob_spell_list.h"
#include "../packets/entity_update.h"
#include "../packets/pet_sync.h"
#include "../ai/ai_container.h"
#include "../ai/controllers/pet_controller.h"
#include "../ai/helpers/pathfind.h"
#include "../ai/helpers/targetfind.h"
#include "../ai/states/ability_state.h"
#include "../utils/battleutils.h"
#include "../utils/petutils.h"
#include "../utils/mobutils.h"
#include "../../common/utils.h"
#include "../mob_modifier.h"
#include "../status_effect_container.h"

CPetEntity::CPetEntity(PETTYPE petType)
: CMobEntity()
, m_PetID(0)
, m_PetType(petType)
, m_spawnLevel(0)
, m_jugSpawnTime(time_point::min())
, m_jugDuration(duration::min())
{
	objtype = TYPE_PET;
	m_EcoSystem = SYSTEM_UNCLASSIFIED;
	allegiance = ALLEGIANCE_PLAYER;
    spawnAnimation = SPAWN_ANIMATION::SPECIAL; // Initial spawn has the special spawn-in animation
    m_IsClaimable = false;
    m_MobSkillList = 0;
    m_HasSpellScript = 0;
    namevis = 0;

    PAI = std::make_unique<CAIContainer>(this, std::make_unique<CPathFind>(this), std::make_unique<CPetController>(this),
        std::make_unique<CTargetFind>(this));
}

CPetEntity::~CPetEntity()
{
}

PETTYPE CPetEntity::getPetType()
{
    return m_PetType;
}

uint8 CPetEntity::getSpawnLevel()
{
    return m_spawnLevel;
}

void CPetEntity::setSpawnLevel(uint8 level)
{
    m_spawnLevel = level;
}

bool CPetEntity::isBstPet()
{
  return getPetType() == PETTYPE_JUG_PET || objtype == TYPE_MOB;
}

int32 CPetEntity::getJugSpawnTime()
{
  TPZ_DEBUG_BREAK_IF(m_PetType != PETTYPE_JUG_PET)

  const auto epoch = m_jugSpawnTime.time_since_epoch();
  return static_cast<int32>(std::chrono::duration_cast<std::chrono::seconds>(epoch).count());
}

void CPetEntity::setJugSpawnTime(int32 spawnTime)
{
  TPZ_DEBUG_BREAK_IF(m_PetType != PETTYPE_JUG_PET);

  m_jugSpawnTime = std::chrono::system_clock::time_point(std::chrono::duration<int>(spawnTime));
}

int32 CPetEntity::getJugDuration()
{
  TPZ_DEBUG_BREAK_IF(m_PetType != PETTYPE_JUG_PET);

  return static_cast<int32>(std::chrono::duration_cast<std::chrono::seconds>(m_jugDuration).count());
}

void CPetEntity::setJugDuration(int32 seconds)
{
  TPZ_DEBUG_BREAK_IF(m_PetType != PETTYPE_JUG_PET);

  m_jugDuration = std::chrono::seconds(seconds);
}

std::string CPetEntity::GetScriptName()
{
    switch (getPetType())
    {
        case PETTYPE_AVATAR:
            return "avatar";
            break;
        case PETTYPE_WYVERN:
            return "wyvern";
            break;
        case PETTYPE_JUG_PET:
            return "jug";
            break;
        case PETTYPE_CHARMED_MOB:
            return "charmed";
            break;
        case PETTYPE_AUTOMATON:
            return "automaton";
            break;
        case PETTYPE_ADVENTURING_FELLOW:
            return "fellow";
            break;
        case PETTYPE_CHOCOBO:
            return "chocobo";
            break;
        case PETTYPE_LUOPAN:
            return "luopan";
            break;
        default:
            return "";
            break;
    }
}

WYVERNTYPE CPetEntity::getWyvernType()
{
  TPZ_DEBUG_BREAK_IF(PMaster == nullptr);

  switch(PMaster->GetSJob())
  {
    case JOB_BLM:
    case JOB_BLU:
    case JOB_SMN:
    case JOB_WHM:
    case JOB_RDM:
    case JOB_SCH:
    case JOB_GEO:
      return WYVERNTYPE_DEFENSIVE;
    case JOB_DRK:
    case JOB_PLD:
    case JOB_NIN:
    case JOB_BRD:
    case JOB_RUN:
      return WYVERNTYPE_MULTIPURPOSE;
    case JOB_WAR:
    case JOB_SAM:
    case JOB_THF:
    case JOB_BST:
    case JOB_RNG:
    case JOB_COR:
    case JOB_DNC:
      return WYVERNTYPE_OFFENSIVE;

    default:
      return WYVERNTYPE_OFFENSIVE;
  };
}

void CPetEntity::PostTick()
{
    CBattleEntity::PostTick();
    if (loc.zone && updatemask && status != STATUS_DISAPPEAR)
    {
        loc.zone->PushPacket(this, CHAR_INRANGE, new CEntityUpdatePacket(this, ENTITY_UPDATE, updatemask));

        if (PMaster && PMaster->PPet == this)
        {
            ((CCharEntity*)PMaster)->pushPacket(new CPetSyncPacket((CCharEntity*)PMaster));
        }

        updatemask = 0;
    }
}

void CPetEntity::FadeOut()
{
    CMobEntity::FadeOut();
    loc.zone->UpdateEntityPacket(this, ENTITY_DESPAWN, UPDATE_NONE);
}

void CPetEntity::Die()
{
    PAI->ClearStateStack();
    // master is zoning, don't go to death state, instead despawn instantly
    if (health.hp > 0 && PMaster && PMaster->objtype == TYPE_PC && static_cast<CCharEntity*>(PMaster)->petZoningInfo.respawnPet)
    {
        PAI->Internal_Despawn();
    }
    else
    {
        PAI->Internal_Die(0s);
    }
    m_unkillable = false;
    
    if ((PAI != nullptr) && (PAI->GetController() != nullptr))
    {    
        PAI->GetController()->SetAutoAttackEnabled(true);
        PAI->GetController()->SetMagicCastingEnabled(true);
        PAI->GetController()->SetWeaponSkillEnabled(true);
    }
    
    luautils::OnMobDeath(this, nullptr);
    CBattleEntity::Die();
    if (PMaster && PMaster->PPet == this && PMaster->objtype == TYPE_PC)
    {
        petutils::DetachPet(PMaster);
    }
}

void CPetEntity::Spawn()
{
    //we need to skip CMobEntity's spawn because it calculates stats (and our stats are already calculated)
    uint16 elementalRecast = 30 - PMaster->getMod(Mod::ELEMENTAL_MAGIC_COOL);

    if (PMaster && PMaster->objtype == TYPE_PC && m_EcoSystem == SYSTEM_ELEMENTAL)
    {
        this->defaultMobMod(MOBMOD_MAGIC_DELAY, 0);
        this->defaultMobMod(MOBMOD_MAGIC_COOL, elementalRecast);
        mobutils::GetAvailableSpells(this);
    }

    if (m_PetType == PETTYPE_JUG_PET)
    {
        m_jugSpawnTime = server_clock::now();
    }

    if (PMaster && PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_CONFRONTATION))
    {
        CStatusEffect* confrontation = PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_CONFRONTATION);
        int16 power = confrontation->GetPower();
        int32 tick = confrontation->GetTickTime() / 1000;
        int32 duration = confrontation->GetDuration();
        int32 subid = confrontation->GetSubID();
        int32 subPower = confrontation->GetSubPower();
        int32 tier = confrontation->GetTier();
        this->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_CONFRONTATION, EFFECT_CONFRONTATION, power, tick, duration, subid, subPower, tier));
    }

    CBattleEntity::Spawn();
    // Max [HP/MP] Boost mods
    this->UpdateHealth();
    this->health.tp = 0;
    this->health.hp = this->GetMaxHP();
    this->health.mp = this->GetMaxMP();
    PAI->EventHandler.triggerListener("SPAWN", this);
    luautils::OnMobSpawn(this);
}

bool CPetEntity::shouldDespawn(time_point tick)
{
    // This check was moved from the original call site when this method was added.
    // It is in theory not needed, but we are not removing it without further testing.
    // TODO: Consider removing this when possible.
    if (isCharmed && tick > charmTime)
    {
        return true;
    }

    if (PMaster != nullptr && PAI->IsSpawned() && m_PetType == PETTYPE_JUG_PET && tick > m_jugSpawnTime + m_jugDuration)
    {
        return true;
    }

    return false;
}

void CPetEntity::loadPetZoningInfo()
{
    if (!PAI->IsSpawned())
    {
        ShowWarning("Attempt to load info without Pet spawned.");
        return;
    }

    if (auto* master = dynamic_cast<CCharEntity*>(PMaster))
    {
        health.tp = static_cast<uint16>(master->petZoningInfo.petTP);
        health.hp = master->petZoningInfo.petHP;
        health.mp = master->petZoningInfo.petMP;

        if (m_PetType == PETTYPE_JUG_PET)
        {
            setJugDuration(master->petZoningInfo.jugDuration);
            setJugSpawnTime(master->petZoningInfo.jugSpawnTime);
        }
    }
}

void CPetEntity::OnAbility(CAbilityState& state, action_t& action)
{
    auto PAbility = state.GetAbility();
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    std::unique_ptr<CBasicPacket> errMsg;
    if (PTarget && IsValidTarget(PTarget->targid, PAbility->getValidTarget(), errMsg))
    {
        if (this != PTarget && distance(this->loc.p, PTarget->loc.p) > PAbility->getRange())
        {
            return;
        }

        // Currently, only the Wyvern uses abilities at all as of writing, but their abilities are not instant and are mob abilities.
        // Abilities are not subject to paralyze if they have non-zero cast time due to this corner case.
        if (state.GetAbility()->getCastTime() == 0s && battleutils::IsParalyzed(this))
        {
            setActionInterrupted(action, PTarget, MSGBASIC_IS_PARALYZED_2, 0);
            return;
        }

        action.id = this->id;
        action.actiontype = PAbility->getActionType();
        action.actionid = PAbility->getID();
        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = PTarget->id;
        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.reaction = REACTION_NONE;
        actionTarget.speceffect = SPECEFFECT_RECOIL;
        actionTarget.animation = PAbility->getAnimationID();
        actionTarget.param = 0;
        auto prevMsg = actionTarget.messageID;

        int32 value = luautils::OnUseAbility(this, PTarget, PAbility, &action);
        if (prevMsg == actionTarget.messageID) actionTarget.messageID = PAbility->getMessage();
        if (actionTarget.messageID == 0) actionTarget.messageID = MSGBASIC_USES_JA;
        actionTarget.param = value;

        if (value < 0)
        {
            actionTarget.messageID = ability::GetAbsorbMessage(actionTarget.messageID);
            actionTarget.param = -value;
        }
    }
    else // Can't target anything, just cancel the animation.
    {
        action.actiontype = ACTION_MOBABILITY_INTERRUPT;
        action.actionid = 28787; // Some hardcoded magic for interrupts
        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation = 0x1FC;
        actionTarget.messageID = 0;
        actionTarget.reaction = REACTION_ABILITY_HIT;
    }
}

bool CPetEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    if (targetFlags & TARGET_PLAYER && PInitiator->allegiance == allegiance)
    {
        return false;
    }
    return CMobEntity::ValidTarget(PInitiator, targetFlags);
}

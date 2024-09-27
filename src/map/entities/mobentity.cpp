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

#include "mobentity.h"

#include <string.h>
#include "../../common/timer.h"
#include "../../common/utils.h"
#include "../ai/ai_container.h"
#include "../ai/controllers/mob_controller.h"
#include "../ai/controllers/player_controller.h"
#include "../ai/helpers/pathfind.h"
#include "../ai/helpers/targetfind.h"
#include "../ai/states/attack_state.h"
#include "../ai/states/weaponskill_state.h"
#include "../ai/states/mobskill_state.h"
#include "../ai/states/item_state.h"
#include "../ai/states/magic_state.h"
#include "../ai/states/ability_state.h"
#include "../ai/states/range_state.h"
#include "../entities/charentity.h"
#include "../packets/action.h"
#include "../packets/entity_update.h"
#include "../packets/pet_sync.h"
#include "../utils/battleutils.h"
#include "../utils/blueutils.h"
#include "../utils/charutils.h"
#include "../utils/itemutils.h"
#include "../utils/mobutils.h"
#include "../utils/petutils.h"
#include "../status_effect_container.h"
#include "../enmity_container.h"
#include "../mob_spell_container.h"
#include "../mob_spell_list.h"
#include "../mob_modifier.h"
#include "../weapon_skill.h"
#include "../mobskill.h"
#include "../roe.h"
#include "../treasure_pool.h"
#include "../conquest_system.h"
#include "../utils/zoneutils.h"
#include "../packets/chat_message.h"
#include "../ability.h"
#include "../attack.h"

int32 g_pixieAmity = 0;
time_t g_pixieLastAmityRefresh = 0;


CMobEntity::CMobEntity()
{
    objtype = TYPE_MOB;

    m_DropID = 0;

    m_minLevel = 1;
    m_maxLevel = 1;

    HPscale = 1.0;
    MPscale = 1.0;
    m_flags = 0;

    allegiance = ALLEGIANCE_MOB;

    // default to normal roaming
    m_roamFlags = ROAMFLAG_NONE;
    m_specialFlags = SPECIALFLAG_NONE;
    m_name_prefix = 0;
    m_MobSkillList = 0;

    m_AllowRespawn = 0;
    m_DropItemTime = 0;
    m_Family = 0;
    m_Type = MOBTYPE_NORMAL;
    m_Behaviour = BEHAVIOUR_NONE;
    m_SpawnType = SPAWNTYPE_NORMAL;
    m_EcoSystem = SYSTEM_UNCLASSIFIED;
    m_Element = 0;
    m_HiPCLvl = 0;
    m_HiPartySize = 0;
    m_THLvl = 0;
    m_ItemStolen = false;
    m_autoTargetReady = true;
    m_autoTargetKiller = nullptr;


    strRank = 3;
    vitRank = 3;
    agiRank = 3;
    intRank = 3;
    mndRank = 3;
    chrRank = 3;
    attRank = 3;
    defRank = 3;
    accRank = 3;
    evaRank = 3;

    m_dmgMult = 100;

    m_giveExp = false;
    m_neutral = false;
    m_Aggro = false;
    m_TrueDetection = 0;
    m_Detects = DETECT_NONE;
    m_Link = 0;

    m_battlefieldID = 0;
    m_bcnmID = 0;

    m_maxRoamDistance = 50.0f;
    m_disableScent = false;

    memset(&m_SpawnPoint, 0, sizeof(m_SpawnPoint));

    m_SpellListContainer = nullptr;
    PEnmityContainer = new CEnmityContainer(this);
    SpellContainer = new CMobSpellContainer(this);

    m_pixieLastCast = 0;

    // For Dyna Stats
    m_StatPoppedMobs = false;


    m_IsClaimable = true;
    m_forceCast = false;

    PAI = std::make_unique<CAIContainer>(this, std::make_unique<CPathFind>(this), std::make_unique<CMobController>(this),
        std::make_unique<CTargetFind>(this));
}

uint32 CMobEntity::getEntityFlags()
{
    return m_flags;
}

void CMobEntity::setEntityFlags(uint32 EntityFlags)
{
    m_flags = EntityFlags;
}

CMobEntity::~CMobEntity()
{
    delete PEnmityContainer;
    delete SpellContainer;
}

/************************************************************************
*                                                                       *
*  Время исчезновения монстра в секундах                                *
*                                                                       *
************************************************************************/

time_point CMobEntity::GetDespawnTime()
{
    return m_DespawnTimer;
}

void CMobEntity::SetDespawnTime(duration _duration)
{
    if (_duration > 0s)
    {
        m_DespawnTimer = server_clock::now() + _duration;
    }
    else
    {
        m_DespawnTimer = time_point::min();
    }
}

uint32 CMobEntity::GetRandomGil()
{

    int16 min = getMobMod(MOBMOD_GIL_MIN);
    int16 max = getMobMod(MOBMOD_GIL_MAX);

    if (min && max)
    {
        // make sure divide won't crash server
        if (max <= min)
        {
            max = min + 2;
        }

        if (max - min < 2)
        {
            max = min + 2;
            ShowWarning("CMobEntity::GetRandomGil Max value is set too low, defauting\n");
        }

        return tpzrand::GetRandomNumber(min, max);
    }

    float gil = (float)pow(GetMLevel(), 1.05f);

    if (gil < 1) {
        gil = 1;
    }

    uint16 highGil = (uint16)(gil / 3 + 4);

    if (max)
    {
        highGil = max;
    }

    if (highGil < 2) {
        highGil = 2;
    }

    // randomize it
    gil += tpzrand::GetRandomNumber(highGil);

    if (min && gil < min)
    {
        gil = min;
    }

    if (getMobMod(MOBMOD_GIL_BONUS) != 0)
    {
        gil *= (getMobMod(MOBMOD_GIL_BONUS) / 100.0f);
    }

    return (uint32)gil;
}

bool CMobEntity::CanDropGil()
{
    // smaller than 0 means drop no gil
    if (getMobMod(MOBMOD_GIL_MAX) < 0) return false;

    if (getMobMod(MOBMOD_GIL_MIN) > 0 || getMobMod(MOBMOD_GIL_MAX))
    {
        return true;
    }

    return getMobMod(MOBMOD_GIL_BONUS) > 0;
}

bool CMobEntity::CanStealGil()
{
    // TODO: Some mobs cannot be mugged
    return CanDropGil();
}

void CMobEntity::ResetGilPurse()
{
    uint32 purse = GetRandomGil() / ((tpzrand::GetRandomNumber(4, 7)));
    if (purse == 0)
        purse = GetRandomGil();
    setMobMod(MOBMOD_MUG_GIL, purse);
}

bool CMobEntity::CanRoamHome()
{
    if ((speed == 0 && !(m_roamFlags & ROAMFLAG_WORM)) || getMobMod(MOBMOD_NO_MOVE) > 0) return false;

    if (getMobMod(MOBMOD_NO_DESPAWN) != 0 ||
        map_config.mob_no_despawn)
    {
        return true;
    }

    return distance(m_SpawnPoint, loc.p) < roam_home_distance;
}

bool CMobEntity::CanRoam()
{
    return !(m_roamFlags & ROAMFLAG_EVENT) && PMaster == nullptr && (speed > 0 || (m_roamFlags & ROAMFLAG_WORM)) && getMobMod(MOBMOD_NO_MOVE) == 0;
}

bool CMobEntity::CanLink(position_t* pos, int16 superLink)
{
    float linkRadius = getMobMod(MOBMOD_LINK_RADIUS);

    // handle super linking
    if (superLink && getMobMod(MOBMOD_SUPERLINK) == superLink)
    {
        return true;
    }

    // can't link right now
    if (m_neutral)
    {
        return false;
    }

    // Don't link I'm an underground worm
    if ((m_roamFlags & ROAMFLAG_WORM) && IsNameHidden())
    {
        return false;
    }

    // Don't link I'm an underground antlion
    if ((m_roamFlags & ROAMFLAG_AMBUSH) && IsNameHidden())
    {
        return false;
    }

    bool canDetectTarget = false;
    if (m_Detects & DETECT_SIGHT) // Sight link
    {
        if (facing(loc.p, *pos, 64))
        {
            canDetectTarget = true;
        }
    }

    if (m_Detects & DETECT_HEARING) // Sound link
    {
        if (distance(loc.p, *pos) <= linkRadius)
        {
            canDetectTarget = true;
        }
    }

    if (!canDetectTarget)
    {
        return false;
    }

    if (distance(loc.p, *pos) > linkRadius)
    {
        return false;
    }

    if (getMobMod(MOBMOD_NO_LINK) > 0)
    {
        return false;
    }

    if (!CanSeeTarget(*pos)) // Make sure target is within LoS (I.e. don't link through walls/floor)
    {
        return false;
    }

    return true;
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

bool CMobEntity::CanDeaggro()
{
    return !(m_Type & MOBTYPE_NOTORIOUS || m_Type & MOBTYPE_BATTLEFIELD || m_Type & MOBTYPE_QUEST);
}

bool CMobEntity::IsFarFromHome()
{
    return distance(loc.p, m_SpawnPoint) > m_maxRoamDistance;
}

bool CMobEntity::CanBeNeutral()
{
    return !(m_Type & MOBTYPE_NOTORIOUS || m_Type & MOBTYPE_QUEST);
}

bool CMobEntity::isPlayerRaceFamily()
{
    return (m_Family >= 145 && m_Family <= 154 || m_Family == 971 || m_Family == 972);
}

uint16 CMobEntity::TPUseChance()
{
    auto& MobSkillList = battleutils::GetMobSkillList(getMobMod(MOBMOD_SKILL_LIST));
    if (StatusEffectContainer->HasStatusEffect(EFFECT_MEIKYO_SHISUI) && health.tp >= 1000)
    {
        return 10000;
    }
    else if (getMobMod(MOBMOD_TP_USE) > 0 && health.tp >= getMobMod(MOBMOD_TP_USE))
    {
        return 10000;
    }
    else if (allegiance == ALLEGIANCE_PLAYER && health.tp >= 1000) // NPC's use TP at 1k like a player
    {
        return 10000;
    }
    else
    {
        if (health.tp < 1000 || MobSkillList.empty() || !static_cast<CMobController*>(PAI->GetController())->IsWeaponSkillEnabled())
        {
            return 0;
        }

		if (health.tp == 3000 || (GetHPP() <= 25 && health.tp >= 1000))
        {
            return 10000;
        }
        else if (health.tp > 1999)
        {
            return 45;
        }
        else
        {
            return 20;
        }
    }

    return (uint16)getMobMod(MOBMOD_TP_USE_CHANCE);
}

void CMobEntity::setMobMod(uint16 type, int16 value)
{
    m_mobModStat[type] = value;
}

int16 CMobEntity::getMobMod(uint16 type)
{
    return m_mobModStat[type];
}

void CMobEntity::addMobMod(uint16 type, int16 value)
{
    m_mobModStat[type] += value;
}

void CMobEntity::defaultMobMod(uint16 type, int16 value)
{
    if (m_mobModStat[type] == 0)
    {
        m_mobModStat[type] = value;
    }
}

void CMobEntity::resetMobMod(uint16 type)
{
    m_mobModStat[type] = m_mobModStatSave[type];
}

int32 CMobEntity::getBigMobMod(uint16 type)
{
    return getMobMod(type) * 1000;
}

void CMobEntity::saveMobModifiers()
{
    m_mobModStatSave = m_mobModStat;
}

void CMobEntity::restoreMobModifiers()
{
    m_mobModStat = m_mobModStatSave;
}

void CMobEntity::HideHP(bool hide)
{
    if (hide)
    {
        m_flags |= FLAG_HIDE_HP;
    }
    else
    {
        m_flags &= ~FLAG_HIDE_HP;
    }
    updatemask |= UPDATE_HP;
}

bool CMobEntity::IsHPHidden()
{
    return m_flags & FLAG_HIDE_HP;
}

bool CMobEntity::IsHumanoid()
{
    return this->m_EcoSystem == SYSTEM_BEASTMEN || this->m_EcoSystem == SYSTEM_HUMANOID || this->m_Family == 3 || this->m_Family == 115 ||
        this->m_Family == 359 || this->m_Family == 509 || this->m_Family == 221 || this->m_Family == 222 || this->m_Family == 223 || this->m_Family == 169 ||
           this->m_Family == 358 || this->m_Family == 329 || this->m_Family == 927 || this->m_Family == 928 || this->m_Family == 61 || this->m_Family == 597;
}



void CMobEntity::CallForHelp(bool call)
{
    if (call)
    {
        m_flags |= FLAG_CALL_FOR_HELP;
        m_OwnerID.clean();
    }
    else
    {
        m_flags &= ~FLAG_CALL_FOR_HELP;
    }
    updatemask |= UPDATE_COMBAT;
}

bool CMobEntity::CalledForHelp()
{
    return m_flags & FLAG_CALL_FOR_HELP;
}

void CMobEntity::Untargetable(bool untargetable)
{
    if (untargetable)
    {
        m_flags |= FLAG_UNTARGETABLE;
    }
    else
    {
        m_flags &= ~FLAG_UNTARGETABLE;
    }
    updatemask |= UPDATE_HP;
}

bool CMobEntity::IsUntargetable()
{
    return m_flags & FLAG_UNTARGETABLE;
}

void CMobEntity::DoAutoTarget()
{
    if (!m_autoTargetReady)
        return;
    m_autoTargetReady = false;

    // logic walk-thru:
    // check each alliance-member of mob claimer if they were engaged with this mob when it died
    // person who landed the final blow designates a new target for the alliance (closest mob to that person)
    // which is a mob that is trying to attack a player and can be attacked by the alliance (white or red name mob)
    // this way, when auto-target triggers, the entire alliance/party will always engage on the same mob together
    // it is no longer a requirement for players to face towards a mob in order to auto-target it

    CCharEntity* POwner = nullptr;
    if (this->m_autoTargetKiller)
        POwner = m_autoTargetKiller;
    else if (this->m_OwnerID.id)
        POwner = zoneutils::GetChar(m_OwnerID.id);
    if (!POwner)
        return;
    CZone* PZone = zoneutils::GetZone(POwner->getZone());
    if (!PZone)
        return;

    PZone->ForEachChar(
    [](CCharEntity* PChar)
    {
        if (PChar && PChar->objtype == TYPE_PC)
            PChar->m_autoTargetOverride = nullptr;
    });

    PZone->ForEachChar(
        [this, POwner, PZone](CCharEntity* PChar)
        {
            bool success = false;

            if (PChar && PChar->objtype == TYPE_PC && PChar->loc.zone->GetID() == this->loc.zone->GetID() && PChar->m_LastEngagedTargID == this->targid &&
                PChar->m_hasAutoTarget)
            {
                CCharEntity* PMember = PChar;
                std::unique_ptr<CBasicPacket> errMsg;
                if (PMember->m_autoTargetOverride)
                {
                    if (PMember->m_autoTargetOverride->allegiance == ALLEGIANCE_MOB && PMember->IsMobOwner(PMember->m_autoTargetOverride) &&
                        !((CBattleEntity*)(PMember->m_autoTargetOverride)->IsNameHidden()) &&
                        distanceSquared(PMember->loc.p, PMember->m_autoTargetOverride->loc.p) < 29.0f * 29.0f)
                    {
                        auto controller{ static_cast<CPlayerController*>(PMember->PAI->GetController()) };
                        success = controller->ChangeTarget(PMember->m_autoTargetOverride->targid);
                    }
                }
                else
                {
                    auto controller{ static_cast<CPlayerController*>(PMember->PAI->GetController()) };
                    CMobEntity* PWinner = nullptr;
                    for (auto&& PPotentialTarget : PMember->SpawnMOBList)
                    {
                        CBattleEntity* PMob = (CBattleEntity*)PPotentialTarget.second;

                        if ((PMob->objtype == TYPE_MOB || PMob->objtype == TYPE_PET) && PMob->animation == ANIMATION_ATTACK &&
                            PMob->allegiance == ALLEGIANCE_MOB && PMember->IsMobOwner(PMob) && !PMob->IsNameHidden() && PMob->id != this->id &&
                            distanceSquared(PMember->loc.p, PMob->loc.p) < 29 * 29 && !PMember->m_autoTargetOverride)
                        {
                            if (PWinner)
                            {
                                if (distanceSquared(PMob->loc.p, POwner->loc.p) < distanceSquared(PWinner->loc.p, POwner->loc.p))
                                    PWinner = (CMobEntity*)PMob;
                            }
                            else
                            {
                                PWinner = (CMobEntity*)PMob;
                            }
                        }
                    }
                    if (PWinner)
                    {
                        success = controller->ChangeTarget(PWinner->targid);
                        PZone->ForEachChar(
                            [PMember, PWinner](CCharEntity* PMembermember)
                            {
                                if (PMembermember->objtype == TYPE_PC && PMembermember->loc.zone->GetID() == PMember->loc.zone->GetID() &&
                                    PMembermember->animation == ANIMATION_ATTACK)
                                    PMembermember->m_autoTargetOverride = (CBattleEntity*)PWinner;
                                // Player pet should auto-target too(if the pet is not currently healing)
                                if (((CCharEntity*)PMembermember)->PPet != nullptr &&
                                    !((CCharEntity*)PMembermember)->PPet->StatusEffectContainer->HasStatusEffect(EFFECT_HEALING))
                                {
                                    petutils::AttackTarget((CBattleEntity*)((CCharEntity*)PMembermember), (CBattleEntity*)PWinner);
                                }
                            });
                    }
                }
            }

            if (!success && PChar && PChar->objtype == TYPE_PC)
                PChar->m_LastEngagedTargID = 0;
        });
}


void CMobEntity::PostTick()
{
    CBattleEntity::PostTick();
    if (loc.zone && updatemask)
    {
        loc.zone->PushPacket(this, CHAR_INRANGE, new CEntityUpdatePacket(this, ENTITY_UPDATE, updatemask));

        // If this mob is charmed, it should sync with its master
        if (PMaster && PMaster->PPet == this && PMaster->objtype == TYPE_PC)
        {
            ((CCharEntity*)PMaster)->pushPacket(new CPetSyncPacket((CCharEntity*)PMaster));
        }

        updatemask = 0;
    }
}

float CMobEntity::GetRoamDistance()
{
    return (float)getMobMod(MOBMOD_ROAM_DISTANCE);
}

float CMobEntity::GetRoamRate()
{
    return (float)getMobMod(MOBMOD_ROAM_RATE) / 10.0f;
}

void CMobEntity::OnAbility(CAbilityState& state, action_t& action)
{
    auto PAbility = state.GetAbility();
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    std::unique_ptr<CBasicPacket> errMsg;
    if (PTarget && IsValidTarget(PTarget->targid, PAbility->getValidTarget(), errMsg))
    {
        // Log target validity and distance

        if (this != PTarget && distance(this->loc.p, PTarget->loc.p) > PAbility->getRange())
        {
            setActionInterrupted(action, PTarget, MSGBASIC_TOO_FAR_AWAY, 0);
            return;
        }

        if (state.GetAbility()->getCastTime() == 0s && battleutils::IsParalyzed(this))
        {
            setActionInterrupted(action, PTarget, MSGBASIC_IS_PARALYZED_2, 0);
            return;
        }

        action.id = this->id;
        action.actiontype = PAbility->getActionType();
        action.actionid = PAbility->getID();

        std::vector<CBattleEntity*> targets = { PTarget };
        if (PAbility->isAoE())
        {
            PAI->TargetFind->reset();
            PAI->TargetFind->findWithinArea(this, AOERADIUS_ATTACKER, PAbility->getRange());
            targets = PAI->TargetFind->m_targets;
        }

        bool first = true;
        for (auto&& PTarget : targets)
        {
            actionList_t& actionList = action.getNewActionList();
            actionList.ActionTargetID = PTarget->id;
            actionTarget_t& actionTarget = actionList.getNewActionTarget();
            actionTarget.reaction = REACTION_NONE;
            actionTarget.speceffect = SPECEFFECT_NONE;
            actionTarget.animation = PAbility->getAnimationID();
            actionTarget.messageID = 0;
            actionTarget.param = 0;

            if (PTarget->isSuperJumped)
            {
                actionTarget.animation = ANIMATION_NONE;
                actionTarget.messageID = 0;
            }
            else
            {
                int32 value = luautils::OnUseAbility(this, PTarget, PAbility, &action);

                if (actionTarget.messageID == 0)
                {
                    actionTarget.messageID = first ? PAbility->getMessage() : PAbility->getAoEMsg();
                }

                if (first && actionTarget.messageID == 0)
                    actionTarget.messageID = MSGBASIC_USES_JA;

                actionTarget.param = value;

                if (value < 0)
                {
                    actionTarget.messageID = ability::GetAbsorbMessage(actionTarget.messageID);
                    actionTarget.param = -value;
                }

                state.ApplyEnmity();
            }

            first = false;
        }
    }
    else
    {
        action.actiontype = ACTION_MOBABILITY_INTERRUPT;
        action.actionid = 28787;
        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = id;
        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation = 0x1FC;
        actionTarget.messageID = 0;
        actionTarget.reaction = REACTION_ABILITY_HIT;
    }
}

void CMobEntity::OnRangedAttack(CRangeState& state, action_t& action)
{
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    if (battleutils::IsParalyzed(this))
    {
        // setup new action packet to send paralyze message
        action_t paralyze_action = {};
        setActionInterrupted(paralyze_action, PTarget, MSGBASIC_IS_PARALYZED, 0);
        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, new CActionPacket(paralyze_action));

        // Set up /ra action to be interrupted
        action.actiontype = ACTION_RANGED_INTERRUPT; // This handles some magic numbers in CActionPacket to cancel actions
        action.id = id;

        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation = 0x1FC; // Seems hardcoded, two bits away from 0x1FF (0x1FC = 1 1111 1100)
        actionTarget.speceffect = SPECEFFECT::SPECEFFECT_RECOIL;
        actionTarget.reaction = REACTION::REACTION_NONE;

        return;
    }

    int32 damage = 0;
    int32 totalDamage = 0;

    action.id = id;
    action.actiontype = ACTION_RANGED_FINISH;

    actionList_t& actionList = action.getNewActionList();
    actionList.ActionTargetID = PTarget->id;

    actionTarget_t& actionTarget = actionList.getNewActionTarget();
    actionTarget.reaction = REACTION_HIT;     // 0x10
    actionTarget.speceffect = SPECEFFECT_HIT; // 0x60 (SPECEFFECT_HIT + SPECEFFECT_RECOIL)
    actionTarget.messageID = 352;

    uint8 slot = SLOT_RANGED;

    uint8 shadowsTaken = 0;
    uint8 hitCount = 1; // 1 hit by default
    uint8 realHits = 0; // to store the real number of hit for tp multipler
    auto ammoConsumed = 0;
    bool hitOccured = false; // track if player hit mob at all
    bool isBarrage = this->StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE, 0);

    // Calculate barrage
    if (isBarrage)
    {
        uint8 lvl = this->GetMLevel();

        if (lvl < 30)
            hitCount += 0;
        else if (lvl < 50)
            hitCount += 3;
        else if (lvl < 75)
            hitCount += 4;
        else if (lvl < 90)
            hitCount += 5;
        else if (lvl < 99)
            hitCount += 6;
        else if (lvl >= 99)
            hitCount += 7;
        // Add + Barrage gear mod
        hitCount += this->getMod(Mod::BARRAGE_SHOT_COUNT); 
    }
    else if (this->StatusEffectContainer->HasStatusEffect(EFFECT_DOUBLE_SHOT) && tpzrand::GetRandomNumber(100) < (this->getMod(Mod::DOUBLE_SHOT_RATE)))
    {
        hitCount = 2;
    }
    else if (this->StatusEffectContainer->HasStatusEffect(EFFECT_TRIPLE_SHOT) && tpzrand::GetRandomNumber(100) < (this->getMod(Mod::TRIPLE_SHOT_RATE)))
    {
        hitCount = 3;
    }
    // loop for barrage hits, if a miss occurs, the loop will end
    for (uint8 i = 1; i <= hitCount; ++i)
    {
        if (tpzrand::GetRandomNumber(100) < battleutils::GetRangedHitRate(this, PTarget, isBarrage)) // hit!
        {
            // absorbed by shadow
            if (battleutils::IsAbsorbByShadow(PTarget, this))
            {
                shadowsTaken++;
            }
            else
            {
                bool isCritical = tpzrand::GetRandomNumber(100) < battleutils::GetRangedCritHitRate(this, PTarget, true);
                float pdif = battleutils::GetRangedDamageRatio(this, PTarget, isCritical);

                if (isCritical)
                {
                    actionTarget.speceffect = SPECEFFECT_CRITICAL_HIT;
                    actionTarget.messageID = 353;

                    luautils::OnCriticalHit(PTarget, this);
                }

                // at least 1 hit occured
                hitOccured = true;
                realHits++;

                damage = (int32)((this->GetRangedWeaponDmg() + battleutils::GetFSTR(this, PTarget, slot)) * pdif);
            }
        }
        else // miss
        {
            damage = 0;
            actionTarget.reaction = REACTION_EVADE;
            actionTarget.speceffect = SPECEFFECT_NONE;
            actionTarget.messageID = 354;
            hitCount = i; // end barrage, shot missed
        }

        totalDamage += damage;

        // Stop adding hits if target would die before calculating other hits
        if (PTarget->health.hp <= totalDamage)
        {
            break;
        }
    }

    // if a hit did occur (even without barrage)
    if (hitOccured == true)
    {
        // any misses with barrage cause remaing shots to miss, meaning we must check Action.reaction
        if (actionTarget.reaction == REACTION_EVADE && (this->StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE)))
        {
            actionTarget.messageID = 352;
            actionTarget.reaction = REACTION_HIT;
            actionTarget.speceffect = SPECEFFECT_CRITICAL_HIT;
        }
        actionTarget.param = battleutils::TakePhysicalDamage(this, PTarget, PHYSICAL_ATTACK_TYPE::RANGED, totalDamage, false, slot, realHits, nullptr, true, true);

        // lower damage based on shadows taken
        if (shadowsTaken)
            actionTarget.param = (int32)(actionTarget.param * (1 - ((float)shadowsTaken / realHits)));

        // absorb message
        if (actionTarget.param < 0)
        {
            actionTarget.param = -(actionTarget.param);
            actionTarget.messageID = 382;
        }

        // Handle frontal PDT
        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PHYSICAL_SHIELD) && infront(this->loc.p, PTarget->loc.p, 64))
        {
            int power = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_PHYSICAL_SHIELD)->GetPower();
            float resist = 1.0f;
            if (power == 3)
            {
                resist = 0;
            }
            actionTarget.param = (int32)(actionTarget.param * (float)resist);
        }
        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PHYSICAL_SHIELD) && infront(this->loc.p, PTarget->loc.p, 64))
        {
            int power = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_PHYSICAL_SHIELD)->GetPower();
            float resist = 1.0f;
            if (power == 5)
            {
                resist = 0.25f;
            }
            actionTarget.param = (int32)(actionTarget.param * (float)resist);
        }
        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PHYSICAL_SHIELD) && infront(this->loc.p, PTarget->loc.p, 64))
        {
            int power = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_PHYSICAL_SHIELD)->GetPower();
            float resist = 1.0f;
            if (power == 6)
            {
                resist = 0.5f;
            }
            actionTarget.param = (int32)(actionTarget.param * (float)resist);
        }

        // Handle Behind PDT
        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PHYSICAL_SHIELD) && behind(this->loc.p, PTarget->loc.p, 64))
        {
            int power = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_PHYSICAL_SHIELD)->GetPower();
            float resist = 1.0f;
            if (power == 4)
            {
                resist = 0;
            }
            actionTarget.param = (int32)(actionTarget.param * (float)resist);
        }
        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PHYSICAL_SHIELD) && behind(this->loc.p, PTarget->loc.p, 64))
        {
            int power = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_PHYSICAL_SHIELD)->GetPower();
            float resist = 1.0f;
            if (power == 7)
            {
                resist = 0.25f;
            }
            actionTarget.param = (int32)(actionTarget.param * (float)resist);
        }
        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PHYSICAL_SHIELD) && behind(this->loc.p, PTarget->loc.p, 64))
        {
            int power = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_PHYSICAL_SHIELD)->GetPower();
            float resist = 1.0f;
            if (power == 8)
            {
                resist = 0.5f;
            }
            actionTarget.param = (int32)(actionTarget.param * (float)resist);
        }
    }
    else if (shadowsTaken > 0)
    {
        // shadows took damage
        actionTarget.messageID = 0;
        actionTarget.reaction = REACTION_EVADE;
        PTarget->loc.zone->PushPacket(PTarget, CHAR_INRANGE_SELF, new CMessageBasicPacket(PTarget, PTarget, 0, shadowsTaken, MSGBASIC_SHADOW_ABSORB));
    }
    if (actionTarget.speceffect == SPECEFFECT_HIT && actionTarget.param > 0)
        actionTarget.speceffect = SPECEFFECT_RECOIL;
    // TODO: luautils::OnAdditionalEffectRanged(PAttacker, PDefender, weapon, Action, finaldamage);?

    // remove barrage effect if present
    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE, 0))
    {
        StatusEffectContainer->DelStatusEffect(EFFECT_BARRAGE, 0);
    }
    battleutils::ClaimMob(PTarget, this);
    // only remove detectables and NOT camouflage
    if (!StatusEffectContainer->HasStatusEffect(EFFECT_CAMOUFLAGE))
        StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);

    if (hitOccured == false && PTarget->objtype == TYPE_MOB)
    {
        // 1 ce for a missed attack for TH application
        ((CMobEntity*)PTarget)->PEnmityContainer->UpdateEnmity((CBattleEntity*)this, 1, 0);
    }

    // Try to double shot
    // #TODO: figure out the packet structure of double/triple shot
    // if (this->StatusEffectContainer->HasStatusEffect(EFFECT_DOUBLE_SHOT, 0) && !this->secondDoubleShotTaken &&	!isBarrage)
    //{
    //    uint16 doubleShotChance = getMod(Mod::DOUBLE_SHOT_RATE);
    //    if (tpzrand::GetRandomNumber(100) < doubleShotChance)
    //    {
    //        this->secondDoubleShotTaken = true;
    //        m_ActionType = ACTION_RANGED_FINISH;
    //        this->m_rangedDelay = 0;
    //        return;
    //    }
    //}
}

bool CMobEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    if (StatusEffectContainer->GetConfrontationEffect() != PInitiator->StatusEffectContainer->GetConfrontationEffect())
    {
        return false;
    }
    if (CBattleEntity::ValidTarget(PInitiator, targetFlags))
    {
        return true;
    }
    if (targetFlags & TARGET_PLAYER_DEAD && (m_Behaviour & BEHAVIOUR_RAISABLE)
        && isDead())
    {
        return true;
    }

    if ((targetFlags & TARGET_PLAYER) && allegiance == PInitiator->allegiance && !isCharmed)
    {
        return true;
    }

    if (targetFlags & TARGET_NPC)
    {
        if (allegiance == PInitiator->allegiance && !(m_Behaviour & BEHAVIOUR_NOHELP) && !isCharmed)
        {
            return true;
        }
    }

    return false;
}

void CMobEntity::Spawn()
{
    CBattleEntity::Spawn();
    m_giveExp = true;
    m_HiPCLvl = 0;
    m_HiPartySize = 0;
    m_THLvl = 0;
    m_ItemStolen = false;
    m_autoTargetReady = true;
    m_autoTargetKiller = nullptr;
    m_DropItemTime = 1000;
    animationsub = (uint8)getMobMod(MOBMOD_SPAWN_ANIMATIONSUB);
    CallForHelp(false);

    PEnmityContainer->Clear();

    uint8 level = m_minLevel;

    // Generate a random level between min and max level
    if (m_maxLevel > m_minLevel)
    {
        level += tpzrand::GetRandomNumber(0, m_maxLevel - m_minLevel + 1);
    }

    SetMLevel(level);
    SetSLevel(level);//calculated in function

    // Don't calculate spells/stats again if a monster pet, they've already been calculated in petutils.cpp
    if (objtype != TYPE_PET)
    {
        mobutils::CalculateMobStats(this, true);
        mobutils::GetAvailableSpells(this);
    }

    // spawn somewhere around my point
    loc.p = m_SpawnPoint;

    if (m_roamFlags & ROAMFLAG_STEALTH)
    {
        HideName(true);
        Untargetable(true);
    }

    // add people to my posse
    if (getMobMod(MOBMOD_ASSIST))
    {
        for (int8 i = 1; i < getMobMod(MOBMOD_ASSIST) + 1; i++)
        {
            CMobEntity* PMob = (CMobEntity*)GetEntity(targid + i, TYPE_MOB);

            if (PMob != nullptr)
            {
                PMob->setMobMod(MOBMOD_SUPERLINK, targid);
            }
        }
    }

    m_DespawnTimer = time_point::min();
    // Max [HP/MP] Boost mods
    this->UpdateHealth();
    this->health.tp = 0;
    this->health.hp = this->GetMaxHP();
    this->health.mp = this->GetMaxMP();
    PAI->EventHandler.triggerListener("SPAWN", this);
    luautils::OnMobSpawn(this);
}

void CMobEntity::OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action)
{
    CBattleEntity::OnWeaponSkillFinished(state, action);

    auto PWeaponSkill = state.GetSkill();
    auto PBattleTarget = static_cast<CBattleEntity*>(state.GetTarget());

    int16 tp = state.GetSpentTP();
    tp = battleutils::CalculateWeaponSkillTP(this, PWeaponSkill, tp);

    SLOTTYPE damslot = SLOT_MAIN;
    bool isRangedWS = (PWeaponSkill->getID() >= 192 && PWeaponSkill->getID() <= 218);

    // Check if target is alive
    if (PBattleTarget->GetHPP() < 1)
        return;

    if (distance(loc.p, PBattleTarget->loc.p) - PBattleTarget->m_ModelSize <= PWeaponSkill->getRange())
    {
        PAI->TargetFind->reset();
        // #TODO: revise parameters
        if (PWeaponSkill->isAoE())
        {
            PAI->TargetFind->findWithinArea(PBattleTarget, AOERADIUS_TARGET, 10);
        }
        else
        {
            PAI->TargetFind->findSingleTarget(PBattleTarget);
        }

        // Assumed, it's very difficult to produce this due to WS being nearly instant
        // TODO: attempt to verify.
        if (PAI->TargetFind->m_targets.size() == 0)
        {
            // No targets, perhaps something like Super Jump or otherwise untargetable
            action.actiontype = ACTION_MAGIC_FINISH;
            action.actionid = 28787; // Some hardcoded magic for interrupts
            actionList_t& actionList = action.getNewActionList();
            actionList.ActionTargetID = id;

            actionTarget_t& actionTarget = actionList.getNewActionTarget();

            actionTarget.animation = 0x1FC; // Assumed, but not verified.
            actionTarget.messageID = 0;
            actionTarget.reaction = REACTION_ABILITY_HIT;

            return;
        }

        for (auto&& PTarget : PAI->TargetFind->m_targets)
        {
            bool primary = PTarget == PBattleTarget;
            actionList_t& actionList = action.getNewActionList();
            actionList.ActionTargetID = PTarget->id;

            actionTarget_t& actionTarget = actionList.getNewActionTarget();

            uint16 tpHitsLanded;
            uint16 extraHitsLanded;
            int32 damage;
            CBattleEntity* taChar = battleutils::getAvailableTrickAttackChar(this, PTarget);

            actionTarget.reaction = REACTION_NONE;
            actionTarget.speceffect = SPECEFFECT_NONE;
            actionTarget.animation = PWeaponSkill->getAnimationId();
            actionTarget.messageID = 0;
            std::tie(damage, tpHitsLanded, extraHitsLanded) = luautils::OnUseWeaponSkill(this, PTarget, PWeaponSkill, tp, primary, action, taChar);

            if (!battleutils::isValidSelfTargetWeaponskill(PWeaponSkill->getID()))
            {
                if (primary && PBattleTarget->objtype == TYPE_MOB)
                {
                    luautils::OnWeaponskillHit(PBattleTarget, this, PWeaponSkill->getID());
                }
            }
            else
            {
                actionTarget.messageID = primary ? 224 : 276; // restores mp msg
                actionTarget.reaction = REACTION_HIT;
                damage = std::max(damage, 0);
                actionTarget.param = PTarget->addMP(damage);
            }

            if (primary)
            {
                // TODO: Probably not needed for mobs?
                //if (PWeaponSkill->getID() >= 192 && PWeaponSkill->getID() <= 218)
                //{
                //    uint16 recycleChance =
                //        getMod(Mod::RECYCLE) + PMeritPoints->GetMeritValue(MERIT_RECYCLE, this) + this->PJobPoints->GetJobPointValue(JP_AMMO_CONSUMPTION);

                //    if (StatusEffectContainer->HasStatusEffect(EFFECT_UNLIMITED_SHOT))
                //    {
                //        StatusEffectContainer->DelStatusEffectSilent(EFFECT_UNLIMITED_SHOT);
                //        recycleChance = 100;
                //    }
                //    if (tpzrand::GetRandomNumber(100) > recycleChance)
                //    {
                //        battleutils::RemoveAmmo(this);
                //    }
                //}
                if (actionTarget.reaction == REACTION_HIT)
                {
                    if (PWeaponSkill->getPrimarySkillchain() != 0)
                    {
                        // NOTE: GetSkillChainEffect is INSIDE this if statement because it
                        //  ALTERS the state of the resonance, which misses and non-elemental(i.e. spirits within) skills should NOT do.

                        SUBEFFECT effect = battleutils::GetSkillChainEffect(PBattleTarget, PWeaponSkill->getPrimarySkillchain(),
                                                                            PWeaponSkill->getSecondarySkillchain(), PWeaponSkill->getTertiarySkillchain());
                        if (effect != SUBEFFECT_NONE)
                        {
                            // TODO: Probably shouldn't exist for mobs
                            // Apply Inundation weapon skill type tracking
                            //if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_INUNDATION))
                            //{
                            //    CStatusEffect* PEffect = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_INUNDATION, 0);
                            //    auto power = PEffect->GetPower();
                            //    auto currentFlag = PItem->getSkillTypeFlag();
                            //    auto subPower = PEffect->GetSubPower();
                            //    if ((subPower & currentFlag) == 0)
                            //    {
                            //        PEffect->SetPower(power + 1);
                            //        PEffect->SetSubPower(subPower | currentFlag);
                            //    }
                            //}

                            actionTarget.addEffectParam = battleutils::TakeSkillchainDamage(this, PBattleTarget, damage, taChar);
                            if (actionTarget.addEffectParam < 0)
                            {
                                actionTarget.addEffectParam = -actionTarget.addEffectParam;
                                actionTarget.addEffectMessage = 384 + effect;
                            }
                            else
                                actionTarget.addEffectMessage = 287 + effect;
                            actionTarget.additionalEffect = effect;
                        }
                        else if (effect == SUBEFFECT_NONE)
                        {
                            // TODO: Probably shouldn't exist for mobs
                            // Reset Inundation weapon skill type tracking
                            //if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_INUNDATION))
                            //{
                            //    CStatusEffect* PEffect = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_INUNDATION, 0);
                            //    auto currentFlag = PItem->getSkillTypeFlag();
                            //    PEffect->SetPower(0);
                            //    PEffect->SetSubPower(currentFlag);
                            //}
                        }
                    }
                }
            }
        }
        // Remove effects consumed if present
        StatusEffectContainer->DelStatusEffectSilent(EFFECT_SENGIKORI);
        battleutils::ClaimMob(PBattleTarget, this);

    }
    else
    {
        if (PBattleTarget)
        {
            actionList_t& actionList = action.getNewActionList();
            actionList.ActionTargetID = PBattleTarget->id;
            action.actiontype = ACTION_MAGIC_FINISH; // all "Too Far" messages use cat 4

            actionTarget_t& actionTarget = actionList.getNewActionTarget();
            actionTarget.animation = 0x1FC; // Seems hardcoded, two bits away from 0x1FF
            if (PBattleTarget->isAlive())
            {
                actionTarget.messageID = MSGBASIC_TOO_FAR_AWAY;
            }
            else
            {
                actionTarget.messageID = 0;
            }

            // While it doesn't seem that speceffect is actually used at all in this "do nothing" animation, this is here for accuracy.
            if (isRangedWS) // Ranged WS seem to stay 0 on Reaction
            {
                actionTarget.speceffect = SPECEFFECT_NONE;
            }
            else // Always 2 observed on various melee weapons
            {
                actionTarget.speceffect = SPECEFFECT_BLOOD;
            }
            this->PAI->EventHandler.triggerListener("WEAPONSKILL_STATE_INTERRUPTED", this, PWeaponSkill->getID());
        }
    }
}


void CMobEntity::OnMobSkillFinished(CMobSkillState& state, action_t& action)
{
    auto PSkill = state.GetSkill();
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();

    // store the skill used
    m_UsedSkillIds[PSkill->getID()] = GetMLevel();

    PAI->TargetFind->reset();

    float distance = PSkill->getDistance();
    uint8 findFlags = 0;
    if (PSkill->getFlag() & SKILLFLAG_HIT_ALL)
    {
        findFlags |= FINDFLAGS_HIT_ALL;
    }

    // Mob buff abilities also hit monster's pets
    if (PSkill->getValidTargets() == TARGET_SELF)
    {
        findFlags |= FINDFLAGS_PET;
    }

    action.id = id;
    if (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() == PETTYPE_AVATAR)
        action.actiontype = ACTION_PET_MOBABILITY_FINISH;
    else if (PSkill->isJobAbility())
        action.actiontype = ACTION_JOBABILITY_FINISH;
    else if (PSkill->getID() < 256)
        action.actiontype = ACTION_WEAPONSKILL_FINISH;
    else
        action.actiontype = ACTION_MOBABILITY_FINISH;
    action.actionid = PSkill->getID();

    if (PTarget && PAI->TargetFind->isWithinRange(&PTarget->loc.p, distance))
    {
        if (PSkill->isAoE())
        {
            PAI->TargetFind->findWithinArea(PTarget, (AOERADIUS)PSkill->getAoe(), PSkill->getRadius(), findFlags);
        }
        else if (PSkill->isConal())
        {
            float angle = 45.0f;
            PAI->TargetFind->findWithinCone(PTarget, distance, angle, findFlags);
        }
        else if (PSkill->isBack())
        {
            float angle = 45.0f;
            PAI->TargetFind->findWithinCone(PTarget, distance, angle, findFlags, true);
        }
        else
        {
            if (this->objtype == TYPE_MOB && (PTarget->objtype == TYPE_PC || PTarget->objtype == TYPE_TRUST))
            {
                CBattleEntity* PCoverAbilityUser = battleutils::GetCoverAbilityUser(PTarget, this);
                if (PCoverAbilityUser != nullptr)
                {
                    PTarget = PCoverAbilityUser;
                }
            }

            PAI->TargetFind->findSingleTarget(PTarget, findFlags);
        }
    }
    else // Out of range
    {
        if (PTarget)
        {
            action.actiontype = ACTION_MOBABILITY_INTERRUPT;
            action.actionid = 0;
            actionList_t& actionList = action.getNewActionList();
            actionList.ActionTargetID = PTarget->id;
            actionTarget_t& actionTarget = actionList.getNewActionTarget();
            actionTarget.animation = 0x1FC; // Hardcoded magic sent from the server
            if (PTarget->isAlive())
            {
                actionTarget.messageID = MSGBASIC_TOO_FAR_AWAY;
            }
            else
            {
                actionTarget.messageID = 0;
            }

            actionTarget.speceffect = SPECEFFECT_BLOOD;
            this->PAI->EventHandler.triggerListener("WEAPONSKILL_STATE_INTERRUPTED", this, PSkill->getID());
            return;
        }
    }

    uint16 targets = static_cast<uint16>(PAI->TargetFind->m_targets.size());
    // No targets, perhaps something like Super Jump or otherwise untargetable
    if (targets == 0)
    {
        action.actiontype = ACTION_MOBABILITY_INTERRUPT;
        action.actionid = 28787; // Some hardcoded magic for interrupts
        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = id;
        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation = 0x1FC; // Hardcoded magic sent from the server
        actionTarget.messageID = 0;
        actionTarget.reaction = REACTION_ABILITY_HIT;
        return;
    }

    PSkill->setTotalTargets(targets);
    PSkill->setPrimaryTargetID(PTarget->id);
    PSkill->setTP(state.GetSpentTP());
    PSkill->setHPP(GetHPP());

    uint16 msg = 0;
    uint16 defaultMessage = PSkill->getMsg();

    bool first {true};
    for (auto&& PTarget : PAI->TargetFind->m_targets)
    {
        actionList_t& list = action.getNewActionList();

        list.ActionTargetID = PTarget->id;

        actionTarget_t& target = list.getNewActionTarget();

        list.ActionTargetID = PTarget->id;
        target.reaction = REACTION_HIT;
        target.speceffect = SPECEFFECT_HIT;
        target.animation = PSkill->getAnimationID();
        target.messageID = PSkill->getMsg();

        // Always knock back regardless of hit or shadow absorb.
        // For Reaving Wind aura knockback, Ullikumis Heavy Strike, etc
        if (PSkill->getFlag() & SKILLFLAG_ALWAYS_KNOCK_BACK)
        {
            target.knockback = PSkill->getKnockback();
        }

        // Set player avatar 2 hours to 15 yard radius
        // TODO: Are these the correct IDs? What are 839 - 919 for?
        if (objtype == TYPE_PET && PMaster->objtype == TYPE_PC)
        {
            if (PSkill->getID() == 616 || PSkill->getID() == 838 || PSkill->getID() == 848 || PSkill->getID() == 856 || PSkill->getID() == 866 ||
                PSkill->getID() == 875 || PSkill->getID() == 884 || PSkill->getID() == 893 || PSkill->getID() == 912 || PSkill->getID() == 2498)
            {
                PSkill->setDistance(15);
            }
        }


        // reset the skill's message back to default
        PSkill->setMsg(defaultMessage);

        if (PTarget->isSuperJumped)
        {
            target.reaction = REACTION_EVADE;
            target.speceffect = SPECEFFECT_NONE;
            target.messageID = 188; // skill miss
            continue;
        }


        if (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() != PETTYPE_JUG_PET)
        {
            if(static_cast<CPetEntity*>(this)->getPetType() == PETTYPE_AVATAR || static_cast<CPetEntity*>(this)->getPetType() == PETTYPE_WYVERN)
            {
                if (PSkill->getID() < 2452 || PSkill->getID() > 2457)
                    target.animation = PSkill->getPetAnimationID();
                else
                    target.animation = PSkill->getPetAnimationID() - 1; // cait sith level ? holy pet animations shifted by 1 from mob animations

            }
            target.param = luautils::OnPetAbility(PTarget, this, PSkill, PMaster, &action);
        }
        else
        {
            target.param = luautils::OnMobWeaponSkill(PTarget, this, PSkill, &action);
        }
        if (msg == 0)
        {
            msg = PSkill->getMsg();
        }
        else
        {
            msg = PSkill->getAoEMsg();
        }

        target.messageID = msg;

        if (PSkill->hasMissMsg())
        {
            target.reaction = REACTION_MISS;
            target.speceffect = SPECEFFECT_NONE;
            if (msg == PSkill->getAoEMsg())
                msg = 282;
        }
        else
        {
            target.reaction = REACTION_HIT;
            // Don't add TP if the TP move is a two hour, buff, heal, or enfeeble.
            if (msg != MSGBASIC_USES && msg != MSGBASIC_SKILL_GAIN_EFFECT && msg != MSGBASIC_SELF_HEAL && msg != MSGBASIC_SKILL_ENFEEB_IS)
            {
                int16 delay = this->GetWeaponDelay(true);
                float ratio = 1.0f;
                int16 baseTp = 0;
                baseTp = battleutils::CalculateBaseTP((int16)(delay * 60.0f / 1000.0f / ratio));
                if (PTarget->id == PSkill->getPrimaryTargetID())
                    this->addTP((int16)(1 * (baseTp * (1.0f + 0.01f * (float)((this->getMod(Mod::STORETP)))))));
            }
        }

        if (target.speceffect & SPECEFFECT_HIT)
        {
            target.speceffect = SPECEFFECT_RECOIL;
            target.knockback = PSkill->getKnockback();
            if (first && (PSkill->getPrimarySkillchain() != 0))
            {
                // Only Humanoid mobs, jug pets, and charmed mobs can skillchain
                if (IsHumanoid() || objtype == TYPE_PET || isCharmed)
                {
                    if (PSkill->getPrimarySkillchain())
                    {
                        SUBEFFECT effect = battleutils::GetSkillChainEffect(PTarget, PSkill->getPrimarySkillchain(), PSkill->getSecondarySkillchain(),
                                                                            PSkill->getTertiarySkillchain());
                        if (effect != SUBEFFECT_NONE)
                        {
                            // Apply Inundation weapon skill type tracking
                            if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_INUNDATION))
                            {
                                CStatusEffect* PEffect = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_INUNDATION, 0);
                                auto power = PEffect->GetPower();
                                auto currentFlag = WEAPONTYPE_PET;
                                auto subPower = PEffect->GetSubPower();
                                if ((subPower & currentFlag) == 0)
                                {
                                    PEffect->SetPower(power + 1);
                                    PEffect->SetSubPower(subPower | currentFlag);
                                }
                            }

                            int32 skillChainDamage = battleutils::TakeSkillchainDamage(this, PTarget, target.param, nullptr);
                            if (skillChainDamage < 0)
                            {
                                target.addEffectParam = -skillChainDamage;
                                target.addEffectMessage = 384 + effect;
                            }
                            else
                            {
                                target.addEffectParam = skillChainDamage;
                                target.addEffectMessage = 287 + effect;
                            }
                            target.additionalEffect = effect;
                        }
                        else if (effect == SUBEFFECT_NONE)
                        {
                            // Reset Inundation weapon skill type tracking
                            if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_INUNDATION))
                            {
                                CStatusEffect* PEffect = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_INUNDATION, 0);
                                auto currentFlag = WEAPONTYPE_PET;
                                PEffect->SetPower(0);
                                PEffect->SetSubPower(currentFlag);
                            }
                        }
                    }
                    first = false;
                }
            }
        }
        // Pet buffing abilities shouldn't remove sneak/invis off players(i.e. Garuda's Hastega Blood Pact: Ward)
        if (objtype != TYPE_PET)
        {
            PTarget->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
        }
        if (PTarget->isDead())
        {
            battleutils::ClaimMob(PTarget, this);
        }
        battleutils::DirtyExp(PTarget, this);
        if (PTarget->isDead() && PTarget->objtype == TYPE_MOB && this->objtype == TYPE_PET && this->PMaster->objtype == TYPE_PC)
        {
            ((CMobEntity*)PTarget)->m_autoTargetKiller = ((CCharEntity*)PMaster);
            ((CMobEntity*)PTarget)->DoAutoTarget();
        }
    }
    PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    if (PTarget->objtype == TYPE_MOB && (PTarget->isDead() || (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() == PETTYPE_AVATAR)))
    {
        battleutils::ClaimMob(PTarget, this);
    }
    battleutils::DirtyExp(PTarget, this);
}

void CMobEntity::OnItemFinish(CItemState& state, action_t& action)
{
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    auto PItem = static_cast<CItemUsable*>(state.GetItem());

    PAI->TargetFind->reset();
    if (PItem->getAoE())
    {
        PTarget->ForParty(
            [PItem, PTarget](CBattleEntity* PMember)
            {
                if (!PMember->isDead() && distance(PTarget->loc.p, PMember->loc.p) <= 10)
                {
                    luautils::OnItemUse(PMember, PItem);
                    battleutils::GenerateInRangeEnmity(PTarget, 0, 640);
                    // Prism and Rainbow powders
                    if (PItem->getID() != 4164 && PItem->getID() != 5362)
                    {
                        PTarget->StatusEffectContainer->DelStatusEffectSilent(EFFECT_INVISIBLE);
                    }
                }
            });
        float radius = 10.0f;
        PAI->TargetFind->findWithinArea(PTarget, AOERADIUS_ATTACKER, radius);

        uint16 targets = (uint16)PAI->TargetFind->m_targets.size();

        for (auto&& PActionTarget : PAI->TargetFind->m_targets)
        {
            if (this->allegiance == PActionTarget->allegiance)
            {
                action.id = this->id;
                action.actiontype = ACTION_ITEM_FINISH;
                action.actionid = PItem->getID();

                actionList_t& actionList = action.getNewActionList();
                actionList.ActionTargetID = PActionTarget->id;

                actionTarget_t& actionTarget = actionList.getNewActionTarget();
                actionTarget.animation = PItem->getAnimationID();
                actionTarget.reaction = REACTION_HIT;
                actionTarget.messageID = PItem->getMsg();
                actionTarget.param = PItem->getParam();

                // Percentage HP / MP restored msg, Healing/Mana Powder
                if (actionTarget.messageID == MSGBASIC_RECOVERS_HP_MP || PItem->getID() == 5322 || PItem->getID() == 4255)
                {
                    int hp = floor(PActionTarget->GetMaxHP() * actionTarget.param);
                    int mp = floor(PActionTarget->GetMaxMP() * actionTarget.param);
                    int hpp = floor(hp / 100);
                    int mpp = floor(mp / 100);

                    actionTarget.param = hpp;

                    // Mana Powder
                    if (PItem->getID() == 4255)
                    {
                        actionTarget.param = mpp;
                    }
                }

                // HP restored msg
                if (actionTarget.messageID == MSGBASIC_RECOVERS_HP || actionTarget.messageID == MSGBASIC_RECOVERS_HP_MP)
                {
                    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_CURSE_II))
                    {
                        actionTarget.param = 0;
                    }
                }
            }
        }
    }
    else
    {
        luautils::OnItemUse(PTarget, PItem);
        battleutils::GenerateInRangeEnmity(PTarget, 0, 640);
        // Prism and Rainbow powders
        if (PItem->getID() != 4164 && PItem->getID() != 5362)
        {
            this->StatusEffectContainer->DelStatusEffectSilent(EFFECT_INVISIBLE);
        }
        action.id = this->id;
        action.actiontype = ACTION_ITEM_FINISH;
        action.actionid = PItem->getID();

        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = PTarget->id;

        // Healing / Clear Salve / Dawn Mulsum (Pet items)
        if (PItem->getID() >= 5835 && PItem->getID() <= 5838 || PItem->getID() == 5411)
        {
            if (PTarget->PPet != nullptr)
            {
                actionList.ActionTargetID = PTarget->PPet->id;
            }
        }

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation = PItem->getAnimationID();
        actionTarget.reaction = REACTION_HIT;
        actionTarget.messageID = PItem->getMsg();
        actionTarget.param = PItem->getParam();

        // Percentage HP for Healing Salve I and II
        if (PItem->getID() == 5835 || PItem->getID() == 5836)
        {
            if (PTarget->PPet != nullptr)
            {
                int hp = floor(PPet->GetMaxHP() * actionTarget.param);
                int hpp = floor(hp / 100);

                actionTarget.param = hpp;
            }
        }

        // Percentage HP / MP restored msg, Healing/Mana Powder
        if (actionTarget.messageID == MSGBASIC_RECOVERS_HP_MP || PItem->getID() == 5322 || PItem->getID() == 4255)
        {
            int hp = floor(this->GetMaxHP() * actionTarget.param);
            int mp = floor(this->GetMaxMP() * actionTarget.param);
            int hpp = floor(hp / 100);
            int mpp = floor(mp / 100);

            actionTarget.param = hpp;

            // Mana Powder
            if (PItem->getID() == 4255)
            {
                actionTarget.param = mpp;
            }
        }

        // HP restored msg
        if (actionTarget.messageID == MSGBASIC_RECOVERS_HP || actionTarget.messageID == MSGBASIC_RECOVERS_HP_MP)
        {
            if (this->StatusEffectContainer->HasStatusEffect(EFFECT_CURSE_II))
            {
                actionTarget.param = 0;
            }
        }
    }
}

void CMobEntity::DistributeRewards()
{
    CCharEntity* PChar = (CCharEntity*)GetEntity(m_OwnerID.targid, TYPE_PC);

    if (PChar != nullptr && PChar->id == m_OwnerID.id)
    {
        PChar->setWeaponSkillKill(false);
        StatusEffectContainer->KillAllStatusEffect();

        // NOTE: this is called for all alliance / party members!
        luautils::OnMobDeath(this, PChar);

        if (!CalledForHelp() && PChar->allegiance != this->allegiance)
        {
            blueutils::TryLearningSpells(PChar, this);
            m_UsedSkillIds.clear();

            if (m_giveExp && !PChar->StatusEffectContainer->HasStatusEffect(EFFECT_BATTLEFIELD))
            {
                charutils::DistributeExperiencePoints(PChar, this);
                charutils::DistributeCapacityPoints(PChar, this);
            }

            // check for gil (beastmen drop gil, some NMs drop gil)
            if ((map_config.mob_gil_multiplier > 0 && CanDropGil()) || (map_config.all_mobs_gil_bonus > 0 && getMobMod(MOBMOD_GIL_MAX) >= 0)) // Negative value of MOBMOD_GIL_MAX is used to prevent gil drops in Dynamis/Limbus.
            {
                charutils::DistributeGil(PChar, this); // TODO: REALISATION MUST BE IN TREASUREPOOL
            }

            // RoE Mob kill event for all party members
            PChar->ForAlliance([this, PChar](CBattleEntity* PMember)
            {
                if (PMember->getZone() == PChar->getZone())
                {
                    roeutils::event(ROE_MOBKILL, (CCharEntity*)PMember, RoeDatagram("mob", (CMobEntity*)this));
                }
            });

            DropItems(PChar);
        }

    }
    else
    {
        luautils::OnMobDeath(this, nullptr);
    }
}

void CMobEntity::DropItems(CCharEntity* PChar)
{
    // Adds an item to the treasure pool and returns true if the pool has been filled
    auto AddItemToPool = [this, PChar](uint16 ItemID, uint8 dropCount) {
        PChar->PTreasurePool->AddItem(ItemID, this);
        return dropCount >= TREASUREPOOL_SIZE;
    };

    // Limit number of items that can drop to the treasure pool size
    uint8 dropCount = 0;

    DropList_t* DropList = itemutils::GetDropList(m_DropID);
    // ShowDebug(CL_CYAN"DropID: %u dropping with TH Level: %u\n" CL_RESET, PMob->m_DropID, PMob->m_THLvl);

    uint16 gDropBase[7][15] = {
        { 2400, 4800, 5600, 6000, 6400, 6666, 6800, 6900, 7050, 7200, 7350, 7400, 7600, 7800, 8000 },
        { 1500, 3000, 4000, 4250, 4500, 4750, 5000, 5250, 5500, 5750, 6000, 6250, 6500, 6750, 7000 },
        { 1000, 1200, 1500, 1650, 1800, 1900, 2000, 2100, 2250, 2400, 2650, 2800, 2950, 3100, 3250 },
        { 0500, 0600, 0700, 0750, 800, 850, 900, 950, 1050, 1150, 1250, 1350, 1550, 1750, 2000 },
        { 0100, 0150, 0200, 0225, 0250, 0300, 0350, 0400, 0475, 0550, 0650, 0750, 825, 900, 1000 },
        { 0050, 0075, 0100, 0120, 0140, 0160, 180, 0200, 0230, 0260, 0300, 0350, 0400, 0450, 0500 },
        { 0010, 0020, 0030, 0035, 0040, 0045, 0050, 0060, 0070, 80, 90, 0100, 0115, 0130, 0150 }
    };

    if (DropList != nullptr && !getMobMod(MOBMOD_NO_DROPS) && (DropList->Items.size() || DropList->Groups.size()))
    {
        uint16 th = m_THLvl;
        if (th > 14)
            th = 14;
        for (const DropGroup_t& group : DropList->Groups)
        {
            uint16 rate = group.GroupRate;
            uint16 category = 7;
            if (rate < 5)
                category = 6;
            else if (rate < 10)
                category = 5;
            else if (rate < 50)
                category = 4;
            else if (rate < 100)
                category = 3;
            else if (rate < 150)
                category = 2;
            else if (rate < 240)
                category = 1;
            else if (rate < 1000)
                category = 0;

            if ((category == 7) || (tpzrand::GetRandomNumber(10000) < gDropBase[category][th]))
            {
                // Each item in the group is given its own weight range which is the previous value to the previous value + item.DropRate
                // Such as 2 items with drop rates of 200 and 800 would be 0-199 and 200-999 respectively
                uint16 previousRateValue = 0;
                uint16 itemRoll = tpzrand::GetRandomNumber(1000);
                for (const DropItem_t& item : group.Items)
                {
                    if (previousRateValue + item.DropRate > itemRoll)
                    {
                        if (AddItemToPool(item.ItemID, ++dropCount))
                            return;
                        break;
                    }
                    previousRateValue += item.DropRate;
                }
            }
        }

        for (const DropItem_t& item : DropList->Items)
        {
            if (item.DropType == 0)
            {
                uint16 rate = item.DropRate;
                uint16 category = 7;
                if (rate < 5)
                    category = 6;
                else if (rate < 10)
                    category = 5;
                else if (rate < 50)
                    category = 4;
                else if (rate < 100)
                    category = 3;
                else if (rate < 150)
                    category = 2;
                else if (rate < 240)
                    category = 1;
                else if (rate < 1000)
                    category = 0;

                if ((category == 7) || (tpzrand::GetRandomNumber(10000) < gDropBase[category][th]))
                {
                    if (AddItemToPool(item.ItemID, ++dropCount))
                        return;
                }
            }
        }
    }
    // Roll for random rare items
    if (tpzrand::GetRandomNumber(500) < 1 && getMobMod(MOBMOD_NO_DROPS) == 0 && GetMLevel() >= 11 && GetMLevel() < 80)
    {
        if (GetMLevel() >= 11 && GetMLevel() <= 20) // 11-20 bracket rare drops
        {
            switch (tpzrand::GetRandomNumber(4))
            {
                case 0:

                    if (AddItemToPool(15835, ++dropCount)) // Desperado Ring
                        return;
                    break;
                case 1:
                    if (AddItemToPool(16279, ++dropCount)) // Pile Chain
                        return;
                    break;
                case 2:
                    if (AddItemToPool(11312, ++dropCount)) // Rambler's Cloak
                        return;
                    break;
                case 3:
                    if (AddItemToPool(15926, ++dropCount)) // Bronze Bandolier
                        return;
                    break;
            }
        }
        else if (GetMLevel() >= 21 && GetMLevel() <= 30) // 21-30 bracket rare drops
        {
            switch (tpzrand::GetRandomNumber(4))
            {
                case 0:

                    if (AddItemToPool(18503, ++dropCount)) // Mammut 100% proc
                        return;
                    break;
                case 1:
                    if (AddItemToPool(16367, ++dropCount)) // Phlegethon's Trousers
                        return;
                    break;
                case 2:
                    if (AddItemToPool(16368, ++dropCount)) // Herder's Subligar
                        return;
                    break;
                case 3:
                    if (AddItemToPool(11401, ++dropCount)) // Rambler's Gaiters
                        return;
                    break;
            }
        }
        else if (GetMLevel() >= 31 && GetMLevel() <= 40) // 31-40 bracket rare drops
        {
            switch (tpzrand::GetRandomNumber(4))
            {
                case 0:

                    if (AddItemToPool(17760, ++dropCount)) // Buccaneer's Scimitar
                        return;
                    break;
                case 1:
                    if (AddItemToPool(18599, ++dropCount)) //Magic Dmg and MACC Affinity +1 (All)
                        return;
                    break;
                case 2:
                    if (AddItemToPool(18451, ++dropCount)) // Mokusa 100% proc
                        return;
                    break;
                case 3:
                    if (AddItemToPool(11492, ++dropCount)) // Risky Patch
                        return;
                    break;
            }
        }
        else if (GetMLevel() >= 41 && GetMLevel() <= 50) // 41-50 bracket rare drops
        {
            switch (tpzrand::GetRandomNumber(4))
            {
                case 0:

                    if (AddItemToPool(15042, ++dropCount)) // Gothic Gauntlets
                        return;
                    break;
                case 1:
                    if (AddItemToPool(11402, ++dropCount)) // Gothic Sabatons
                        return;
                    break;
                case 2:
                    if (AddItemToPool(18075, ++dropCount)) // Rossignol
                        return;
                    break;
                case 3:
                    if (AddItemToPool(19114, ++dropCount)) // Galkan Dagger 100% proc
                        return;
                    break;
            }
        }
        else if (GetMLevel() >= 51 && GetMLevel() <= 60) // 51-60 bracket rare drops
        {
            switch (tpzrand::GetRandomNumber(4))
            {
                case 0:

                    if (AddItemToPool(11042, ++dropCount)) // Rebel Earring
                        return;
                    break;
                case 1:
                    if (AddItemToPool(14954, ++dropCount)) // Sadhu Cuffs
                        return;
                    break;
                case 2:
                    if (AddItemToPool(11575, ++dropCount)) // Grapevine Cape
                        return;
                    break;
                case 3:
                    if (AddItemToPool(14953, ++dropCount)) // Sadhu Bracelets
                        return;
                    break;
            }
        }
        else if (GetMLevel() >= 61 && GetMLevel() <= 70) // 61-70 bracket rare drops
        {
            switch (tpzrand::GetRandomNumber(4))
            {
                case 0:

                    if (AddItemToPool(15980, ++dropCount)) // Magnifying Earring
                        return;
                    break;
                case 1:
                    if (AddItemToPool(17965, ++dropCount)) // Sirocco Axe 100% proc
                        return;
                    break;
                case 2:
                    if (AddItemToPool(18867, ++dropCount)) // Daedalus Hammer
                        return;
                    break;
                case 3:
                    if (AddItemToPool(10816, ++dropCount)) // Glassblower's Belt
                        return;
                    break;
            }
        }
        else if (GetMLevel() >= 71 && GetMLevel() < 80) // 71-79 bracket rare drops
        {
            switch (tpzrand::GetRandomNumber(4))
            {
                case 0:

                    if (AddItemToPool(15786, ++dropCount)) // Divisor Ring
                        return;
                    break;
                case 1:
                    if (AddItemToPool(17721, ++dropCount)) // Sanguine Sword
                        return;
                    break;
                case 2:
                    if (AddItemToPool(18028, ++dropCount)) // Matron's Knife
                        return;
                    break;
                case 3:
                    if (AddItemToPool(15796, ++dropCount)) // Psi Ring
                        return;
                    break;
            }
        }
        loc.zone->PushPacket(this, CHAR_INZONE, new CChatMessagePacket(PChar, CHAT_MESSAGE_TYPE::MESSAGE_SYSTEM_2, "An extremely rare item has dropped!!!"));
    }

    if (tpzrand::GetRandomNumber(5000) < 1 && getMobMod(MOBMOD_NO_DROPS) == 0 && GetMLevel() >= 80)
    {
        if (GetMLevel() >= 80) // 80+ bracket rare drops
        {
            switch (tpzrand::GetRandomNumber(9))
            {
                case 0:
                    if (AddItemToPool(27580, ++dropCount)) // Adoulin Ring
                        return;
                    break;
                case 1:
                    if (AddItemToPool(27581, ++dropCount)) // Woltaris Ring
                        return;
                    break;
                case 2:
                    if (AddItemToPool(27582, ++dropCount)) // Weatherspoon Ring
                        return;
                    break;
                case 3:
                    if (AddItemToPool(27583, ++dropCount)) // Janniston Ring
                        return;
                    break;
                case 4:
                    if (AddItemToPool(27584, ++dropCount)) // Renaye Ring
                        return;
                    break;
                case 5:
                    if (AddItemToPool(27585, ++dropCount)) // Gorney Ring
                        return;
                    break;
                case 6:
                    if (AddItemToPool(27586, ++dropCount)) // Haverton Ring
                        return;
                    break;
                case 7:
                    if (AddItemToPool(27587, ++dropCount)) // Karieyh Ring
                        return;
                    break;
                case 8:
                    if (AddItemToPool(27588, ++dropCount)) // Vocane Ring
                        return;
                    break;
                case 9:
                    if (AddItemToPool(27589, ++dropCount)) // Thurandaut Ring
                        return;
                    break;
            }
        }
        loc.zone->PushPacket(this, CHAR_INZONE, new CChatMessagePacket(PChar, CHAT_MESSAGE_TYPE::MESSAGE_SYSTEM_2, "A legendary item has dropped!!!!"));
    }
    uint16 Pzone = PChar->getZone();

    // ToAU beastmen strongholds Moogle Coin drops
    if (Pzone == 65 || Pzone == 54 || Pzone == 62)
    {
        if (tpzrand::GetRandomNumber(100) < 24 && getMobMod(MOBMOD_NO_DROPS) == 0)
        {
            if (AddItemToPool(8732, ++dropCount))
                return;
        }
    }

    bool validZone = ((Pzone > 0 && Pzone < 31) || (Pzone > 44 && Pzone < 55) || (Pzone > 56 && Pzone < 63) || (Pzone > 64 && Pzone < 66) || (Pzone > 66 && Pzone < 69) ||
         (Pzone > 69 && Pzone < 73) || (Pzone > 78 && Pzone < 134) || (Pzone > 135 && Pzone < 185) || (Pzone > 188 && Pzone < 294));

    if (validZone && charutils::CheckMob(m_HiPCLvl, GetMLevel()) > EMobDifficulty::TooWeak)
    {

        //check for seal drops
        /* MobLvl >= 1 = Beastmen Seals ID=1126
        >= 50 = Kindred Seals ID=1127
        >= 75 = Kindred Crests ID=2955
        >= 90 = High Kindred Crests ID=2956
        */
        if (tpzrand::GetRandomNumber(100) < 90 && PChar->PTreasurePool->CanAddSeal() && getMobMod(MOBMOD_NO_DROPS) == 0)
        {
            //RULES: Only 1 kind may drop per mob
           // if (GetMLevel() >= 75 && luautils::IsContentEnabled("ABYSSEA")) //all 4 types
            if (GetMLevel() >= 190 && luautils::IsContentEnabled("ABYSSEA")) // all 4 types
            {
                switch (tpzrand::GetRandomNumber(4))
                {
                case 0:

                    if (AddItemToPool(1126, ++dropCount))
                        return;
                    break;
                case 1:
                    if (AddItemToPool(1127, ++dropCount))
                        return;
                    break;
                case 2:
                    if (AddItemToPool(2955, ++dropCount))
                        return;
                    break;
                case 3:
                    if (AddItemToPool(2956, ++dropCount))
                        return;
                    break;
                }
            }
           // else if (GetMLevel() >= 70 && luautils::IsContentEnabled("ABYSSEA")) //b.seal & k.seal & k.crest
            else if (GetMLevel() >= 80 && luautils::IsContentEnabled("ABYSSEA")) // b.seal & k.seal & k.crest
            {
                switch (tpzrand::GetRandomNumber(3))
                {
                case 0:
                    if (AddItemToPool(1127, ++dropCount))
                        return;
                    break;
                case 1:
                    if (AddItemToPool(1127, ++dropCount))
                        return;
                    break;
                case 2:
                    if (AddItemToPool(1127, ++dropCount))
                        return;
                    break;
                }
            }
            else if (GetMLevel() >= 50) //b.seal & k.seal only
            {
                if (tpzrand::GetRandomNumber(2) == 0)
                {
                    if (AddItemToPool(1126, ++dropCount))
                        return;
                }
                else
                {
                    if (AddItemToPool(1127, ++dropCount))
                        return;
                }
            }
            else
            {
                //b.seal only
                if (AddItemToPool(1126, ++dropCount))
                    return;
            }
        }
        // Todo: Avatarite and Geode drops during day/weather. Much higher chance during weather than day.
        // Item element matches day/weather element, not mob crystal. Lv80+ xp mobs can drop Avatarite.
        // Wiki's have conflicting info on mob lv required for Geodes. One says 50 the other 75. I think 50 is correct.

        uint8 effect = 0; // Begin Adding Crystals

        if (m_Element > 0)
        {
            uint8 regionID = PChar->loc.zone->GetRegionID();
            switch (regionID)
            {
                // Sanction Regions
                case REGION_WEST_AHT_URHGAN:
                case REGION_MAMOOL_JA_SAVAGE:
                case REGION_HALVUNG:
                case REGION_ARRAPAGO:
                    effect = 2;
                    break;
                // Sigil Regions
                case REGION_RONFAURE_FRONT:
                case REGION_NORVALLEN_FRONT:
                case REGION_GUSTABERG_FRONT:
                case REGION_DERFLAND_FRONT:
                case REGION_SARUTA_FRONT:
                case REGION_ARAGONEAU_FRONT:
                case REGION_FAUREGANDI_FRONT:
                case REGION_VALDEAUNIA_FRONT:
                    effect = 3;
                    break;
                // Signet Regions
                default:
                    effect = (conquest::GetRegionOwner(PChar->loc.zone->GetRegionID()) <= 2) ? 1 : 0;
                    break;
            }
        }
        uint8 crystalRolls = 0;
        PChar->ForParty([this, &crystalRolls, &effect](CBattleEntity* PMember)
        {
            switch(effect)
            {
                case 1:
                    if (PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SIGNET) && PMember->getZone() == getZone() && distance(PMember->loc.p, loc.p) < 100)
                    {
                        crystalRolls++;
                    }
                    break;
                case 2:
                    if (PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SANCTION) && PMember->getZone() == getZone() && distance(PMember->loc.p, loc.p) < 100)
                    {
                        crystalRolls++;
                    }
                    break;
                case 3:
                    if (PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SIGIL) && PMember->getZone() == getZone() && distance(PMember->loc.p, loc.p) < 100)
                    {
                        crystalRolls++;
                    }
                    break;
                default:
                    break;
            }
        });
        for (uint8 i = 0; i < crystalRolls; i++)
        {
            if (tpzrand::GetRandomNumber(100) < 20 && getMobMod(MOBMOD_NO_DROPS) == 0 && AddItemToPool(4095 + m_Element, ++dropCount))
            {
                return;
            }
        }
    }
}






bool CMobEntity::CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg)
{
    auto skill_list_id {getMobMod(MOBMOD_ATTACK_SKILL_LIST)};
    if (skill_list_id)
    {
        auto attack_range {GetMeleeRange()};
        auto skillList {battleutils::GetMobSkillList(skill_list_id)};
        if (!skillList.empty())
        {
            auto skill {battleutils::GetMobSkill(skillList.front())};
            if (skill)
            {
                attack_range = (uint8)skill->getDistance();
            }
        }
        if ((distance(loc.p, PTarget->loc.p) - PTarget->m_ModelSize) > attack_range ||
            !PAI->GetController()->IsAutoAttackEnabled())
        {
            return false;
        }
        return true;
    }
    else
    {
        return CBattleEntity::CanAttack(PTarget, errMsg);
    }
}

void CMobEntity::OnEngage(CAttackState& state)
{
    CBattleEntity::OnEngage(state);
    luautils::OnMobEngaged(this, state.GetTarget());
    unsigned int range = this->getMobMod(MOBMOD_ALLI_HATE);
    if (range != 0)
    {
        CBaseEntity* PTarget = state.GetTarget();
        CBaseEntity* PPet = nullptr;
        if (PTarget->objtype == TYPE_PET)
        {
            PPet = state.GetTarget();
            PTarget = ((CPetEntity*)PTarget)->PMaster;
        }

        // TODO: Supertanking might be effected by this block when we don't want it to be.
        // Things like Ambuscade "don't have" supertanking, though.
        // This block apparently only effects rare things like NW apollyon, so might be ok for now.

        if (PTarget->objtype == TYPE_PC)
        {
            ((CCharEntity*)PTarget)->ForAlliance([this, PTarget, range](CBattleEntity* PMember)
            {
                auto currentDistance = distance(PMember->loc.p, PTarget->loc.p);
                if (currentDistance < range)
                    this->PEnmityContainer->AddBaseEnmity(PMember);
            });
            this->PEnmityContainer->UpdateEnmity((PPet ? (CBattleEntity*)PPet : (CBattleEntity*)PTarget), 0, 1); // Set VE so target doesn't change
        }
    }

    // my pet should engage as well
    if (this->objtype == TYPE_MOB)
    {
        CBaseEntity* PTarget = state.GetTarget();
        if (PTarget)
        {
            if (this->PPet != nullptr && this->PPet->PAI->IsRoaming())
            {
                this->PAI->EventHandler.triggerListener("LINK", this->PPet, PTarget->targid);
                this->PPet->PAI->Engage(PTarget->id);
            }

            if (this->PPet2 != nullptr && this->PPet2->PAI->IsRoaming())
            {
                this->PAI->EventHandler.triggerListener("LINK", this->PPet2, PTarget->targid);
                this->PPet2->PAI->Engage(PTarget->id);
            }
        }
    }

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();
}

void CMobEntity::FadeOut()
{
    CBaseEntity::FadeOut();
    PEnmityContainer->Clear();
}

void CMobEntity::OnDeathTimer()
{
    if (!(m_Behaviour & BEHAVIOUR_RAISABLE))
        PAI->Despawn();
}

void CMobEntity::OnDespawn(CDespawnState&)
{
    if ((PAI != nullptr) && (PAI->GetController() != nullptr))
    {
        PAI->GetController()->SetAutoAttackEnabled(true);
        PAI->GetController()->SetMagicCastingEnabled(true);
        PAI->GetController()->SetWeaponSkillEnabled(true);
    }
    FadeOut();
    PAI->Internal_Respawn(std::chrono::milliseconds(m_RespawnTime));
    luautils::OnMobDespawn(this);
    PAI->ClearActionQueue();
    m_unkillable = false;
    animationsub = 0;
    //#event despawn
    PAI->EventHandler.triggerListener("DESPAWN", this);
}

void CMobEntity::Die()
{
    DoAutoTarget();
    PEnmityContainer->Clear();
    PAI->ClearStateStack();
    if (PPet != nullptr && PPet->isAlive() && GetMJob() == JOB_SMN)
    {
        PPet->Die();
    }
    PAI->Internal_Die(15s);
    CBattleEntity::Die();
    PAI->QueueAction(queueAction_t(std::chrono::milliseconds(m_DropItemTime), false, [this](CBaseEntity* PEntity) {
        if (static_cast<CMobEntity*>(PEntity)->isDead())
        {
            if (PLastAttacker)
                loc.zone->PushPacket(this, CHAR_INRANGE, new CMessageBasicPacket(PLastAttacker, this, 0, 0, MSGBASIC_DEFEATS_TARG));
            else
                loc.zone->PushPacket(this, CHAR_INRANGE, new CMessageBasicPacket(this, this, 0, 0, MSGBASIC_FALLS_TO_GROUND));

            DistributeRewards();
            m_OwnerID.clean();
            m_THLvl = 0;
            PAI->ClearActionQueue();
        }
    }));
    if (PMaster && PMaster->PPet == this && PMaster->objtype == TYPE_PC)
    {
        petutils::DetachPet(PMaster);
    }
}

void CMobEntity::OnDisengage(CAttackState& state)
{
    PAI->PathFind->Clear();
    PEnmityContainer->Clear();

    if (getMobMod(MOBMOD_IDLE_DESPAWN))
    {
        SetDespawnTime(std::chrono::seconds(getMobMod(MOBMOD_IDLE_DESPAWN)));
    }
    // this will let me decide to walk home or despawn
    m_neutral = true;

    m_OwnerID.clean();

    CBattleEntity::OnDisengage(state);

    luautils::OnMobDisengage(this);
}

void CMobEntity::OnCastFinished(CMagicState& state, action_t& action)
{
    CBattleEntity::OnCastFinished(state, action);

    CMobController* mobController = dynamic_cast<CMobController*>(PAI->GetController());
    if (mobController)
    {
        mobController->OnCastStopped(state, action);
    }

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();

    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    if (PTarget->isDead() && PTarget->objtype == TYPE_MOB && this->objtype == TYPE_PET && this->PMaster->objtype == TYPE_PC)
    {
        ((CMobEntity*)PTarget)->m_autoTargetKiller = ((CCharEntity*)PMaster);
        ((CMobEntity*)PTarget)->DoAutoTarget();
    }
}

void CMobEntity::OnCastInterrupted(CMagicState& state, action_t& action, MSGBASIC_ID msg, bool blockedCast)
{
    TracyZoneScoped;
    CBattleEntity::OnCastInterrupted(state, action, msg, blockedCast);

    CMobController* mobController = dynamic_cast<CMobController*>(PAI->GetController());
    if (mobController)
    {
        mobController->OnCastStopped(state, action);
    }
}

bool CMobEntity::OnAttack(CAttackState& state, action_t& action)
{
    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();

    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    if (PTarget->isDead() && PTarget->objtype == TYPE_MOB && this->objtype == TYPE_PET && this->PMaster->objtype == TYPE_PC)
    {
        ((CMobEntity*)PTarget)->m_autoTargetKiller = ((CCharEntity*)PMaster);
        ((CMobEntity*)PTarget)->DoAutoTarget();
    }

    if (getMobMod(MOBMOD_ATTACK_SKILL_LIST))
    {
        return static_cast<CMobController*>(PAI->GetController())->MobSkill(getMobMod(MOBMOD_ATTACK_SKILL_LIST));
    }
    else
    {
        return CBattleEntity::OnAttack(state, action);
    }
}

void CMobEntity::PixieTryHealPlayer(CCharEntity* PChar)
{
    time_t now = time(NULL);
    SpellID spell = SpellID::NULLSPELL;
    if (!PAI)
    {
        return;
    }
    CMobController* controller = static_cast<CMobController*>(PAI->GetController());
    if (!controller)
    {
        return;
    }
    if (getMobMod(MOBMOD_PIXIE) <= 0)
    {
        return;
    }
    if (m_pixieLastCast + 30 >= now)
    {
        // Must rest between casts (TODO: Check real value)
        return;
    }
    if (PChar->m_pixieHate >= 20)
    {
        // TODO: Find real values
        // You killed my relatives so I don't care if you die
        return;
    }
    if (!controller->CanDetectTarget(PChar, false, true))
    {
        // Must be able to detect the player to cast
        return;
    }
    if (PChar->m_hasRaise > 0)
    {
        // Player is dead with has raise active
        return;
    }
    if (PChar->isDead())
    {
        spell = SpellID::Raise_III;
    }
    else if (PChar->GetHPP() <= 90)
    {
        // TODO: Check what's the cure threshold on retail
        int32 max_hp = PChar->GetMaxHP();
        int32 current_hp = PChar->health.hp;
        int32 to_cure = max_hp - current_hp;
        if (to_cure < 0)
        {
            to_cure = 0;
        }
        if (to_cure > 0)
        {
            // Set according to the soft cap of each cure
            if (to_cure <= 30)
            {
                spell = SpellID::Cure;
            }
            else if (to_cure <= 90)
            {
                spell = SpellID::Cure_II;
            }
            else if (to_cure <= 190)
            {
                spell = SpellID::Cure_III;
            }
            else if (to_cure <= 380)
            {
                spell = SpellID::Cure_IV;
            }
            else
            {
                spell = SpellID::Cure_V;
            }
        }
    }
    if (spell != SpellID::NULLSPELL)
    {
        if (controller->Cast(PChar->targid, spell))
        {
            m_pixieLastCast = now;
        }
    }
}

bool CMobEntity::PixieShouldSpawn()
{
    int32 amity = 0;
    // Prevent spamming the DB with calls
    time_t now = time(NULL);
    if (g_pixieLastAmityRefresh + 60 < now)
    {
        int32 ret = Sql_Query(SqlHandle, "SELECT value FROM server_variables WHERE name = 'PixieAmity';");
        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            amity = Sql_GetIntData(SqlHandle, 0);
        }
        g_pixieAmity = amity;
        g_pixieLastAmityRefresh = now;
    }
    else
    {
        amity = g_pixieAmity;
    }
    if (amity < -255)
    {
        amity = -255;
    }
    if (amity > 255)
    {
        amity = 255;
    }
    if (loc.zone->GetRegionID() < 33 || loc.zone->GetRegionID() > 40)
    {
        // Pixies in the present require higher amity
        amity -= 300;
    }
    if (amity >= -50)
    {
        return true;
    }
    if (amity <= -150)
    {
        return false;
    }
    int32 chance = amity + 150;
    return (tpzrand::GetRandomNumber(100) < chance);
}

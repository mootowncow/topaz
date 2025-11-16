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

#include "trustentity.h"
#include "../mob_spell_container.h"
#include "../mob_spell_list.h"
#include "../packets/char_health.h"
#include "../packets/entity_update.h"
#include "../packets/trust_sync.h"
#include "../packets/mob_extdata.h"
#include "../ai/ai_container.h"
#include "../ai/controllers/trust_controller.h"
#include "../ai/helpers/pathfind.h"
#include "../ai/helpers/targetfind.h"
#include "../ai/states/ability_state.h"
#include "../utils/battleutils.h"
#include "../utils/trustutils.h"
#include "../ai/states/attack_state.h"
#include "../ai/states/weaponskill_state.h"
#include "../ai/states/mobskill_state.h"
#include "../ai/states/item_state.h"
#include "../ai/states/magic_state.h"
#include "../ai/states/range_state.h"
#include "../recast_container.h"
#include "../mob_spell_container.h"
#include "../status_effect_container.h"
#include "../attack.h"
#include "../utils/charutils.h"

CTrustEntity::CTrustEntity(CCharEntity* PChar)
{
    objtype = TYPE_TRUST;
    m_EcoSystem = SYSTEM_UNCLASSIFIED;
    allegiance = ALLEGIANCE_PLAYER;
    spawnAnimation = SPAWN_ANIMATION::SPECIAL; // Initial spawn has the special spawn-in animation
    m_MobSkillList = 0;
    PMaster = PChar;
    m_IsClaimable = false;
    namevis = 0;
    speed = 50;
    m_hasReraise = 0;
    m_isDead = false;

    m_modStat[Mod::SDT_FIRE] = 100;
    m_modStat[Mod::SDT_ICE] = 100;
    m_modStat[Mod::SDT_WIND] = 100;
    m_modStat[Mod::SDT_EARTH] = 100;
    m_modStat[Mod::SDT_THUNDER] = 100;
    m_modStat[Mod::SDT_WATER] = 100;
    m_modStat[Mod::SDT_LIGHT] = 100;
    m_modStat[Mod::SDT_DARK] = 100;

    m_modStat[Mod::EEM_AMNESIA] = 100;
    m_modStat[Mod::EEM_VIRUS] = 100;
    m_modStat[Mod::EEM_SILENCE] = 100;
    m_modStat[Mod::EEM_GRAVITY] = 100;
    m_modStat[Mod::EEM_STUN] = 100;
    m_modStat[Mod::EEM_LIGHT_SLEEP] = 100;
    m_modStat[Mod::EEM_CHARM] = 100;
    m_modStat[Mod::EEM_PARALYZE] = 100;
    m_modStat[Mod::EEM_BIND] = 100;
    m_modStat[Mod::EEM_SLOW] = 100;
    m_modStat[Mod::EEM_PETRIFY] = 100;
    m_modStat[Mod::EEM_TERROR] = 100;
    m_modStat[Mod::EEM_POISON] = 100;
    m_modStat[Mod::EEM_DARK_SLEEP] = 100;
    m_modStat[Mod::EEM_BLIND] = 100;

    PAI = std::make_unique<CAIContainer>(this, std::make_unique<CPathFind>(this), std::make_unique<CTrustController>(PChar, this), std::make_unique<CTargetFind>(this));
}

void CTrustEntity::Tick(time_point tick)
{
    TracyZoneScoped;
    CBattleEntity::Tick(tick);
    if (m_DeathTimestamp > 0 && tick >= m_deathSyncTime)
    {
        // Send an update packet at a regular interval to keep the player's death variables synced
        updatemask |= UPDATE_STATUS;
        m_deathSyncTime = tick + death_update_frequency;
    }

    if (m_isDead && m_hasReraise > 0)
    {
        OnRaise();
    }

    if (health.hp > 0)
    {
        m_isDead = false;
        m_Behaviour &= ~BEHAVIOUR_RAISABLE;
    }
}

void CTrustEntity::PostTick()
{
    CBattleEntity::PostTick();
    if (loc.zone && status != STATUS_DISAPPEAR)
    {
        if (updatemask)
        {
            loc.zone->PushPacket(this, CHAR_INRANGE, new CEntityUpdatePacket(this, ENTITY_UPDATE, updatemask));

            if (PMaster && PMaster->PParty && updatemask & UPDATE_HP)
            {
                PMaster->ForParty([this](auto PMember) { static_cast<CCharEntity*>(PMember)->pushPacket(new CCharHealthPacket(this)); });
            }
            updatemask = 0;
        }

        if (extDataUpdateFlag)
        {
            // Send update packet for custom data..
            loc.zone->PushPacket(this, CHAR_INRANGE, new CMobExtDataPacket(this));

            // Clear flag..
            extDataUpdateFlag = false;
        }
    }
}

void CTrustEntity::FadeOut()
{
    CBaseEntity::FadeOut();
    loc.zone->UpdateEntityPacket(this, ENTITY_DESPAWN, UPDATE_NONE);
}

void CTrustEntity::Die()
{
    if (!m_isDead)
    {
        Die(death_duration);
        luautils::OnMobDeath(this, nullptr);
        PAI->ClearStateStack();
        PAI->Internal_Die(0s);
        SetDeathTimestamp((uint32)time(nullptr));

        if ((PAI != nullptr) && (PAI->GetController() != nullptr))
        {
            PAI->GetController()->SetAutoAttackEnabled(true);
            PAI->GetController()->SetMagicCastingEnabled(true);
            PAI->GetController()->SetWeaponSkillEnabled(true);
        }

        if (PLastAttacker)
        {
            loc.zone->PushPacket(this, CHAR_INRANGE, new CMessageBasicPacket(PLastAttacker, this, 0, 0, MSGBASIC_DEFEATS_TARG));
            // Add Listener
            PLastAttacker->PAI->EventHandler.triggerListener("PLAYER_DEATH", PLastAttacker, this);
        }
        else
        {
            loc.zone->PushPacket(this, CHAR_INRANGE, new CMessageBasicPacket(this, this, 0, 0, MSGBASIC_FALLS_TO_GROUND));
        }

        m_isDead = true;

        CBattleEntity::Die();
        m_Behaviour |= BEHAVIOUR_RAISABLE;
    }
}

void CTrustEntity::Spawn()
{
    // we need to skip CMobEntity's spawn because it calculates stats (and our stats are already calculated)
    CBattleEntity::Spawn();
    PAI->EventHandler.triggerListener("SPAWN", this);
    luautils::OnMobSpawn(this);
    trustutils::BuildingTrustSkillsTable(this);
    m_isDead = false;
    // Max [HP/MP] Boost mods
    this->UpdateHealth();
    this->health.tp = 0;
    this->health.hp = this->GetMaxHP();
    this->health.mp = this->GetMaxMP();
    ((CCharEntity*)PMaster)->pushPacket(new CTrustSyncPacket((CCharEntity*)PMaster, this));
    if (PMaster && PMaster->PParty)
    {
        PMaster->PParty->ReloadParty();
    }
}

void CTrustEntity::OnAbility(CAbilityState& state, action_t& action)
{
    auto* PAbility = state.GetAbility();
    auto* PTarget = dynamic_cast<CBattleEntity*>(state.GetTarget());
    if (!PTarget)
    {
        return;
    }

    std::unique_ptr<CBasicPacket> errMsg;
    if (IsValidTarget(PTarget->targid, PAbility->getValidTarget(), errMsg))
    {
        if (this != PTarget)
        {
            float jaRange = PAbility->getRange();
            if (PAbility->isMeleeAbility())
            {
                if (CBattleEntity* pBattleTarget = dynamic_cast<CBattleEntity*>(PTarget))
                {
                    if (pBattleTarget)
                    {
                        jaRange = this->GetMeleeRange() + pBattleTarget->m_ModelSize;
                    }
                }
            }
            if (distance(this->loc.p, PTarget->loc.p) > jaRange)
            {
                return;
            }
        }

        if (this->loc.zone->CanUseMisc(MISC_LOS_BLOCK) && !this->CanSeeTarget(PTarget, false))
        {
            return;
        }

        action.id = this->id;
        action.actiontype = PAbility->getActionType();
        action.actionid = PAbility->getID();
        action.recast = PAbility->getRecastTime();

        if (battleutils::IsParalyzed(this))
        {
            // 2 hours can be paraylzed but it won't reset their timers
            if (PAbility->getRecastId() != ABILITYRECAST_TWO_HOUR && PAbility->getRecastId() != ABILITYRECAST_TWO_HOUR_TWO)
            {
                // If Third Eye is paralyzed while seigan is active, use the modified seigan cooldown for thirdeye(30s instead of 1m)
                if (action.actionid == ABILITY_THIRD_EYE && this->StatusEffectContainer->HasStatusEffect(EFFECT_SEIGAN))
                {
                    action.recast /= 2;
                }

                PRecastContainer->Add(RECAST_ABILITY, PAbility->getRecastId(), action.recast);
            }


            setActionInterrupted(action, PTarget, MSGBASIC_IS_PARALYZED, 0);
            return;
        }

        // There is an overall cap of -25 seconds for a 35 second recast
        // https://www.bg-wiki.com/ffxi/Quick_Draw
        if (PAbility->isQuickDraw())
        {
            action.recast -= std::min<int16>(getMod(Mod::QUICK_DRAW_RECAST), 25);
        }

        if (action.actionid == ABILITY_LIGHT_ARTS || action.actionid == ABILITY_DARK_ARTS || PAbility->getRecastId() == 231) // stratagems
        {
            if (this->StatusEffectContainer->HasStatusEffect(EFFECT_TABULA_RASA))
                action.recast = 0;
        }

        if (PAbility->isAoE())
        {
            PAI->TargetFind->reset();

            float distance = PAbility->getRange();

            PAI->TargetFind->findWithinArea(this, AOERADIUS_ATTACKER, distance, FINDFLAGS_NONE, PAbility->getValidTarget());

            uint16 prevMsg = 0;
            for (auto&& PTargetFound : PAI->TargetFind->m_targets)
            {
                actionList_t& actionList = action.getNewActionList();
                actionList.ActionTargetID = PTargetFound->id;
                actionTarget_t& actionTarget = actionList.getNewActionTarget();
                actionTarget.reaction = REACTION_NONE;
                actionTarget.speceffect = SPECEFFECT_NONE;
                actionTarget.animation = PAbility->getAnimationID();
                actionTarget.messageID = PAbility->getMessage();
                actionTarget.param = 0;

                int32 value = luautils::OnUseAbility(this, PTargetFound, PAbility, &action);

                if (prevMsg == 0) // get default message for the first target
                {
                    actionTarget.messageID = PAbility->getMessage();
                }
                else // get AoE message for second, if there's a manual override, otherwise return message from PAbility->getMessage().
                {
                    actionTarget.messageID = PAbility->getAoEMsg();
                }

                actionTarget.param = value;

                if (value < 0)
                {
                    actionTarget.messageID = ability::GetAbsorbMessage(actionTarget.messageID);
                    actionTarget.param = -actionTarget.param;
                }

                prevMsg = actionTarget.messageID;

                state.ApplyEnmity();
            }
        }
        else
        {
            actionList_t& actionList = action.getNewActionList();
            actionList.ActionTargetID = PTarget->id;
            actionTarget_t& actionTarget = actionList.getNewActionTarget();
            actionTarget.reaction = REACTION_NONE;
            actionTarget.speceffect = SPECEFFECT_RECOIL;
            actionTarget.animation = PAbility->getAnimationID();
            actionTarget.param = 0;
            auto prevMsg = actionTarget.messageID;

            int32 value = luautils::OnUseAbility(this, PTarget, PAbility, &action);
            if (prevMsg == actionTarget.messageID)
            {
                actionTarget.messageID = PAbility->getMessage();
            }
            if (actionTarget.messageID == 0)
            {
                actionTarget.messageID = MSGBASIC_USES_JA;
            }
            actionTarget.param = value;

            if (value < 0)
            {
                actionTarget.messageID = ability::GetAbsorbMessage(actionTarget.messageID);
                actionTarget.param = -value;
            }
        }

        state.ApplyEnmity();

        // Remove Contradance after using a Waltz
        if (StatusEffectContainer->HasStatusEffect(EFFECT_CONTRADANCE) && PAbility->getID() > ABILITY_HASTE_SAMBA && PAbility->getID() < ABILITY_HEALING_WALTZ ||
            PAbility->getID() == ABILITY_DIVINE_WALTZ || PAbility->getID() == ABILITY_DIVINE_WALTZ_II)
        {
            StatusEffectContainer->DelStatusEffectSilent(EFFECT_CONTRADANCE);
        }

        battleutils::HandlePlayerAbilityUsed(this, PAbility, &action);

        PRecastContainer->Add(RECAST_ABILITY, PAbility->getRecastId(), action.recast);
    }

    if (PTarget && PTarget->isDead() && PTarget->objtype == TYPE_MOB)
    {
        ((CMobEntity*)PTarget)->m_autoTargetKiller = ((CCharEntity*)PMaster);
        ((CMobEntity*)PTarget)->DoAutoTarget();
    }
}

void CTrustEntity::OnRangedAttack(CRangeState& state, action_t& action)
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
    actionTarget.reaction = REACTION_HIT;		//0x10
    actionTarget.speceffect = SPECEFFECT_HIT;		//0x60 (SPECEFFECT_HIT + SPECEFFECT_RECOIL)
    if (battleutils::IsInRangedSweetSpot(this, PTarget))
    {
        actionTarget.messageID = MSGBASIC_RANGED_TRUE;
    }
    else if (battleutils::IsCloseToRangedSweetSpot(this, PTarget))
    {
        actionTarget.messageID = MSGBASIC_RANGED_SQUARELY;
    }
    else
    {
        actionTarget.messageID = MSGBASIC_RANGED_HIT;
    }


    /*
    CItemWeapon* PItem = (CItemWeapon*)this->getEquip(SLOT_RANGED);
    CItemWeapon* PAmmo = (CItemWeapon*)this->getEquip(SLOT_AMMO);

    bool ammoThrowing = PAmmo ? PAmmo->isThrowing() : false;
    bool rangedThrowing = PItem ? PItem->isThrowing() : false;

    uint8 slot = SLOT_RANGED;

    if (ammoThrowing)
    {
        slot = SLOT_AMMO;
        PItem = nullptr;
    }
    if (rangedThrowing)
    {
        PAmmo = nullptr;
    }
    */

    uint8 slot = SLOT_RANGED;
    uint8 shadowsTaken = 0;
    uint8 hitCount = 1;			// 1 hit by default
    uint8 realHits = 0;			// to store the real number of hit for tp multipler
    auto ammoConsumed = 0;
    bool hitOccured = false;	// track if player hit mob at all
    bool isBarrage = StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE, 0);

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
    //ShowDebug("Hit Count: %u\n", hitCount);

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
                bool isCritical = tpzrand::GetRandomNumber(100) < battleutils::GetRangedCritHitRate(this, PTarget, true, SLOT_RANGED);
                float pdif = battleutils::GetRangedDamageRatio(this, PTarget, isCritical);

                if (isCritical)
                {
                    actionTarget.speceffect = SPECEFFECT_CRITICAL_HIT;
                    actionTarget.messageID = MSGBASIC_RANGED_CRIT;
                }

                // at least 1 hit occured
                hitOccured = true;
                realHits++;

                damage = (int32)((this->GetRangedWeaponDmg() + battleutils::GetFSTR(this, PTarget, slot)) * pdif);
                CItemWeapon* Pitem = (CItemWeapon*)m_Weapons[SLOT_RANGED];
                if (slot == SLOT_RANGED)
                {
                    if (state.IsRapidShot())
                    {
                        damage = attackutils::CheckForDamageMultiplier(this, Pitem, damage, PHYSICAL_ATTACK_TYPE::RAPID_SHOT, SLOT_RANGED);
                    }
                    else
                    {
                        damage = attackutils::CheckForDamageMultiplier(this, Pitem, damage, PHYSICAL_ATTACK_TYPE::RANGED, SLOT_RANGED);
                    }
                }
            }
        }
        else //miss
        {
            damage = 0;
            actionTarget.reaction = REACTION_EVADE;
            actionTarget.speceffect = SPECEFFECT_NONE;
            actionTarget.messageID = MSGBASIC_RANGED_MISS;
            hitCount = i; // end barrage, shot missed
        }
        /*
        // check for recycle chance
        uint16 recycleChance = getMod(Mod::RECYCLE);
        if (charutils::hasTrait(this, TRAIT_RECYCLE))
        {
            recycleChance += PMeritPoints->GetMeritValue(MERIT_RECYCLE, this);
        }

        // Only remove unlimited shot on hit
        if (hitOccured && this->StatusEffectContainer->HasStatusEffect(EFFECT_UNLIMITED_SHOT))
        {
            StatusEffectContainer->DelStatusEffect(EFFECT_UNLIMITED_SHOT);
            recycleChance = 100;
        }

        if (PAmmo != nullptr && tpzrand::GetRandomNumber(100) > recycleChance)
        {
            ++ammoConsumed;
            TrackArrowUsageForScavenge(PAmmo);
            if (PAmmo->getQuantity() == i)
            {
                hitCount = i;
            }
        }
        */
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
            actionTarget.reaction = REACTION_HIT;
            actionTarget.speceffect = SPECEFFECT_CRITICAL_HIT;
            if (battleutils::IsInRangedSweetSpot(this, PTarget))
            {
                actionTarget.messageID = MSGBASIC_RANGED_TRUE;
            }
            else if (battleutils::IsCloseToRangedSweetSpot(this, PTarget))
            {
                actionTarget.messageID = MSGBASIC_RANGED_SQUARELY;
            }
            else
            {
                actionTarget.messageID = MSGBASIC_RANGED_HIT;
            }
        }

        actionTarget.param = battleutils::TakePhysicalDamage(this, PTarget, PHYSICAL_ATTACK_TYPE::RANGED, totalDamage, false, slot, realHits, nullptr, true, true);

        // lower damage based on shadows taken
        if (shadowsTaken)
        {
            actionTarget.param = (int32)(actionTarget.param * (1 - ((float)shadowsTaken / realHits)));
        }

        // absorb message
        if (actionTarget.param < 0)
        {
            actionTarget.param = -(actionTarget.param);
            actionTarget.messageID = 382;
        }

        /*
        //add additional effects
        //this should go AFTER damage taken
        //or else sleep effect won't work
        //battleutils::HandleRangedAdditionalEffect(this,PTarget,&Action);
        //TODO: move all hard coded additional effect ammo to scripts
        if ((PAmmo != nullptr && battleutils::GetScaledItemModifier(this, PAmmo, Mod::ADDITIONAL_EFFECT) > 0) ||
            (PItem != nullptr && battleutils::GetScaledItemModifier(this, PItem, Mod::ADDITIONAL_EFFECT) > 0)) {}
        luautils::OnAdditionalEffect(this, PTarget, (PAmmo != nullptr ? PAmmo : PItem), &actionTarget, totalDamage);
         */
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

    // remove barrage effect if present
    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE, 0)) {
        StatusEffectContainer->DelStatusEffect(EFFECT_BARRAGE, 0);
    }
    battleutils::ClaimMob(PTarget, this);
    //battleutils::RemoveAmmo(this, ammoConsumed);

    StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
    StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_ATTACK);

    if (PTarget && PTarget->isDead() && PTarget->objtype == TYPE_MOB)
    {
        ((CMobEntity*)PTarget)->m_autoTargetKiller = ((CCharEntity*)PMaster);
        ((CMobEntity*)PTarget)->DoAutoTarget();
    }
}

bool CTrustEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    if (PInitiator->objtype == TYPE_TRUST && PMaster == PInitiator->PMaster)
    {
        return true;
    }

    if ((targetFlags & TARGET_PLAYER_PARTY_PIANISSIMO) && PInitiator->allegiance == allegiance && PMaster && PInitiator != this)
    {
        return true;
    }

    if ((targetFlags & TARGET_PLAYER_PARTY_ENTRUST) && PInitiator->allegiance == allegiance && PMaster && PInitiator != this)
    {
        return true;
    }

    if ((targetFlags & TARGET_PLAYER_PARTY_ENTRUST) && PInitiator->objtype == TYPE_TRUST && PInitiator->allegiance == allegiance)
    {
        return true;
    }

    if (targetFlags & TARGET_PLAYER_PARTY && PInitiator->objtype == TYPE_PET && PInitiator->allegiance == allegiance)
    {
        return true;
    }

    if (targetFlags & TARGET_PLAYER_PARTY && PInitiator->allegiance == allegiance && PMaster)
    {
        return PInitiator->PParty == PMaster->PParty;
    }

    return CMobEntity::ValidTarget(PInitiator, targetFlags);
}

void CTrustEntity::OnDespawn(CDespawnState&)
{
    if (GetHPP() > 0)
    {
        // Don't call this when despawning after being killed
        luautils::OnMobDespawn(this);
    }
    FadeOut();
    PAI->EventHandler.triggerListener("DESPAWN", this);
}

void CTrustEntity::OnDisengage(CAttackState& state)
{
    CBattleEntity::OnDisengage(state);

    luautils::OnMobDisengage(this);
}

void CTrustEntity::OnCastFinished(CMagicState& state, action_t& action)
{
    CBattleEntity::OnCastFinished(state, action);


    CTrustController* trustController = dynamic_cast<CTrustController*>(PAI->GetController());
    if (trustController)
    {
        trustController->OnCastStopped(state, action);
    }

    auto PSpell = state.GetSpell();

    PRecastContainer->Add(RECAST_MAGIC, static_cast<uint16>(PSpell->getID()), action.recast);
    charutils::RemoveStratagems(this, PSpell);

    battleutils::HandlePlayerSpellCasted(this, PSpell, &action);

    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    if (PTarget->isDead() && PTarget->objtype == TYPE_MOB)
    {
        ((CMobEntity*)PTarget)->m_autoTargetKiller = ((CCharEntity*)PMaster);
        ((CMobEntity*)PTarget)->DoAutoTarget();
    }
}

void CTrustEntity::OnCastInterrupted(CMagicState& state, action_t& action, MSGBASIC_ID msg, bool blockedCast)
{
    TracyZoneScoped;
    CBattleEntity::OnCastInterrupted(state, action, msg, blockedCast);

    CTrustController* trustController = dynamic_cast<CTrustController*>(PAI->GetController());
    if (trustController)
    {
        trustController->OnCastStopped(state, action);
    }
}

void CTrustEntity::OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action)
{
    CBattleEntity::OnWeaponSkillFinished(state, action);

    auto PWeaponSkill = state.GetSkill();
    auto PBattleTarget = static_cast<CBattleEntity*>(state.GetTarget());

    int16 tp = state.GetSpentTP();
    tp = battleutils::CalculateWeaponSkillTP(this, PWeaponSkill, tp);

    if (distance(loc.p, PBattleTarget->loc.p) - PBattleTarget->m_ModelSize <= PWeaponSkill->getRange())
    {
        PAI->TargetFind->reset();
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
            actionTarget.animation = 0x1FC; // assumed
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
            else // Self-targeting WS restoring MP
            {
                actionTarget.messageID = primary ? 224 : 276; // Restores mp msg
                actionTarget.reaction = REACTION_HIT;
                damage = std::max(damage, 0);
                actionTarget.param = damage;
                PTarget->addMP(damage);
            }

            if (primary)
            {
                if (actionTarget.reaction == REACTION_HIT)
                {
                    if (PWeaponSkill->getPrimarySkillchain() != 0 && PTarget->isAlive())
                    {
                        // NOTE: GetSkillChainEffect is INSIDE this if statement because it
                        //  ALTERS the state of the resonance, which misses and non-elemental skills should NOT do.
                        SUBEFFECT effect = battleutils::GetSkillChainEffect(PBattleTarget, PWeaponSkill->getPrimarySkillchain(),
                                                                            PWeaponSkill->getSecondarySkillchain(), PWeaponSkill->getTertiarySkillchain());
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

                            actionTarget.addEffectParam = battleutils::TakeSkillchainDamage(this, PBattleTarget, damage, taChar);
                            if (actionTarget.addEffectParam < 0)
                            {
                                actionTarget.addEffectParam = -actionTarget.addEffectParam;
                                actionTarget.addEffectMessage = 384 + effect;
                            }
                            else
                            {
                                actionTarget.addEffectMessage = 287 + effect;
                            }
                            actionTarget.additionalEffect = effect;
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
                }
            }
        }
    }
    else
    {
        if (PBattleTarget)
        {
            actionList_t& actionList = action.getNewActionList();
            actionList.ActionTargetID = PBattleTarget->id;
            action.actiontype = ACTION_MAGIC_FINISH; // all "too far" messages use cat 4

            actionTarget_t& actionTarget = actionList.getNewActionTarget();
            actionTarget.animation = 0x1FC; // seems hardcoded, 2 bits away from 0x1FF.
            if (PBattleTarget->isAlive())
            {
                actionTarget.messageID = MSGBASIC_TOO_FAR_AWAY;
            }
            else
            {
                actionTarget.messageID = 0;
            }

            actionTarget.speceffect =
                SPECEFFECT_NONE; // It seems most mobs use NONE, but player-like models use BLOOD for their weaponskills
                                 // TODO: figure out a good way to differentiate between the two. There does not seem to be a functional difference.
        }
    }

    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    if (PTarget->isDead() && PTarget->objtype == TYPE_MOB)
    {
        ((CMobEntity*)PTarget)->m_autoTargetKiller = ((CCharEntity*)PMaster);
        ((CMobEntity*)PTarget)->DoAutoTarget();
    }
}

void CTrustEntity::OnMobSkillFinished(CMobSkillState& state, action_t& action)
{
    CMobEntity::OnMobSkillFinished(state, action);

    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    if (PTarget->isDead() && PTarget->objtype == TYPE_MOB)
    {
        ((CMobEntity*)PTarget)->m_autoTargetKiller = ((CCharEntity*)PMaster);
        ((CMobEntity*)PTarget)->DoAutoTarget();
    }
}

void CTrustEntity::OnRaise()
{
    uint8 weaknessLvl = 1;
    int weaknessDura = 0;
    uint16 hpReturned = 1;

    if (StatusEffectContainer->HasStatusEffect(EFFECT_WEAKNESS))
    {
        // double weakness!
        weaknessLvl = 2;
    }

    // Add weakness effect (75% reduction in HP/MP) if not Mijin or GM command raise
    if (GetLocalVar("MijinGakure") == 0 && GetLocalVar("GMRaise") == 0)
    {
        // Duration of Weakness varies with raise effect
        switch (m_hasReraise)
        {
            case 1:
                weaknessDura = 180;
                hpReturned = GetMaxHP() * 0.1;
                break;
            case 2:
                weaknessDura = 120;
                hpReturned = GetMaxHP() * 0.25;
                break;
            case 3:
                weaknessDura = 60;
                hpReturned = GetMaxHP() * 0.50;
                break;
            case 4:
            case 5:
                weaknessDura = 30;
                hpReturned = GetMaxHP();
                break;
            default:
                weaknessDura = 180;
                hpReturned = GetMaxHP() * 0.1;
                break;
        }
    }

    // Mijin Gakure used with MIJIN_RERAISE MOD
    if (GetLocalVar("MijinGakure") != 0 && getMod(Mod::MIJIN_RERAISE) != 0)
    {
        hpReturned = (uint16)(GetMaxHP());
    }
    else if (GetLocalVar("GMRaise") != 0)
    {
        hpReturned = (uint16)(GetMaxHP());
    }

    CStatusEffect* PWeaknessEffect = new CStatusEffect(EFFECT_WEAKNESS, EFFECT_WEAKNESS, weaknessLvl, 0, weaknessDura);
    StatusEffectContainer->AddStatusEffect(PWeaknessEffect);

    addHP(((hpReturned < 1) ? 1 : hpReturned));
    updatemask |= UPDATE_HP;

    StatusEffectContainer->DelStatusEffect(EFFECT_RERAISE);
    m_hasReraise = 0;
    m_isDead = false;

    PAI->Disengage();
}

void CTrustEntity::Die(duration _duration)
{
    if (StatusEffectContainer->HasStatusEffect(EFFECT_RERAISE))
    {
        CStatusEffect* reraise = StatusEffectContainer->GetStatusEffect(EFFECT_RERAISE, 0);
        uint16 reraiseNumber = reraise->GetPower();
        switch (reraiseNumber)
        {
            case 1:
                m_hasReraise = 1;
                break;
            case 2:
                m_hasReraise = 2;
                break;
            case 3:
                m_hasReraise = 3;
                break;
            case 4:
                m_hasReraise = 4;
                break;
            default:
                m_hasReraise = 1;
                break;
        }
    }
    else if (StatusEffectContainer->HasStatusEffect(EFFECT_HYMNUS))
    {
        m_hasReraise = 1;
    }

    // MIJIN_RERAISE checks
    if (m_hasReraise == 0 && this->getMod(Mod::MIJIN_RERAISE) > 0)
        m_hasReraise = 1;

    m_deathSyncTime = server_clock::now() + death_update_frequency;
    PAI->ClearStateStack();
    PAI->Internal_Die(_duration);

    // If player allegiance is not reset on death they will auto-homepoint
    allegiance = ALLEGIANCE_PLAYER;

    CBattleEntity::Die();
}

void CTrustEntity::Raise()
{
    PAI->Internal_Raise();
    SetDeathTimestamp(0);
}

void CTrustEntity::SetDeathTimestamp(uint32 timestamp)
{
    m_DeathTimestamp = timestamp;
}

int32 CTrustEntity::GetSecondsElapsedSinceDeath()
{
    return m_DeathTimestamp > 0 ? (uint32)time(nullptr) - m_DeathTimestamp : 0;
}

void CTrustEntity::OnItemFinish(CItemState& state, action_t& action)
{
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    auto PItem = static_cast<CItemUsable*>(state.GetItem());

    PAI->TargetFind->reset();
    if (PItem->getAoE())
    {
        PTarget->ForParty(
            [this, PItem, PTarget](CBattleEntity* PMember)
            {
                if (!PMember->isDead() && distance(PTarget->loc.p, PMember->loc.p) <= 10)
                {
                    luautils::OnItemUse(PMember, PItem, this);
                    battleutils::GenerateInRangeEnmity(PTarget, 0, 640);
                    // Prism and Rainbow powders
                    if (PItem->getID() != 4164 && PItem->getID() != 5362)
                    {
                        PTarget->StatusEffectContainer->DelStatusEffectSilent(EFFECT_INVISIBLE);
                    }

                    battleutils::HandleFoodEffects(PItem, PTarget);
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
        luautils::OnItemUse(PTarget, PItem, this);
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

        // Healing / Clear Salve / Dawn Mulsum / Shepherd's Drink (Pet items)
        if (PItem->getID() >= 5835 && PItem->getID() <= 5838 || PItem->getID() == 5411 || PItem->getID() == 5396)
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

        // Percentage HP for Healing Salve I / II and Shepherd's Drink
        if (PItem->getID() == 5835 || PItem->getID() == 5836 || PItem->getID() == 5396)
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

        battleutils::HandleFoodEffects(PItem, PTarget);
    }
}

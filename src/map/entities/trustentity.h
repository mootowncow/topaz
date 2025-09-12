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

#ifndef _CTRUSTENTITY_H
#define _CTRUSTENTITY_H

#include "mobentity.h"

class CCharEntity;
class CAbilityState;
class CRangeState;
class CDespawnState;
class CMagicState;
class CMobSkillState;
class CWeaponSkillState;

class CTrustEntity : public CMobEntity
{
public:
    explicit CTrustEntity(CCharEntity*);
    ~CTrustEntity() override = default;

    virtual void Tick(time_point) override;
    void PostTick() override;
    void FadeOut() override;
    void Spawn() override;
    void OnAbility(CAbilityState&, action_t&) override;
    void OnRangedAttack(CRangeState&, action_t&) override;
    bool ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags) override;

    virtual void OnDisengage(CAttackState&) override;
    void OnDespawn(CDespawnState&) override;

    virtual void Die() override;
    void Die(duration _duration);
    void Raise();

    static constexpr duration death_duration = 60min;
    static constexpr duration death_update_frequency = 16s;

    void SetDeathTimestamp(uint32 timestamp);
    int32 GetSecondsElapsedSinceDeath();

    void OnCastFinished(CMagicState& state, action_t& action) override;
    virtual void OnCastInterrupted(CMagicState&, action_t&, MSGBASIC_ID msg, bool blockedCast) override;
    void OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action) override;
    void OnMobSkillFinished(CMobSkillState& state, action_t& action) override;
    virtual void OnRaise() override;
    virtual void OnItemFinish(CItemState&, action_t&);

    uint32 m_TrustID{};

    uint32 m_DeathTimestamp;    // Timestamp when death counter has been saved to database
    time_point m_deathSyncTime; // Timer used for sending an update packet at a regular interval while the trust is dead
    uint8 m_hasReraise;         // checks if the trust has reraise already
    bool  m_isDead = false;      // Ensures that the trust won't continously run death logic over and over repeatadly
};

#endif

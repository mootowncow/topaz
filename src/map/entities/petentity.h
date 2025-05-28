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

#ifndef _CPETENTITY_H
#define _CPETENTITY_H

#include "mobentity.h"

enum PETTYPE
{
    PETTYPE_AVATAR             = 0,
    PETTYPE_WYVERN             = 1,
    PETTYPE_JUG_PET            = 2,
    PETTYPE_CHARMED_MOB        = 3,
    PETTYPE_AUTOMATON          = 4,
    PETTYPE_ADVENTURING_FELLOW = 5,
    PETTYPE_CHOCOBO            = 6,
    PETTYPE_LUOPAN             = 7,
};

enum WYVERNTYPE
{
    WYVERNTYPE_NONE = 0,
    WYVERNTYPE_DEFENSIVE = 1,
    WYVERNTYPE_MULTIPURPOSE = 2,
    WYVERNTYPE_OFFENSIVE = 3
};

class CPetEntity : public CMobEntity
{
public:
	 CPetEntity(PETTYPE petType);						// конструктор
	~CPetEntity();						// деструктор
	PETTYPE     getPetType();
    uint8       getSpawnLevel();
    void        setSpawnLevel(uint8 level);
    int32       getJugSpawnTime();            // initial spawn time (in seconds since epoch) of this pet if it's a jug pet
    int32       getJugDuration();             // duration of this jug pet in seconds
    void        setJugDuration(int32 seconds); // sets the duration of this jug pet in seconds
    bool isBstPet();
	uint8 m_Element;
	uint32 m_PetID;
    std::string GetScriptName();

    WYVERNTYPE getWyvernType();
    virtual void PostTick() override;
    virtual void FadeOut() override;
    virtual void Die() override;
    virtual void Spawn() override;
    bool shouldDespawn(time_point tick); // if true, the pet should despawn at this point in time
    void loadPetZoningInfo();            // loads info from previous zone (hp / mp / tp / spawn time). This MUST be called after Spawn()
    virtual void OnAbility(CAbilityState&, action_t&) override;
    virtual bool ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags) override;

private:
	PETTYPE m_PetType;			//the type of pet e.g. avatar/wyvern/jugpet etc
    uint8 m_spawnLevel;        // The level the pet was spawned at
    time_point m_jugSpawnTime; // original spawn time of a jug pet
    duration m_jugDuration;    // Time before the jug is despawned after being called

    void setJugSpawnTime(int32 spawnTime); // sets the initial spawn time of this pet in seconds since epoch
};

#endif

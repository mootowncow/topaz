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

#include "../../common/utils.h"

#include "item_usable.h"

#include "../vana_time.h"
#include "../map.h"

CItemUsable::CItemUsable(uint16 id) : CItem(id)
{
	setType(ITEM_USABLE);

	m_UseDelay		 = 0;
	m_MaxCharges	 = 0;
	m_Animation		 = 0;
	m_AnimationTime	 = 0;
	m_ActivationTime = 0;
	m_ValidTarget	 = 0;
	m_ReuseDelay	 = 0;
    m_AssignTime     = 0;
    m_AoE            = 0;
    m_Message        = 0;

    // Food-specific fields
    m_Mod1 = m_Mod2 = m_Mod3 = m_Mod4 = m_Mod5 = 0;
    m_Mod6 = m_Mod7 = m_Mod8 = m_Mod9 = m_Mod10 = 0;

    m_Power1 = m_Power2 = m_Power3 = m_Power4 = m_Power5 = 0;
    m_Power6 = m_Power7 = m_Power8 = m_Power9 = m_Power10 = 0;

    m_Duration = 0;
}

CItemUsable::~CItemUsable()
{
}

void CItemUsable::setUseDelay(uint8 UseDelay)
{
	m_UseDelay = UseDelay;
}

uint8 CItemUsable::getUseDelay()
{
	return m_UseDelay;
}

void CItemUsable::setReuseDelay(uint32 ReuseDelay)
{
	m_ReuseDelay = ReuseDelay;
}

uint32 CItemUsable::getReuseDelay()
{
	return m_ReuseDelay;
}

void CItemUsable::setLastUseTime(uint32 LastUseTime)
{
	ref<uint32>(m_extra, 0x04) = LastUseTime;
}

uint32 CItemUsable::getLastUseTime()
{
	return ref<uint32>(m_extra, 0x04);
}

uint32 CItemUsable::getNextUseTime()
{
    return getLastUseTime() + m_ReuseDelay;
}

void CItemUsable::setCurrentCharges(uint8 CurrCharges)
{
	ref<uint8>(m_extra, 0x01) = std::clamp<uint8>(CurrCharges, 0, m_MaxCharges);
}

uint8 CItemUsable::getCurrentCharges()
{
    return ref<uint8>(m_extra, 0x01);
}

void CItemUsable::setMaxCharges(uint8 MaxCharges)
{
	m_MaxCharges = MaxCharges;
}

uint8 CItemUsable::getMaxCharges()
{
	return m_MaxCharges;
}

void CItemUsable::setAnimationID(uint16 Animation)
{
	m_Animation = Animation;
}

uint16 CItemUsable::getAnimationID()
{
	return m_Animation;
}

void CItemUsable::setAnimationTime(uint16 AnimationTime)
{
	m_AnimationTime = AnimationTime;
}

uint16 CItemUsable::getAnimationTime()
{
	return m_AnimationTime;
}

void CItemUsable::setActivationTime(uint16 ActivationTime)
{
	m_ActivationTime = ActivationTime;
}

uint16 CItemUsable::getActivationTime()
{
	return m_ActivationTime;
}

void CItemUsable::setValidTarget(uint8 ValidTarget)
{
	m_ValidTarget = ValidTarget;
}

uint8 CItemUsable::getValidTarget()
{
	return m_ValidTarget;
}

uint16 CItemUsable::getAoE()
{
    return m_AoE;
}

void CItemUsable::setAoE(uint16 AoE)
{
    m_AoE = AoE;
}

uint16 CItemUsable::getMsg()
{
    return m_Message;
}

void CItemUsable::setMsg(uint16 msg)
{
    m_Message = msg;
}

uint16 CItemUsable::getParam()
{
    return m_Param;
}

void CItemUsable::setParam(uint16 param)
{
    m_Param = param;
}

// === Food items ===

uint16 CItemUsable::getMod(uint8 index) const
{
    switch(index)
    {
        case 1: return m_Mod1;
        case 2: return m_Mod2;
        case 3: return m_Mod3;
        case 4: return m_Mod4;
        case 5: return m_Mod5;
        case 6: return m_Mod6;
        case 7: return m_Mod7;
        case 8: return m_Mod8;
        case 9: return m_Mod9;
        case 10: return m_Mod10;
        default: return 0;
    }
}

uint16 CItemUsable::getPower(uint8 index) const
{
    switch(index)
    {
        case 1: return m_Power1;
        case 2: return m_Power2;
        case 3: return m_Power3;
        case 4: return m_Power4;
        case 5: return m_Power5;
        case 6: return m_Power6;
        case 7: return m_Power7;
        case 8: return m_Power8;
        case 9: return m_Power9;
        case 10: return m_Power10;
        default: return 0;
    }
}

uint16 CItemUsable::getDuration() const
{
    return m_Duration;
}

void CItemUsable::setMod(uint8 index, int16 value)
{
    switch(index)
    {
        case 1: m_Mod1 = value; break;
        case 2: m_Mod2 = value; break;
        case 3: m_Mod3 = value; break;
        case 4: m_Mod4 = value; break;
        case 5: m_Mod5 = value; break;
        case 6: m_Mod6 = value; break;
        case 7: m_Mod7 = value; break;
        case 8: m_Mod8 = value; break;
        case 9: m_Mod9 = value; break;
        case 10: m_Mod10 = value; break;
    }
}

void CItemUsable::setPower(uint8 index, int16 value)
{
    switch(index)
    {
        case 1: m_Power1 = value; break;
        case 2: m_Power2 = value; break;
        case 3: m_Power3 = value; break;
        case 4: m_Power4 = value; break;
        case 5: m_Power5 = value; break;
        case 6: m_Power6 = value; break;
        case 7: m_Power7 = value; break;
        case 8: m_Power8 = value; break;
        case 9: m_Power9 = value; break;
        case 10: m_Power10 = value; break;
    }
}

void CItemUsable::setDuration(uint16 duration)
{
    m_Duration = duration;
}

/************************************************************************
*																		*
*  Время экипировки предмета (VanaTime)                                 *
*																		*
************************************************************************/

void CItemUsable::setAssignTime(uint32 VanaTime)
{
    m_AssignTime = VanaTime;
}

/************************************************************************
*																		*
*  Оставшееся время до следующего использования предмета                *
*																		*
************************************************************************/

uint32 CItemUsable::getReuseTime()
{
    uint32 CurrentTime = CVanaTime::getInstance()->getVanaTime();
    uint32 ReuseTime   = std::max(m_AssignTime + m_UseDelay, getLastUseTime() + m_ReuseDelay);

    return (ReuseTime > CurrentTime ? (ReuseTime - CurrentTime) * 1000 : 0);
}

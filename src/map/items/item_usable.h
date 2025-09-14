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

#ifndef _CITEMUSABLE_H
#define _CITEMUSABLE_H

#include "../../common/cbasetypes.h"

#include "item.h"

class CItemUsable : public CItem
{
public:

	CItemUsable(uint16);
	virtual ~CItemUsable();

	uint8	getUseDelay();
	uint8	getCurrentCharges();
	uint8	getMaxCharges();
	uint16	getAnimationID();
	uint16	getAnimationTime();
	uint16	getActivationTime();
	uint8	getValidTarget();
    uint32  getReuseTime();
	uint32	getReuseDelay();
	uint32	getLastUseTime();
    uint32  getNextUseTime();
    uint16  getAoE();
    uint16  getMsg();
    uint16  getParam();
    uint16  getMod(uint8 index) const;
    uint16  getPower(uint8 index) const;
    uint16  getDuration() const;

	void	setUseDelay(uint8 UseDelay);
	void	setCurrentCharges(uint8 CurrCharges);
	void	setMaxCharges(uint8 MaxCharges);
	void	setAnimationID(uint16 Animation);
	void	setAnimationTime(uint16 AnimationTime);
	void	setActivationTime(uint16 ActivationTime);
	void	setValidTarget(uint8 ValidTarget);
	void	setReuseDelay(uint32 ReuseDelay);
	void	setLastUseTime(uint32 LastUseTime);
    void    setAssignTime(uint32 VanaTime);
	void    setAoE(uint16 AoE);
    void    setMsg(uint16 msg);
    void    setParam(uint16 param);
    void    setMod(uint8 index, int16 value);
    void    setPower(uint8 index, int16 value);
    void    setDuration(uint16 duration);

private:

	uint8	m_UseDelay;         // задержка использования после экипировки
	uint8	m_MaxCharges;       // максимальное количество зарядов предмета
	uint16	m_Animation;
	uint16	m_AnimationTime;    // время анимации для правильного отображения сообщения (эффектов)
	uint16	m_ActivationTime;   // время активации предмета во время использования
	uint8	m_ValidTarget;
	uint32	m_ReuseDelay;       // задержка между использованием предмета
    uint32  m_AssignTime;       // время экипировки предмета
    uint16  m_AoE;
    uint16  m_Message;          // Message param in packet (Recovers X HP etc)
    uint16  m_Param;            // Amount displayed in message (Player recovers 50 HP etc)

    // === Food items ===
    int16 m_Mod1;
    int16 m_Mod2;
    int16 m_Mod3;
    int16 m_Mod4;
    int16 m_Mod5;
    int16 m_Mod6;
    int16 m_Mod7;
    int16 m_Mod8;
    int16 m_Mod9;
    int16 m_Mod10;

    int16 m_Power1;
    int16 m_Power2;
    int16 m_Power3;
    int16 m_Power4;
    int16 m_Power5;
    int16 m_Power6;
    int16 m_Power7;
    int16 m_Power8;
    int16 m_Power9;
    int16 m_Power10;

    uint16 m_Duration;
};

#endif

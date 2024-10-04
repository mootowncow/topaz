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

#include "../../common/socket.h"
#include "../../common/utils.h"

#include <string.h>

#include "mob_extdata.h"

#include "../entities/mobentity.h"
#include "../status_effect_container.h"

CMobExtDataPacket::CMobExtDataPacket(CMobEntity* pMonster)
{
    this->type = 0xFF;
    this->size = 0x06;

    ref<uint32>(0x04) = pMonster->id;
    ref<uint16_t>(0x08) = pMonster->targid;
    ref<int16_t>(0x0A) = pMonster->m_THLvl;
}
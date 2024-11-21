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

#include "trust_progression.h"

#include "../entities/battleentity.h"
#include "../entities/mobentity.h"
#include "../entities/petentity.h"
#include "../entities/trustentity.h"
#include "../entities/charentity.h"

CTrustProgressionPacket::CTrustProgressionPacket(CBattleEntity* PEntity)
{
    this->type = 0xFF;
    this->size = 0x20 / 2;

    ref<uint32>(0x04) = 2; // Packet subtype 2

    const char* query = "SELECT \
                    (SELECT value FROM server_variables WHERE name = '[Trust]Melee'), \
                    (SELECT value FROM server_variables WHERE name = '[Trust]Ranged'), \
                    (SELECT value FROM server_variables WHERE name = '[Trust]Tank'), \
                    (SELECT value FROM server_variables WHERE name = '[Trust]Caster'), \
                    (SELECT value FROM server_variables WHERE name = '[Trust]Healer'), \
                    (SELECT value FROM server_variables WHERE name = '[Trust]Support')";

    int ret = Sql_Query(SqlHandle, query);
    if (ret != SQL_ERROR && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        ref<uint32>(0x08) = Sql_GetIntData(SqlHandle, 0); // [Trust]Melee (offset adjusted from 0x04 to 0x08)
        ref<uint32>(0x0C) = Sql_GetIntData(SqlHandle, 1); // [Trust]Ranged (offset adjusted from 0x08 to 0x0C)
        ref<uint32>(0x10) = Sql_GetIntData(SqlHandle, 2); // [Trust]Tank   (offset adjusted from 0x0C to 0x10)
        ref<uint32>(0x14) = Sql_GetIntData(SqlHandle, 3); // [Trust]Caster (offset adjusted from 0x10 to 0x14)
        ref<uint32>(0x18) = Sql_GetIntData(SqlHandle, 4); // [Trust]Healer (offset adjusted from 0x14 to 0x18)
        ref<uint32>(0x1C) = Sql_GetIntData(SqlHandle, 5); // [Trust]Support (offset adjusted from 0x18 to 0x1C)
    }
}

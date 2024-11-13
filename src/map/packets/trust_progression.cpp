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

CTrustProgressionPacket::CTrustProgressionPacket(CBattleEntity* PEntity)
{
    this->type = 0xFF;
    this->size = 0x06;

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
        ref<uint32>(0x04) = Sql_GetIntData(SqlHandle, 0); // [Trust]Melee
        ref<uint32>(0x08) = Sql_GetIntData(SqlHandle, 1); // [Trust]Ranged
        ref<uint32>(0x0C) = Sql_GetIntData(SqlHandle, 2); // [Trust]Tank
        ref<uint32>(0x10) = Sql_GetIntData(SqlHandle, 3); // [Trust]Caster
        ref<uint32>(0x14) = Sql_GetIntData(SqlHandle, 4); // [Trust]Healer
        ref<uint32>(0x18) = Sql_GetIntData(SqlHandle, 5); // [Trust]Support
    }
}

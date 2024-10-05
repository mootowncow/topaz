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

#include "../entities/battleentity.h"
#include "../entities/mobentity.h"
#include "../entities/trustentity.h"
#include "../status_effect_container.h"

#define MAX_STATUS_EFFECTS 16

CMobExtDataPacket::CMobExtDataPacket(CBattleEntity* PEntity)
{
    this->type = 0xFF;
    this->size = 0x06;

    ref<uint32>(0x04) = PEntity->id;
    ref<uint16_t>(0x08) = PEntity->targid;

    if (PEntity->objtype == TYPE_MOB)
    {
        ref<int16_t>(0x0A) = ((CMobEntity*)PEntity)->m_THLvl;
    }
    else
    {
        ref<int16_t>(0x0A) = 0;
    }

    auto effectCount = 0;
    PEntity->StatusEffectContainer.get()->ForEachEffect(
        [&](CStatusEffect* PEffect)
        {
            if (effectCount < MAX_STATUS_EFFECTS)
            {
                auto offset = 0x0C + (effectCount * 8);
                ref<uint16_t>(offset) = PEffect->GetStatusID();
                ref<uint16_t>(offset + 2) = PEffect->GetPower();

                auto elapsedTime = server_clock::now() - PEffect->GetStartTime();
                auto remainingTime = PEffect->GetDuration() - std::chrono::duration_cast<std::chrono::milliseconds>(elapsedTime).count();
                ref<uint32_t>(offset + 4) = remainingTime > 0 ? static_cast<uint32_t>(remainingTime) : 0;
                effectCount++;
            }
        });
    this->size += effectCount * 4;
}
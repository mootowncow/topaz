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

#include "../job_points.h"
#include "menu_merit.h"

#include "../entities/charentity.h"
#include "../utils/charutils.h"


CMenuMeritPacket::CMenuMeritPacket(CCharEntity* PChar)
{
    this->type = 0x63;
    this->size = 0x08;

    ref<uint8>(0x04) = 0x02; // Update Type
    ref<uint8>(0x06) = 0x0C; // Variable Data Size

    ref<uint16>(0x08) = PChar->PMeritPoints->GetLimitPoints();
    ref<uint16>(0x0A) = PChar->PMeritPoints->GetMeritPoints();

    // 0x0A
    if (PChar->GetMJob() == JOB_BLU)
    {
        uint8 bluePointBonus = 0;

        if (PChar->GetMLevel() >= 75)
        {
            bluePointBonus += PChar->PMeritPoints->GetMeritValue(MERIT_ASSIMILATION, PChar);
        }
        // TODO: JP
        if (PChar->GetMLevel() >= 99)
        {
            bluePointBonus += PChar->PJobPoints->GetJobPointValue(JP_BLUE_MAGIC_POINT_BONUS);
        }

        ref<uint16>(0x0A) |= bluePointBonus << 7;
    }

    bool canUseMeritMode = PChar->jobs.job[PChar->GetMJob()] >= 75 && charutils::hasKeyItem(PChar, 606);

    ref<uint16>(0x0A) |= canUseMeritMode << 13; // Level >= 75 and has Limit Break KI

    bool atMaxLevelLimit = PChar->jobs.job[PChar->GetMJob()] >= PChar->jobs.genkai;
    bool hasCappedXp = PChar->jobs.exp[PChar->GetMJob()] == (charutils::GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()]) - 1);

    ref<uint16>(0x0A) |= ((atMaxLevelLimit && hasCappedXp) || PChar->MeritMode && atMaxLevelLimit) << 14; // XP is capped, or player is in Merit Mode
    ref<uint16>(0x0A) |= (canUseMeritMode && PChar->MeritMode) << 15;                  // Merit Mode Enabled, and Current Job is eligible

    ref<uint8>(0x0C) = map_config.max_merit_points + PChar->PMeritPoints->GetMeritValue(MERIT_MAX_MERIT, PChar);

    PChar->pushPacket(new CBasicPacket(*this));

    // Update Type 3 : Monstrosity 1 (Possible to move these packets out of here?)
    // --------------------------------------------

    this->size = 0x6E;

    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    uint8 packet[] = { 0x03, 0x00, 0xD8 };

    memcpy(data + (0x04), &packet, sizeof(packet));

    // This is a hack.  We really should clear all non-relevant bytes in memset
    ref<uint8>(0x0C) = 0x00; // Temporary fix for Monstrosity Gladiator Rank.  This applies to next packet as well.

    PChar->pushPacket(new CBasicPacket(*this));

    // Update Type 4 : Monstrosity 2
    // --------------------------------------------

    this->size = 0x5A;

    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    uint8 packet2[] = { 0x04, 0x00, 0xB0 };
    memcpy(data + (0x04), &packet2, sizeof(packet2));
}



//0x63, 0x06, 0x88, 0x41, 0x02, 0x00, 0x08, 0x00, 0xD3, 0x03, 0x03, 0x60

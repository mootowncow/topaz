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

#include "currency2.h"

#include "../entities/charentity.h"

CCurrencyPacket2::CCurrencyPacket2(CCharEntity* PChar)
{
    this->type = 0x118;
    this->size = 0x9F;


    const char* query = "SELECT bayld, kinetic_unit, imprimaturs, mystical_canteen, obsidian_fragment, lebondopt_wing, \
                         pulchridopt_wing, mweya_plasm, ghastly_stone, ghastly_stone_1, ghastly_stone_2, verdigris_stone, \
                         verdigris_stone_1, verdigris_stone_2, wailing_stone, wailing_stone_1, wailing_stone_2, \
                         snowslit_stone, snowslit_stone_1, snowslit_stone_2, snowtip_stone, snowtip_stone_1, snowtip_stone_2, \
                         snowdim_stone, snowdim_stone_1, snowdim_stone_2, snoworb_stone, snoworb_stone_1, snoworb_stone_2, \
                         leafslit_stone, leafslit_stone_1, leafslit_stone_2, leaftip_stone, leaftip_stone_1, leaftip_stone_2, \
                         leafdim_stone, leafdim_stone_1, leafdim_stone_2, leaforb_stone, leaforb_stone_1, leaforb_stone_2, \
                         duskslit_stone, duskslit_stone_1, duskslit_stone_2, dusktip_stone, dusktip_stone_1, dusktip_stone_2, \
                         duskdim_stone, duskdim_stone_1, duskdim_stone_2, duskorb_stone, duskorb_stone_1, duskorb_stone_2, \
                         pellucid_stone, fern_stone, taupe_stone, escha_beads, escha_silt, potpourri, current_hallmarks, \
                         total_hallmarks, gallantry, crafter_points, fire_crystal_set, ice_crystal_set, wind_crystal_set, \
                         earth_crystal_set, lightning_crystal_set, water_crystal_set, light_crystal_set, dark_crystal_set, \
                         mc_s_sr01_set, mc_s_sr02_set, mc_s_sr03_set, liquefaction_spheres_set, induration_spheres_set, \
                         detonation_spheres_set, scission_spheres_set, impaction_spheres_set, reverberation_spheres_set, \
                         transfixion_spheres_set, compression_spheres_set, fusion_spheres_set, distortion_spheres_set, \
                         fragmentation_spheres_set, gravitation_spheres_set, light_spheres_set, darkness_spheres_set, \
                         silver_aman_voucher, domain_points, domain_points_daily, mog_segments, gallimaufry, is_accolades, \
                         temenos_units, apollyon_units \
                         FROM char_points WHERE charid = % d ";

    int ret = Sql_Query(SqlHandle, query, PChar->id);
    if (ret != SQL_ERROR && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        ref<uint32>(0x04) = Sql_GetIntData(SqlHandle, 0); // bayld
        ref<uint16>(0x08) = Sql_GetIntData(SqlHandle, 1); // kinetic_unit
        ref<uint8>(0x0A) = Sql_GetIntData(SqlHandle, 2);  // imprimaturs
        ref<uint8>(0x0B) = Sql_GetIntData(SqlHandle, 3);  // mystical_canteen
        ref<uint32>(0x0C) = Sql_GetIntData(SqlHandle, 4); // obsidian_fragment
        ref<uint16>(0x10) = Sql_GetIntData(SqlHandle, 5); // lebondopt_wing
        ref<uint16>(0x12) = Sql_GetIntData(SqlHandle, 6); // pulchridopt_wing
        ref<uint32>(0x14) = Sql_GetIntData(SqlHandle, 7); // mewya_plasm

        ref<uint8>(0x18) = Sql_GetIntData(SqlHandle, 8);  // ghastly_stone
        ref<uint8>(0x19) = Sql_GetIntData(SqlHandle, 9);  // ghastly_stone_1
        ref<uint8>(0x1A) = Sql_GetIntData(SqlHandle, 10); // ghastly_stone_2
        ref<uint8>(0x1B) = Sql_GetIntData(SqlHandle, 11); // verdigris_stone
        ref<uint8>(0x1C) = Sql_GetIntData(SqlHandle, 12); // verdigris_stone_1
        ref<uint8>(0x1D) = Sql_GetIntData(SqlHandle, 13); // verdigris_stone_2
        ref<uint8>(0x1E) = Sql_GetIntData(SqlHandle, 14); // wailing_stone
        ref<uint8>(0x1F) = Sql_GetIntData(SqlHandle, 15); // wailing_stone_1
        ref<uint8>(0x20) = Sql_GetIntData(SqlHandle, 16); // wailing_stone_2

        ref<uint8>(0x21) = Sql_GetIntData(SqlHandle, 17); // snowslit_stone
        ref<uint8>(0x22) = Sql_GetIntData(SqlHandle, 18); // snowslit_stone_1
        ref<uint8>(0x23) = Sql_GetIntData(SqlHandle, 19); // snowslit_stone_2
        ref<uint8>(0x24) = Sql_GetIntData(SqlHandle, 20); // snowtip_stone
        ref<uint8>(0x25) = Sql_GetIntData(SqlHandle, 21); // snowtip_stone_1
        ref<uint8>(0x26) = Sql_GetIntData(SqlHandle, 22); // snowtip_stone_2
        ref<uint8>(0x27) = Sql_GetIntData(SqlHandle, 23); // snowdim_stone
        ref<uint8>(0x28) = Sql_GetIntData(SqlHandle, 24); // snowdim_stone_1
        ref<uint8>(0x29) = Sql_GetIntData(SqlHandle, 25); // snowdim_stone_2
        ref<uint8>(0x2A) = Sql_GetIntData(SqlHandle, 26); // snoworb_stone
        ref<uint8>(0x2B) = Sql_GetIntData(SqlHandle, 27); // snoworb_stone_1
        ref<uint8>(0x2C) = Sql_GetIntData(SqlHandle, 28); // snoworb_stone_2
        ref<uint8>(0x2D) = Sql_GetIntData(SqlHandle, 29); // leafslit_stone
        ref<uint8>(0x2E) = Sql_GetIntData(SqlHandle, 30); // leafslit_stone_1
        ref<uint8>(0x2F) = Sql_GetIntData(SqlHandle, 31); // leafslit_stone_2
        ref<uint8>(0x30) = Sql_GetIntData(SqlHandle, 32); // leaftip_stone
        ref<uint8>(0x31) = Sql_GetIntData(SqlHandle, 33); // leaftip_stone_1
        ref<uint8>(0x32) = Sql_GetIntData(SqlHandle, 34); // leaftip_stone_2
        ref<uint8>(0x33) = Sql_GetIntData(SqlHandle, 35); // leafdim_stone
        ref<uint8>(0x34) = Sql_GetIntData(SqlHandle, 36); // leafdim_stone_1
        ref<uint8>(0x35) = Sql_GetIntData(SqlHandle, 37); // leafdim_stone_2
        ref<uint8>(0x36) = Sql_GetIntData(SqlHandle, 38); // leaforb_stone
        ref<uint8>(0x37) = Sql_GetIntData(SqlHandle, 39); // leaforb_stone_1
        ref<uint8>(0x38) = Sql_GetIntData(SqlHandle, 40); // leaforb_stone_2
        ref<uint8>(0x39) = Sql_GetIntData(SqlHandle, 41); // duskslit_stone
        ref<uint8>(0x3A) = Sql_GetIntData(SqlHandle, 42); // duskslit_stone_1
        ref<uint8>(0x3B) = Sql_GetIntData(SqlHandle, 43); // duskslit_stone_2
        ref<uint8>(0x3C) = Sql_GetIntData(SqlHandle, 44); // dusktip_stone
        ref<uint8>(0x3D) = Sql_GetIntData(SqlHandle, 45); // dusktip_stone_1
        ref<uint8>(0x3E) = Sql_GetIntData(SqlHandle, 46); // dusktip_stone_2
        ref<uint8>(0x3F) = Sql_GetIntData(SqlHandle, 47); // duskdim_stone
        ref<uint8>(0x40) = Sql_GetIntData(SqlHandle, 48); // duskdim_stone_1
        ref<uint8>(0x41) = Sql_GetIntData(SqlHandle, 49); // duskdim_stone_2
        ref<uint8>(0x42) = Sql_GetIntData(SqlHandle, 50); // duskorb_stone
        ref<uint8>(0x43) = Sql_GetIntData(SqlHandle, 51); // duskorb_stone_1
        ref<uint8>(0x44) = Sql_GetIntData(SqlHandle, 52); // duskorb_stone_2

        ref<uint8>(0x45) = Sql_GetIntData(SqlHandle, 53); // pellucid_stone
        ref<uint8>(0x46) = Sql_GetIntData(SqlHandle, 54); // fern_stone
        ref<uint8>(0x47) = Sql_GetIntData(SqlHandle, 55); // taupe_stone

        ref<uint16>(0x4A) = Sql_GetIntData(SqlHandle, 56); // escha_beads
        ref<uint32>(0x4C) = Sql_GetIntData(SqlHandle, 57); // escha_silt

        ref<uint32>(0x50) = Sql_GetIntData(SqlHandle, 58); // potpourri

        ref<uint32>(0x54) = Sql_GetIntData(SqlHandle, 59); // current_hallmarks
        ref<uint32>(0x58) = Sql_GetIntData(SqlHandle, 60); // total_hallmarks
        ref<uint32>(0x5C) = Sql_GetIntData(SqlHandle, 61); // gallantry

        ref<uint32>(0x60) = Sql_GetIntData(SqlHandle, 62); // crafter_points

        ref<uint8>(0x64) = Sql_GetIntData(SqlHandle, 63); // fire_crystal_set
        ref<uint8>(0x65) = Sql_GetIntData(SqlHandle, 64); // ice_crystal_set
        ref<uint8>(0x66) = Sql_GetIntData(SqlHandle, 65); // wind_crystal_set
        ref<uint8>(0x67) = Sql_GetIntData(SqlHandle, 66); // earth_crystal_set
        ref<uint8>(0x68) = Sql_GetIntData(SqlHandle, 67); // lightning_crystal_set
        ref<uint8>(0x69) = Sql_GetIntData(SqlHandle, 68); // water_crystal_set
        ref<uint8>(0x6A) = Sql_GetIntData(SqlHandle, 69); // light_crystal_set
        ref<uint8>(0x6B) = Sql_GetIntData(SqlHandle, 70); // dark_crystal_set
        ref<uint8>(0x6C) = Sql_GetIntData(SqlHandle, 71); // mc_s_sr01_set
        ref<uint8>(0x6D) = Sql_GetIntData(SqlHandle, 72); // mc_s_sr02_set
        ref<uint8>(0x6E) = Sql_GetIntData(SqlHandle, 73); // mc_s_sr03_set
        ref<uint8>(0x6F) = Sql_GetIntData(SqlHandle, 74); // liquefaction_spheres_set
        ref<uint8>(0x70) = Sql_GetIntData(SqlHandle, 75); // induration_spheres_set
        ref<uint8>(0x71) = Sql_GetIntData(SqlHandle, 76); // detonation_spheres_set
        ref<uint8>(0x72) = Sql_GetIntData(SqlHandle, 77); // scission_spheres_set
        ref<uint8>(0x73) = Sql_GetIntData(SqlHandle, 78); // impaction_spheres_set
        ref<uint8>(0x74) = Sql_GetIntData(SqlHandle, 79); // reverberation_spheres_set
        ref<uint8>(0x75) = Sql_GetIntData(SqlHandle, 80); // transfixion_spheres_set
        ref<uint8>(0x76) = Sql_GetIntData(SqlHandle, 81); // compression_spheres_set
        ref<uint8>(0x77) = Sql_GetIntData(SqlHandle, 82); // fusion_spheres_set
        ref<uint8>(0x78) = Sql_GetIntData(SqlHandle, 83); // distortion_spheres_set
        ref<uint8>(0x79) = Sql_GetIntData(SqlHandle, 84); // fragmentation_spheres_set
        ref<uint8>(0x7A) = Sql_GetIntData(SqlHandle, 85); // gravitation_spheres_set
        ref<uint8>(0x7B) = Sql_GetIntData(SqlHandle, 86); // light_spheres_set
        ref<uint8>(0x7C) = Sql_GetIntData(SqlHandle, 87); // darkness_spheres_set

        ref<uint32>(0x80) = Sql_GetIntData(SqlHandle, 88); // silver_aman_voucher

        ref<uint32>(0x84) = Sql_GetIntData(SqlHandle, 89); // domain_points
        ref<uint32>(0x88) = Sql_GetIntData(SqlHandle, 90); // domain_points_daily
        ref<uint32>(0x8C) = Sql_GetIntData(SqlHandle, 91); // mog_segments
        ref<uint32>(0x90) = Sql_GetIntData(SqlHandle, 92); // gallimaufry
        ref<uint16>(0x94) = Sql_GetIntData(SqlHandle, 93); // is_accolades
        ref<uint16>(0x98) = Sql_GetIntData(SqlHandle, 94); // temenos_units
        ref<uint16>(0x9C) = Sql_GetIntData(SqlHandle, 95); // apollyon_units
    }
}

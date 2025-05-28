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

#ifndef _IPETUTILS_H
#define _IPETUTILS_H

#include "../../common/cbasetypes.h"
#include "../../common/mmo.h"

enum PETID
{
    PETID_FIRESPIRIT         = 0,
    PETID_ICESPIRIT          = 1,
    PETID_AIRSPIRIT          = 2,
    PETID_EARTHSPIRIT        = 3,
    PETID_THUNDERSPIRIT      = 4,
    PETID_WATERSPIRIT        = 5,
    PETID_LIGHTSPIRIT        = 6,
    PETID_DARKSPIRIT         = 7,
    PETID_CARBUNCLE          = 8,
    PETID_FENRIR             = 9,
    PETID_IFRIT              = 10,
    PETID_TITAN              = 11,
    PETID_LEVIATHAN          = 12,
    PETID_GARUDA             = 13,
    PETID_SHIVA              = 14,
    PETID_RAMUH              = 15,
    PETID_DIABOLOS           = 16,
    PETID_ALEXANDER          = 17,
    PETID_ODIN               = 18,
    PETID_ATOMOS             = 19,
    PETID_CAIT_SITH          = 20,
    PETID_SHEEP_FAMILIAR = 21,
    PETID_HARE_FAMILIAR = 22,
    PETID_CRAB_FAMILIAR = 23,
    PETID_COURIER_CARRIE = 24,
    PETID_HOMUNCULUS = 25,
    PETID_FLYTRAP_FAMILIAR = 26,
    PETID_TIGER_FAMILIAR = 27,
    PETID_FLOWERPOT_BILL = 28,
    PETID_EFT_FAMILIAR = 29,
    PETID_LIZARD_FAMILIAR = 30,
    PETID_MAYFLY_FAMILIAR = 31,
    PETID_FUNGUAR_FAMILIAR = 32,
    PETID_BEETLE_FAMILIAR = 33,
    PETID_ANTLION_FAMILIAR = 34,
    PETID_DIREMITE_FAMILIAR = 35,
    PETID_LULLABY_MELODIA = 36,
    PETID_KEENEARED_STEFFI = 37,
    PETID_FLOWERPOT_BEN = 38,
    PETID_SABER_SIRAVARDE = 39,
    PETID_COLDBLOOD_COMO = 40,
    PETID_SHELLBUSTER_OROB = 41,
    PETID_VORACIOUS_AUDREY = 42,
    PETID_AMBUSHER_ALLIE = 43,
    PETID_LIFEDRINKER_LARS = 44,
    PETID_PANZER_GALAHAD = 45,
    PETID_CHOPSUEY_CHUCKY = 46,
    PETID_AMIGO_SABOTENDER = 47,
    PETID_WYVERN             = 48,
    PETID_CLYVONNE = 49,
    PETID_SHASRA = 50,
    PETID_LULUSH = 51,
    PETID_FARGANN = 52,
    PETID_LOUISE = 53,
    PETID_SIEGHARD = 54,
    PETID_YULY = 55,
    PETID_MERLE = 56,
    PETID_NAZUNA = 57,
    PETID_CETAS = 58,
    PETID_ANNA = 59,
    PETID_JULIO = 60,
    PETID_BRONCHA = 61,
    PETID_GERARD = 62,
    PETID_HOBS = 63,
    PETID_FALCORR = 64,
    PETID_RAPHIE = 65,
    PETID_MAC = 66,
    PETID_SILAS = 67,
    PETID_TOLOI = 68,
    PETID_HARLEQUINFRAME     = 69,
    PETID_VALOREDGEFRAME     = 70,
    PETID_SHARPSHOTFRAME     = 71,
    PETID_STORMWAKERFRAME    = 72,
    PETID_ADVENTURING_FELLOW = 73,
    PETID_CHOCOBO            = 74,
    PETID_LUOPAN             = 75,
    PETID_ROCHE = 76,          // AIRY BROTH
    PETID_CAROLINE = 77,       // AGED HUMUS
    PETID_KEN = 78,            // BLACKWATER BROTH
    PETID_JEDD = 79,           // CRACKLING BROTH
    PETID_ANNABELLE = 80,      // CREEPY BROTH
    PETID_WALUIS = 81,         // CRUMBLY SOIL
    PETID_SLIME = 82,          // DECAYING BROTH
    PETID_PATRICE = 83,        // PUTRESCENT BROTH
    PETID_ARTHUR = 84,         // DIRE BROTH
    PETID_CANDI = 85,          // ELECTRIFIED BROTH
    PETID_HONEY = 86,          // BUG-RIDDEN BROTH
    PETID_LYNX = 87,           // FRIZZANTE BROTH
    PETID_GASTON = 88,         // SPUMANTE BROTH
    PETID_KIYOMARO = 89,       // FIZZY BROTH
    PETID_VICKIE = 90,         // TANT. BROTH
    PETID_ALICE = 91,          // FURIOUS BROTH
    PETID_STORM = 92,          // INSIPID BROTH
    PETID_IYO = 93,            // DEEPWATER BROTH
    PETID_PATRICK = 94,        // LIVID BROTH
    PETID_SHIZUNA = 95,        // LYRICAL BROTH
    PETID_RANDY = 96,          // MEATY BROTH
    PETID_LYNN = 97,           // MUDDY BROTH
    PETID_PERCIVAL = 98,       // PALE SAP
    PETID_ACUEX = 99,          // POISONOUS BROTH
    PETID_BREDO = 100,         // VENOMOUS BROTH
    PETID_WEEVIL = 101,        // PRISTINE SAP
    PETID_ANGELINA = 102,      // TRULY PRISTINE SAP
    PETID_REINHARD = 103,      // RAPID BROTH
    PETID_HERMES = 104,        // SALINE BROTH
    PETID_PORTER_CRAB = 105,   // RANCID BROTH
    PETID_EDWIN = 106,         // PUNGENT BROTH
    PETID_IBUKI = 107,         // SALUBRIOUS BROTH
    PETID_ZHIVAGO = 108,       // WINDY GREENS
    PETID_MALFIK = 109,        // SHIMMERING BROTH
    PETID_ANGUS = 110,         // FERM. BROTH
    PETID_XERIN = 111,         // SPICY BROTH
    PETID_BERTHA = 112,        // BUBBLY BROTH
    PETID_SPIDER = 113,        // STICKY WEBBING
    PETID_HACHIROBE = 114,     // SLIMY WEBBING
    PETID_COLIBRI = 115,       // SUGARY BROTH
    PETID_LEERA = 116,         // GLAZED BROTH
    PETID_DORTWIN = 117,       // SWIRLING BROTH
    PETID_PETER = 118,         // VIS. BROTH
    PETID_HENRY = 119,         // TRANS. BROTH
    PETID_HIPPOGRYPH = 120,    // TURPID BROTH
    PETID_ROLAND = 121,        // FECULENT BROTH
    PETID_MOSQUITO = 122,      // WETLANDS BROTH
    PETID_YOKO = 123,          // HEAVENLY BROTH BREAKS SERVER
    PETID_GLENN = 124,            // WISPY BROTH
    PETID_YELLOW_BEETLE = 125, // ZESTFUL SAP
    PETID_SEFINA = 126,        // GASSY SAP
    MAX_PETID                = 999,
};

class CBattleEntity;
class CPetEntity;

namespace petutils
{
    void LoadPetList();
    void FreePetList();

    void SpawnPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone);
    void SpawnMobPet(CBattleEntity* PMaster, uint32 PetID);
    void DetachPet(CBattleEntity* PMaster);
    void DespawnPet(CBattleEntity* PMaster);
    void AttackTarget(CBattleEntity* PMaster, CBattleEntity* PTarget);
    void RetreatToMaster(CBattleEntity* PMaster);
    int16 PerpetuationCost(uint32 id, uint8 level);
    void Familiar(CBattleEntity* PPet, CBattleEntity* PMaster);
    void LoadPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone);
    void CalculateAvatarStats(CBattleEntity* PMaster, CPetEntity* PPet);
    void CalculateWyvernStats(CBattleEntity* PMaster, CPetEntity* PPet);
    void CalculateJugPetStats(CBattleEntity* PMaster, CPetEntity* PPet);
    void CalculateAutomatonStats(CBattleEntity* PMaster, CPetEntity* PPet);
    void CalculateLoupanStats(CBattleEntity* PMaster, CPetEntity* PPet);
    void FinalizePetStatistics(CBattleEntity* PMaster, CPetEntity* PPet);

    void SetupPetWithMaster(CBattleEntity* PMaster, CPetEntity* PPet);

    bool CheckPetModType(CBattleEntity* PPet, PetModType petmod);
};

#endif

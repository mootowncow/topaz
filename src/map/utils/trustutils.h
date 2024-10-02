#ifndef _ITRUSTUTILS_H
#define _ITRUSTUTILS_H

#include "../../common/cbasetypes.h"
#include "../../common/mmo.h"

class CBattleEntity;
class CCharEntity;
class CTrustEntity;

namespace trustutils
{
    void LoadTrustList();
    void BuildingTrustSkillsTable(CTrustEntity* PTrust);
    void FreeTrustList();
    int  GetEvasionRankForJob(uint8 job);
    bool IsHighLevelWS(uint16 skill_id);

    void SpawnTrust(CCharEntity* PMaster, uint32 TrustID);

    // Internal
    void BuildTrust(uint32 TrustID);
    CTrustEntity* LoadTrust(CCharEntity* PMaster, uint32 TrustID);
    void LoadTrustStatsAndSkills(CTrustEntity* PTrust);
}; // namespace trustutils

#endif

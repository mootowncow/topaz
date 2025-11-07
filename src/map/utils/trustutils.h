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
    uint8   GetDefenseRankForJob(uint8 job);
    uint8   GetEvasionRankForJob(uint8 job);

    bool IsMediumLevelWS(uint16 skill_id);
    bool IsHighLevelWS(uint16 skill_id);
    bool IsBuffWS(uint16 skill_id);

    void SpawnTrust(CCharEntity* PMaster, uint32 TrustID);

    // Internal
    void BuildTrust(uint32 TrustID);
    CTrustEntity* LoadTrust(CCharEntity* PMaster, uint32 TrustID);
    void LoadTrustStatsAndSkills(CTrustEntity* PTrust);
}; // namespace trustutils

#endif

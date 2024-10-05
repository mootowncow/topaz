#ifndef _CMOBEXTDATAPACKET_H
#define _CMOBEXTDATAPACKET_H

#include "../../common/cbasetypes.h"

#include "basic.h"

class CBattleEntity;
class CMobEntity;
class CTrustEntity;
class CPetEntity;

class CMobExtDataPacket : public CBasicPacket
{
public:
    CMobExtDataPacket(CBattleEntity* PEntity);
};

#endif

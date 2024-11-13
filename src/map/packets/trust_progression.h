#ifndef _TRUSTPROGRESSION_H
#define _TRUSTPROGRESSION_H

#include "../../common/cbasetypes.h"

#include "basic.h"

class CBattleEntity;
class CMobEntity;
class CTrustEntity;
class CPetEntity;

class CTrustProgressionPacket : public CBasicPacket
{
public:
    CTrustProgressionPacket(CBattleEntity* PEntity);
};

#endif

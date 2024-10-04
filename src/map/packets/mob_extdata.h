#ifndef _CMOBEXTDATAPACKET_H
#define _CMOBEXTDATAPACKET_H

#include "../../common/cbasetypes.h"

#include "basic.h"

class CMobEntity;

class CMobExtDataPacket : public CBasicPacket
{
public:
    CMobExtDataPacket(CMobEntity* PEntity);
};

#endif

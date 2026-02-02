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

#include "../../common/showmsg.h"

#include "lua_spell.h"
#include "../spell.h"
#include "../utils/battleutils.h"


/************************************************************************
*																		*
*  Конструктор															*
*																		*
************************************************************************/

CLuaSpell::CLuaSpell(lua_State *L)
{
    if (!lua_isnil(L, -1))
    {
        m_PLuaSpell = (CSpell*)(lua_touserdata(L, -1));
        lua_pop(L, 1);
    }
    else
    {
        m_PLuaSpell = nullptr;
    }
}

/************************************************************************
*																		*
*  Конструктор															*
*																		*
************************************************************************/

CLuaSpell::CLuaSpell(CSpell* PSpell)
{
    m_PLuaSpell = PSpell;
}

/************************************************************************
*                                                                       *
*  Устанавливаем сообщение заклинания                                   *
*                                                                       *
************************************************************************/

inline int32 CLuaSpell::setMsg(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->setMessage((uint16)lua_tointeger(L, -1));
    return 0;
}

inline int32 CLuaSpell::setAoE(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->setAOE((uint8)lua_tointeger(L, -1));
    return 0;
}

inline int32 CLuaSpell::setFlag(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->setFlag((uint8)lua_tointeger(L, -1));
    return 0;
}

inline int32 CLuaSpell::setRadius(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->setRadius((float)lua_tonumber(L, -1));
    return 0;
}

inline int32 CLuaSpell::setSkillType(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->setSkillType((uint8)lua_tointeger(L, -1));
    return 0;
}


inline int32 CLuaSpell::base(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);

    if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
    {
        m_PLuaSpell->setBase((uint16)lua_tointeger(L, 1));
        return 0;
    }

    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));
    lua_pushinteger(L, m_PLuaSpell->getBase());
    return 1;
}

inline int32 CLuaSpell::multiplier(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);

    if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
    {
        m_PLuaSpell->setMultiplier((float)lua_tonumber(L, 1));
        return 0;
    }

    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));
    lua_pushnumber(L, m_PLuaSpell->getMultiplier());
    return 1;
}

inline int32 CLuaSpell::getAnimation(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    lua_pushinteger(L, m_PLuaSpell->getAnimationID());
    return 1;
}

inline int32 CLuaSpell::setAnimation(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->setAnimationID((uint16)lua_tonumber(L, -1));
    return 0;
}

inline int32 CLuaSpell::setMPCost(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->setMPCost((uint16)lua_tonumber(L, -1));
    return 0;
}

inline int32 CLuaSpell::castTime(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);

    if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
    {
        m_PLuaSpell->setCastTime((uint32)lua_tointeger(L, 1));
        return 0;
    }

    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));
    lua_pushinteger(L, m_PLuaSpell->getCastTime());
    return 1;
}

inline int32 CLuaSpell::getValidTarget(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getValidTarget());
    return 1;
}

inline int32 CLuaSpell::setValidTarget(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->m_ValidTarget = ((uint8)lua_tonumber(L, -1));
    return 0;
}


inline int32 CLuaSpell::canTargetEnemy(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushboolean(L, m_PLuaSpell->canTargetEnemy());
    return 1;
}

inline int32 CLuaSpell::getTotalTargets(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getTotalTargets());
    return 1;
}

inline int32 CLuaSpell::getPrimaryTargetID(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getPrimaryTargetID());
    return 1;
}

inline int32 CLuaSpell::getMagicBurstMessage(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getMagicBurstMessage());
    return 1;
}

inline int32 CLuaSpell::getElement(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getElement());
    return 1;
}

inline int32 CLuaSpell::getCE(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getCE());
    return 1;
}

inline int32 CLuaSpell::getVE(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getVE());
    return 1;
}

inline int32 CLuaSpell::isAoE(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    // Returns 0 to lua. You have to do spell:isAoE() > 0 for true and spell:isAoE() == 0 for false
    lua_pushinteger(L, m_PLuaSpell->getAOE());
    return 1;
}

inline int32 CLuaSpell::isCovered(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushboolean(L, m_PLuaSpell->isCovered());
    return 1;
}

inline int32 CLuaSpell::tookEffect(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushboolean(L, m_PLuaSpell->tookEffect());
    return 1;
}

inline int32 CLuaSpell::getID(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, static_cast<uint16>(m_PLuaSpell->getID()));
    return 1;
}

int32 CLuaSpell::getMsg(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);

    lua_pushinteger(L, m_PLuaSpell->getMessage());
    return 1;
}

inline int32 CLuaSpell::getMPCost(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, static_cast<uint16>(m_PLuaSpell->getMPCost()));
    return 1;
}

inline int32 CLuaSpell::getSkillType(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getSkillType());
    return 1;
}

inline int32 CLuaSpell::getSpellGroup(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getSpellGroup());
    return 1;
}

inline int32 CLuaSpell::getSpellFamily(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getSpellFamily());
    return 1;
}

inline int32 CLuaSpell::getFlag(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getFlag());
    return 1;
}

inline int32 CLuaSpell::getRequirements(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushinteger(L, m_PLuaSpell->getRequirements());
    return 1;
}

inline int32 CLuaSpell::setRequirements(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->setRequirements((uint16)lua_tointeger(L, -1));
    return 0;
}

inline int32 CLuaSpell::getAttackBonus(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushnumber(L, m_PLuaSpell->getAttackBonus());
    return 1;
}

inline int32 CLuaSpell::setAttackBonus(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    float value = static_cast<float>(lua_tonumber(L, -1));
    m_PLuaSpell->setAttackBonus(value);
    return 0;
}

inline int32 CLuaSpell::getEcosystem(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushnumber(L, m_PLuaSpell->getEcosystem());
    return 1;
}

inline int32 CLuaSpell::setEcosystem(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

    m_PLuaSpell->setEcosystem((ECOSYSTEM)lua_tonumber(L, 1));
    return 0;
}

inline int32 CLuaSpell::dealsDamage(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushboolean(L, m_PLuaSpell->dealsDamage());
    return 1;
}

inline int32 CLuaSpell::getTier(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    lua_pushnumber(L, m_PLuaSpell->getTier());
    return 1;
}

/************************************************************************
*																		*
*  Инициализация методов в lua											*
*																		*
************************************************************************/

const char CLuaSpell::className[] = "CSpell";
Lunar<CLuaSpell>::Register_t CLuaSpell::methods[] =
{
    LUNAR_DECLARE_METHOD(CLuaSpell,setMsg),
    LUNAR_DECLARE_METHOD(CLuaSpell,setAoE),
    LUNAR_DECLARE_METHOD(CLuaSpell,setFlag),
    LUNAR_DECLARE_METHOD(CLuaSpell,setRadius),
    LUNAR_DECLARE_METHOD(CLuaSpell,base),
    LUNAR_DECLARE_METHOD(CLuaSpell,multiplier),
    LUNAR_DECLARE_METHOD(CLuaSpell,getAnimation),
    LUNAR_DECLARE_METHOD(CLuaSpell,setAnimation),
    LUNAR_DECLARE_METHOD(CLuaSpell,setMPCost),
    LUNAR_DECLARE_METHOD(CLuaSpell,isAoE),
    LUNAR_DECLARE_METHOD(CLuaSpell,isCovered),
    LUNAR_DECLARE_METHOD(CLuaSpell,tookEffect),
    LUNAR_DECLARE_METHOD(CLuaSpell,getMagicBurstMessage),
    LUNAR_DECLARE_METHOD(CLuaSpell,getElement),
    LUNAR_DECLARE_METHOD(CLuaSpell,getCE),
    LUNAR_DECLARE_METHOD(CLuaSpell,getVE),
    LUNAR_DECLARE_METHOD(CLuaSpell,castTime),
    LUNAR_DECLARE_METHOD(CLuaSpell,getValidTarget),
    LUNAR_DECLARE_METHOD(CLuaSpell,setValidTarget),
    LUNAR_DECLARE_METHOD(CLuaSpell,canTargetEnemy),
    LUNAR_DECLARE_METHOD(CLuaSpell,getTotalTargets),
    LUNAR_DECLARE_METHOD(CLuaSpell,getPrimaryTargetID),
    LUNAR_DECLARE_METHOD(CLuaSpell,getSkillType),
    LUNAR_DECLARE_METHOD(CLuaSpell,setSkillType),
    LUNAR_DECLARE_METHOD(CLuaSpell,getID),
    LUNAR_DECLARE_METHOD(CLuaSpell,getMsg),
    LUNAR_DECLARE_METHOD(CLuaSpell,getMPCost),
    LUNAR_DECLARE_METHOD(CLuaSpell,getSpellGroup),
    LUNAR_DECLARE_METHOD(CLuaSpell,getSpellFamily),
    LUNAR_DECLARE_METHOD(CLuaSpell,getFlag),
    LUNAR_DECLARE_METHOD(CLuaSpell,getRequirements),
    LUNAR_DECLARE_METHOD(CLuaSpell,setRequirements),
    LUNAR_DECLARE_METHOD(CLuaSpell,getAttackBonus),
    LUNAR_DECLARE_METHOD(CLuaSpell,setAttackBonus),
    LUNAR_DECLARE_METHOD(CLuaSpell,getEcosystem),
    LUNAR_DECLARE_METHOD(CLuaSpell,setEcosystem),
    LUNAR_DECLARE_METHOD(CLuaSpell,dealsDamage),
    LUNAR_DECLARE_METHOD(CLuaSpell,getTier),
    {nullptr,nullptr}
};

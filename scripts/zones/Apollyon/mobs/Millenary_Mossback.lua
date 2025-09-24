-----------------------------------
-- Area: Apollyon NW
--  Mob: Millenary Mossback
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.DEF, 4000)
    mob:addMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, -15)
    mob:setMod(tpz.mod.FIREDEF, 192)
    mob:setMod(tpz.mod.ICEDEF, 128)
    mob:setMod(tpz.mod.WINDDEF, 192)
    mob:setMod(tpz.mod.EARTHDEF, 192)
    mob:setMod(tpz.mod.THUNDERDEF, 192)
    mob:setMod(tpz.mod.WATERDEF, 192)
    mob:setMod(tpz.mod.LIGHTDEF, 192)
    mob:setMod(tpz.mod.DARKDEF, 192)

end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()
        GetNPCByID(ID.npc.APOLLYON_NW_CRATE[3][1]):setPos(mobX, mobY, mobZ)
        GetNPCByID(ID.npc.APOLLYON_NW_CRATE[3][1]):setStatus(tpz.status.NORMAL)
    end
end

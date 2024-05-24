-----------------------------------
-- Area: RoMaeve
--   NM: Shikigami Weapon
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/regimes")
require("scripts/globals/status")
-----------------------------------

local pathingTable = {
    { x = -47, y = -4, z = -37 },
    { x = -49, y = -4, z = -37 },
    { x = -54, y = -4, z = -37 },
    { x = -59, y = -4, z = -43 },
    { x = -67, y = -3.7, z = -50.6 },
    { x = -76, y = -1.4, z = -60 },
    { x = -87, y = -1, z = -69 },
    { x = -104, y = -3, z = -58 },
    { x = -118, y = -3, z = -46 },
    { x = -112, y = -3.5, z = -28 },
    { x = -98, y = -6, z = -16 },
    { x = -84, y = -6, z = -9 },
    { x = -64, y = -6, z = 1.1 },
    { x = -40, y = -6, z = 9.6 },
    { x = -20, y = -6, z = 12 },
    { x = -10, y = -6.2, z = 11 },
    { x = 31, y = -6, z = 11 },
    { x = 52, y = -6, z = 5 },
    { x = 75, y = -6, z = -4 },
    { x = 94, y = -6, z = -14 },
    { x = 110, y = -4.2, z = -25 },
    { x = 118, y = -3, z = -34 },
    { x = 109, y = -3.25, z = -55 },
    { x = 87, y = -1, z = -70 },
    { x = 68, y = -3.3, z = -53 },
    { x = 57, y = -4, z = -41 },
    { x = 28, y = -4, z = -37 },
    { x = 6, y = -4, z = -35 },
    { x = -15, y = -4, z = -36 },
    { x = -23, y = -4, z = -36 },
    { x = -35, y = -4, z = -36 },
}


function onMobInitialize(mob)
end

function onMobSpawn(mob)
    mob:setDamage(120)
    mob:setMod(tpz.mod.ATT, 522)
    mob:setMod(tpz.mod.DEF, 522)
    mob:setMod(tpz.mod.EVA, 314) 
    mob:setMod(tpz.mod.UFASTCAST, 25)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
    mob:setMod(tpz.mod.REFRESH, 50)
    mob:setMod(tpz.mod.REGEN, 10) 
	mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:addImmunity(tpz.immunity.SILENCE)
    mob:setStatus(tpz.status.INVISIBLE)
    mob:setLocalVar("path", 0)
    mob:setLocalVar("pathstep", 0)
end

function onMobRoam(mob)
    tpz.path.loop(mob, pathingTable, tpz.path.flag.RUN)
end

function onMobEngaged(mob, target)
    mob:setStatus(tpz.status.UPDATE)
end

function onMobDisengage(mob)
    mob:setStatus(tpz.status.INVISIBLE)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 119, 2, tpz.regime.type.FIELDS)
end

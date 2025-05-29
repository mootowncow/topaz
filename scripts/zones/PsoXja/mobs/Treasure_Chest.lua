-----------------------------------
-- Area: Pso'xja
--   Mob: Treasure Chest
-- It's a Mimic!
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
	mob:setMobMod(tpz.mobMod.SOUND_RANGE, 5)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 2) 
    mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:hideName(true)
    mob:untargetable(true)
end

function onMobFight(mob, target)
end

function onMobRoam(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    mob:hideName(false)
    mob:untargetable(false)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDisengage(mob)
    mob:hideName(true)
    mob:untargetable(true)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
end

-----------------------------------
-- Area: The Ashu Talif
--  Mob: Windjammer Imp
-- Instance: Targeting the Captain
-----------------------------------
mixins = {require("scripts/mixins/families/imp")}
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
	mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
end

function onMobRoam(mob)
    -- Does not move, just faces a random direction every 5 seconds
    tpz.path.faceRandomDirection(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
end
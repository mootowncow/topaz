-----------------------------------
-- Area: Monarch Linn
--  Mob: Mammet-19 Epsilon
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
mixins = { require("scripts/mixins/families/mammet") }
-----------------------------------
function onMobInitialize(mob)
    mob:setMod(tpz.mod.REFRESH, 40)
	mob:addMod(tpz.mod.MDEF, 12)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.DEFP, 20)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

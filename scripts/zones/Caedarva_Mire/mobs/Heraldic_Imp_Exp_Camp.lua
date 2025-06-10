-----------------------------------
-- Area: Caedarva Mire
--  Mob: Heraldic Imp (EXP camp by Azouph Staging Point)
-----------------------------------
require("scripts/globals/status")
mixins = {require("scripts/mixins/families/imp")}
-----------------------------------
function onMobSpawn(mob)
	mob:setMod(tpz.mod.PIERCERES, 1000)
    mob:setMod(tpz.mod.RANGEDRES, 1000)
end

function onMobDeath(mob, player, isKiller, noKiller)
end
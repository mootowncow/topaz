------------------------------
-- Area: Grauberg [S]
--   NM: Vasiliceratops
-- Lyft NM
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/wotg")
require("scripts/globals/mobs")
require("scripts/globals/status")
------------------------------
function onMobSpawn(mob)
	mob:setDamage(350) -- Hits for 400 crits for 600
    mob:addMod(tpz.mod.DEFP, 25) 
	mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
    mob:setMod(tpz.mod.REFRESH, 400)
	mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 12)
	mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
	mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
	mob:setMod(tpz.mod.BINDRESTRAIT, 100)
	mob:setMod(tpz.mod.GRAVITYRESTRAIT, 100)
	mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT1(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 505)
end

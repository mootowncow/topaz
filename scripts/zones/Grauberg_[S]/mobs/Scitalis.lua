------------------------------
-- Area: Grauberg [S]
--   NM: Scitalis
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/mobs")
------------------------------
function onMobSpawn(mob)
	mob:addMod(tpz.mod.DEFP, 25) 
	mob:addMod(tpz.mod.ATTP, 25)
	mob:addMod(tpz.mod.ACC, 25) 
	mob:addMod(tpz.mod.EVA, 25)
	mob:addMod(tpz.mod.MOVE_SPEED_STACKABLE, 20)
	mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
	mob:addMod(tpz.mod.WIND_ABSORB, 100)
	mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
	mob:setMod(tpz.mod.BINDRESTRAIT, 100)
	mob:setMod(tpz.mod.GRAVITYRESTRAIT, 100)
	mob:setMod(tpz.mod.SLOWRESTRAIT, 100)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end


function onAdditionalEffect(mob, target, damage)
	return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENAERO, {chance = 100, power = math.random(120, 150)})
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 503)
end

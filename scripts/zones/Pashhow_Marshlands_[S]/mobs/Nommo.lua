------------------------------
-- Area: Pashhow Marshlands [S]
--   NM: Nommo
-- Lyft NM
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/wotg")
mixins = { require("scripts/mixins/families/slug") }
------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
	mob:setDamage(250) -- 350-450 on DD's
    mob:addMod(tpz.mod.DEFP, 25) 
	mob:setMod(tpz.mod.EVA, 50)
	mob:setMod(tpz.mod.MOVE, 25)
	mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
	mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
	mob:setMod(tpz.mod.BINDRESTRAIT, 100)
	mob:setMod(tpz.mod.GRAVITYRESTRAIT, 100)
    mob:setLocalVar("RainRegen", 100)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.AMNESIA)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT1(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 509)
end

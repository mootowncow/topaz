------------------------------
-- Area: Caedarva Mire
--   NM: Vidhuwa the Wrathborn
-- Lyft NM
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/wotg")
------------------------------

function onMobSpawn(mob)
	mob:setDamage(120) 
    mob:addMod(tpz.mod.DEFP, 20) 
    mob:addMod(tpz.mod.ACC, 50) 
    mob:addMod(tpz.mod.MOVE_SPEED_STACKABLE, 12) 
    mob:addMod(tpz.mod.SPELLINTERRUPT, 95) 
	mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
    mob:setMod(tpz.mod.REFRESH, 400)
	mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
	mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
	mob:setMod(tpz.mod.BINDRESTRAIT, 100)
	mob:setMod(tpz.mod.GRAVITYRESTRAIT, 100)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onSpellPrecast(mob, spell)
    if spell:getID() == 214 then -- Flood
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
        spell:setRadius(10)
	end
end


function onAdditionalEffect(mob, target, damage)
	return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {chance = 100, power = 40})
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT1(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 471)
end

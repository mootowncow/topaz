-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Seiryu
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
	mob:setMod(tpz.mod.ATT, 448)
	mob:setDamage(145)
	mob:setMod(tpz.mod.DEF, 393)
	mob:setMod(tpz.mod.EVA, 390)
    mob:setMod(tpz.mod.MDEF, 12) 
    mob:setMod(tpz.mod.REGAIN, 150)
    mob:setMod(tpz.mod.REFRESH, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 20000)
end

function onMonsterMagicPrepare(mob, target)
    if not mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS, 0) then
        local rnd = math.random()
        if rnd < 0.5 then
            return 186 -- aeroga 3
        elseif rnd < 0.7 then
            return 157 -- aero 4
        elseif rnd < 0.9 then
            return 208 -- tornado
        else
            return 237 -- choke
        end
    end
    return 0 -- Still need a return, so use 0 when not casting
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENAERO, {chance = 100, power = math.random(30, 50)})
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:showText(mob, ID.text.SKY_GOD_OFFSET + 10)
end

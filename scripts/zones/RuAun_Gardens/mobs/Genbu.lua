-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Genbu
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
	mob:setDamage(120)
	mob:setMod(tpz.mod.ATTP, 10)
	mob:setMod(tpz.mod.DEF, 640)
	mob:setMod(tpz.mod.EVA, 337)
    mob:setMod(tpz.mod.MDEF, 12) 
	mob:setMod(tpz.mod.VIT, 188)
	mob:setMod(tpz.mod.COUNTER, 10)
	mob:setMod(tpz.mod.MOVE, -15)
    mob:setMod(tpz.mod.REFRESH, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 20000)
end

function onMobFight(mob, target)
local HP = mob:getHPP()
local BaseAttack = 348
local Attack = ((HP - 100 ) * -10) + BaseAttack
	mob:setMod(tpz.mod.ATT, Attack)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENWATER, {chance = 100, power = math.random(150, 250)})
end

function onMonsterMagicPrepare(mob, target)
    local rnd = math.random()
    if (rnd < 0.5) then
        return 201 -- Waterga 3
    elseif (rnd < 0.7) then
        return 172 -- Water 4
    elseif (rnd < 0.9) then
        return 214 -- Flood
    else
        return 240 -- Drown
    end
    return 0 -- Still need a return, so use 0 when not casting
end

function onMobDeath(mob, player, isKiller, noKiller)
end
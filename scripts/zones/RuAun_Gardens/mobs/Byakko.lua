-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Byakko
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
-----------------------------------


function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
	mob:setMod(tpz.mod.ATT, 440)
	mob:setDamage(145)
	mob:setMod(tpz.mod.DEF, 415)
	mob:setMod(tpz.mod.VIT, 50)
    mob:setMod(tpz.mod.MDEF, 12)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 40)
    mob:setMod(tpz.mod.REFRESH, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 20000)
end


function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENLIGHT, {chance = 100, power = math.random(30, 50)})
end

function onMonsterMagicPrepare(mob, target)
    local rnd = math.random()
    if (rnd < 0.5) then
        return 40 -- Banishga 3
    elseif (rnd < 0.7) then
        return 31 -- Banish 4
    elseif (rnd < 0.9) then
        return 35 -- Diaga III
    else
        return 21 -- Holy
    end
    return 0 -- Still need a return, so use 0 when not casting
end

function onMobDeath(mob, player, isKiller, noKiller)
end
-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Seiryu (Pet version)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.MAGIC_DELAY, 30)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
	mob:setMod(tpz.mod.REGAIN, 50)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENAERO)
end

function onMobFight(mob, target)
    if mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) == false then
        mob:SetMobAbilityEnabled(true);
    else
        mob:SetMobAbilityEnabled(false);
    end
end

function onMonsterMagicPrepare(mob, target)
    if mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) == false then
        local rnd = math.random()
        if (rnd < 0.5) then
            return 186 -- aeroga 3
        elseif (rnd < 0.7) then
            return 157 -- aero 4
        elseif (rnd < 0.9) then
            return 208 -- tornado
        else
            return 237 -- choke
        end
    end
    return 0 -- Still need a return, so use 0 when not casting
end

function onMobDespawn(mob)
end


function onMobDeath(mob, player, isKiller, noKiller)
end
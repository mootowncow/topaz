-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Olla Grande
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/settings")
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:addMod(tpz.mod.MATT, 25)
end

function onMonsterMagicPrepare(mob, target)
	rnd = math.random()

    if (rnd < 0.5) then
        return 40 -- banishga III
    elseif (rnd < 0.7) then
        return 30 -- Banish III
    elseif (rnd < 0.8) then
        return 53 -- Blink
    elseif (rnd < 0.9) then
        return 54 -- Stoneskin
    else
        return 112 -- flash
    end
    return 0 -- Still need a return, so use 0 when not casting
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.DISPEL, {chance = 25})
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    GetNPCByID(ID.npc.OLLAS_QM):updateNPCHideTime(FORCE_SPAWN_QM_RESET_TIME)
end

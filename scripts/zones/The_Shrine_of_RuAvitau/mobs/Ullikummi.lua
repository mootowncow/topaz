-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Ullikummi
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/settings")

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
end

function onMobFight(mob, target)
	mob:setMod(tpz.mod.REGAIN, 250)
end

function onMonsterMagicPrepare(mob, target)
	rnd = math.random()

    if (rnd < 0.5) then
        return 40 -- banishga III
    elseif (rnd < 0.7) then
        return 34 -- diaga II
    else
        return 112 -- flash
    end
    return 0 -- Still need a return, so use 0 when not casting
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
end

-----------------------------------
-- Area: Cape Teriggan
--   NM: Kreutzet
-----------------------------------
require("scripts/globals/world")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
end

function onMobRoam(mob)
    if not (mob:getWeather() == tpz.weather.WIND or mob:getWeather() == tpz.weather.GALES) then
        DespawnMob(mob:getID())
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 926 then
        local stormwindCounter = mob:getLocalVar("stormwindCounter")

        stormwindCounter = stormwindCounter +1
        mob:setLocalVar("stormwindCounter", stormwindCounter)
        mob:setLocalVar("stormwindDamage", stormwindCounter) -- extra var for dmg calculation (in stormwind.lua)

        if stormwindCounter > 2 then
            mob:setLocalVar("stormwindCounter", 0)
        else
            mob:useMobAbility(926)
        end
    end
end

function onMobDisengage(mob, weather)
    if not (mob:getWeather() == tpz.weather.WIND or mob:getWeather() == tpz.weather.GALES) then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    -- Set Kruetzet's spawnpoint and respawn time (9-12 hours)
    UpdateNMSpawnPoint(mob:getID())
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no wind weather and immediate despawn
end

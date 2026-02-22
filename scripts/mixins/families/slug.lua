-- slug family mixin

require("scripts/globals/mixins")
require("scripts/globals/utils")
require("scripts/globals/mobs")
require("scripts/globals/status")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- set default 12/tick regen
-- this can be overridden in onMobSpawn

g_mixins.families.slug = function(mob)
    mob:addListener("SPAWN", "SLUG_SPAWN", function(mob)
        mob:setLocalVar("RainRegen", 12)
    end)

    mob:addListener("ROAM_TICK", "SLUG_ROAM", function(mob)
        CheckRain(mob)
    end)

    mob:addListener("COMBAT_TICK", "SLUG_COMBAT", function(mob)
        CheckRain(mob)
    end)
end

function CheckRain(mob)
    if mob:getWeather() == tpz.weather.RAIN or mob:getWeather() == tpz.weather.SQUALL then
        utils.AddDynamicMod(mob, tpz.mod.REGEN, mob:getLocalVar("RainRegen"))
    else
        utils.DelDynamicMod(mob, tpz.mod.REGEN)
    end
end

return g_mixins.families.slug

require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.orobon = function(mob)

    -- set default 1% chance to break horn on critical hit taken
    -- this can be overridden in onMobSpawn

    mob:addListener("SPAWN", "OROBON_SPAWN", function(mob)
        mob:setLocalVar("FeelersBreakChance", 1)
    end)

    -- 1% chance to break horn on critical hit
    mob:addListener("FRONTAL_CRITICAL_TAKE", "OROBON_FRONT_CRITICAL_TAKE", function(mob)
        if math.random(100) <= mob:getLocalVar("FeelersBreakChance") and mob:AnimationSub() ==  0 and not IsMobBusy(mob) then
            mob:AnimationSub(1)
        end
    end)

end

return g_mixins.families.orobon

require("scripts/globals/mixins")
require("scripts/globals/utils")

g_mixins = g_mixins or {}

g_mixins.targeting_the_captain = function(mob)
    mob:addListener("AGGRO_TARGET", "KABSALAH_AGGRO", function(mob, target)
        local instance = mob:getInstance()
        instance:setLocalVar("detected", 1)
    end)
end


return g_mixins.targeting_the_captain

-- Worm family mixin

require("scripts/globals/mixins")
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.worm = function(mob)
    mob:addListener("COMBAT_TICK", "WORM_CTICK", function(mob)
        local targ = mob:getTarget()
        if targ then
            if mob:checkDistance(targ) < 4 then
               mob:SetMagicCastingEnabled(false)
            else 
                mob:SetMagicCastingEnabled(true)                        
            end
         end 
    end)
end 

return g_mixins.families.worm
 
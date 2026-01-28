-- Zdei family mixin
-- Change to a new mode if time has expired and not currently charging optic induration
-- Swaps between no rings/bars on spawn -> rings/bars. Then goes back to no rings/bars momentarily before going back to a ring/bar mode
-- First swap to Ring/Bar mode on engage is after 10-20 seconds 
-- Stays in no ring/bar mode for 10-20s
-- Stays in ring/bar modes for 50-60s
require("scripts/globals/magic")
require("scripts/globals/mixins")
require("scripts/globals/utils")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.zdei = function(mob)
    mob:addListener("SPAWN", "ZDEI_SPAWN", function(mob)
        mob:AnimationSub(0)
    end)

    mob:addListener("ENGAGE", "ZDEI_ENGAGE", function(mob, target)
        mob:AnimationSub(1)
        mob:setLocalVar("changeTime", os.time() + math.random(10, 20))
    end)

    mob:addListener("DISENGAGE", "ZDEI_DISENGAGE", function(mob)
        mob:AnimationSub(0)
        mob:setLocalVar("changeTime", 0)
    end)

    mob:addListener("COMBAT_TICK", "ZDEI_CTICK", function(mob)
        local changeTime = mob:getLocalVar("changeTime")
        local now = os.time()
        if not IsMobBusy(mob) then
            if now >= changeTime and mob:getCurrentAction() == tpz.act.ATTACK and mob:getLocalVar("charge_count") == 0 then
                if mob:AnimationSub() <= 1 then
                    mob:AnimationSub(math.random(2, 3))
                    mob:setLocalVar("changeTime", now + math.random(50, 60))
                else
                    mob:AnimationSub(1)
                    mob:setLocalVar("changeTime", now + math.random(10, 20))
                end
            end
        end
    end)
end

return g_mixins.families.zdei

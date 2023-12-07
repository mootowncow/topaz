-- Zdei family mixin

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
        mob:setLocalVar("changeTime", os.time() + 60)
    end)

    mob:addListener("DISENGAGE", "ZDEI_DISENGAGE", function(mob)
        mob:AnimationSub(0)
        mob:setLocalVar("changeTime", 0)
    end)

    mob:addListener("COMBAT_TICK", "ZDEI_CTICK", function(mob)
        local changeTime = mob:getLocalVar("changeTime")
        local now = os.time()

        -- Change to a new mode if time has expired and not currently charging optic induration
        if not IsMobBusy(mob) then
            if now >= changeTime and mob:getCurrentAction() == tpz.act.ATTACK and mob:getLocalVar("charge_count") == 0 then
                if mob:AnimationSub() <= 1 then
                    mob:AnimationSub(math.random(2, 3))
                    mob:setLocalVar("changeTime", now + 60)
                else
                    mob:AnimationSub(1)
                    mob:setLocalVar("changeTime", now + 60)
                end
            end
        end
    end)
end

return g_mixins.families.zdei

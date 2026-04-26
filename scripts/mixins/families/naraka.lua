require("scripts/globals/mixins")
require("scripts/globals/magic")
require("scripts/globals/mobs")
require("scripts/globals/utils")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.naraka = function(mob)

    -- Pick a random stance on spawn (PDT or MDT)
    mob:addListener("ENGAGE", "NARAKA_ENGAGE", function(mob)
        mob:setLocalVar("Stance", math.random(2))
    end)

    mob:addListener("COMBAT_TICK", "NARAKA_CTICK", function(mob, target)
        if mob:getLocalVar("Stance") == tpz.mob.animationSubs['Naraka'].PDT then
            utils.DelDynamicMod(mob, tpz.mod.UDMGMAGIC)
            utils.DelDynamicMod(mob, tpz.mod.UDMGBREATH)
            utils.AddDynamicMod(mob, tpz.mod.UDMGPHYS, -50)
            utils.AddDynamicMod(mob, tpz.mod.UDMGRANGE, -50)
        elseif mob:getLocalVar("Stance") == tpz.mob.animationSubs['Naraka'].MDT then
            utils.DelDynamicMod(mob, tpz.mod.UDMGPHYS)
            utils.DelDynamicMod(mob, tpz.mod.UDMGRANGE)
            utils.AddDynamicMod(mob, tpz.mod.UDMGMAGIC, -50)
            utils.AddDynamicMod(mob, tpz.mod.UDMGBREATH, -50)
        end
    end)

    mob:addListener("DISENGAGE", "NARAKA_DISENGAGE", function(mob)
    end)

end

return g_mixins.families.naraka

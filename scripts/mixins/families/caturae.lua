require("scripts/globals/mixins")
require("scripts/globals/magic")
require("scripts/globals/mobs")
require("scripts/globals/utils")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.caturae = function(mob)

    -- Pick a random stance on spawn (PDT or MDT)
    mob:addListener("ENGAGE", "CATURAE_ENGAGE", function(mob)
    end)

    mob:addListener("COMBAT_TICK", "CATURAE_CTICK", function(mob)
        if mob:getMod(tpz.mod.MAGIC_SS) > 0 then
            utils.AddDynamicMod(mob, tpz.mod.MATT, 50)
        elseif mob:getLocalVar("Stance" == tpz.mob.NarakaStance.MDT) then
            utils.DelDynamicMod(mob, tpz.mod.MATT)
        end
    end)

    mob:addListener("DISENGAGE", "CATURAE_DISENGAGE", function(mob)
    end)
end

return g_mixins.families.caturae

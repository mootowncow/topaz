require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.poroggo = function(mob)

    -- Safety checks so it won't get perma locked into Providence spells
    mob:addListener("ENGAGE", "POROGGO_ENGAGE", function(mob, target)
        mob:setLocalVar("Providence", 0)
    end)

    mob:addListener("DISENGAGE", "POROGGO_DISENGAGE", function(mob)
        mob:setLocalVar("Providence", 0)
    end)

    mob:addListener("TICK", "POROGGO_TICK", function(mob)
        local Providence = mob:getLocalVar("Providence")
        if Providence > 0 then
        	mob:setMobMod(tpz.mobMod.MAGIC_COOL, 0)
            mob:setSpellList(2043)
        else
        	mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
            mob:setSpellList(2)
        end
    end)

    mob:addListener("MAGIC_STATE_EXIT", "POROGGO_MAGIC_STATE_EXIT", function(mob, spell)
        mob:setLocalVar("Providence", 0)
    end)

end

return g_mixins.families.poroggo

require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- AnimationSub for Ruszor
-- 0 = Nothing
-- 1 = Icy Mist (Ice Absorb)
-- 2 = Bubbles (Water Absorb)

g_mixins.families.ruszor = function(mob)
    
	mob:addListener("SPAWN", "RUSZOR_SPAWN", function(mob)
        mob:AnimationSub(0)
    end)

	mob:addListener("TICK", "RUSZOR_TICK", function(mob)
        local animationSub = mob:AnimationSub()
        local waterAbsorbTimer = mob:getLocalVar("ruszorWaterAbsorbTimer")
        -- Go back to animation sub 0 when buff timer ends for buffs
        if (mob:getMod(tpz.mod.MAGIC_SS) == 0 and mob:getMod(tpz.mod.PHYSICAL_SS) == 0 and os.time() > waterAbsorbTimer) and not IsMobBusy(mob) then
            mob:AnimationSub(0)
        end

        -- Change animation sub depending on which type of stoneskin is currently applied
        if (mob:getMod(tpz.mod.PHYSICAL_SS) > 0) and not IsMobBusy(mob) then
            mob:AnimationSub(1)
        end

        if (mob:getMod(tpz.mod.MAGIC_SS) > 0 or os.time() < waterAbsorbTimer) and not IsMobBusy(mob) then
            mob:AnimationSub(2)
        end

        -- Gain's Ice Or Water absorb depending on current buff from using Frozen Mist / Hydro Wave / Aqua Blast
        if (animationSub == 1) then
            mob:setMod(tpz.mod.ICE_ABSORB, 100)
            mob:setMod(tpz.mod.WATER_ABSORB, 0)
        elseif (animationSub == 2 or os.time() < waterAbsorbTimer) then
            mob:setMod(tpz.mod.WATER_ABSORB, 100)
            mob:setMod(tpz.mod.ICE_ABSORB, 0)
        else
            mob:setMod(tpz.mod.ICE_ABSORB, 0)
            mob:setMod(tpz.mod.WATER_ABSORB, 0)
        end
    end)

end

return g_mixins.families.ruszor

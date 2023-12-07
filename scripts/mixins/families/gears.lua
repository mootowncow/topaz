require("scripts/globals/mixins")
require("scripts/globals/status")


g_mixins = g_mixins or {}

g_mixins.gears = function(mob)

    mob:addListener("SPAWN", "WEAPON_BREAK", function(mob)
        mob:setLocalVar("BreakChance", 5)
		if mob:isNM() then
			mob:setLocalVar("BreakChance", 1)
		end
    end)

    mob:addListener("CRITICAL_TAKE", "GEAR_CRITICAL_TAKE", function(mob)
        local GearNumber = mob:getLocalVar("GearNumber")
        -- Can lose a gear from crits after restoring a gear only
        if GearNumber > 0 then
            if math.random(100) <= mob:getLocalVar("BreakChance") and not IsMobBusy(mob) then
                local animationSub = mob:AnimationSub()

                -- Lose a gear
                if animationSub == 0 then
                    mob:AnimationSub(1)
                    mob:setLocalVar("GearNumber", 2)
                end
                -- Lose a gear
                if animationSub == 1 then
                    mob:AnimationSub(2)
                    mob:setLocalVar("GearNumber", 1)
                end
            end
        end
    end)

    mob:addListener("COMBAT_TICK", "GEARS_CTICK", function(mob)
    -- Restoral gear variable
        local GearNumber = mob:getLocalVar("GearNumber")
        if GearNumber == 2 then
            if mob:AnimationSub() == 2 then -- Single Gear
                mob:setMod(tpz.mod.MDEF, -10)
                mob:setMod(tpz.mod.DEFP, -20)
                mob:AnimationSub(1) -- double gear
            end
        elseif GearNumber == 3 then 
            if mob:AnimationSub() == 1 then -- Two Gears
                mob:setMod(tpz.mod.MDEF, 0)
                mob:setMod(tpz.mod.DEFP, 0)
                mob:AnimationSub(0) -- triple gear
            end
        end
        if mob:AnimationSub() == 0 then -- 3 gears
            mob:setMobMod(tpz.mobMod.SKILL_LIST, 150)
        elseif mob:AnimationSub() == 1 then -- 2 gears
            mob:setMobMod(tpz.mobMod.SKILL_LIST, 151)
        elseif mob:AnimationSub() == 2 then -- 1 gears
            mob:setMobMod(tpz.mobMod.SKILL_LIST, 152)
        end
        -- Lose a gear below HP threshold
        local mobHPP = mob:getHPP()
        if mob:getPool() ~= 243 then -- Armed Gears has their own logic in their lua file
            if (mobHPP >= 33 and mobHPP <= 65) then
                if mob:AnimationSub() ~= 1 then
                    mob:setMod(tpz.mod.MDEF, -10)
                    mob:setMod(tpz.mod.DEFP, -20)
                    mob:AnimationSub(1) -- double gear
                    mob:setMobMod(tpz.mobMod.SKILL_LIST, 151)
                end
            elseif mobHPP <= 32 then
                if mob:AnimationSub() ~= 2 then
                    mob:setMod(tpz.mod.MDEF, -20)
                    mob:setMod(tpz.mod.DEFP, -40)
                    mob:AnimationSub(2) -- single gear
                    mob:setMobMod(tpz.mobMod.SKILL_LIST, 152)
                end
            elseif mobHPP > 50 then
                if mob:AnimationSub() ~= 0 then
                    mob:setMod(tpz.mod.MDEF, 0)
                    mob:setMod(tpz.mod.DEFP, 0)
                    mob:AnimationSub(0) -- triple gear
                    mob:setMobMod(tpz.mobMod.SKILL_LIST, 150)
                end
            end
        end

    end)

end

return g_mixins.gears

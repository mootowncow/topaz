require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- AnimationSub for Qutrub
-- 0 = main weapon out, sub weapon sheathed
-- 1 = main weapon broken, sub weapon sheathed
-- 2 = main weapon broken, sub weapon out
-- 3 = both weapons broken

g_mixins.families.qutrub = function(mob)

    -- set default 10% chance to break weapon on critical hit taken
    -- this can be overridden in onMobSpawn

    mob:addListener("SPAWN", "QUTRUB_SPAWN", function(mob)
        mob:setLocalVar("qutrubBreakChance", 10)
    end)

    -- when a qutrub's weapon has been broken it will switch between using its second

    mob:addListener("COMBAT_TICK", "QUTRUB_COMBAT_TICK", function(mob)
        local swapTime = mob:getLocalVar("swapTime")

        if swapTime > 0 and os.time() > swapTime then
            local animationSub = mob:AnimationSub()

            if animationSub == 1 and not IsMobBusy(mob) then
                mob:AnimationSub(2)
                mob:setLocalVar("swapTime", os.time() + 60)

            elseif animationSub == 2 and not IsMobBusy(mob) then
                mob:AnimationSub(1)
                mob:setLocalVar("swapTime", os.time() + 60)
            end
        end
    end)

    -- chance to break weapon when taking a critical hit

    mob:addListener("CRITICAL_TAKE", "QUTRUB_CRITICAL_TAKE", function(mob)
        if math.random(100) <= mob:getLocalVar("qutrubBreakChance") then
            local animationSub = mob:AnimationSub()

            -- break first weapon
            if animationSub == 0 and not IsMobBusy(mob) then
                mob:AnimationSub(1)
                mob:setLocalVar("swapTime", os.time() + 60)

            -- break second weapon
            elseif animationSub == 2 and not IsMobBusy(mob) then
                mob:AnimationSub(3)
                mob:setLocalVar("swapTime", 0)
            end
        end

    end)
	
	-- chance to break when hit by an offensive JA(like box step)
	mob:addListener("ABILITY_TAKE", "BREAK_CRITICAL_TAKE", function(mob, user, ability, action)
        local abilityID = ability:getID()
        if abilityID == 150      -- tomahawk
        or abilityID == 46       -- shield bash
        or abilityID == 77       -- weapon bash
        or abilityID == 66       -- jump
        or abilityID == 67       -- high jump
        or abilityID == 68       -- super jump
        or abilityID == 201      -- quick step
        or abilityID == 202      -- box step
        or abilityID == 203      -- stutter step
        or abilityID == 205      -- desperate flourish
        or abilityID == 207      -- violent flourish
        or abilityID == 168      -- blade bash
        or abilityID == 170 then -- angon
			if math.random(100) <= 5 then
				local animationSub = mob:AnimationSub()

				-- break first weapon
				if animationSub == 0 and not IsMobBusy(mob) then
					mob:AnimationSub(1)
					mob:setLocalVar("swapTime", os.time() + 60)

				-- break second weapon
				elseif animationSub == 2 and not IsMobBusy(mob) then
					mob:AnimationSub(3)
					mob:setLocalVar("swapTime", 0)
				end
			end
        end
	end)

end

return g_mixins.families.qutrub

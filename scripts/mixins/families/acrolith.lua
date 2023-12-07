require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.acrolith = function(mob)

    -- set default 1% chance to break parts on critical hit taken
    -- this can be overridden in onMobSpawn

    mob:addListener("SPAWN", "ACROLITH_SPAWN", function(mob)
        mob:setLocalVar("PartBreakChance", 1)
    end)

    mob:addListener("CRITICAL_TAKE", "ACROLITH_CRITICAL_TAKE", function(mob)
        local AnimationSub = mob:AnimationSub()
        if math.random(100) <= mob:getLocalVar("PartBreakChance") and AnimationSub == 0 and mob:actionQueueEmpty() then
            mob:useMobAbility(2074) -- Detonating Grip
        end
        if math.random(100) <= mob:getLocalVar("PartBreakChance") and AnimationSub == 1 and mob:actionQueueEmpty() then
            mob:useMobAbility(2074) -- Detonating Grip
        end
    end)

	mob:addListener("WEAPONSKILL_TAKE", "ACROLITH_WS_TAKE", function(target, user, wsid)
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
            local AnimationSub = mob:AnimationSub()
			if math.random(100) <= mob:getLocalVar("PartBreakChance") and AnimationSub == 0 and not IsMobBusy(mob) then
                mob:useMobAbility(2074) -- Detonating Grip
			end
        if math.random(100) <= mob:getLocalVar("PartBreakChance") and AnimationSub == 1 and not IsMobBusy(mob) then
                mob:useMobAbility(2074) -- Detonating Grip
			end
		end
	end)

end

return g_mixins.families.acrolith

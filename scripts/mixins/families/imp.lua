require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.imp = function(mob)

    -- set default 10% chance to break horn on critical hit taken
    -- this can be overridden in onMobSpawn

    mob:addListener("SPAWN", "IMP_SPAWN", function(mob)
        mob:setLocalVar("HornBreakChance", 5)
    end)

    mob:addListener("COMBAT_TICK", "IMP_COMBAT_TICK", function(mob)
        local ReobtainHornTime = mob:getLocalVar("ReobtainHornTime")

        if ReobtainHornTime > 0 and os.time() > ReobtainHornTime then
            local AnimationSub = mob:AnimationSub()

            if AnimationSub == 1 and not IsMobBusy(mob) then
                mob:AnimationSub(0)
                mob:setLocalVar("ReobtainHornTime", os.time() + 60)
            end
        end
    end)

    -- 10% chance to break horn on critical hit
    mob:addListener("CRITICAL_TAKE", "IMP_CRITICAL_TAKE", function(mob)
        if math.random(100) <= mob:getLocalVar("HornBreakChance") and mob:AnimationSub() == 0 and not IsMobBusy(mob) then
            mob:AnimationSub(1)
            mob:setLocalVar("ReobtainHornTime", os.time() + 60)
        end
    end)
	
	-- chance to break when hit by an offensive JA(like box step)
	mob:addListener("ABILITY_TAKE", "IMP_ABILITY_TAKE", function(mob, user, ability, action)
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
			if math.random(100) <= mob:getLocalVar("HornBreakChance") and mob:AnimationSub() == 0 and not IsMobBusy(mob) then
				mob:AnimationSub(1)
                mob:setLocalVar("ReobtainHornTime", os.time() + 60)
			end
		end
	end)

    mob:addListener("DEATH", "IMP_DEATH", function(mob, killer)
        if (mob:AnimationSub() >= 1) then
            if killer and (math.random(1,100) <= 5) then 
                killer:addTreasure(2157, mob) --Imp Horn
            end
        end
    end)

end

return g_mixins.families.imp

require("scripts/globals/mixins")
require("scripts/globals/status")


g_mixins = g_mixins or {}

-- AnimationSub for Peiste
-- 0 = Nothing
-- 1 = Yellow Eyes(Grim Glower)
-- 2 = Blue Eyes(Opporessive Glare)

g_mixins.peiste = function(mob)

    mob:addListener("COMBAT_TICK", "PEISTE_CTICK", function(mob)
		local swapTimeGlower = mob:getLocalVar("swapTimeGlower")
		local swapTimeGlare = mob:getLocalVar("swapTimeGlare")
		local animationSub = mob:AnimationSub()
		local target = mob:getTarget()
		if mob:hasStatusEffect(tpz.effect.BLINDNESS) then -- Inflicting Blind on a peiste will neutralize the effect of Grim Glower / Oppressive Glare
			mob:AnimationSub(0)
		end
		if swapTimeGlower > 0 and os.time() > swapTimeGlower or swapTimeGlare > 0 and os.time() > swapTimeGlare  then -- Remove gaze eyes after 1m duration
			mob:AnimationSub(0)
		end
        if target:hasStatusEffect(tpz.effect.FEALTY) then -- Fealty blocks all status effects
		    return
	    end
		if animationSub == 1 then
			if (target:isFacing(mob)) then
				if target:hasStatusEffect(tpz.effect.BLINDNESS) then --Can't gaze debuff them if they can't see!
					return
				end
                if not target:hasStatusEffect(tpz.effect.PETRIFICATION) then
				    target:addStatusEffect(tpz.effect.PETRIFICATION, 1, 0, 5)
                end
			end
		end
		if animationSub == 2 then
			if (target:isFacing(mob)) then
				if target:hasStatusEffect(tpz.effect.BLINDNESS) then --Can't gaze debuff them if they can't see!
					return
				end
                if not target:hasStatusEffect(tpz.effect.TERROR) then
				    target:addStatusEffect(tpz.effect.TERROR, 1, 0, 5)
                end
                if not target:hasStatusEffect(tpz.effect.CURSE_II) then
				    target:addStatusEffect(tpz.effect.CURSE_II, 1, 0, 5) --Zombie
                end
			end
		end
    end)

end

return g_mixins.peiste

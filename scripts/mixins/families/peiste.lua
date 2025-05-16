require("scripts/globals/mixins")
require("scripts/globals/status")


g_mixins = g_mixins or {}

-- AnimationSub for Peiste
-- 0 = Nothing
-- 1 = Yellow Eyes(Grim Glower)
-- 2 = Blue Eyes(Oppressive Glare)

g_mixins.families.peiste = function(mob)

    mob:addListener("COMBAT_TICK", "PEISTE_CTICK", function(mob)
		local swapTimeGlower = mob:getLocalVar("swapTimeGlower")
		local swapTimeGlare = mob:getLocalVar("swapTimeGlare")
		local animationSub = mob:AnimationSub()
		local target = mob:getTarget()

		if mob:hasStatusEffect(tpz.effect.BLINDNESS) then -- Inflicting Blind on a peiste will neutralize the effect of Grim Glower / Oppressive Glare
			mob:AnimationSub(0)
		end

        -- Petrification Gaze Yellow Eyes(Grim Glower)
		if (animationSub == 1) then

            -- Remove gaze eyes after 1m duration
            if swapTimeGlower > 0 and os.time() > swapTimeGlower then
                mob:AnimationSub(0)
            end


            local gazeTick = mob:getLocalVar("gazeTick")
            if (os.time() >= gazeTick) then
                local nearbyEnemies = mob:getNearbyEntities(15)
                if (nearbyEnemies ~= nil) then 
                    for _,v in pairs(nearbyEnemies) do
                        if
                            mob:isFacing(v) and
                            v:isFacing(mob) and
                            not v:isNPC() and
                            not v:hasStatusEffect(tpz.effect.FEALTY) and
                            not v:hasStatusEffect(tpz.effect.BLINDNESS) and
                            (v:getID() ~= mob:getID())
                        then
                            v:delStatusEffectSilent(tpz.effect.PETRIFICATION)
                            v:addStatusEffect(tpz.effect.PETRIFICATION, 1, 0, 3)
                        end
                    end
		        end
                mob:setLocalVar("gazeTick", os.time() +3)
            end
        end

        -- Terror / Zombie gaze Blue Eyes(Oppressive Glare)
		if (animationSub == 2) then

            -- Remove gaze eyes after 1m duration
            if swapTimeGlare > 0 and os.time() > swapTimeGlare then
                mob:AnimationSub(0)
            end

            local gazeTick = mob:getLocalVar("gazeTick")
            if (os.time() >= gazeTick) then
                local nearbyEnemies = mob:getNearbyEntities(15)
                if (nearbyEnemies ~= nil) then 
                    for _,v in pairs(nearbyEnemies) do
                        if
                            mob:isFacing(v) and
                            v:isFacing(mob) and
                            not v:isNPC() and
                            not v:hasStatusEffect(tpz.effect.FEALTY) and
                            not v:hasStatusEffect(tpz.effect.BLINDNESS) and
                            (v:getID() ~= mob:getID())
                        then
                            v:delStatusEffectSilent(tpz.effect.TERROR)
                            v:addStatusEffect(tpz.effect.TERROR, 1, 0, 3)
                            v:delStatusEffectSilent(tpz.effect.CURSE_II)
                            v:addStatusEffect(tpz.effect.CURSE_II, 1, 0, 3)
                        end
                    end
		        end
                mob:setLocalVar("gazeTick", os.time() +3)
            end
        end
    end)
end

return g_mixins.families.peiste

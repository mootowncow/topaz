-- Gnole family mixin
-- animsub 1= standing, animsub 0 = all fours

require("scripts/globals/mixins")
require("scripts/globals/utils")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.gnole = function(mob)
    mob:addListener("SPAWN", "GNOLE_SPAWN", function(mob)
        local moon = utils.getMoonPhase()
        local moonphase = 0
        if (moon == 'Full') then
            mob:setMod(tpz.mod.MARTIAL_ARTS, 280)
            mob:addMod(tpz.mod.EVA, 60)
        elseif (moon == 'Gibbeus') then
            mob:setMod(tpz.mod.MARTIAL_ARTS, 200)
            mob:addMod(tpz.mod.EVA, 30)
        elseif (moon == 'Quarter') then
             mob:setMod(tpz.mod.MARTIAL_ARTS, 150)
        elseif (moon == 'Cresecent') then
            mob:setMod(tpz.mod.MARTIAL_ARTS, 70)
            mob:addMod(tpz.mod.EVA, -30)
        elseif (moon == 'New') then
            mob:setMod(tpz.mod.MARTIAL_ARTS, 20)
            mob:addMod(tpz.mod.EVA, -60)
        end
        mob:AnimationSub(math.random(0, 1))
    end)

    mob:addListener("ROAM_TICK", "GNOLE_ROAM", function(mob)
        local currentHour = VanadielHour()
	    if currentHour >= 18 and currentHour < 6 then
		    mob:setMod(tpz.mod.REGEN, 30)
	    else
		    mob:setMod(tpz.mod.REGEN, 0)
	    end
        attemptTransform(mob, 300)
    end)

    mob:addListener("ENGAGE", "GNOLE_ENGAGE", function(mob, target)
        mob:setLocalVar("transformTime", os.time() + 60)
    end)

    mob:addListener("COMBAT_TICK", "GNOLE_COMBAT", function(mob)
        attemptTransform(mob, 60)
    end)
end

function attemptTransform(mob, timer)
    local transformTime = mob:getLocalVar("transformTime")
    local currentTime = os.time()
    if currentTime >= transformTime and not IsMobBusy(mob) then
        local animSub = mob:AnimationSub()
        animSub = (animSub + 1) % 2
        mob:AnimationSub(animSub)
        mob:setLocalVar("transformTime", currentTime + timer)
    end
end

return g_mixins.families.gnole

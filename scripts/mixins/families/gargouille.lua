require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- AnimationSub for Gargouilles
-- 0 = grounded
-- 1 = flying
-- 2 = "Statue" stance

g_mixins.families.gargouille = function(mob)

    mob:addListener("SPAWN", "GARGOUILLES_SPAWN", function(mob)
        mob:setLocalVar("swapTime", os.time())
    end)

    mob:addListener("TICK", "GARGOUILLES_TICK", function(mob)
        local swapTime = mob:getLocalVar("swapTime")
        local animationSub = mob:AnimationSub()

        -- Gains 60 Evasion while flying
        if animationSub == 0 or animationSub == 4 then
            DelEvasionBonus(mob)
        elseif animationSub == 1 then
            AddEvasionBonus(mob)
        end

        if swapTime > 0 and os.time() > swapTime and not IsMobBusy(mob) then

            if animationSub == 0 or animationSub == 4 then
                mob:AnimationSub(1)
                mob:setLocalVar("swapTime", os.time() + math.random(45, 60))
            elseif animationSub == 1 then
                mob:AnimationSub(0)
                mob:setLocalVar("swapTime", os.time() + math.random(45, 60))
            end
        end
    end)

end

function AddEvasionBonus(mob)
    if mob:getLocalVar("evaMod") == 0 then
        mob:addMod(tpz.mod.EVA, 60)
        mob:setLocalVar("evaMod", 1)
    end
end

function DelEvasionBonus(mob)
    if mob:getLocalVar("evaMod") == 1 then
        mob:delMod(tpz.mod.EVA, 60)
        mob:setLocalVar("evaMod", 0)
    end
end

return g_mixins.families.gargouille

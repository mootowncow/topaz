-----------------------------------
--
-- tpz.effect.ADDLE
--
-----------------------------------

function onEffectGain(target, effect)
    local subpower = effect:getSubPower()
    if (subpower == nil or subpower == 0) then
        subpower = effect:getPower()
    end

    target:addMod(tpz.mod.FASTCAST, -effect:getPower()) -- Yes we are subtracting in addMod()
    target:addMod(tpz.mod.MACC, -subpower) -- This is intentional
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local subpower = effect:getSubPower()
    if (subpower == nil or subpower == 0) then
        subpower = effect:getPower()
    end

    target:delMod(tpz.mod.FASTCAST, -effect:getPower())
    target:delMod(tpz.mod.MACC, -subpower)
end

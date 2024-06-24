-----------------------------------
--
--tpz.effect.GRADUAL_PETRIFICATION
--
-----------------------------------

function onEffectGain(target, effect)
    -- Store targets attack and movement speed to reapply later
    target:setLocalVar("attackSpeed", target:getMod(tpz.mod.HASTE_MAGIC))
    target:setLocalVar("movementSpeed", target:getMod(tpz.mod.MOVE_SPEED_STACKABLE))
    -- minimum time is 10 seconds!
    if (effect:getPower() < 10) then
        effect:setPower(10)
    end
end

function onEffectTick(target, effect)
    local remainingTicks = 1 + (effect:getTimeRemaining() / 1000) / 3
    -- the effect restore accuracy of 1 every 3 ticks.
    local speedDecrease = effect:getPower()
    if (speedDecrease > 0) then
        effect:setPower(speedDecrease - 1)
        target:addMod(tpz.mod.HASTE_MAGIC, -1000)
        target:addMod(tpz.mod.MOVE_SPEED_STACKABLE, -5)
    end
    -- Petrification countdown message
    target:messagePublic(530, target, remainingTicks, remainingTicks)
end

function onEffectLose(target, effect)
    if (effect:getTimeRemaining() == 0) then
        -- Set attack and movement speed back to what it was before applying this effect, then petrify
        target:addStatusEffect(tpz.effect.PETRIFICATION, 1, 0, 120)
    end
    target:setMod(tpz.mod.HASTE_MAGIC, target:getLocalVar("attackSpeed"))
    target:setMod(tpz.mod.MOVE_SPEED_STACKABLE, target:getLocalVar("movementSpeed"))
end

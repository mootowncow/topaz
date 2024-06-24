-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    -- Set movement and attack speed back if petrified mid gradual petrificatioin(Safety Check)
    if target:getLocalVar("movementSpeed") > 0 then
        target:setMod(tpz.mod.MOVE_SPEED_STACKABLE, target:getLocalVar("movementSpeed"))
    end
    if target:getLocalVar("attackSpeed") > 0 then
        target:setMod(tpz.mod.HASTE_MAGIC, target:getLocalVar("attackSpeed"))
    end
end

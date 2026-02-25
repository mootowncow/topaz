-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local hpBoost = target:getMainLvl() * 3
    local currentHpPercent = target:getHPP()
    printf("currentHpPercent %d", currentHpPercent)

    target:addMod(tpz.mod.NINJA_TOOL, effect:getPower())
    target:addMod(tpz.mod.ENMITY, effect:getPower())
    target:addMod(tpz.mod.HP, hpBoost)

    -- Set HP percent back to what it was before the HP boost
    target:queue(0, function(target)
        target:setHPP(currentHpPercent)
    end)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local hpBoost = target:getMainLvl() * 3

    target:delMod(tpz.mod.NINJA_TOOL, effect:getPower())
    target:delMod(tpz.mod.ENMITY, effect:getPower())
    target:delMod(tpz.mod.HP, hpBoost)
end

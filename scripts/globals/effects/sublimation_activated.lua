-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.REGEN_DOWN, effect:getSubPower())
end

function onEffectTick(target, effect)
    local sublimationData =
    {
        { Level = 75, Refresh = 7 },
        { Level = 70, Refresh = 6 },
        { Level = 60, Refresh = 5 },
        { Level = 50, Refresh = 4 },
        { Level = 40, Refresh = 3 },
        { Level = 35, Refresh = 2 },
    }

    local complete = false
    local level = 0
    if (target:getMainJob() == tpz.job.SCH) then
        level = target:getMainLvl()
    else
        level = target:getSubLvl()
    end

    local lvlBonus = 0
    for _, subData in ipairs(sublimationData) do
        if level >= subData.Level then
            lvlBonus = subData.Refresh
            break
        end
    end

    local bonus = target:getMod(tpz.mod.SUBLIMATION_BONUS)
    local store = effect:getPower() + lvlBonus + bonus

    -- The effect changes to "Sublimation: Complete" when the total MP stored is equal to 50% of your matpzmum HP or when the player's HP falls to orange level (<50%).
    local limit = math.floor((target:getBaseHP() + target:getMod(tpz.mod.HP) + target:getMerit(tpz.merit.MAX_HP)) / 2) +
        target:getMerit(tpz.merit.MAX_SUBLIMATION) * 10 + target:getJobPointLevel(tpz.jp.SUBLIMATION_EFFECT) * 3

    -- Instantly completes if HP drops to 50% or less
    if (target:getHPP() < 51 ) then
        complete = true
    end

    if store > limit then
        store = limit
        complete = true
    end

    if (complete) then
        target:delStatusEffectSilent(tpz.effect.SUBLIMATION_ACTIVATED)
        target:addStatusEffect(tpz.effect.SUBLIMATION_COMPLETE, store, 0, 7200)
    else
        effect:setPower(store)
    end

end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.REGEN_DOWN, effect:getSubPower())
end

--------------------------------------
--
-- tpz.effect.AUSPICE
--
-- Power: Used for Enspell Effect
-- SubPower: Tracks Subtle Blow Bonus
-- Tier: Used for Enspell Calculation
--
--------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
--------------------------------------

function onEffectGain(target, effect)
    --Auspice Reduces TP via adding to your Subtle Blow Mod
    local subtleBlowBonus = 10 + target:getMod(tpz.mod.AUSPICE_EFFECT)
    --printf("AUSPICE: Adding Subtle Blow +%d!", subtleBlowBonus)
    effect:setSubPower(subtleBlowBonus)
    target:addMod(tpz.mod.SUBTLE_BLOW, subtleBlowBonus)
    -- Add Store TP
    target:addMod(tpz.mod.STORETP, 25)

    --Afflatus Misery Bonuses
    if (target:hasStatusEffect(tpz.effect.AFFLATUS_MISERY)) then
        target:getStatusEffect(tpz.effect.AFFLATUS_MISERY):setSubPower(0)
        target:addMod(tpz.mod.ENSPELL, tpz.magic.enspell.AUSPICE)
        target:addMod(tpz.mod.ENSPELL_DMG, effect:getPower())
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local subtleBlow = effect:getSubPower()
    --printf("AUSPICE: Removing Subtle Blow +%d!", subtleBlow)
    target:delMod(tpz.mod.SUBTLE_BLOW, subtleBlow)
    target:delMod(tpz.mod.STORETP, 25)

    --Clean Up Any Bonuses That From Afflatus Misery Combo
    if (target:hasStatusEffect(tpz.effect.AFFLATUS_MISERY)) then
        local accuracyBonus = target:getStatusEffect(tpz.effect.AFFLATUS_MISERY):getSubPower()
        --printf("AUSPICE: Removing Accuracy Bonus +%d!", accuracyBonus)
        target:delMod(tpz.mod.ACC, accuracyBonus)
        local accuracyBonus = target:getStatusEffect(tpz.effect.AFFLATUS_MISERY):setSubPower(0)

        target:setMod(tpz.mod.ENSPELL_DMG, 0)
        target:setMod(tpz.mod.ENSPELL, 0)
    end

end

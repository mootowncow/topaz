-----------------------------------
-- Ability: Mantra
-- Increases the max. HP of party members within area of effect.
-- Obtainable: Monk Level 75
-- Recast Time: 0:10:00
-- Duration: 0:03:00
-- Inner Strength: Increases duration to 9 minutes.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local merits = 20 + (1 - player:getMerit(tpz.merit.MANTRA))
    local gearMod = 0 -- TODO
    local power = merits + gearMod
    local duration = 180

    if player:isPC() then
        if player:hasStatusEffect(tpz.effect.INNER_STRENGTH) then
            duration = 540
        end
    end

    if canOverwrite(target, tpz.effect.MAX_HP_BOOST, power) then
        target:delStatusEffectSilent(tpz.effect.MAX_HP_BOOST)
        target:addStatusEffect(tpz.effect.MAX_HP_BOOST, power, 0, duration)
    end
end

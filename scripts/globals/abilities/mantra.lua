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
    local duration = 180

    if player:isPC() then
        if player:hasStatusEffect(tpz.effect.INNER_STRENGTH) then
            duration = 540
        end
    end

    if canOverwrite(target, tpz.effect.MAX_HP_BOOST, merits) then
        player:delStatusEffectSilent(tpz.effect.MAX_HP_BOOST)
        target:addStatusEffect(tpz.effect.MAX_HP_BOOST, merits, 0, duration)
        player:delStatusEffectSilent(tpz.effect.INNER_STRENGTH)
    end
end

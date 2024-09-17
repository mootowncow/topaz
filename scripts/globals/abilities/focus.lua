-----------------------------------
-- Ability: Focus
-- Enhances user's accuracy.
-- Obtained: Monk Level 25
-- Recast Time: 5:00
-- Duration: 2:00
-- Inner Strength: Also grants crit rate bonus.
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local power = 20 + player:getMod(tpz.mod.FOCUS_EFFECT)
    local subpower = 0
    if player:isPC() then
        if player:hasStatusEffect(tpz.effect.INNER_STRENGTH) then
            subpower = 25
        end
    end

    player:addStatusEffect(tpz.effect.FOCUS, power, 0, 180, 0, subpower, 0)
end

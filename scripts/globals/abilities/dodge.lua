-----------------------------------
-- Ability: Dodge
-- Enhances user's evasion, Guard Power, and Parry rate.
-- Obtained: Monk Level 15
-- Recast Time: 3:00
-- Duration: 1:00
-- Inner Strength: Also grants MEVA
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local power = 20 + player:getMod(tpz.mod.DODGE_EFFECT)
    local subpower = 0
    if player:isPC() then
        if player:hasStatusEffect(tpz.effect.INNER_STRENGTH) then
            subpower = 100
        end
    end

    player:addStatusEffect(tpz.effect.DODGE, power, 0, 180, 0, subpower, 0)
end

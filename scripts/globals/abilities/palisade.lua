-----------------------------------
-- Ability: Palisade
-- Description: Increases chance of blocking with shield, and eliminates enmity loss.
-- Obtained: PLD Level 95
-- Recast Time: 00:05:00
-- Duration: 0:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local power = 100
    local jpValue = player:getJobPointLevel(tpz.jp.PALISADE_EFFECT)
    power = power + jpValue

    -- Custom AoE Palisade that stops mobs from moving if cast by a player, otherwise retail accurate Palisade
    if player:isPC() then
        target:addStatusEffect(tpz.effect.PALISADE, power, 0, 60, 0, 1, 0)
    else
        player:addStatusEffect(tpz.effect.PALISADE, power, 0, 60)
    end
end

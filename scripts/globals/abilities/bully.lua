-----------------------------------
-- Ability: Bully
-- Intimidates target. (About 15% proc rate)
-- Removes the direction requirement from Sneak Attack for main job Thieves when active.
-- Obtained: Thief Level 93
-- Recast Time: 3:00
-- Duration: 0:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    if player:isPC() then
        target:addStatusEffectEx(tpz.effect.DOUBT, tpz.effect.INTIMIDATE, 25, 0, 60)
    else
        target:addStatusEffectEx(tpz.effect.DOUBT, tpz.effect.INTIMIDATE, 15, 0, 30)
    end
    return tpz.effect.INTIMIDATE
end

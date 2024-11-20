-----------------------------------
-- Ability: Ternary Flourish
-- Description: Grants +3% critical hit rate per finishing move consumed to nearby allies.
-- Obtained: DNC Level 93
-- Recast Time: 00:01:30 (Flourishes III)
-- Duration: 00:03:00
-- Cost: 1-5 Finishing Move charges
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/job_util")
require("scripts/globals/msg")
-----------------------------------
function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    if player:hasStatusEffect(tpz.effect.FINISHING_MOVE_1) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_3)
        target:addStatusEffect(tpz.effect.TERNARY_FLOURISH, 3, 0, 180)
    elseif player:hasStatusEffect(tpz.effect.FINISHING_MOVE_3) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_2)
        target:addStatusEffect(tpz.effect.TERNARY_FLOURISH, 6, 0, 180)
    elseif player:hasStatusEffect(tpz.effect.FINISHING_MOVE_3) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_3)
        target:addStatusEffect(tpz.effect.TERNARY_FLOURISH, 9, 0, 180)
    elseif player:hasStatusEffect(tpz.effect.FINISHING_MOVE_4) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_4)
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_1, 1, 0, 7200)
        target:addStatusEffect(tpz.effect.TERNARY_FLOURISH, 12, 0, 180)
    elseif player:hasStatusEffect(tpz.effect.FINISHING_MOVE_5) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_5)
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_2, 1, 0, 7200)
        target:addStatusEffect(tpz.effect.TERNARY_FLOURISH, 15, 0, 180)
    end
end

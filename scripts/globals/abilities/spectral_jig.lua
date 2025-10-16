-----------------------------------
-- Ability: Spectral jig
-- Allows you to evade enemies by making you undetectable by sight and sound.
-- Obtained: Dancer Level 25
-- TP Required: 0
-- Recast Time: 30 seconds
-- Duration: 3 minutes
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
   return 0, 0
end

function onUseAbility(player, target, ability)
    local duration = 90
    local gearBonus = player:getMod(tpz.mod.JIG_DURATION)
    local jpBonus =  player:getJobPointLevel(tpz.jp.JIG_DURATION)
    if (player:getMainJob() == tpz.job.DNC) then
        duration = 180
    end

    duration = duration + gearBonus
    duration = duration + jpBonus
    -- printf("duration %s", duration)
    player:delStatusEffect(tpz.effect.SNEAK)
    player:delStatusEffect(tpz.effect.INVISIBLE)
    player:addStatusEffect(tpz.effect.SNEAK, 0, 10, duration)
    player:addStatusEffect(tpz.effect.INVISIBLE, 0, 10, duration)
end

-----------------------------------
-- Ability: Meditate
-- Gradually charges TP.
-- Obtained: Samurai Level 30
-- Recast Time: 3:00 (Can be reduced to 2:30 using Merit Points)
-- Duration: 15 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local amount = 12
    local jpBonus = (target:getJobPointLevel(tpz.jp.MEDITATE_EFFECT) * 5) / 10
    if (player:getMainJob() == tpz.job.SAM) then
        amount = 20 + jpBonus
    end
    local duration = 15 + player:getMod(tpz.mod.MEDITATE_DURATION)
    player:addStatusEffectEx(tpz.effect.MEDITATE, 0, amount, 3, duration)
end

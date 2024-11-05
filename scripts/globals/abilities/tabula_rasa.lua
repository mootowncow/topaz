-----------------------------------
-- Ability: Tabula Rasa
-- Optimizes both white and black magic capabilities while allowing charge-free stratagem use.
-- Obtained: Scholar Level 1
-- Recast Time: 1:00:00
-- Duration: 0:03:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)

    local regenbonus = 0
    if (player:getMainJob() == tpz.job.SCH and player:getMainLvl() >= 20) then
        regenbonus = 3 * math.floor((player:getMainLvl() - 10) / 10)
    end

    local helixbonus = 0
    if (player:getMainJob() == tpz.job.SCH and player:getMainLvl() >= 20) then
        helixbonus = math.floor(player:getMainLvl() / 4)
    end

    local jpValue = player:getJobPointLevel(tpz.jp.TABULA_RASA_EFFECT)
    if jpValue > 0 then
        player:addMP(player:getMaxMP() * 0.02 * jpValue)
    end

    player:resetRecast(tpz.recast.ABILITY, 228)
    player:resetRecast(tpz.recast.ABILITY, 231)
    player:resetRecast(tpz.recast.ABILITY, 232)
    player:addStatusEffect(tpz.effect.TABULA_RASA, math.floor(helixbonus*1.5), 0, 30, 0, math.floor(regenbonus*1.5))

    return tpz.effect.TABULA_RASA
end

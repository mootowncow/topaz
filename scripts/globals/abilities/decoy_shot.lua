-----------------------------------
-- Ability: Decoy Shot
-- Description: Diverts enmity when launching a ranged attack from behind a party member.
-- Obtained: RNG Level 95
-- Recast Time: 00:05:00
-- Duration: 00:03:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local typeEffect = tpz.effect.BLINK
    local numShadows = 2
    local jpBonus = math.floor(player:getJobPointLevel(tpz.jp.DECOY_SHOT_EFFECT) / 5)
    -- Create 4 Shadows of RNG main, 2 if not
    if (player:getMainJob() == tpz.job.RNG) then
        numShadows = 4
    end

    -- Add 1 additonal shadow per 5 points in Decoy Shot Effect JP
    numShadows = numShadows + jpBonus

    local duration = 300
    local procChance = 75

    player:addStatusEffect(typeEffect, numShadows, 0, duration, 0, procChance, 0)
end

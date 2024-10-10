-----------------------------------
-- Ability: Restraint
-- Grants an absorb shield (stoneskin).
-- Obtained: WAR Level 40
-- Recast Time: 1:00
-- Duration: 00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)

    -- Power is 10% of HP + VIT * 2
    local power = math.floor(player:getMaxHP() * 0.10)
    local duration = 30

    -- Add vit mod
    power = power + math.floor(player:getStat(tpz.mod.VIT) * 2)

    -- Add stoneskin gear
    power = power + player:getMod(tpz.mod.STONESKIN_BONUS_HP)

    -- Add JP bonus (2% bonus per job point)
    power = math.floor(power * (1 + player:getJobPointLevel(tpz.jp.RESTRAINT_EFFECT) / 100))
    -- Add mod bonus
    power = math.floor(power * (1 + player:getMod(tpz.mod.ENHANCES_RESTRAINT) / 100))

    player:addStatusEffect(tpz.effect.RESTRAINT, power, 0, duration)

    return tpz.effect.RESTRAINT
end
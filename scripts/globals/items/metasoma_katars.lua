-----------------------------------------
-- ID: 18784
-- Item: Metasoma Katars
-- Additional effect: Poison, Paralyze, or Bind
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = CalculateAdditionalEffectChance(player, 10)
    local power = 15
    local duration = 60
    local subpower = 0
    local tier = 1
    local bonus = 0
    local rng = math.random(3)
    if (rng == 1) then
        return TryApplyAdditionalEffect(player, target, tpz.effect.POISON, tpz.magic.ele.WATER, power, tick, duration, subpower, tier, chance, bonus)
    elseif (rng == 2) then
        return TryApplyAdditionalEffect(player, target, tpz.effect.PARALYSIS, tpz.magic.ele.ICE, power, tick, duration, subpower, tier, chance, bonus)
    elseif (rng == 3) then
        power = 1
        duration = GetBindDuration()
        return TryApplyAdditionalEffect(player, target, tpz.effect.BIND, tpz.magic.ele.ICE, power, tick, duration, subpower, tier, chance, bonus)
    end
end
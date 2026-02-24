---------------------------------------------
-- Hastega II
-- Grants 30% haste allies in range.
---------------------------------------------
require("scripts/globals/summon")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill, summoner)
    local effect = tpz.effect.HASTE
    local power = 3007 -- Haste
    local tick = 0
    local duration = 600
    local bonus = 0
    local subId = 0
    local subPower = 0
    local tier = 2

    AvatarBuffBP(pet, target, skill, effect, power, tick, duration, params, bonus, subId, subPower, tier)
    return effect
end
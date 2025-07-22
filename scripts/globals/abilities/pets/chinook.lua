---------------------------------------------
-- Chinook
---------------------------------------------
require("scripts/globals/summon")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill, summoner)
    local effect = tpz.effect.INTENSION
    local power = 15
    local duration = 180
    local bonus = 0

    AvatarBuffBP(pet, target, skill, effect, power, tick, duration, params, bonus)
    AvatarBuffBP(pet, target, skill, tpz.effect.FAST_CAST, power, tick, duration, params, bonus)
    return effect
end

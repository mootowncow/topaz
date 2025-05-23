---------------------------------------------
-- Inferno Howl
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
    local effect = tpz.effect.ATTACK_BOOST
    local power = 10
    local duration = 180
    local bonus = 0

    AvatarBuffBP(pet, target, skill, effect, power, tick, duration, params, bonus)
    AvatarBuffBP(pet, target, skill, tpz.effect.ENFIRE, 6592, tick, duration, params, bonus)
    return effect
end

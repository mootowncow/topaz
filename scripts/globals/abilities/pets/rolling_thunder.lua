---------------------------------------------
-- Rolling Thunder
---------------------------------------------
require("scripts/globals/summon")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    getAvatarTP(player)
    return 0, 0
end

function onPetAbility(target, pet, skill, summoner)
    local power = 5
    local duration = 180
    local bonus = 0

    AvatarBuffBP(pet, target, skill, tpz.effect.POTENCY, power, tick, duration, params, bonus)
    AvatarBuffBP(pet, target, skill, tpz.effect.ENTHUNDER, 6592, tick, duration, params, bonus)
    return tpz.effect.ENTHUNDER
end

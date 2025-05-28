---------------------------------------------
-- Katabatic Blades
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
    local power = 25
    local duration = 180
    local bonus = 0

    AvatarBuffBP(pet, target, skill, tpz.effect.STORE_TP, power, tick, duration, params, bonus)
    AvatarBuffBP(pet, target, skill, tpz.effect.ENAERO, 6592, tick, duration, params, bonus)
    return tpz.effect.ENAERO
end

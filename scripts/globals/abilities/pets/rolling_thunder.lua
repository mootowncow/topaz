---------------------------------------------
--
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
    local effect = tpz.effect.POTENCY
    local power = math.floor(pet:getMainLvl() / 5) -- 15% at 75
    local duration = 180
    local bonus = 0

    AvatarBuffBP(pet, target, skill, effect, power, tick, duration, params, bonus)
    return effect
end

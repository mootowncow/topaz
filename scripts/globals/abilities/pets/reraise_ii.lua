---------------------------------------------
-- Raise II (Avatar)
---------------------------------------------
require("scripts/globals/summon")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    getAvatarTP(player)
    return 0, 0
end

function onPetAbility(target, pet, skill, summoner)
    local params = {}
    local effect = tpz.effect.RERAISE
    local power = 2
    local tick = 0
    local duration = 3600
    local bonus = 0
    params.NO_TP_CONSUMPTION = true

    AvatarBuffBP(pet, target, skill, effect, power, tick, duration, params, bonus)
    return effect
end

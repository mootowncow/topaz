---------------------------------------------
-- Fleet Wind
-- Grants 20% quickening allies in range.
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
    local effect = tpz.effect.QUICKENING
    local power = 20
    local duration = 600
    local bonus = 0

    AvatarBuffBP(pet, target, skill, effect, power, tick, duration, params, bonus)
    return effect
end
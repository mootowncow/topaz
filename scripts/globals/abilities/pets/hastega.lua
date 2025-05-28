---------------------------------------------
-- Hastega
-- Grants 15-30% haste and 25% quickening effect to allies in range.
---------------------------------------------
require("scripts/globals/summon")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    getAvatarTP(player)
    return 0, 0
end

function onPetAbility(target, pet, skill, summoner)
    local effect = tpz.effect.HASTE
    local power = 1530 -- Haste
    if summoner:getMainLvl() >= 75 then
        power = 3007 -- Haste II
    end
    local duration = 600
    local bonus = 0
    local effect2 = tpz.effect.QUICKENING
    local power2 = 20

    AvatarBuffBP(pet, target, skill, effect, power, tick, duration, params, bonus)
    AvatarBuffBP(pet, target, skill, effect2, power2, tick, duration, params, bonus)
    return effect
end
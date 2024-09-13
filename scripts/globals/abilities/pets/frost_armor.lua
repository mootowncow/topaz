---------------------------------------------
-- Frost Armor
-- Grants allies in range Aquaveil(4 charges) and 3/tick Refresh
-- Aquaveil duration 15 minutes, Refresh 3 minutes.
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
    local effect = tpz.effect.AQUAVEIL
    local power = 4
    local duration = 900
    local bonus = 0
    local effect2 = tpz.effect.REFRESH
    local power2 = 3 -- Refresh
    if summoner:getMainJob() >= 75 then
        power2 = 6 -- Refresh II
    end
    local tick2 = 3
    local duration2 = 600 + target:getMod(tpz.mod.REFRESH_DURATION)
    local bonus = 0

    AvatarBuffBP(pet, target, skill, effect, power, tick, duration, params, bonus)
    AvatarBuffBP(pet, target, skill, effect2, power2, tick2, duration2, params, bonus)
    return effect
end
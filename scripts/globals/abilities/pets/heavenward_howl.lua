---------------------------------------------
-- Heavenward Howl
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
    local effect = tpz.effect.ENDRAIN
    local power = 6592
    local duration = 180
    local bonus = 0
    local targetJob = utils.GetJobType(target)

    if (targetJob == 'Caster') and (target:getID() ~= pet:getID()) then
        effect = tpz.effect.ENASPIR
    end

    AvatarBuffBP(pet, target, skill, effect, power, tick, duration, params, bonus)
    return effect
end

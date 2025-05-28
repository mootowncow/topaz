-----------------------------------------
-- Sleepga
-----------------------------------------
require("scripts/globals/summon")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/spell_data")
require("scripts/globals/summon")
-----------------------------------------

function onAbilityCheck(player, target, ability)
    getAvatarTP(player)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local params = {}
    local effect = tpz.effect.SLEEP_I
    local power = 1
    local duration = 90
    local bonus = 0

    -- Can't overwrite any sleep
    if hasSleepT1Effect(target) then
        giveAvatarTP(pet)
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return effect
    end

    skill:setMsg(AvatarStatusEffectBP(pet, target, effect, power, duration, params, bonus))
    giveAvatarTP(pet)
    return effect
end
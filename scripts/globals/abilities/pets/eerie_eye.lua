-----------------------------------------
-- Eerie Eye
-- Amnesia + Silence
-- Gaze based conal.
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
    local effect = tpz.effect.SILENCE
    local power = 1
    local duration = 20
    local bonus = 0
    local effect2 = tpz.effect.AMNESIA
    local duration2 = 12

    -- Check that Cait Sith is facing the mob
    if not target:isFacing(pet) or target:hasStatusEffect(tpz.effect.BLINDNESS) then
        giveAvatarTP(pet)
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return effect
    end

    skill:setMsg(AvatarStatusEffectBP(pet, target, effect, power, duration, params, bonus))
    AvatarStatusEffectBP(pet, target, effect2, power, duration2, params, bonus)
    target:setTP(0)
    giveAvatarTP(pet)

    return tpz.effect.SLEEP_II
end
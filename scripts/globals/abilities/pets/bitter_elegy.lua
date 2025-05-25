-----------------------------------------
-- Bitter Elegy
-- Wind elementally alligned Elegy
-----------------------------------------
require("scripts/globals/summon")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/spell_data")
require("scripts/globals/summon")
-----------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local params = {}
    params.ELEMENT_OVERRIDE = tpz.magic.ele.WIND
    local effect = tpz.effect.ELEGY
    local power = 5000
    local duration = 180
    local bonus = 0

    skill:setMsg(AvatarStatusEffectBP(pet, target, effect, power, duration, params, bonus))
    return effect
end
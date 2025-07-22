-----------------------------------------
-- Shock Squall
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
    local effect = tpz.effect.STUN
    local power = 1
    local duration = 15
    local bonus = 200

    skill:setMsg(AvatarStatusEffectBP(pet, target, effect, power, duration, params, bonus))
    return effect
end
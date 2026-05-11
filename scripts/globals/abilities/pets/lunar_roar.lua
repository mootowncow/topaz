---------------------------------------------
-- Lunar Roar
-- Dispels two effects from target in AOE.
-- Additional effect: MAB and MACC down.
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

function onPetAbility(target, pet, skill)
    local params = {}
    local effect = tpz.effect.MAGIC_ATK_DOWN
    local power = 10
    local duration = 180
    local bonus = 0
    local effect2 = tpz.effect.MAGIC_ACC_DOWN
    local dispel_1 = AvatarDispelMove(pet, target, skill, tpz.magic.ele.DARK, tpz.effectFlag.DISPELABLE)
    local dispel_2 = AvatarDispelMove(pet, target, skill, tpz.magic.ele.DARK, tpz.effectFlag.DISPELABLE)

    AvatarStatusEffectBP(pet, target, effect, power, duration, params, bonus)
    AvatarStatusEffectBP(pet, target, effect2, power, duration, params, bonus)

    if (dispel_1 == tpz.effect.NONE) then
        skill:setMsg(tpz.msg.basic.NO_EFFECT)
    else
        skill:setMsg(tpz.msg.basic.NONE) -- No message on retail
    end

    return 0
end

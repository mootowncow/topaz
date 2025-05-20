---------------------------------------------
-- Altana's Favor
---------------------------------------------
require("scripts/globals/summon")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local params = {}
    local effect = tpz.effect.RERAISE
    local power = 4
    local tick = 0
    local duration = 3600
    local bonus = 0
    params.NO_TP_CONSUMPTION = true

    if not target:isPC() then
        skill:setMsg(tpz.msg.basic.JA_NO_EFFECT_2)
        return 0
    end
    
    skill:setMsg(tpz.msg.basic.JA_GAINS_EFFFECT)
    
    if target:isDead() then
        target:sendRaise(4)
        skill:setMsg(tpz.msg.basic.NONE)
    else
        AvatarBuffBP(pet, target, skill, effect, power, tick, duration, params, bonus)
        skill:setMsg(tpz.msg.basic.JA_NO_EFFECT_2)
    end
    
    pet:getMaster():setMP(0)
    return tpz.effect.RERAISE
end


-----------------------------------------
-- ID: 18948
-- Item: Enforcer
-- Additional Effect: MP drain
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = CalculateAdditionalEffectChance(player, 10)
    local power = 50
    local maccBonus = 50
    local dmg = doAdditionalEffectDamage(player, target, chance, power, nil, false, 0, tpz.magic.ele.DARK, tpz.skill.SCYTHE, maccBonus)

    if dmg == 0 or target:isUndead() then
        return 0, 0, 0
    end

    dmg = math.min(dmg, target:getMP())
    player:addMP(dmg)
    target:delMP(dmg)

    local message = tpz.msg.basic.ADD_EFFECT_MP_DRAIN

    return tpz.subEffect.MP_DRAIN, message, dmg
end


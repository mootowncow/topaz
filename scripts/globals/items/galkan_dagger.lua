-----------------------------------------
-- ID: 19114
-- Item: Galkan Dagger
-- Additional Effect: Earth Damage
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = CalculateAdditionalEffectChance(player, 100)
    local power = math.random(8, 10)
    local bonus = 255
    local dmg = doAdditionalEffectDamage(player, target, chance, power, nil, false, 0, tpz.magic.ele.EARTH, tpz.skill.DAGGER, bonus)

    if dmg == 0 then
        return 0, 0, 0
    end

    local message = tpz.msg.basic.ADD_EFFECT_DMG
    if (dmg < 0) then
        message = tpz.msg.basic.ADD_EFFECT_HEAL
        dmg = target:addHP(-dmg)
    end

    return tpz.subEffect.EARTH_DAMAGE, message, dmg
end

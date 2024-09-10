-----------------------------------------
-- ID: 16936
-- Item: Demonic Sword
-- Additional Effect: Darkness Damage
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
function onAdditionalEffect(player, target, damage)
    local chance = 33
    local dmg = 25
    local includeMAB = false
    local bonusMAB = 0
    local element = tpz.magic.ele.DARK
    local bonus = 0
    local dmg = doAdditionalEffectDamage(player, target, chance, dmg, nil, includeMAB, bonusMAB, element, bonus)

    if dmg == 0 then
        return 0, 0, 0
    end

    local message = tpz.msg.basic.ADD_EFFECT_DMG
    if (dmg < 0) then
        message = tpz.msg.basic.ADD_EFFECT_HEAL
        dmg = target:addHP(-dmg)
    end

    return tpz.subEffect.DARK_DAMAGE, message, dmg
end

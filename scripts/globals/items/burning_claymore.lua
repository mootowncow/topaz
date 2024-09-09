-----------------------------------------
-- ID: 16929
-- Item: Burning Claymore
-- Additional Effect: Fire Damage
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
function onAdditionalEffect(player, target, damage)
    local chance = 10
    local dmg = 15
    local includeMAB = false
    local bonusMAB = 0
    local element = tpz.magic.ele.FIRE
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

    return tpz.subEffect.FIRE_DAMAGE, message, dmg
end



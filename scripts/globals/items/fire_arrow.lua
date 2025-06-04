-----------------------------------------
-- ID: 18153
-- Item: Fire Arrow
-- Additional Effect: Fire Damage
-- Bolt dmg is affected by fire/water staves and Chatoyant
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local dmg = doAdditionalEffectDamage(player, target, 100, 0, tpz.mod.INT, true, 0, tpz.magic.ele.FIRE, tpz.skill.ARCHERY, 100)

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

-----------------------------------------
-- ID: 18153
-- Item: Ice Arrow
-- Additional Effect: Ice Damage
-- Bolt dmg is affected by ice/fire staves and Chatoyant
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local dmg = doAdditionalEffectDamage(player, target, 100, 20, tpz.mod.INT, true, 0, tpz.magic.ele.ICE, 100)

    if dmg == 0 then
        return 0, 0, 0
    end

    local message = tpz.msg.basic.ADD_EFFECT_DMG
    if (dmg < 0) then
        message = tpz.msg.basic.ADD_EFFECT_HEAL
        dmg = target:addHP(-dmg)
    end

    return tpz.subEffect.ICE_DAMAGE, message, dmg
end

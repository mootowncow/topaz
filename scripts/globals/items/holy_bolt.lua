-----------------------------------------
-- ID: 18153
-- Item: Holy Bolt
-- Additional Effect: Light Damage
-- Bolt dmg is affected by light/dark staves and Chatoyant
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local dmg = doAdditionalEffectDamage(player, target, 100, 20, tpz.mod.MND, true, 0, tpz.magic.ele.LIGHT, 100)

    if dmg == 0 then
        return 0, 0, 0
    end

    local message = tpz.msg.basic.ADD_EFFECT_DMG
    if (dmg < 0) then
        message = tpz.msg.basic.ADD_EFFECT_HEAL
        dmg = target:addHP(-dmg)
    end

    return tpz.subEffect.LIGHT_DAMAGE, message, dmg
end

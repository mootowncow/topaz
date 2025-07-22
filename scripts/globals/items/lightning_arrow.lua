-----------------------------------------
-- ID: 18153
-- Item: Lightning Arrow
-- Additional Effect: Lightning Damage
-- Bolt dmg is affected by lightning/earth staves and Chatoyant
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local dmg = doAdditionalEffectDamage(player, target, 100, 0, tpz.mod.INT, true, 0, tpz.magic.ele.THUNDER, tpz.skill.ARCHERY, 100)

    if dmg == 0 then
        return 0, 0, 0
    end

    local message = tpz.msg.basic.ADD_EFFECT_DMG
    if (dmg < 0) then
        message = tpz.msg.basic.ADD_EFFECT_HEAL
        dmg = target:addHP(-dmg)
    end

    return tpz.subEffect.LIGHTNING_DAMAGE, message, dmg
end

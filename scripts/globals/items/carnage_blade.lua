-----------------------------------------
-- ID: 16827
-- Item: Carnage Blade
-- Additional Effect: Drains HP
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = CalculateAdditionalEffectChance(player, 10)
    local power = math.random(20, 25)
    local dmg = doAdditionalEffectDamage(player, target, chance, power, nil, false, 0, tpz.magic.ele.DARK, 0)

    if dmg == 0 then
        return 0, 0, 0
    end

    local message = tpz.msg.basic.ADD_EFFECT_HP_DRAIN
    if (dmg < 0) then
        message = tpz.msg.basic.ADD_EFFECT_HEAL
        dmg = target:addHP(-dmg)
    end

    player:addHP(dmg)
    return tpz.subEffect.HP_DRAIN, message, dmg
end

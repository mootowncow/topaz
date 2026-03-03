-----------------------------------------
-- ID: 18013
-- Item: Melt Kukri
-- Additional Effect: Weakens defense
-- TODO: Enchantment: Weakens defense
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/items")
-----------------------------------
function onItemCheck(itemUser)
    local target = itemUser:getCursorTarget()
    if not target or not target:isMob() then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

function onItemUse(target, item, itemUser)
    local chance = CalculateAdditionalEffectChance(itemUser, 100)
    local effect = tpz.effect.DEFENSE_DOWN
    local power = item:getParam()
    local tick = 0
    local duration = 300
    local subpower = 0
    local tier = 1
    local element = tpz.magic.ele.WIND
    local skill = tpz.skill.DAGGER
    local bonus = 255

    local target = itemUser:getCursorTarget()

    return TryApplyAdditionalEffect(itemUser, target, effect, element, power, tick, duration, subpower, tier, chance, skill, bonus)
end

function onAdditionalEffect(player, target, damage)
    local chance = CalculateAdditionalEffectChance(player, 10)

    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, tpz.magic.ele.WIND, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:delStatusEffectSilent(tpz.effect.DEFENSE_BOOST)
        target:addStatusEffect(tpz.effect.DEFENSE_DOWN, 10, 0, 60)
        return tpz.subEffect.DEFENSE_DOWN, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.DEFENSE_DOWN
    end
end

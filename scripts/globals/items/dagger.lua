-----------------------------------------
-- ID: 18148
-- Item: Acid Bolt
-- Additional Effect: Weakens Defense
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/items")
require("scripts/globals/augments")
require("scripts/globals/item_utils")
-----------------------------------
function onAdditionalEffect(player, target, damage)
    for slot = tpz.slot.MAIN, tpz.slot.SUB do
        local item = player:getEquippedItem(slot)

        if item then
            local augmentValue = tpz.itemUtils.HasAugment(item, tpz.augments.ADDEFF_WEAKENS_DEF)
            if augmentValue then
                local chance = CalculateAdditionalEffectChance(player, 100)
                local power = augmentValue +1
                local duration = 180
                local subpower = 0
                local tier = 1
                local bonus = 0

                return TryApplyAdditionalEffect(player, target, tpz.effect.DEFENSE_DOWN, tpz.magic.ele.WIND, power, tick, duration, subpower, tier, chance, tpz.skill.MARKSMANSHIP, bonus)
            end
        end
    end

    return
end


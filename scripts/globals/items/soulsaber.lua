-----------------------------------------
-- Item: Soulsaber
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
                local dmg = augmentValue
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
        end
    end

    return
end


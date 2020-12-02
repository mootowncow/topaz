-----------------------------------------
-- ID: 16742
-- Item: Poison Knife +1
-- Additional Effect: Poison
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 17  -- changed to 17%

    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, tpz.magic.ele.WATER, 0) <= 0.5) then
        return 0, 0, 0
    else
        if (not target:hasStatusEffect(tpz.effect.POISON)) then
            target:addStatusEffect(tpz.effect.POISON, 11, 3, 60)  -- changed to 1m dura, 11/tick   
        end
        return tpz.subEffect.POISON, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.POISON
    end
end

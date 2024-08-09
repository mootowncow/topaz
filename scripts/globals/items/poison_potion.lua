-----------------------------------------
-- ID: 4157
-- Item: Poison Potion
-- Item Effect: Poison 1HP / Removes 60 HP over 180 seconds
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local typeEffect = tpz.effect.POISON
    if (not target:hasStatusEffect(typeEffect)) then
        target:addStatusEffect(typeEffect, 1, 3, 180)
        if (target:getName() == 'Mihli_Aliapoh') then
            local effect1 = target:getStatusEffect(typeEffect)
            if (effect1 ~= nil) then
                effect1:unsetFlag(tpz.effectFlag.WALTZABLE)
            end
        end
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

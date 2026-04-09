-----------------------------------------
-- ID: 14495
-- Item: Healing Harness
-- Item Effect: Restores 50-75 HP
-----------------------------------------
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local hpHeal = math.random(50, 75)
    local dif = target:getMaxHP() - target:getHP()
    if (hpHeal > dif) then
        hpHeal = dif
    end
    target:addHP(hpHeal)
    target:messageBasic(tpz.msg.basic.RECOVERS_HP, 0, hpHeal)
end

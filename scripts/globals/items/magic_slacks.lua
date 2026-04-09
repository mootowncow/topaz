-----------------------------------------
-- ID: 15372
-- Item: Magic Slacks
-- Item Effect: Restores 200-300 MP
-----------------------------------------
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local mpHeal = math.random(200, 300)
    local dif = target:getMaxMP() - target:getMP()
    if (mpHeal > dif) then
        mpHeal = dif
    end
    target:addMP(mpHeal)
    target:messageBasic(tpz.msg.basic.RECOVERS_MP, 0, mpHeal)
end

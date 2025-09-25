-----------------------------------------
-- ID: 4249
-- Item: Copy of Schultz Stratage
-- Grants 150 - 500 EXP
-- Does not grant Limit Points.
--
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local check = 56
    if (target:getMainLvl() >= 65) then
        check = 0
    end
    return check
end

function onItemUse(target)
    local exp = math.random(150, 500)
    local silent = true
    local xpOnly = true

    target:addExp(exp, silent, xpOnly)
    target:messageBasic(8, exp, 0)
end

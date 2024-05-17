-----------------------------------------
-- ID: 4248
-- Item: Copy of "Ginuva's Battle Theory"
-- Grants 50 - 200 EXP
-- Does not grant Limit Points.
--
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/settings")
-----------------------------------------

function onItemCheck(target)
    local check = 56
    if (target:getMainLvl() >= 65) then
        check = 0
    end
    return check
end

function onItemUse(target)
    local exp = math.random(50, 200)
    target:addExp(exp)
    target:messageBasic(8, exp, 0)
end

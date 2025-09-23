-----------------------------------------
-- ID: 4247
-- Item: Page From Miratete's Memo
-- Grants 750 - 1, 500 EXP
-- Does not grant Limit Points.
--
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local check = 56
    if (target:getMainLvl() >= 20) then
        check = 0
    end
    return check
end

function onItemUse(target)
    local exp = math.random(750, 1500)
    local silent = true
    local xpOnly = true

    target:addExp(exp, silent, xpOnly)
    target:messageBasic(8, exp, 0)
end

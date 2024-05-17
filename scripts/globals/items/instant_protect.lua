-----------------------------------------
-- ID: 5990
-- Scroll of Instant Protect
-- Grants the user a 200 HP Stoneskin effect
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local spellData =
    {
        { 7, 10 },
        {27, 25 },
        {47, 40 },
        {63, 55 },
    }
    local power = 55

    if target:getMainLvl() >= 63 then
        power = 55
    elseif target:getMainLvl() >= 47 and target:getMainLvl() < 63 then
        power = 47
    elseif target:getMainLvl() >= 27 and target:getMainLvl() < 47 then
        power = 27
    elseif target:getMainLvl() >= 7 and target:getMainLvl() < 27 then
        power = 10
    end

    if target:addStatusEffect(tpz.effect.PROTECT, power, 0, 1800) then
        target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.PROTECT)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

-----------------------------------------
-- ID: 5990
-- Scroll of Instant Stoneskin
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
        { 17, 9 },
        { 37, 14 },
        { 57, 19 },
        { 68, 22 },
    }

    local power = 22

    if target:getMainLvl() >= 68 then
        power = 22
    elseif target:getMainLvl() >= 57 and target:getMainLvl() < 68 then
        power = 19
    elseif target:getMainLvl() >= 37 and target:getMainLvl() < 57 then
        power = 14
    elseif target:getMainLvl() >= 17 and target:getMainLvl() < 37 then
        power = 9
    end

    if target:addStatusEffect(tpz.effect.SHELL, power, 0, 1800) then
        target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.SHELL)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

-----------------------------------------
-- ID: 5990
-- Scroll of Instant Stoneskin
-- Grants the user a Stoneskin effect
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local power = math.floor(target:getMainLvl() * 3)

    utils.ShouldRemoveStoneskin(target, power)
    if target:addStatusEffect(tpz.effect.STONESKIN, power, 0, 300, 0, 0, 4) then
        target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.STONESKIN)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

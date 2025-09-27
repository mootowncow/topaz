-----------------------------------------
-- ID: 4203
-- vitality_potion
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    if target:hasStatusEffect(tpz.effect.MEDICINE) then
        return tpz.msg.basic.ITEM_NO_USE_MEDICATED
    end
    return 0
end

function onItemUse(target)
    local phalanxPower = 100

    -- Add phalanx recieved gear mod
    phalanxPower = phalanxPower + target:getMod(tpz.mod.PHALANX_RECIEVED)

    target:addStatusEffect(tpz.effect.VIT_BOOST, 20, 0, 30)
    target:addStatusEffect(tpz.effect.PHALANX, phalanxPower, 0, 30)
    target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.PHALANX)
    target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 3600)
end

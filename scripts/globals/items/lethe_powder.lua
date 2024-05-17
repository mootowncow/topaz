-----------------------------------------
-- ID: 4214
-- Lethe Powder
-- Dispels all positive status effects from surrounding enemies.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effectsDispelled = target:dispelAllStatusEffect(bit.bor(tpz.effectFlag.DISPELABLE))

    target:messagePublic(tpz.msg.basic.EFFECTS_DISAPPEAR, target, effectsDispelled, effectsDispelled)
end


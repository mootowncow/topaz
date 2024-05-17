-----------------------------------------
-- ID: 4212
-- Lethe Water +1
-- Dispels all positive status effects from target.
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


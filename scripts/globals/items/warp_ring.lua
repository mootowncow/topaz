-----------------------------------------
-- ID: 28540
-- Warp Ring
--  Transports the user to their Home Point
-----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if target:getObjType() == tpz.objType.PC then
        target:clearTrusts()
    end

    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.WARP, 0, 3)
end

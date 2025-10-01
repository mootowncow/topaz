-----------------------------------------
-- ID: 5261
-- Item: Bottle of Psychoanima
-- Item Effect: Empty Killer +255% (30s)
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/items")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target, item, itemUser)
    local param = item:getParam()
    local duration = 60

    itemUser:queue(0, function(itemUser)
        itemUser:addMod(tpz.mod.EMPTY_KILLER, param)
    end)

    itemUser:queue(duration*1000, function(itemUser)
        itemUser:delMod(tpz.mod.EMPTY_KILLER, param)
    end)
end
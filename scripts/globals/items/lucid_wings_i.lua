-----------------------------------------
-- ID: 5834
-- Lucid Wings I
-- Increases TP of the user and nearby allies by 500
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/items")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
	local tp = (500 * (100 + target:getMod(tpz.mod.STORETP))) / 100
    target:addTP(tp)
    target:messageBasic(tpz.msg.basic.PLAYER_REGAIN_TP, target, tp)
end

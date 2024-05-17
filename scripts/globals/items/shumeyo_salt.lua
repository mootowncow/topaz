-----------------------------------------
-- ID: 5267
-- Item: Chunk Of Shu'Meyo Salt
-- Effect: Adds 20 seconds to the Snoll Tzar fight
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/player")
-----------------------------------------

local ID = require("scripts/zones/Bearclaw_Pinnacle/IDs")

function onItemCheck(target, param, player)
    local result = 0
	local id = target:getID()

	if id ~= 16801793 then -- snoll tzar
        result = tpz.msg.basic.ITEM_UNABLE_TO_USE
    elseif target:checkDistance(player) > 10 then
        result = tpz.msg.basic.TOO_FAR_AWAY
    end

    return result
end

function onItemUse(target, player)
    local salt = target:getLocalVar("salty")

    if (salt == 0) then -- random time until shaken off
        target:setLocalVar("delayed", os.time() + 20)
        target:setLocalVar("cooldown", os.time() + math.random(15, 20))
        target:setLocalVar("salty", 1)
        target:setLocalVar("melt", 1)    
    end
end

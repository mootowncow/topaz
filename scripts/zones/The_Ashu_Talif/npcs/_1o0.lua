-----------------------------------
-- Area: The Ashu Talif
-- Door: Cargo Hold (_1o0)
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
require("scripts/globals/status")
-----------------------------------

function onTrigger(player, npc)
    local instance = player:getInstance()
    local stage = instance:getStage()
    local progress = instance:getProgress()

    if (stage == 0) and (progress == 1) then
        npc:getEntity(bit.band(ID.npc.DOOR_CARGO_HOLD, 0xFFF), tpz.objType.NPC):setAnimation(tpz.animation.OPEN_DOOR)
        instance:setStage(1)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

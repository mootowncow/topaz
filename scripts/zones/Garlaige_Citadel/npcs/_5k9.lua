-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Banishing Gate #2
-- !pos -100 -2.949 81 200
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Gates already opened, do nothing
    if npc:getAnimation() == tpz.anim.OPEN_DOOR then
        return 1
    end

    -- Player doesn't have KI, return default text
    if (player:hasKeyItem(tpz.ki.POUCH_OF_WEIGHTED_STONES) == false or player:getZPos() < 80.5) then
        player:messageSpecial(ID.text.A_GATE_OF_STURDY_STEEL)
        return 1
    end

    local DoorID = npc:getID()
    local door = GetNPCByID(DoorID)

    for i = DoorID, DoorID+4, 1 do
        GetNPCByID(i):openDoor(40)
    end

    local zonePlayers = player:getZone():getPlayers()
    for _, zonePlayer in pairs(zonePlayers) do
        -- send gate opening text to each player in zone
        zonePlayer:messageText(zonePlayer, ID.text.SECOND_GATE_OPENING, 5)

        door:timer(1000 * 40, function(door)
            -- send gate closing text to each player in zone
            zonePlayer:messageText(zonePlayer, ID.text.SECOND_GATE_CLOSING, 5)
        end)
    end

    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

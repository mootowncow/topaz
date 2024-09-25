-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Banishing Gate #1
-- !pos -201.000 -2.994 220 200
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:hasKeyItem(tpz.ki.POUCH_OF_WEIGHTED_STONES) == false or player:getXPos() > -201) then
        player:messageSpecial(ID.text.A_GATE_OF_STURDY_STEEL)
        return 1
    else
        local DoorID = npc:getID()
        local door = GetNPCByID(DoorID)

        for i = DoorID, DoorID+4, 1 do
            GetNPCByID(i):openDoor(60)
        end

        local zonePlayers = player:getZone():getPlayers()
        for _, zonePlayer in pairs(zonePlayers) do
            -- send gate opening text to each player in zone
            zonePlayer:messageText(zonePlayer, ID.text.FIRST_GATE_OPENING, 5)

            door:timer(1000 * 60, function(door)
                -- send gate closing text to each player in zone
                zonePlayer:messageText(zonePlayer, ID.text.FIRST_GATE_CLOSING, 5)
            end)
        end

        return 1
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

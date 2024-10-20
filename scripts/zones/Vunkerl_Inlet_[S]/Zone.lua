-----------------------------------
--
-- Zone: Vunkerl_Inlet_[S] (83)
--
-----------------------------------
local ID = require("scripts/zones/Vunkerl_Inlet_[S]/IDs")
require("scripts/globals/status")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then
        player:setPos(-393.238, -50.034, 741.199, 2)
    end
    return cs
end

function onZoneWeatherChange(weather)
    local npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS) -- Indescript Markings
    if npc then
        npc:setStatus(tpz.status.NORMAL)
    end
end

function onGameHour(zone)
    local npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS) -- Indescript Markings
    if npc then
        npc:setStatus(tpz.status.NORMAL)
    end
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

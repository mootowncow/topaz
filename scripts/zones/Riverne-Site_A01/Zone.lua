-----------------------------------
--
-- Zone: Riverne-Site_A01
--
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onInitialize(zone)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getCurrentMission(COP) == tpz.mission.id.cop.ANCIENT_VOWS and player:getCharVar("PromathiaStatus") == 1 then
        cs = 100
    end
    
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(732.55, -32.5, -506.544, 90) -- {R}
    end

    return cs
end

function afterZoneIn(player)
    if (ENABLE_COP_ZONE_CAP == 1) then -- ZONE WIDE LEVEL RESTRICTION
        player:addStatusEffect(tpz.effect.LEVEL_RESTRICTION, 40, 0, 0) -- LV40 cap
    end
end

function onRegionEnter(player, region)
end

function onGameDay()
    -- move shield bug ???
    local positions =
    {
        {275.1907, 0.8048, 273.8457},
        {581.000,  -1.0981,   426.000},
        {-245.6420,  19.9981,  -718.3527},
    }
    local newPosition = npcUtil.pickNewPosition(ID.npc.SHIELD_BUG_QM, positions)
    GetNPCByID(ID.npc.SHIELD_BUG_QM):setPos(newPosition.x, newPosition.y, newPosition.z)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 100 then
        player:setCharVar("PromathiaStatus", 2)
    end
end

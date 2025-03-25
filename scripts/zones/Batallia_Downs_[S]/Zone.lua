-----------------------------------
--
-- Zone: Batallia_Downs_[S] (84)
--
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs_[S]/IDs")
require("scripts/globals/voidwalker")
-----------------------------------

function onInitialize(zone)
    local circleRadius = 15
    zone:registerRegion(1, 159.000000, circleRadius, 99.000000, 0, 0, 0)
    zone:registerRegion(2, 3.8, circleRadius, 225, 0, 0, 0)
    zone:registerRegion(3, 0.854450, circleRadius, -170.000000, 0, 0, 0)

    tpz.voidwalker.zoneOnInit(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-500.451, -39.71, 504.894, 39)
    end
    return cs
end

function onRegionEnter(player, region)
    local RegionID = region:GetRegionID()

    -- Map RegionID to Gate NPC ID
    local gates = {
        [1] = 17122111,
        [2] = 17122112,
        [3] = 17122113,
    }

    -- Get the corresponding gate for the region the player entered
    local gateId = gates[RegionID]

    if gateId then
        local gate = GetNPCByID(gateId)
        if gate and (gate:getAnimation() == tpz.anim.CLOSE_DOOR) then
            gate:setAnimation(tpz.anim.OPEN_DOOR)
            gate:timer(1000 * 30, function(gate) -- Stay open for 30s
                gate:setAnimation(tpz.anim.CLOSE_DOOR)
            end)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

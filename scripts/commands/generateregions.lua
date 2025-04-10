---------------------------------------------------------------------------------------------------
-- func: !generateregions
-- desc: Generates regions for current zone (Used in WotG dungeons)
---------------------------------------------------------------------------------------------------
------------------------------
require("scripts/globals/wotg")
------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!generateregions")
end

function onTrigger(player)
    local zone = player:getZone()
    local zoneId = player:getZoneID()
    local zoneData = {
        tpz.zone.CRAWLERS_NEST_S, tpz.zone.THE_ELDIEME_NECROPOLIS_S, tpz.zone.GARLAIGE_CITADEL_S
    }

    -- Make sure the zone is a valid zone to generate regions in
    local isValid = false
    for _, validZone in pairs(zoneData) do
        if (zoneId == validZone) then
            isValid = true
            break
        end
    end

    if not isValid then
        error(player, "Not a valid zone for regions to be generated in.")
        return
    end

    tpz.wotg.onInitialize(zone)
    player:PrintToPlayer("Active regions successfully generated")
end

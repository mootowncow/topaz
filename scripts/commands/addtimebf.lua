---------------------------------------------------------------------------------------------------
-- func: addtimebf
-- desc: Adds time to a battlefield.
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/zone")
---------------------------------------------------------------------------------------------------
cmdprops =
{
    permission = 0,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setprogress <number>")
end

function onTrigger(player, minutes)
    local battlefield = player:getBattlefield()
    local ID = zones[player:getZoneID()]

    if minutes == nil then
        error(player, "You must enter an interget")
    end

    local timeLimit = battlefield:getTimeLimit()
    local extension = minutes * 60
    battlefield:setTimeLimit(timeLimit + extension)

    players = battlefield:getPlayers()
    for _, player in pairs(players) do
        player:messageSpecial(ID.text.TIME_EXTENDED, minutes)
        player:messageSpecial(ID.text.TIME_LEFT, battlefield:getRemainingTime()/60)
    end
 end

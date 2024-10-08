---------------------------------------------------------------------------------------------------
-- func: countdown
-- desc: Sets a countdown on the target player
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!countdown {time}")
end

function onTrigger(player, time)
    if not time then
        error(player, "Must specify a time. ")
        return
    end

    local target

    if target then
        target = GetPlayerByName(target)
    else
        target = player:getCursorTarget()
    end

    if not target or not target:isPC() then
        error(player, "No valid target found. place cursor on a player object or specify a player name. ")
        return
    end

    target:countdown(time)
    player:PrintToPlayer(string.format("Added timer [%i] to %s", time, player:getName()))
end

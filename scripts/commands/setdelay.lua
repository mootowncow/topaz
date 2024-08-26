
---------------------------------------------------------------------------------------------------
-- func: setdelay
-- desc: Sets the mobs weapon delay
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setmodel {npcID} <delay>")
end

function onTrigger(player, arg1, arg2)
    local targ
    local delay

    if (arg2 == nil) then
        -- player did not provide npcId.  Shift arguments by one.
        targ = player:getCursorTarget()
        delay = arg1
    else
        -- player provided npcId and delay.
        targ = GetMobByID(tonumber(arg1))
        delay = arg2
    end

    -- validate target
    if (not targ:isMob() and not targ:isPet()) then
        error(player, "You must either enter a valid mob or pet")
        return
    end

    player:PrintToPlayer(string.format("Target name: %s (Target ID: %i) delay set to: %d", targ:getName(), targ:getID(), delay))
    targ:setDelay(delay)
end

---------------------------------------------------------------------------------------------------
-- func: setentityflags
-- desc: Sets targets entity flags
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setentityflags {entity} <entityFlags>")
end

function onTrigger(player, arg1, arg2)
    local targ
    local entityFlags

    if (arg2 == nil) then
        -- player did not provide npcId.  Shift arguments by one.
        targ = player:getCursorTarget()
        entityFlags = arg1
    else
        -- player provided npcId and entityFlags.
        targ = GetMobByID(tonumber(arg1))
        entityFlags = arg2
    end

    -- validate target
    if (targ == nil) then
        error(player, "You must either enter a valid npcID or target an entity.")
        return
    end

    player:setEntityFlags(entityFlags, targ:getID())
end
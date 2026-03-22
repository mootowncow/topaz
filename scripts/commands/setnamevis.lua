---------------------------------------------------------------------------------------------------
-- func: setnamevis
-- desc: Sets the mobs namevis (nameplate information)
---------------------------------------------------------------------------------------------------

require("scripts/globals/mobs")

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setnamevis {npcID} <entityFlag>")
end

function onTrigger(player, arg1, arg2)

    local targ
    local entityFlag

    if (arg2 == nil) then
        -- player did not provide npcId. Shift arguments by one.
        targ = player:getCursorTarget()
        entityFlag = arg1
    else
        -- player provided npcId and entityFlag.
        targ = GetMobByID(tonumber(arg1))
        entityFlag = arg2
    end

    entityFlag = tonumber(entityFlag) or tpz.mob.ENTITYFLAGS[string.upper(entityFlag)]

    if not entityFlag then
        error(player, "No valid entity flag found.")
        return
    end

    if not targ then
        error(player, "Invalid target.")
        return
    end

    -- validate target
    if (not targ:isMob()) and (not targ:isPet()) then
        error(player, "You must either enter a valid mob or pet.")
        return
    end

    targ:setEntityFlags(entityFlag)
end
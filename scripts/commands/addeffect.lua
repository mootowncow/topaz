---------------------------------------------------------------------------------------------------
-- func: addeffect
-- desc: Adds the given effect to the given player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/teleports")


cmdprops =
{
    permission = 1,
    parameters = "ssssss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!addeffect {target} <effect> {power} {duration} {subid} {subPower}")
end

function onTrigger(player, arg1, arg2, arg3, arg4, arg5, arg6)

    local targ = player:getCursorTarget()
    local id
    local power
    local duration
    local subId
    local subPower


    if (arg1 == nil) then
        error(player, "Invalid effect.")
        return
    else
        if not targ:isMob() or not targ:isPet() or (targ ~= arg1) then
            targ = player:getCursorTarget()
            -- Target player
            id = arg1
            power = tonumber(arg2) or 1
            duration = tonumber(arg3) or 60
            subId = tonumber(arg4) or 0
            subPower = tonumber(arg5) or 0
        else
            -- Target is player
            target = player
            id = arg1
            power = tonumber(arg2) or 1
            duration = tonumber(arg3) or 60
            subId = tonumber(arg4) or 0
            subPower = tonumber(arg5) or 0
        end
    end

    -- validate effect
    if (id == nil) then
        error(player, "Invalid effect.")
        return
    else
        id = tonumber(id) or tpz.effect[string.upper(id)]
        if (id == nil) then
            error(player, "Invalid player or effect.")
            return
        end
    end

    -- validate power
    if (power < 0) then
        error(player, "Invalid power.")
        return
    end

    -- validate duration
    if (duration < 0) then
        error(player, "Invalid duration.")
        return
    end

    -- validate subId
    if (subId < 0) then
        error(player, "Invalid subId.")
        return
    end

    -- validate subPower
    if (subPower < 0) then
        error(player, "Invalid subPower.")
        return
    end

    -- add effect
    if (targ:addStatusEffect(id, power, 3, duration, subid, subPower)) then
        targ:messagePublic(280, targ, id, id)
    else
        targ:messagePublic(283, targ, id)
    end
end

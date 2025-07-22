---------------------------------------------------------------------------------------------------
-- func: setundispellable
-- desc: Sets the given effect undispellable / curable
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/utils")


cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setundispellable {target} <effect>")
end

function onTrigger(player, arg1)

    local targ = player:getCursorTarget()
    local id

    if (arg1 == nil) then
        error(player, "Invalid effect.")
        return
    else
        if not targ:isMob() or not targ:isPet() or (targ ~= arg1) then
            targ = player:getCursorTarget()
            -- Target player
            id = arg1
        else
            -- Target is player
            target = player
            id = arg1
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

    targ:setEffectUndispellable(id)
    local effectName = utils.PunctuateString(arg1)
    player:PrintToPlayer(string.format("%s is now undispellable.", effectName))
end

---------------------------------------------------------------------------------------------------
-- func: addimmunity
-- desc: Adds the given immunity to the target mob
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/teleports")


cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!addimmunity <immunity>")
end

function onTrigger(player, immunity)

    local targ = player:getCursorTarget()

    if not targ:isMob() then
        error(player, "Target needs to be a valid mob.")
        return
    end

    -- validate immunity
    if (immunity == nil) then
        error(player, "Invalid effect.")
        return
    else
        immunity = tonumber(immunity) or tpz.immunity[string.upper(immunity)]
        if (immunity == nil) then
            error(player, "Invalid player or immunity.")
            return
        end
    end

    -- add immunity
    targ:addImmunity(immunity)
    player:PrintToPlayer(string.format("%s immunity added to %s.", immunity, targ:getName()))
end

---------------------------------------------------------------------------------------------------
-- func: delweaponskill
-- desc: Deletes a weapon skill from given target. If no target then to the current player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/weaponskillids")
require("scripts/globals/utils")

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

local function getWsNameFromId(id)
    for name, value in pairs(tpz.ws_unlock) do
        if value == id then
            return utils.formatEnumName(name)
        end
    end
    return "Unknown Weaponskill"
end

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!delweaponskill <wsId> {player}")
end

function onTrigger(player, wsId, target)

    -- validate weaponskill id
    if (wsId == nil) then
        error(player, "You must supply a weaponskill ID.")
        return
    end

    wsId = tonumber(wsId) or tpz.ws_unlock[string.upper(wsId)]
    if (wsId == nil or wsId < 1) then
        error(player, "Invalid Weaponskill ID.")
        return
    end

    -- validate target
    local targ
    if target then
        targ = GetPlayerByName(target)
        if not targ then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    else
        targ = player
    end

    targ:delLearnedWeaponskill(wsId)
    player:PrintToPlayer(string.format("%s no longer has the weaponskill %s.", targ:getName(), getWsNameFromId(wsId)))
end

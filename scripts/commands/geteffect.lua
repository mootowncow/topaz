---------------------------------------------------------------------------------------------------
-- func: geteffect
-- desc: Prints the status effect power requested of the currently selected target under the cursor
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
    player:PrintToPlayer("!geteffect <effect>")
end

function onTrigger(player, arg1)
    local targ = player:getCursorTarget()
    local id = arg1

    if (targ:isMob() or targ:isPet() or targ:isPC()) then

        if (arg1 == nil) then
            error(player, "Invalid effect.")
            return
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

        local effect = targ:getStatusEffect(id)

        if (effect == nil) then
            error(player, "No such effect on the currently selected target.")
            return
        end

        local power = effect:getPower()
        local tick = effect:getTick()
        local duration = math.ceil((effect:getTimeRemaining()) / 1000)
        local subId = effect:getSubType()
        local subPower = effect:getSubPower()
        local tier = effect:getTier()

        if (targ ~= nil) then
            player:PrintToPlayer(string.format("%s's %u power: %u, tick: %u, duration: %u, subId: %u, subPower: %u, tier: %u", targ:getName(), id, power, tick, duration, subId, subPower, tier))
        else
            player:PrintToPlayer("Must select a target using in game cursor first.")
        end
    else
        error(player, "Invalid target.")
        return
    end
end

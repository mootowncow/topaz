
---------------------------------------------------------------------------------------------------
-- func: setdmg
-- desc: Sets the mobs weapon damage
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setmodel {npcID} <damage>")
end

function onTrigger(player, arg1, arg2)
    local targ
    local damage

    if (arg2 == nil) then
        -- player did not provide npcId.  Shift arguments by one.
        targ = player:getCursorTarget()
        damage = arg1
    else
        -- player provided npcId and damage.
        targ = GetMobByID(tonumber(arg1))
        damage = arg2
    end

    -- validate target
    if (not targ:isMob() and not targ:isPet()) then
        error(player, "You must either enter a valid mob or pet")
        return
    end

    player:PrintToPlayer(string.format("Target name: %s (Target ID: %i) weapon damage set to: %d", targ:getName(), targ:getID(), damage))
    targ:setDamage(damage)
end
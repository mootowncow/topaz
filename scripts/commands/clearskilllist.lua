---------------------------------------------------------------------------------------------------
-- func: clearskilllist
-- desc: Clears a mobs current skill list
---------------------------------------------------------------------------------------------------
require("scripts/globals/mobs")
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!clearskilllist {mob}")
end

function onTrigger(player, arg1)
    local targ

    if (arg1 == nil) then
        -- player did not provide npcId.
        targ = player:getCursorTarget()
    else
        -- player provided npcId
        targ = GetMobByID(tonumber(arg1))
    end

    -- validate target
    if (targ == nil) then
        error(player, "You must either enter a valid npcID or target an entity.")
        return
    end


    targ:clearSkillList()
    player:PrintToPlayer(string.format("Cleared [%d] %s's skill list.", targ:getID(), MobName(targ)))
end
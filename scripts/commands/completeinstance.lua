---------------------------------------------------------------------------------------------------
-- func: completeinstance
-- desc: Completes the instance
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!completeinstance")
end

function onTrigger(player, arg1)
    local instance = player:getInstance()

    if (instance:complete()) then
        player:PrintToPlayer("Instance is now completed")
    end
 end

---------------------------------------------------------------------------------------------------
-- func: getprogress
-- desc: Gets the stage of the curent instance.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getprogress")
end

function onTrigger(player)
    local instance = player:getInstance()

    local progress = instance:getProgress()
    player:PrintToPlayer(string.format("Current instance progress is %i.", progress))
 end

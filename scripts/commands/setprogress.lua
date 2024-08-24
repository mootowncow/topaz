---------------------------------------------------------------------------------------------------
-- func: setprogress
-- desc: Sets the progress of the instance.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setprogress <number>")
end

function onTrigger(player, arg1)
    local instance = player:getInstance()

    if arg1 == nil then
        error(player, "You must enter an interget(1, 2, 3)")
    end

    instance:setProgress(arg1)
    player:PrintToPlayer(string.format("Current instance progress set to %i.", arg1))
 end

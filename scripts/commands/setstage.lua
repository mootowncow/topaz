---------------------------------------------------------------------------------------------------
-- func: setstage
-- desc: Sets the stage of the instance.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setstage <number>")
end

function onTrigger(player, arg1)
    local instance = player:getInstance()

    if arg1 == nil then
        error(player, "You must enter an interget(1, 2, 3)")
    end

    instance:setStage(arg1)
    player:PrintToPlayer(string.format("Current instance stage set to %i.", arg1))
 end

---------------------------------------------------------------------------------------------------
-- func: getstage
-- desc: Gets the stage of the curent instance.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getstage")
end

function onTrigger(player)
    local instance = player:getInstance()

    local stage = instance:getStage()
    player:PrintToPlayer(string.format("Current instance stage is %i.", stage))
 end

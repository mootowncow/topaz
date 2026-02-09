---------------------------------------------------------------------------------------------------
-- func: getzonevar
-- desc: Gets a instance var.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setinstancevar <var> <number>")
end

function onTrigger(player, var)
    local instance = player:getInstance()

    if (var == nil) then
        error(player, "You must enter a var name")
    end

    local instanceVar = instance:getLocalVar(var)
    player:PrintToPlayer(string.format("Current instance local var [%s] is %i.", var, instanceVar))
 end

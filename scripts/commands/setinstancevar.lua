---------------------------------------------------------------------------------------------------
-- func: setinstancevar
-- desc: Sets the instance var.
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

function onTrigger(player, var, varNum)
    local instance = player:getInstance()

    if (var == nil) then
        error(player, "You must enter a var name")
    elseif (varNum == nil) then
        error(player, "You must enter a var amount")
    end

    instance:setLocalVar(var, varNum)
    local instanceVar = instance:getLocalVar(var)
    player:PrintToPlayer(string.format("Current instance local var set to %i.", instanceVar))
 end

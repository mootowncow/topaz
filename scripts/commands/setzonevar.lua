---------------------------------------------------------------------------------------------------
-- func: setzonevar
-- desc: Sets the progress of the instance.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setzonevar <var> <number>")
end

function onTrigger(player, var, varNum)
    local zone = player:getZone()

    if (var == nil) then
        error(player, "You must enter a var name")
    elseif (varNum == nil) then
        error(player, "You must enter a var amount")
    end

    zone:setLocalVar(var, varNum)
    local zoneVar = zone:getLocalVar(var)
    player:PrintToPlayer(string.format("Current zone local var set to %i.", zoneVar))
 end

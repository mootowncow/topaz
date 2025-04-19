---------------------------------------------------------------------------------------------------
-- func: getzonevar
-- desc: Gets a zone var.
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

function onTrigger(player, var)
    local zone = player:getZone()

    if (var == nil) then
        error(player, "You must enter a var name")
    end

    local zoneVar = zone:getLocalVar(var)
    player:PrintToPlayer(string.format("Current zone local var [%s] is %i.", var, zoneVar))
 end

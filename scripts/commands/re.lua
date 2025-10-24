-----------------------------------------------------------------------
-- func: Raises party, removes weakness, resets JA's without an exp loss.
-- desc: Sends raise menu to GM or target player.
-----------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "ss"
}


function onTrigger(player)
    local zonePlayers = player:getZone():getPlayers()
    for _, zonePlayer in pairs(zonePlayers) do
        if zonePlayer:getHP() == 0 then
            zonePlayer:setLocalVar("GMRaise", 1)
            zonePlayer:sendRaise(3)
        end
        zonePlayer:delStatusEffect(1)
        zonePlayer:resetRecasts()
        zonePlayer:PrintToPlayer( string.format( "Sucessfully raised and reset everyone's JA's") )
    end
end

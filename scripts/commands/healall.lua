-----------------------------------------------------------------------
-- func: Fully heals all players and removes status effects.
-----------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function onTrigger(player)
    local nearbyEntities = player:getNearbyEntities(100)
    if (nearbyEntities ~= nil) then
        for _, nearbyPlayers in pairs(nearbyEntities) do
            if (nearbyPlayers:isPC() or nearbyPlayers:isTrust()) then
                nearbyPlayers:removeAllNegativeEffects()
                nearbyPlayers:setHPP(100)
                nearbyPlayers:setMPP(100)
            end
        end
        player:PrintToPlayer( string.format( "Successfully healed everyone's HP and MP to full and removed all negative status effects.") )
    end
end

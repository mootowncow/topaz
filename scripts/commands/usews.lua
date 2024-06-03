---------------------------------------------------------------------------------------------------
-- func: useWS
-- desc: Tells the target mob to use specificed TP move.
---------------------------------------------------------------------------------------------------
require("scripts/globals/mobs")

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!usews")
end

function onTrigger(player, tpmove)
    printf("Triggered onTrigger function with tpmove: %s", tpmove)
    
    local targ = player:getCursorTarget()
    
    if targ == nil or (not targ:isMob() and not targ:isPet()) then
        error(player, "you must select a target monster with the cursor first")
    else
        printf("Target acquired: %s", targ:getName())
        
        tpmove = tonumber(tpmove) or tpz.mob.skills[string.upper(tpmove)]
        printf("TP move: %s", tpmove)
        
        if (tpmove == nil) then
            error(player, "Invalid TP move.")
            return
        end
        
        targ:useMobAbility(tpmove)
    end
end

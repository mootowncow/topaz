---------------------------------------------------------------------------------------------------
-- func: useJA
-- desc: Tells the target mob to use specificed job ability.
---------------------------------------------------------------------------------------------------
require("scripts/globals/ability")

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!useja")
end

function onTrigger(player, tpmove)
    local targ = player:getCursorTarget()
    
    if targ == nil or (not targ:isMob() and not targ:isPet()) then
        error(player, "you must select a target monster with the cursor first")
    else
        print("onTrigger called with tpmove:", tpmove) -- Print initial tpmove
        
        tpmove = tonumber(tpmove) or tpz.jobAbility[string.upper(tpmove)]
        
        if (tpmove == nil) then
            error(player, "Invalid job ability.")
            return
        end
        
        print("targ:useJobAbility called with tpmove:", tpmove, " target ID:", targ:getTarget():getID()) -- Print final tpmove and target ID
        targ:useJobAbility(tpmove, targ:getTarget())
    end
end


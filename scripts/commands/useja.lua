---------------------------------------------------------------------------------------------------
-- func: useJA
-- desc: Tells the target mob to use specificed job ability.
---------------------------------------------------------------------------------------------------
require("scripts/globals/ability")

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!useja")
end

function onTrigger(player, jobAbility, self)
    local targ = player:getCursorTarget()
    
    if targ == nil or (not targ:isMob() and not targ:isPet()) then
        error(player, "you must select a target monster with the cursor first")
    else
        
        jobAbility = tonumber(jobAbility) or tpz.jobAbility[string.upper(jobAbility)]
        
        if (jobAbility == nil) then
            error(player, "Invalid job ability.")
            return
        end
        
        if (self == nil) then
            targ:useJobAbility(jobAbility)
        else
            targ:useJobAbility(jobAbility, targ)
        end
    end
end


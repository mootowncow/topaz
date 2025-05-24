---------------------------------------------------------------------------------------------------
-- func: useBP
-- desc: Use a Blood Pact ability on current target
---------------------------------------------------------------------------------------------------
require("scripts/globals/ability")

cmdprops =
{
    permission = 0,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!useja")
end

function onTrigger(player, jobAbility, self)
    local targ = player:getCursorTarget()
    
        jobAbility = tonumber(jobAbility) or tpz.jobAbility[string.upper(jobAbility)]
        
        if (jobAbility == nil) then
            error(player, "Invalid job ability.")
            return
        end
        
    player:useJobAbility(jobAbility, targ)
end


---------------------------------------------------------------------------------------------------
-- func: getTP
-- desc: prints the current targets TP
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!gettp")
end

function onTrigger(player)
    
    local targ = player:getCursorTarget()

    if targ == nil then
        error(player, "you must select a target monster or pet with the cursor first")
    end
    
    if not (targ:isPC() or targ:isMob() or targ:isPet() or targ:isTrust()) then
        error(player, "you must select a target that is a player, monster, pet, or trust.")
    end

    player:PrintToPlayer(string.format("%s's TP is: %u ", targ:getName(), targ:getTP()))
end

---------------------------------------------------------------------------------------------------
-- func: getburden
-- desc: Shows all your burden
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    local burden = player:getBurden()
    if not burden then
        error(player, "You must summon an Automaton to have Burden")
    else
        for i = 1, #burden do
            player:PrintToPlayer(string.format("Element %d burden = %d", i, burden[i]))
        end
    end
end
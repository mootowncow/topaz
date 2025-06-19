---------------------------------------------------------------------------------------------------
-- func: delwhmspells <player>
-- desc: Removes WHM spells from the players spell list.
-- Note: Not actually all WHM spells
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!delspell {player}")
end

function onTrigger(player, target)
    -- validate target
    local targ
    if (target == nil) then
        targ = player
    else
        targ = GetPlayerByName(target)
        if (targ == nil) then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    -- Define spell ID ranges to delete
    local ranges = {
        {86, 92},    -- Bar spells
        {7, 13},     -- Curaga spells, Raise, Raise II
        {14, 20},    -- -Na spells
        {125, 135},  -- Protectra / Shellra / Reraise
    }

    -- Loop through each range and delete those spells
    for _, range in ipairs(ranges) do
        for spellId = range[1], range[2] do
            targ:delSpell(spellId)
            printf("Deleting spell: %d", spellId)
        end
    end

    player:PrintToPlayer(string.format("Deleted WHM spells from %s.", targ:getName()))
end

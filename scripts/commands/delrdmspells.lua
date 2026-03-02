---------------------------------------------------------------------------------------------------
-- func: delrdmspells <player>
-- desc: Removes RDM spells from the players spell list.
-- Note: Not actually all RDM spells
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!delrdmspells {player}")
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
        {60, 65},    -- Bar element spells
        {72, 78},    -- Bar resist spells
        {100, 106},  -- Enspells / Phalanx
    }

    -- Loop through each range and delete those spells
    for _, range in ipairs(ranges) do
        for spellId = range[1], range[2] do
            targ:delSpell(spellId)
            printf("Deleting spell: %d", spellId)
        end
    end

    targ:delSpell(109) -- Refresh
    targ:delSpell(260) -- Dispel

    player:PrintToPlayer(string.format("Deleted RDM spells from %s.", targ:getName()))
end

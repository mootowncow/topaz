---------------------------------------------------------------------------------------------------
-- func: dellallrolls
-- desc: Deletes all valid rolls. If no target then to the current player.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!delallspells {player}")
end

function onTrigger(player, target)
    local validRolls =
    {
        -- 98–122
        98, 99, 100, 101, 102, 103, 104, 105, 106, 107,
        108, 109, 110, 111, 112, 113, 114, 115, 116, 117,
        118, 119, 120, 121, 122,

        -- 302–305
        302, 303, 304, 305,

        -- 390–391
        390, 391,
    }

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

    -- delete all rolls
    for i = 1, #validRolls do
        targ:delLearnedAbility(validRolls[i])
    end

    player:PrintToPlayer(string.format("%s no longer has any rolls.", targ:getName()))
end

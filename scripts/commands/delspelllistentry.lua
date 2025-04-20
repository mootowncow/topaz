
---------------------------------------------------------------------------------------------------
-- func: delspelllistentry
-- desc: Deletes a spell to the targets spell list
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!delspelllistentry {mob} <spellId>")
end

function onTrigger(player, arg1, arg2)
    local targ
    local spellId

    if (arg2 == nil) then
        -- player did not provide npcId.  Shift arguments by one.
        targ = player:getCursorTarget()
        spellId = arg1
    else
        -- player provided npcId and spellId.
        targ = GetMobByID(tonumber(arg1))
        spellId = arg2
    end

    -- validate target
    if (targ == nil) then
        error(player, "You must either enter a valid npcID or target an entity.")
        return
    end

    targ:delSpelllistEntry(spellId)
end
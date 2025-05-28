---------------------------------------------------------------------------------------------------
-- func: delspelllistentry
-- desc: Deletes a spell to the targets spell list
---------------------------------------------------------------------------------------------------
require("scripts/globals/spell_data")
require("scripts/globals/utils")
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!delspelllistentry {mob} <spell>")
end

function onTrigger(player, arg1, arg2)
    local targ
    local spell

    if (arg2 == nil) then
        -- player did not provide npcId.  Shift arguments by one.
        targ = player:getCursorTarget()
        spell = arg1
    else
        -- player provided npcId and spell.
        targ = GetMobByID(tonumber(arg1))
        spell = arg2
    end

    spell = tonumber(spell) or tpz.magic.spell[string.upper(spell)]
    if (spell == nil) then
        error(player, "Invalid spell.")
        return
    end

    -- validate target
    if (targ == nil) then
        error(player, "You must either enter a valid npcID or target an entity.")
        return
    end

    targ:delSpelllistEntry(spell)
    local spellName = string.gsub(arg1, '_', ' ')
    spellName = utils.PunctuateString(spellName)
    player:PrintToPlayer(string.format("Deleted spell (%s) from [%d] %s's spell list [%i].", spellName, targ:getID(), MobName(targ), targ:getSpellList()))
end
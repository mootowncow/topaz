---------------------------------------------------------------------------------------------------
-- func: delmobskilllistentry
-- desc: Deletes a spell to the targets spell list
---------------------------------------------------------------------------------------------------
require("scripts/globals/mobs")
require("scripts/globals/utils")
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!delmobskilllistentry {mob} <skill>")
end

function onTrigger(player, arg1, arg2)
    local targ
    local skill

    if (arg2 == nil) then
        -- player did not provide npcId.  Shift arguments by one.
        targ = player:getCursorTarget()
        skill = arg1
    else
        -- player provided npcId and skill.
        targ = GetMobByID(tonumber(arg1))
        skill = arg2
    end

    -- validate target
    if (targ == nil) then
        error(player, "You must either enter a valid npcID or target an entity.")
        return
    end

    skill = tonumber(skill) or tpz.mob.skills[string.upper(skill)]
    if (skill == nil) then
        error(player, "Invalid skill.")
        return
    end

    targ:delSkillListEntry(skill)
    local skillName = string.gsub(arg1, '_', ' ')
    skillName = utils.PunctuateString(skillName)
    player:PrintToPlayer(string.format("Deleted skill (%s) from [%d] %s's skill list [%i].", skillName, targ:getID(), MobName(targ), targ:getSkillList()))
end
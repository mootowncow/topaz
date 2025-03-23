-----------------------------------
-- Area: Grauberg [S]
--   NM: Migratory Hippogryph
-- Note: Spawned for quest "The Unfinished Waltz"
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_ACCEPTED and player:getCharVar("QuestStatus_DNC_AF1") == 3) then
        player:setCharVar("QuestStatus_DNC_AF1", 4)
    end
end

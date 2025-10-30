-----------------------------------
-- Area: Riverne - Site B01
--   NM: Spell_Spitter_Spilospok
-- Go! Go! Gobmuffin! map quest
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/quests")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if (isKiller or noKiller) then
        local party = player:getParty()
        if player:isTrust() or player:isPet() then
            party = player:getMaster():getParty()
        end

        for _, member in pairs(party) do
            local riverneMapQuest = member:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.GO_GO_GOBMUFFIN)
            local riverneMapProgress = member:getCharVar("riverneMapQuest")

            if (riverneMapQuest == QUEST_ACCEPTED and riverneMapProgress < 4) then
                member:setCharVar("riverneMapQuest", riverneMapProgress +1)
            end
        end
    end
end
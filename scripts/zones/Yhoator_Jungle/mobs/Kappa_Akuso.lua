-----------------------------------
-- Area: Yhoator Jungle
--   NM: Kappa Akuso
-- Involved in Quest: True will
-----------------------------------
local ID = require("scripts/zones/Yhoator_Jungle/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.TRUE_WILL) == QUEST_ACCEPTED then
        local lastNM = not (GetMobByID(ID.mob.KAPPA_BONZE):isAlive() or GetMobByID(ID.mob.KAPPA_BIWA):isAlive())
        if lastNM then -- Only count the kill for the last alive/spawned NM dying
            player:addCharVar("trueWillKilledNM", 1)
        end
    end
end

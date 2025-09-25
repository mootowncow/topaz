-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--  Mob: War Lynx
-- The Tigress Strikes Fight
-----------------------------------
local ID = require("scripts/zones/Fort_Karugo-Narugo_[S]/IDs")
require("scripts/globals/quests")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    if (mob:getID() == ID.mob.TIGRESS_STRIKES_WAR_LYNX) then
        SetGenericNMStats(mob)
        mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
        mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if (mob:getID() == ID.mob.TIGRESS_STRIKES_WAR_LYNX and player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STRIKES) == QUEST_ACCEPTED) then
        player:setCharVar("WarLynxKilled", 1)
    end
end

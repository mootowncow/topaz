-----------------------------------
-- NPC:  Treasure Chest
-- Involved in Random Events
-----------------------------------
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/treasure_chests")}
-----------------------------------
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.wotg.distributeChestLoot(player, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
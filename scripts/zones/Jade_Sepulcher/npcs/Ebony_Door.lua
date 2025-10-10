-----------------------------------
-- Area: Jade Sepulcher
-- NPC:  Ebony Door
-- !pos -35 -1 -539 31
-----------------------------------
local ID = require("scripts/zones/Jade_Sepulcher/IDs")
require("scripts/globals/bcnm")
require("scripts/globals/quests")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- TODO: player:startEvent(32003, 67, 1, 0, 0, 0, 67, 1, 1)
    player:leaveBattlefield(1)
    player:setPos(299, 0, -199, 67)
    player:ChangeMusic(0, 0)
    player:ChangeMusic(1, 0)
    player:ChangeMusic(2, 0)
    player:ChangeMusic(3, 0)
    player:setLocalVar("[battlefield]area", 0)
end

function onEventUpdate(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
end


-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Syndella
-- Type: Alter Ego Points NPC
-- !pos -4.349 1 134.014 243
-----------------------------------
require("scripts/globals/npc_util")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------
function onTrigger(player, npc)
    if not player:hasKeyItem(tpz.ki.CIPHER_BRACELET) then
        player:PrintToPlayer("My name is " .. npc:getName() .. ". I am currently researching the art of trust magic.",0,"Syndella")
        player:PrintToPlayer("Please take this Cipher Braclet to help me with my research!",0,"Syndella")
        player:addKeyItem(tpz.ki.CIPHER_BRACELET)
    else
        player:PrintToPlayer("Ah, my research is going quite splendidly. You see, I am able to observe your efforts through the bracelet.",0,"Syndella")
        player:PrintToPlayer("Now then, I wish you the best of luck.",0,"Syndella")
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
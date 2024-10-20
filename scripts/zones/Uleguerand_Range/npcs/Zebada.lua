-----------------------------------
-- Area: Uleguerand Range
--  NPC: Zebada
-- Type: ENM Quest Activator
-- !pos -308.112 -42.137 -570.096 5
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local ZephyrFanCD = player:getCharVar("[ENM]ZephyrFan")

    if (player:hasKeyItem(tpz.ki.ZEPHYR_FAN)) then
        player:startEvent(12)
    else
        if (ZephyrFanCD >= os.time()) then
            -- Both Vanadiel time and unix timestamps are based on seconds. Add the difference to the event.
            player:startEvent(15, VanadielTime()+(ZephyrFanCD-os.time()))
        else
            player:startEvent(13)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 13) then
        player:addKeyItem(tpz.ki.ZEPHYR_FAN)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ZEPHYR_FAN)
        player:setCharVar("[ENM]ZephyrFan", os.time() + 432000) -- 5 days
    elseif (csid == 14) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1779) -- Cotton Pouch
            return
        else
            player:addItem(1779)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1779) -- Cotton Pouch
        end
    end
end

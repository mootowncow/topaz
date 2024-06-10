-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Drahbah
-- Appraiser NPC
-- !gotoid 16982150
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/appraisal")
require("scripts/globals/npc_util")

local gilToPay = 500

function onTrade(player, npc, trade)
    local appraisalCsid = 679
    tpz.appraisalUtil.appraiseItem(player, npc, trade, gilToPay, appraisalCsid, { ID.text.NOT_HAVE_ENOUGH_GIL, 4618 })
end

function onTrigger(player, npc)
    player:startEvent(678, gilToPay)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local appraisalCsid = 679
    tpz.appraisalUtil.appraisalOnEventFinish(player, csid, option, gilToPay, appraisalCsid)
end

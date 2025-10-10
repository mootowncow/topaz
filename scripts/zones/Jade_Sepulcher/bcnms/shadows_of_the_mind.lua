-----------------------------------
-- Area: Jade Sepulcher
-- BCNM: Shadows of the Mind
-----------------------------------
require("scripts/globals/battlefield")
----------------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
        local ID = zones[player:getZoneID()]
        -- Only lose KI if you win(and don't run away)
        if player:hasKeyItem(tpz.ki.SECRET_IMPERIAL_ORDER) then
            player:delKeyItem(tpz.ki.SECRET_IMPERIAL_ORDER)
            player:messageSpecial(ID.text.KEYITEM_BREAKS, tpz.ki.SECRET_IMPERIAL_ORDER)
        end
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

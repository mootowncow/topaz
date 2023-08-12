-----------------------------------
--
-- SCH AF3: Seeing Blood-Red
--
-- https://gitlab.com/ffxiwings/wings/-/commit/f14b88073651da884ed5fd2f55de842dda8c2025?page=2
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Ruhotz_Silvermines/IDs")
-----------------------------------

function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)
    SpawnMob(ID.mob.ULBRECHT, instance)
end

function onInstanceTimeUpdate(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

function onInstanceFailure(instance)

    local mob = GetMobByID(ID.mob.ULBRECHT, instance)
    if mob then
        mob:messageText(mob, ID.text.UNLEARNT_SPRAT)
    end

    local chars = instance:getChars()
    for i, v in pairs(chars) do
        v:startEvent(10001)
    end
end

function onInstanceProgressUpdate(instance, progress)
end

function onInstanceComplete(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        if (v:getCharVar("SeeingBloodRed") == 3) then
            v:setCharVar("SeeingBloodRed", 4)
            v:startEvent(10000, 300, 23, 1757) -- can't seem to get this to work manually with GM commands?
        else
            v:startEvent(10001) -- could be off by 1 or 2 or we just need to send them to grauberg
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10000 or csid == 10001 then -- SCH AF3 battle
        player:setPos(0, 0, 0, 0, 89) -- Send back to Grauberg [S]
    end
end

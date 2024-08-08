-----------------------------------
--
-- Zone: Qufim_Island (126)
--
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
require("scripts/globals/conquest")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    tpz.conq.setRegionalConquestOverseers(zone:getRegionID())
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-286.271, -21.619, 320.084, 255)
    end

    if prevZone == tpz.zone.BEHEMOTHS_DOMINION and player:getCharVar("theTalekeepersGiftKilledNM") >= 3 then
        cs = 100
    end

    return cs
end

function afterZoneIn(player)
    local day = VanadielDayOfTheWeek()
    local arkangels = { 17293832, 17293833, 17293836, 17293837, 17293838 }
    local anySpawned = false

    -- Check if any of the Ark Angels are already spawned
    for id = 17293832, 17293839 do
        if GetMobByID(id):isSpawned() then
            anySpawned = true
            break
        end
    end

    -- If none are spawned and it's Darksday, spawn a random Ark Angel
    if not anySpawned and (day == tpz.day.DARKSDAY) then
        local selectedArkAngel = arkangels[math.random(#arkangels)]
        GetMobByID(selectedArkAngel):spawn()

        -- Spawn other related mobs if needed
        for v = 17293840, 17293846 do
            if not GetMobByID(v):isSpawned() then
                GetMobByID(v):spawn()
            end
        end
    end
end


function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 100 then
        npcUtil.completeQuest(player, BASTOK, tpz.quest.id.bastok.THE_TALEKEEPER_S_GIFT, {item = 12638, fame = 60, title = tpz.title.PARAGON_OF_WARRIOR_EXCELLENCE, var = {"theTalekeeperGiftCS", "theTalekeepersGiftKilledNM"}})
    end
end

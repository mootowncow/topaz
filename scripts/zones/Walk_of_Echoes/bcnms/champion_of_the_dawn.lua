-----------------------------------
-- Cait Sith Battle
-- Walk of Echoes
-- requires:
-- Quests Champion of the Dawn or The Dawn Also Rises
-- and breath of dawn key items
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/quests")
require("scripts/globals/titles")
local ID = require("scripts/zones/Walk_of_Echoes/IDs")
-----------------------------------
function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldInitialise(battlefield)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        -- cutscene is triggered after setPos and it's tied to the reward, not possible to skip
        local arg8 = 0 --(player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN) == QUEST_COMPLETED) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 7, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        if player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_DAWN_ALSO_RISES) > QUEST_AVAILABLE or
            player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN) > QUEST_AVAILABLE then
            printf("Fight successful")
            -- Fight successful and quest active
            player:setCharVar("TrialByCait_Won", 1)
            for breathOfDawn = tpz.ki.BREATH_OF_DAWN1, tpz.ki.BREATH_OF_DAWN3 do
                player:delKeyItem(breathOfDawn)
                player:messageSpecial(ID.text.KEYITEM_LOST, breathOfDawn)
            end
        end
        player:addTitle(tpz.title.LIGHT_OF_DAWN)
        -- clear black screen
        player:setPos(-700, -17.6, -335, 64, 182) -- Walk of Echoes in front of Ornate Door
    end
end

-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Justinius
-- Involved in mission : COP2-3
-- !pos 76 -34 68 26
-- https://gitlab.com/ffxiwings/wings/-/blob/master/scripts/zones/Tavnazian_Safehold/npcs/Justinius.lua
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
require("scripts/globals/utils")
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
-----------------------------------

-- Cache COP missions for later reference
local copMissions = tpz.mission.id.cop

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local copCurrentMission = player:getCurrentMission(COP)
    local copMissionStatus = player:getCharVar("PromathiaStatus")
    local uninvitedGuests =  player:getCharVar("UninvitedGuestsStatus")

    -- COP 2-3
    if copCurrentMission == copMissions.DISTANT_BELIEFS and copMissionStatus == 3 then
        player:startEvent(113)
    -- COP 2-4
    elseif copCurrentMission == copMissions.AN_ETERNAL_MELODY and copMissionStatus == 1 then
        player:startEvent(127) -- optional dialogue
    -- COP 4-1
    elseif copCurrentMission == copMissions.SHELTERING_DOUBT and copMissionStatus == 2 then
        player:startEvent(109)
    -- COP 4-2
    elseif copCurrentMission == copMissions.THE_SAVAGE then
        if copMissionStatus == 2 then
            player:startEvent(110) -- finish mission
        else
            player:startEvent(130) -- optional dialogue
        end
    elseif player:hasCompletedMission(COP, tpz.mission.id.cop.THE_SAVAGE) and player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNINVITED_GUESTS) == QUEST_AVAILABLE then
        player:startEvent(570) -- Intial Uninvited Quest CS
    elseif uninvitedGuests == 1 then
        if not player:hasKeyItem(tpz.ki.MONARCH_LINN_PATROL_PERMIT) then
            player:addKeyItem(tpz.ki.MONARCH_LINN_PATROL_PERMIT)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MONARCH_LINN_PATROL_PERMIT)
        end
        player:startEvent(571) -- Reminds player to go to Monarch Linn
    elseif uninvitedGuests == 2 then 
        player:startEvent(572) -- Uninvited Guests Victory
    elseif uninvitedGuests == 3 or (uninvitedGuests == 4 and player:getCharVar("UninvitedGuestsReset")) == getConquestTally() then
        player:startEvent(575) -- Uninvited Guests Failure - mocks player until conquest tally
    elseif uninvitedGuests == 4 and player:getCharVar("UninvitedGuestsReset") ~= getConquestTally() then
        player:startEvent(574) -- Reissues permit post failure
    elseif player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNINVITED_GUESTS) == QUEST_COMPLETED and player:getCharVar("UninvitedGuestsReset") ~= getConquestTally() then
        player:startEvent(573) -- Repeatable Init CS
    else
        player:startEvent(123)
    end
end


function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if csid == 113 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, copMissions.DISTANT_BELIEFS)
        player:addMission(COP, copMissions.AN_ETERNAL_MELODY)
    elseif csid == 109 then
        player:setCharVar("PromathiaStatus", 3)
    elseif csid == 110 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, copMissions.THE_SAVAGE)
        player:addMission(COP, copMissions.THE_SECRETS_OF_WORSHIP)
        player:addTitle(tpz.title.NAGMOLADAS_UNDERLING)
    elseif csid == 570 and option == 1 then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNINVITED_GUESTS)
        player:addKeyItem(tpz.ki.MONARCH_LINN_PATROL_PERMIT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MONARCH_LINN_PATROL_PERMIT)
        player:setCharVar("UninvitedGuestsStatus", 1) -- accepted
    elseif csid == 572 then
        if rewardId == 0 then
            rewardId = generateUninvitedGuestsReward(player)
        end

        -- Complete Quest if Active
        if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNINVITED_GUESTS) == QUEST_ACCEPTED then
            if npcUtil.completeQuest(player, OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNINVITED_GUESTS, {item = rewardId, title=tpz.title.MONARCH_LINN_PATROL_GUARD, var = {"UninvitedGuestsStatus", "UninvitedGuestsReward"}}) then
                updateUninvitedGuests(player, false)
            end
        else
            if(rewardId == 1) then -- special case for Gil
                if npcUtil.giveCurrency(player, "gil", 10000) then
                    updateUninvitedGuests(player, true)
                end
            elseif npcUtil.giveItem(player, rewardId) then
                updateUninvitedGuests(player, true)
            end
        end
    elseif csid == 574 or (csid == 573 and option == 1) then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MONARCH_LINN_PATROL_PERMIT)
        player:addKeyItem(tpz.ki.MONARCH_LINN_PATROL_PERMIT)
        player:setCharVar("UninvitedGuestsStatus", 1) -- accepted
    elseif csid == 575 then
        if player:getCharVar("UninvitedGuestsStatus") == 3 then
            updateUninvitedGuests(player, false)
            player:setCharVar("UninvitedGuestsStatus", 4) -- Player has failed and must wait until conquest to retry
        end
    end
end

function updateUninvitedGuests(player, clearVars)
    player:setCharVar("UninvitedGuestsReset", getConquestTally())
    if clearVars then
        player:setCharVar("UninvitedGuestsStatus", 0)
        player:setCharVar("UninvitedGuestsReward", 0)
    end
end

function generateUninvitedGuestsReward(player)
    -- Reward info taken from https://ffxiclopedia.fandom.com/wiki/Uninvited_Guests
    -- Moved any value with a 0 to 0.1
    -- Reduced Miratete's Memoirs from 57.7% to 50.9% to align total reward percentage to 100%
    local rewardId 
    local roll = math.random(1000) -- Since we need tenths of a percent - use 1000

    if roll <= 500 then -- 50%
        rewardId = 4247 -- Miratete's Memoirs
    elseif roll <= 514 then -- 1.39%
        rewardId = 4550 -- Bream Risotto
    elseif roll <= 528 then -- 1.39%
        rewardId = 1132 -- Raxa
    elseif roll <= 542 then -- 1.39%
        rewardId = 5144 -- Crimson Jelly
    elseif roll <= 556 then -- 1.39%
        rewardId = 4279 -- Tavnazian Salad
    elseif roll <= 570 then -- 1.39%
        rewardId = 678 -- Aluminum Ore
    elseif roll <= 584 then -- 1.39%
        rewardId = 5142 -- Bison Steak
    elseif roll <= 598 then -- 1.39%
        rewardId = 4544 -- Mushroom Stew
    elseif roll <= 612 then -- 1.39%
        rewardId = 1766 -- Tiger Eye
    elseif roll <= 626 then -- 1.39%
        rewardId = 1841 -- Unicorn Horn
    elseif roll <= 640 then -- 1.39%
        rewardId = 61 -- Armoire
    elseif roll <= 654 then -- 1.39%
        rewardId = 1602 -- Mannequin Body
    elseif roll <= 668 then -- 1.39%
        rewardId = 4434 -- Mushroom Risotto
    elseif roll <= 682 then -- 1.39%
        rewardId = 1603 -- Mannequin Hands
    elseif roll <= 696 then -- 1.39%
        rewardId = 1770 -- Oversized Fang
    elseif roll <= 710 then -- 1.39%
        rewardId = 1771 -- Dragon Bone
    elseif roll <= 724 then -- 1.39%
        rewardId = 690 -- Elm Log
    elseif roll <= 738 then -- 1.39%
        rewardId = 1604 -- Mannequin Legs
    elseif roll <= 752 then -- 1.39%
        rewardId = 1605 -- Mannequin Feet
    elseif roll <= 766 then -- 1.39%
        rewardId = 646 -- Adaman Ore
    elseif roll <= 780 then -- 1.39%
        rewardId = 860 -- Behemoth Hide
    elseif roll <= 794 then -- 1.39%
        rewardId = 1765 -- Habu Skin
    elseif roll <= 808 then -- 1.39%
        rewardId = 1842 -- Cloud Evoker
    elseif roll <= 822 then -- 1.39%
        rewardId = 1601 -- Mannequin Head
    elseif roll <= 836 then -- 1.39%
        rewardId = 739 -- Orichalcum Ore
    elseif roll <= 850 then -- 1.39%
        rewardId = 5158 -- Vermillion Jelly
    elseif roll <= 864 then -- 1.39%
        rewardId = 5185 -- Leremieu Salad
    elseif roll <= 878 then -- 1.39%
        rewardId = 908 -- Adamantoise Shell
    elseif roll <= 892 then -- 1.39%
        rewardId = 1312 -- Angel Skin
    elseif roll <= 906 then -- 1.39%
        rewardId = 4486 -- Dragon Heart
    elseif roll <= 920 then -- 1.39%
        rewardId = 5157 -- Marbled Steak
    elseif roll <= 934 then -- 1.39%
        rewardId = 4268 -- Sea Spray Risotto
    elseif roll <= 948 then -- 1.39%
        rewardId = 1313 -- Siren's Hair
    elseif roll <= 962 then -- 1.39%
        rewardId = 5264 -- Yellow Liquid
    elseif roll <= 976 then -- 1.39%
        rewardId = 4330 -- Witch Risotto
    elseif roll <= 990 then -- 1.39%
        rewardId = 1 -- 10,000 Gil Special cased to ID 1
    elseif roll <= 994 then -- 0.5%
        rewardId = 14470 -- Assault Breastplate
    elseif roll <= 1000 then -- 0.6%
        rewardId = 4344 -- Witch Stew
    end

    player:setCharVar("UninvitedGuestsReward", rewardId)
    return rewardId
end


--------------------------------------
-- Assault Utilities
-- desc : Common functions for the assaults
-- Credit: KnowOne - https://github.com/KnowOne134/DSP-Shared_Collection/blob/main/Assault/assault.lua
--------------------------------------
require("scripts/globals/appraisal")
require("scripts/globals/besieged")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/zone")
--------------------------------------
assaultUtil = {}

assaultUtil.missionInfo =
{
    [LEUJAOAM_CLEANSING]               = {suggestedLevel = 50, minimumPoints = 1000},
    [ORICHALCUM_SURVEY]                = {suggestedLevel = 50, minimumPoints = 1200},
    [ESCORT_PROFESSOR_CHANOIX]         = {suggestedLevel = 60, minimumPoints = 1100},
    [SHANARHA_GRASS_CONSERVATION]      = {suggestedLevel = 50, minimumPoints = 1333},
    [COUNTING_SHEEP]                   = {suggestedLevel = 60, minimumPoints = 1166},
    [SUPPLIES_RECOVERY]                = {suggestedLevel = 70, minimumPoints = 1000},
    [AZURE_EXPERIMENTS]                = {suggestedLevel = 70, minimumPoints = 1000},
    [IMPERIAL_CODE]                    = {suggestedLevel = 70, minimumPoints = 1333},
    [RED_VERSUS_BLUE]                  = {suggestedLevel = 70, minimumPoints = 1666},
    [BLOODY_RONDO]                     = {suggestedLevel = 70, minimumPoints = 1500},
    [IMPERIAL_AGENT_RESCUE]            = {suggestedLevel = 60, minimumPoints = 1100},
    [PREEMPTIVE_STRIKE]                = {suggestedLevel = 60, minimumPoints = 1000},
    [SAGELORD_ELIMINATION]             = {suggestedLevel = 70, minimumPoints = 1200},
    [BREAKING_MORALE]                  = {suggestedLevel = 60, minimumPoints = 1333},
    [THE_DOUBLE_AGENT]                 = {suggestedLevel = 70, minimumPoints = 1200},
    [IMPERIAL_TREASURE_RETRIEVAL]      = {suggestedLevel = 50, minimumPoints = 1200},
    [BLITZKRIEG]                       = {suggestedLevel = 70, minimumPoints = 1533},
    [MARIDS_IN_THE_MIST]               = {suggestedLevel = 70, minimumPoints = 1333},
    [AZURE_AILMENTS]                   = {suggestedLevel = 70, minimumPoints = 1000},
    [THE_SUSANOO_SHUFFLE]              = {suggestedLevel = 70, minimumPoints = 1500},
    [EXCAVATION_DUTY]                  = {suggestedLevel = 50, minimumPoints = 1100},
    [LEBROS_SUPPLIES]                  = {suggestedLevel = 60, minimumPoints = 1200},
    [TROLL_FUGITIVES]                  = {suggestedLevel = 70, minimumPoints = 1000},
    [EVADE_AND_ESCAPE]                 = {suggestedLevel = 70, minimumPoints = 1000},
    [SIEGEMASTER_ASSASSINATION]        = {suggestedLevel = 70, minimumPoints = 1100},
    [APKALLU_BREEDING]                 = {suggestedLevel = 60, minimumPoints = 1300},
    [WAMOURA_FARM_RAID]                = {suggestedLevel = 70, minimumPoints = 1166},
    [EGG_CONSERVATION]                 = {suggestedLevel = 70, minimumPoints = 1333},
    [OPERATION__BLACK_PEARL]           = {suggestedLevel = 70, minimumPoints = 1400},
    [BETTER_THAN_ONE]                  = {suggestedLevel = 70, minimumPoints = 1500},
    [SEAGULL_GROUNDED]                 = {suggestedLevel = 70, minimumPoints = 1100},
    [REQUIEM]                          = {suggestedLevel = 70, minimumPoints = 1000},
    [SAVING_PRIVATE_RYAAF]             = {suggestedLevel = 70, minimumPoints = 1100},
    [SHOOTING_DOWN_THE_BARON]          = {suggestedLevel = 60, minimumPoints = 1100},
    [BUILDING_BRIDGES]                 = {suggestedLevel = 70, minimumPoints = 1200},
    [STOP_THE_BLOODSHED]               = {suggestedLevel = 50, minimumPoints = 1000},
    [DEFUSE_THE_THREAT]                = {suggestedLevel = 60, minimumPoints = 1600},
    [OPERATION__SNAKE_EYES]            = {suggestedLevel = 70, minimumPoints = 1333},
    [WAKE_THE_PUPPET]                  = {suggestedLevel = 70, minimumPoints = 1200},
    [THE_PRICE_IS_RIGHT]               = {suggestedLevel = 70, minimumPoints = 1500},
    [GOLDEN_SALVAGE]                   = {suggestedLevel = 60, minimumPoints = 1100},
    [LAMIA_NO_13]                      = {suggestedLevel = 70, minimumPoints = 1200},
    [EXTERMINATION]                    = {suggestedLevel = 70, minimumPoints = 1100},
    [DEMOLITION_DUTY]                  = {suggestedLevel = 50, minimumPoints = 1000},
    [SEARAT_SALVATION]                 = {suggestedLevel = 60, minimumPoints = 1166},
    [APKALLU_SEIZURE]                  = {suggestedLevel = 60, minimumPoints = 1000},
    [LOST_AND_FOUND]                   = {suggestedLevel = 60, minimumPoints = 1000},
    [DESERTER]                         = {suggestedLevel = 70, minimumPoints = 1000},
    [DESPERATELY_SEEKING_CEPHALOPODS]  = {suggestedLevel = 70, minimumPoints = 1000},
    [BELLEROPHON_S_BLISS]              = {suggestedLevel = 70, minimumPoints = 1500},
    [NYZUL_ISLE_INVESTIGATION]         = {suggestedLevel = 75, minimumPoints = nil},
    [NYZUL_ISLE_UNCHARTED_AREA_SURVEY] = {suggestedLevel = 99, minimumPoints = nil},
}

-----------------------------------------------
-- get offset for level sync error
-----------------------------------------------

function AssaultGetLevelSyncError(player)
    local zoneId = player:getZoneID()
    local text = zones[zoneId].text
    return text.CANNOT_ENTER_LEVEL_RESTRICTED
end

-- -------------------------------------------------------------------
-- hasOrders(player)
-- Check if player has obtained the Assault Order
-- -------------------------------------------------------------------
function hasOrders(player)
    local orders = {tpz.ki.LEUJAOAM_ASSAULT_ORDERS, tpz.ki.MAMOOL_JA_ASSAULT_ORDERS, tpz.ki.LEBROS_ASSAULT_ORDERS,
    tpz.ki.PERIQIA_ASSAULT_ORDERS, tpz.ki.ILRUSI_ASSAULT_ORDERS, tpz.ki.NYZUL_ISLE_ASSAULT_ORDERS}

    for _, v in pairs(orders) do
        if player:hasKeyItem(v) then
            return true
        end
    end
    return false
end

-- -------------------------------------------------------------------
-- onTriggerArmbandNPC(player, npc, csid1, csid2, csid3, csid4, csid5, csid6, csid7, beginningsKI, orders)
-- NPCs in Staging Points
-- -------------------------------------------------------------------
function onTriggerArmbandNPC(player, npc, csid1, csid2, csid3, csid4, csid5, csid6, csid7, beginningsKI, orders)
    local toauMission = player:getCurrentMission(TOAU)
    local beginnings = player:getQuestStatus(tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.BEGINNINGS)

    -- IMMORTAL SENTRIES
    if toauMission == tpz.mission.id.toau.IMMORTAL_SENTRIES then
        if player:hasKeyItem(tpz.ki.SUPPLIES_PACKAGE) then
            player:startEvent(csid1)
        elseif player:getCharVar("AhtUrganStatus") == 1 then
            player:startEvent(csid2)
        end

    -- BEGINNINGS
    elseif beginnings == QUEST_ACCEPTED then
        if not player:hasKeyItem(beginningsKI) then
            player:startEvent(csid3)
        else
            player:startEvent(csid4)
        end;

    -- ASSAULT
    elseif toauMission >= tpz.mission.id.toau.PRESIDENT_SALAHEEM then
        local IPpoint = player:getCurrency("imperial_standing")
        if player:getCharVar("assaultEntered") == 0 and player:hasKeyItem(orders) and not player:hasKeyItem(tpz.ki.ASSAULT_ARMBAND) then
            player:startEvent(csid5, 50, IPpoint)
        else
            player:startEvent(csid6)
        end

    -- DEFAULT DIALOG
    else
        player:startEvent(csid7)
    end
end

-- -------------------------------------------------------------------
-- onEventFinishArmbandNPC(player, csid, option, csid1, csid2, csid3, beginningsKI)
-- NPCs in Staging Points
-- -------------------------------------------------------------------
function onEventFinishArmbandNPC(player, csid, option, csid1, csid2, csid3, beginningsKI)
    -- IMMORTAL SENTRIES
    if csid == csid1 and option == 1 then
        player:delKeyItem(tpz.ki.SUPPLIES_PACKAGE)
        player:setCharVar("AhtUrganStatus",1)

    -- BEGINNINGS
    elseif csid == csid2 then
        npcUtil.giveKeyItem(player, beginningsKI)

    -- ASSAULT
    elseif csid == csid3 and option == 1 then
        npcUtil.giveKeyItem(player, tpz.ki.ASSAULT_ARMBAND)
        player:delCurrency("imperial_standing", 50)
    end
end

-- -------------------------------------------------------------------
-- onAssaultTrigger(player, npc, csid, orders, indexID)
-- Selection of the entrance portal of the assault
-- ------------------------------------------------------------------- 
function onAssaultTrigger(player, npc, csid, orders, indexID)
    if player:hasKeyItem(orders) and player:getCharVar("assaultEntered") == 0 then
        -- don't allow players under level sync to enter
        if player:hasStatusEffect(tpz.effect.LEVEL_SYNC) then
            local sync_error = AssaultGetLevelSyncError(player)
            if sync_error ~= nil then
                player:messageSpecial(sync_error, 0, 0)
            end
            return
        end

        local assaultID = player:getCurrentAssault()
        local level = assaultUtil.missionInfo[assaultID].suggestedLevel
        local armband = 0

        if player:hasKeyItem(tpz.ki.ASSAULT_ARMBAND) then
            armband = 1
        end
        player:startEvent(csid, assaultID, -4, 0, level, indexID, armband)
    else
        player:messageText(player, zones[player:getZoneID()].text.NOTHING_HAPPENS)
    end
end

-- -------------------------------------------------------------------
-- onAssaultUpdate(player, csid, option, target, orders, zoneID)
-- Creation of the assault if the prerequisites are met
-- -------------------------------------------------------------------
function onAssaultUpdate(player, csid, option, target, orders, zoneID)
    local assaultID = player:getCurrentAssault()

    local cap = bit.band(option, 0x03)
    if cap == 0 then
        cap = 0
    elseif cap == 1 then
        cap = 70
    elseif cap == 2 then
        cap = 60
    else
        cap = 50
    end

    player:setCharVar("AssaultCap", cap)

    if (player:getGMLevel() == 0 or player:getGMLevel() == 1) and player:getPartySize() <= 1 then
        player:messageSpecial(zones[player:getZoneID()].text.PARTY_MIN_REQS, 3)
        player:instanceEntry(target,1)
        return
    elseif player:checkSoloPartyAlliance() == 2 then
        player:messageText(player, zones[player:getZoneID()].text.MEMBER_NO_REQS + 1, false)
        player:instanceEntry(target,1)
        return
    end

    local party = player:getParty()

    if party ~= nil then
        for _,v in ipairs(party) do
            if not v:hasKeyItem(orders) or v:getCurrentAssault() ~= assaultID or v:getCharVar("assaultEntered") ~= 0 or v:getMainLvl() < 50 then
            --if not v:hasKeyItem(orders) or v:getCurrentAssault() ~= assaultID or v:getMainLvl() < 50 then
                player:messageText(player, zones[player:getZoneID()].text.MEMBER_NO_REQS, false)
                player:instanceEntry(target,1)
                return
            elseif v:getZoneID() ~= player:getZoneID() or v:checkDistance(player) > 50 then
                player:messageText(player, zones[player:getZoneID()].text.MEMBER_TOO_FAR, false)
                player:instanceEntry(target,1)
                return
            end
        end
    end

    player:createInstance(player:getCurrentAssault(), zoneID)
end

-- -------------------------------------------------------------------
-- onAssaultCreated(player, target, instance, endCS, destinationID)
-- Set party members to the correct assault
-- -------------------------------------------------------------------
function onAssaultCreated(player, target, instance, endCS, destinationID)
    if instance then
        instance:setLevelCap(player:getCharVar("AssaultCap"))
        player:setInstance(instance)
        player:instanceEntry(target,4)
        player:setCharVar("AssaultCap", 0)
        player:setCharVar("Assault_Armband", 1)
        player:delKeyItem(tpz.ki.ASSAULT_ARMBAND)
        player:setLocalVar("Area", destinationID)

        local party = player:getParty()
        if (party ~= nil) then
            for _,v in ipairs(party) do
                if v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID() then
                    v:release()
                    v:setLocalVar("Area", destinationID)
                    v:setInstance(instance)
                    v:timer(3000, function(player) player:startEvent(endCS, destinationID) end)
                end
            end
        end
    else
        player:messageText(player, zones[player:getZoneID()].text.CANNOT_ENTER, false)
        player:instanceEntry(target,3)
    end
end

-- -------------------------------------------------------------------
-- afterAssaultRegister(player, fireFlies, textTable, mobTable)
-- Set the assault with the restrictions related to the level cap
-- -------------------------------------------------------------------
function afterAssaultRegister(player, fireFlies, textTable, mobTable)
    local instance = player:getInstance()
    local assaultID = player:getCurrentAssault()
    --local cap = instance:getLevelCap()
    local cap = 0 -- TODO: need to correct this!

    player:setLocalVar("AssaultCompletedMessage", 0)
    player:messageSpecial(textTable.ASSAULT_START_OFFSET + assaultID, assaultID)
    player:messageSpecial(textTable.TIME_TO_COMPLETE, instance:getTimeLimit())
    player:addTempItem(fireFlies)
    if cap ~= 0 then
        player:addStatusEffect(tpz.effect.LEVEL_RESTRICTION, cap, 0, 0)
    end
    if player:getCharVar("Assault_Armband") == 1 then
        if cap ~= 0 then
            for _, v in pairs(mobTable[assaultID].MOBS_START) do
                if cap == 70 then
                    cap = 5
                elseif cap == 60 then
                    cap = 15
                elseif cap == 50 then
                    cap = 25
                end
                instance:getEntity(bit.band(v, 0xFFF), tpz.objType.MOB):setMobLevel(instance:getEntity(bit.band(v, 0xFFF), tpz.objType.MOB):getMainLvl() - cap)
            end
        end
    end
end

-- -------------------------------------------------------------------
-- onAssaultFailure(instance, CSID, textTable)
-- Notifies players that the assault has failed
-- -------------------------------------------------------------------
function onAssaultFailure(instance, CSID, textTable)
    local chars = instance:getChars()
    local mobs = instance:getMobs()

    for _,v in pairs(mobs) do
        local mobID = v:getID()
        DespawnMob(mobID, instance)
    end

    for _,v in pairs(chars) do
        v:messageSpecial(textTable.MISSION_FAILED, 10, 10)
        v:startEvent(CSID)
    end
end

-- -------------------------------------------------------------------
-- onAssaultComplete( instance, X, Z, textTable, npcTable)
-- Annonce to players that Rune of Release has appeared at a position
-- -------------------------------------------------------------------
function onAssaultComplete(instance, X, Z, textTable, npcTable)
    local chars = instance:getChars()

    for _,v in pairs(chars) do
        if v:getLocalVar("AssaultCompletedMessage") ~= 1 then
            v:messageSpecial(textTable.RUNE_UNLOCKED_POS, X, Z)
            v:setLocalVar("AssaultCompletedMessage", 1)
            v:clearTrusts()
            v:resetRecasts()
        end
    end

    instance:getEntity(bit.band(npcTable.RUNE_OF_RELEASE, 0xFFF), tpz.objType.NPC):setStatus(tpz.status.NORMAL)
    instance:getEntity(bit.band(npcTable.ANCIENT_LOCKBOX, 0xFFF), tpz.objType.NPC):setStatus(tpz.status.NORMAL)
end

-- -------------------------------------------------------------------
-- assaultOnEventFinish(player, csid, endCS, ZONE)
-- Teleport party members out of assault when assault is win
-- -------------------------------------------------------------------
function assaultOnEventFinish(player, csid, endCS, ZONE)
    if csid == endCS then
        local instance = player:getInstance()
        local chars = instance:getChars()
        if csid == endCS then
            for _,v in pairs(chars) do
                v:setPos(0,0,0,0,ZONE)
            end
        end
    end
end

-- -------------------------------------------------------------------
-- onEventFinishExitRune(player, csid, option,LEBROS_ASSASSAULT_POINTAULT_POINT, textTable, ZONE)
-- Teleport party members out of assault when assault is win
-- -------------------------------------------------------------------
function onEventFinishExitRune(player, csid, option, ASSAULT_POINT, textTable, ZONE)
    if csid == 100 and option == 1 then
        runeReleaseFinish(player, ASSAULT_POINT, textTable)
    elseif csid == 102 then
        local instance = player:getInstance()
        local chars = instance:getChars()
        for _, v in pairs(chars) do
            v:delKeyItem(1870) -- MAP_OF_PERIQIA
            v:delKeyItem(1869) -- MAP_OF_ILRUSI_ATOLL
            v:delKeyItem(1866) -- MAP_OF_LEUJAOAM_SANCTUM
            v:delKeyItem(1868) -- MAP_OF_LEBROS_CAVERN
            v:delKeyItem(1867) -- MAP_OF_THE_TRAINING_GROUNDS
            v:setPos(0, 0, 0, 0, ZONE)
        end
    end
end

-- -------------------------------------------------------------------
-- runeReleaseFinish(player, ASSAULT_POINT, textTable)
-- Set assault points win for each party members when assault is win
-- -------------------------------------------------------------------
function runeReleaseFinish(player, ASSAULT_POINT, textTable)
    local instance = player:getInstance()
    local chars = instance:getChars()
    local id = instance:getID()
    local playerpoints = math.max((#chars -3)*.1, 0)
    local points = 0
    local assaultID = player:getCurrentAssault()
    local mobs = instance:getMobs()

    for _,v in pairs(mobs) do
        local mobID = v:getID()
        DespawnMob(mobID, instance)
    end

    for _,v in pairs(chars) do
        if v:getLocalVar("AssaultPointsAwarded") == 0 then
            v:setLocalVar("AssaultPointsAwarded", 1)

            local pointModifier = assaultUtil.missionInfo[assaultID].minimumPoints
            points = pointModifier - (pointModifier * playerpoints)
            if v:getCharVar("Assault_Armband") == 1 then
                points = points*(1.1)
            end
            if v:hasCompletedAssault(v:getCurrentAssault()) then
                points = math.floor(points)
                v:setCharVar("AssaultPromotion", v:getCharVar("AssaultPromotion") +1)
                v:addAssaultPoint(ASSAULT_POINT, points)
            else
                points = math.floor(points*(1.5))
                v:setCharVar("AssaultPromotion", v:getCharVar("AssaultPromotion") +1)
                v:addAssaultPoint(ASSAULT_POINT, points)
            end
            v:clearTrusts()
            v:messageSpecial(textTable.ASSAULT_POINTS_OBTAINED, points)
            v:setCharVar("AssaultComplete",1)
            v:startEvent(102)
        end
    end
end

-- -------------------------------------------------------------------
-- onTriggerExitRune(player, npc)
-- Check Rune of Release and check if assaut is completed
-- -------------------------------------------------------------------
function onTriggerExitRune(player, npc, option)
    local instance = npc:getInstance()
    if (instance:completed()) then
        player:startEvent(100, option)
    end
    return 1
end

function adjustMobLevel(mob, mobID)
    local instance = mob:getInstance()
    local cap = instance:getLevelCap()

    if cap == 70 then
        cap = 5
    elseif cap == 60 then
        cap = 15
    elseif cap == 50 then
        cap = 25
    end
    instance:getEntity(bit.band(mobID, 0xFFF), tpz.objType.MOB):setMobLevel(instance:getEntity(bit.band(mobID, 0xFFF), tpz.objType.MOB):getMainLvl() - cap)
end

-- -------------------------------------------------------------------
-- assaultChestTrigger(player, npc, qItemTable, regItemTable, textTable)
-- Add box items in treasure and box ??? items to player who open the box
-- -------------------------------------------------------------------
function assaultChestTrigger(player, npc, qItemTable, regItemTable, textTable)
    local instance = player:getInstance()
    local chars = instance:getChars()
    local area = player:getCurrentAssault()

    if instance:completed() and npc:getLocalVar("open") == 0 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(textTable.ITEM_CANNOT_BE_OBTAINED + 1)
        else
            npc:entityAnimationPacket("open")
            npc:setLocalVar("open", 1)
            npc:timer(15000, function(npc) npc:entityAnimationPacket("kesu") end)
            npc:timer(16000, function(npc) npc:setStatus(tpz.status.DISAPPEAR) end)
            if canGetQuestionMarkItem(player, instance, area) then
                for i = 1, #qItemTable, 1 do
                    local lootGroup = qItemTable[i]
                    if lootGroup then
                        local max = 0
                        for _, entry in pairs(lootGroup) do
                            max = max + entry.droprate
                        end
                        local roll = math.random(max)
                        for _, entry in pairs(lootGroup) do
                            max = max - entry.droprate
                            if roll > max then
                                if entry.itemid > 0 then
                                    player:addItem({id = entry.itemid, appraisal = area})
                                    for _, v in pairs(chars) do
                                        v:messageName(textTable.PLAYER_OBTAINS_ITEM, player, entry.itemid)
                                    end
                                end
                                break
                            end
                        end
                    end
                end
            end
            for i = 1, #regItemTable, 1 do
                local lootGroup = regItemTable[i]
                if lootGroup then
                    local max = 0
                    for _, entry in pairs(lootGroup) do
                        max = max + entry.droprate
                    end
                    local roll = math.random(max)
                    for _, entry in pairs(lootGroup) do
                        max = max - entry.droprate
                        if roll > max then
                            if entry.itemid ~= 0 then
                                player:addTreasure(entry.itemid, npc)
                            end
                        end
                        break
                    end
                end
            end
        end
    end
end

-- -------------------------------------------------------------------
-- spawnMobInAssault(instance, mobTable)
-- Spawn the mob of the assault
-- -------------------------------------------------------------------
function spawnMobInAssault(instance, mobTable)
    local assaultID = instance:getID()

    for _, v in pairs(mobTable[assaultID].MOBS_START) do
        SpawnMob(v, instance)
    end
end

function SetExcavationDutyMods(mob)
    if mob:getFamily() == 922 then -- Goblins
        mob:setDamage(140)
    else -- Trolls
        mob:setDamage(50)
    end
end
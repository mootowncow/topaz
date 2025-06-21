-----------------------------------
-- Magian Trial Global
-- !gotoid 17772782
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require('scripts/globals/magian_data')
require('scripts/globals/npc_util')
-----------------------------------
tpz = tpz or {}
tpz.magian = tpz.magian or {}

local magianMoogleInfo =
{
    ['Magian_Moogle_Blue']   = {   nil, 10141, 10142, 10143, 10144, 10148, tpz.itemType.ARMOR  },
    ['Magian_Moogle_Orange'] = { 10121, 10122, 10123, 10124, 10125, 10129, tpz.itemType.WEAPON },
}

tpz.magian.moogle =
{
    BLUE    = 17772782,
    ORANGE  = 17772778,
    GREEN   = 17772784,
}

-- Builds the table of what trials to add when trading an item + starter item
tpz.magian.onGameIn = function()
    tpz.magian.startableTrials = {}
    tpz.magian.trialDataById = {}

    for trialNumber, trial in pairs(tpz.magian.trials) do
        -- Map trial number to trial data
        tpz.magian.trialDataById[trialNumber] = trial

        -- Build startableTrials for Items trials
        if trial.mainItem and trial.tradeItem and trial.tradeItem ~= tpz.items.NONE and trial.type == 'Items' then
            tpz.magian.startableTrials[trial.mainItem] = tpz.magian.startableTrials[trial.mainItem] or {}
            tpz.magian.startableTrials[trial.mainItem][trial.tradeItem] = trialNumber
        end

        -- Build startableTrials for Kills trials (no trade item)
        if trial.mainItem and trial.type == 'Kills' then
            tpz.magian.startableTrials[trial.mainItem] = tpz.magian.startableTrials[trial.mainItem] or {}
            tpz.magian.startableTrials[trial.mainItem][0] = trialNumber
        end
    end
end

tpz.magian.magianOnTrigger = function(player, npc, trade)
    local npc        = player:getEventTarget()
    local moogleData = magianMoogleInfo[npc:getName()]
    local moogle = npc:getName()

    if
        moogleData[1] and
        player:getMainLvl() < 75
    then
        player:startEvent(moogleData[1])
    elseif not player:hasKeyItem(tpz.ki.MAGIAN_TRIAL_LOG) then
        player:startEvent(moogleData[2])
    else
        if (moogle == 'Magian_Moogle_Blue') then
            player:startEvent(10142, 0, 0, 0, 0, 0, 13146543, 4095, 0)
        elseif (moogle == 'Magian_Moogle_Orange') then
            player:startEvent(10123, 0, 0, 0, 0, 0, 13146543, 4095, 0)
        end
    end
end

tpz.magian.magianEventUpdate = function(player, csid, option)
end

tpz.magian.magianOnEventFinish = function(player, csid, option)
    local npc        = player:getEventTarget()
    local moogleData = magianMoogleInfo[npc:getName()]
    local finishType = bit.band(option, 0xFF)

    if
        csid == moogleData[2] and
        option == 1
    then
        npcUtil.giveKeyItem(player, tpz.ki.MAGIAN_TRIAL_LOG)
    else
        -- TODO: ???
    end
end

tpz.magian.magianOnTrade = function(player, npc, trade)
    if not player:hasKeyItem(tpz.ki.MAGIAN_TRIAL_LOG) then
        return
    end

    if trade:getSlotCount() == 0 then
        player:messageSpecial(ID.text.FULL_INVENTORY_AFTER_TRADE)
        return
    end

    local tradedItem = trade:getItem()
    if not tradedItem then return end

    local mainItemId = tradedItem:getID()
    local currentTrial = tradedItem:getTrialNumber()

    -- Check if starting a new Items trial
    if tpz.magian.startableTrials[mainItemId] then
        for tradeItemId, trialNumber in pairs(tpz.magian.startableTrials[mainItemId]) do
            local trial = tpz.magian.trials[trialNumber]
            if trial and trial.type == 'Items' then
                if npcUtil.tradeHas(trade, {mainItemId, tradeItemId}) and (currentTrial == 0) then
                    player:confirmTrade()
                    player:addItem(mainItemId, 1, 0, 0, 0, 0, 0, 0, 0, 0, trialNumber)
                    player:messageSpecial(ID.text.MAGIAN_TRIAL_STARTED, tpz.ki.MAGIAN_TRIAL_LOG)
                    player:setCharVar("MagianTrial_" .. trialNumber, tpz.magian.TRIAL_ACCEPTED)
                    return
                end
            end
        end
    end

    -- Check if starting a new Kills trial (weapon only)
    if tpz.magian.startableTrials[mainItemId] then
        for tradeItemId, trialNumber in pairs(tpz.magian.startableTrials[mainItemId]) do
            local trial = tpz.magian.trials[trialNumber]
            if trial and trial.type == 'Kills' then
                if npcUtil.tradeHas(trade, {mainItemId}) and (currentTrial == 0) then
                    player:confirmTrade()
                    player:addItem(mainItemId, 1, 0, 0, 0, 0, 0, 0, 0, 0, trialNumber)
                    player:messageSpecial(ID.text.MAGIAN_TRIAL_STARTED, tpz.ki.MAGIAN_TRIAL_LOG)
                    player:setCharVar("MagianTrial_" .. trialNumber, tpz.magian.TRIAL_ACCEPTED)
                    return
                end
            end
        end
    end

    -- If item has an active trial, attempt to process it
    if currentTrial > 0 then
        local trial = tpz.magian.trialDataById[currentTrial]
        if trial then
            local handler = magianTrials[trial.type]
            local callWrapper = magianTrials.Call[trial.type]
            if handler and callWrapper then
                local handled = callWrapper(handler, player, npc, trade, trial, currentTrial)
                if handled then return end
            end
        end
    end

    -- Fallback message
    if (currentTrial == 0) then
        player:messageSpecial(ID.text.MAGIAN_NO_TRIAL)
    else
        player:messageSpecial(ID.text.MAGIAN_TRIAL_ACTIVE)
    end
end

tpz.magian.IsValidReward = function(player, npc, trade, rewardItem)
    if IsRareItem(rewardItem) then
        if player:hasItem(rewardItem) then
            return false
        end
    end

    return true
end

tpz.magian.checkMagianTrial = function (player, mob)
    printf("[Magian] Checking Magian Trials for player %s", player:getName())

    local activeTrials = tpz.magian.getActiveMagianTrials(player)
    printf("[Magian] Found %d active trial(s)", table.getn(activeTrials))

    for trialNum, data in pairs(activeTrials) do
        printf("[Magian] Checking trial %d (itemId: %d in slot %d)", trialNum, data.itemId, data.slot)
        local trial = tpz.magian.trialDataById[trialNum]
        if trial and trial.type == 'Kills' then
            printf("[Magian] Trial %d is a Kills trial of type %s", trialNum, trial.killType)

            if trial.killType == 'Family' then
                local mobFamily = mob:getFamily()
                printf("[Magian] Mob family: %d. Trial requires families: %s", mobFamily, table.concat(trial.mob, ", "))

                for _, familyId in ipairs(trial.mob) do
                    if mobFamily == familyId then
                        -- Increment progress
                        local kills = player:getCharVar("MagianKills_" .. trialNum)
                        kills = kills + 1
                        local remainingKills = trial.numRequired - kills
                        player:setCharVar("MagianKills_" .. trialNum, kills)

                        printf("[Magian] Incremented kills for trial %d to %d", trialNum, kills)

                        -- Check for completion
                        if (kills >= trial.numRequired) then
                            player:messageCombat(player, trialNum, 0, tpz.msg.combat.MAGIAN_TRIAL_COMPLETE)
                            player:setCharVar("MagianTrial_" .. trialNum, tpz.magian.TRIAL_COMPLETED)
                        else
                            player:messageCombat(player, trialNum, remainingKills, tpz.msg.combat.MAGIAN_TRIAL_PROGRESS)
                        end
                        break
                    end
                end
            end
        end
    end
end

tpz.magian.getActiveMagianTrials = function(player)
    local activeTrials = {}

    for slot = tpz.slot.MAIN, tpz.slot.BACK do
        local itemInstance = player:getEquippedItem(slot)
        if itemInstance then
            local itemId = itemInstance:getID()
            local trialNum = itemInstance:getTrialNumber()

            printf("[Magian] Slot %d has itemId: %d with trial number: %d", slot, itemId, trialNum)

            if trialNum and trialNum > 0 then
                activeTrials[trialNum] = {
                    slot = slot,
                    itemId = itemId
                }
            end
        else
            printf("[Magian] Slot %d is empty.", slot)
        end
    end

    return activeTrials
end


magianTrials = {}
magianTrials.Items = function(player, npc, trade, trial, trialNumber)
    if npcUtil.tradeHas(trade, {{trial.tradeItem, trial.numRequired -1}}) then -- -1 because it takes 1 to start the trial

        -- Previous trial check
        if trial.previousTrial > 0 and (player:getCharVar("MagianTrial_"..trial.previousTrial) ~= tpz.magian.TRIAL_COMPLETED) then
            player:PrintToPlayer("You have not completed the previous trial, kupo!", 0, "Magian Moogle")
            return true
        end

        if tpz.magian.IsValidReward(player, npc, trade, trial.rewardItem.itemId) then
            local flatAugments = {}
            for _, augPair in ipairs(trial.rewardItem.itemAugments) do
                for _, val in ipairs(augPair) do
                    table.insert(flatAugments, val)
                end
            end

            player:confirmTrade()
            player:addItem(trial.rewardItem.itemId, 1, unpack(flatAugments))
            player:setCharVar("MagianTrial_" .. trialNumber, tpz.magian.TRIAL_COMPLETED)
            player:messageSpecial(ID.text.MAGIAN_TRIAL_COMPLETE, trial.rewardItem.itemId)
            player:messageSpecial(ID.text.ITEM_OBTAINED, trial.rewardItem.itemId)
        else
            player:messageSpecial(ID.text.MAGIAN_ALREADY_HAVE_ITEM, trial.rewardItem.itemId)
        end
        return true
    end

    return false
end

magianTrials.Kills = function(player, npc, trade, trial, trialNumber)
    -- Previous trial check
    if trial.previousTrial > 0 and (player:getCharVar("MagianTrial_"..trial.previousTrial) ~= tpz.magian.TRIAL_COMPLETED) then
        player:PrintToPlayer("You have not completed the previous trial, kupo!", 0, "Magian Moogle")
        return true
    end

    -- Check active trial
    if npcUtil.tradeHas(trade, { trial.mainItem }) then
        local killsDone = player:getCharVar("MagianKills_" .. trialNumber)
        if (killsDone >= trial.numRequired) then
            if tpz.magian.IsValidReward(player, npc, trade, trial.rewardItem.itemId) then
                local flatAugments = {}
                for _, augPair in ipairs(trial.rewardItem.itemAugments) do
                    for _, val in ipairs(augPair) do
                        table.insert(flatAugments, val)
                    end
                end

                player:confirmTrade()
                player:addItem(trial.rewardItem.itemId, 1, unpack(flatAugments))
                player:setCharVar("MagianTrial_" .. trialNumber, tpz.magian.TRIAL_COMPLETED)
                player:setCharVar("MagianKills_" .. trialNumber, 0)
                player:messageSpecial(ID.text.MAGIAN_TRIAL_COMPLETE, trial.rewardItem.itemId)
                player:messageSpecial(ID.text.ITEM_OBTAINED, trial.rewardItem.itemId)
            else
                player:messageSpecial(ID.text.MAGIAN_ALREADY_HAVE_ITEM, trial.rewardItem.itemId)
            end
            return true
        end
    end
    return false
end

magianTrials.Call = {
    Items = function(handler, player, npc, trade, trial, trialNumber)
        return handler(player, npc, trade, trial, trialNumber)
    end,
    Kills = function(handler, player, npc, trade, trial, trialNumber)
        return handler(player, npc, trade, trial, trialNumber)
    end,
}


-- TODO: Tracking kill progress function
-- TODO: Progress messages on kills
-- MAGIAN_TRIAL_PROGRESS = 583, -- Trial <id>: <number> objectives remain.
-- MAGIAN_TRIAL_COMPLETE = 584, -- You have completed Trial <id>. Report your success to a Magian Moogle.

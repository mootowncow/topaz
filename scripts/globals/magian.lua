-----------------------------------
-- Magian Trial Global
-- !gotoid 17772782
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/spell_data")
require("scripts/globals/status")
require("scripts/globals/magian_data")
require("scripts/globals/npc_util")
require("scripts/globals/world")
require("scripts/globals/item_utils")
-----------------------------------
-- TODO: Make weather into functions so you can just call "wind" and itll do both winds (Do in world.lua?)
-- TODO: Make sure trials are kill shared for allies in range
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

local trialListeners =
{
    ['WSUse'] = function(player, trialNum, trial)
        player:addListener("WEAPONSKILL_USE", "MAGIAN_USE_WS_"..trialNum, function(player, target, wsId)
            printf("WS use")
            local points = tpz.magian.evaluateTrialConditions(player, target, trial, wsId)
            if points > 0 then
                tpz.magian.addTrialPoints(player, trialNum, trial, points)
            end
        end)
    end,

    ['WSDamage'] = function(player, trialNum, trial)
        printf("Adding WS dmg listener")
        player:addListener("WS_DMG_DONE", "MAGIAN_WS_DMG_DONE_"..trialNum, function(player, target, damage, wsId)
            printf("ws dmg")
            local points = tpz.magian.evaluateTrialConditions(player, target, trial, wsId, damage)
            if points > 0 then
                tpz.magian.addTrialPoints(player, trialNum, trial, points)
            end
        end)
    end,

    ['ExperiencePoints'] = function(player, trialNum, trial)
        player:addListener("EXPERIENCE_POINTS", "MAGIAN_GAIN_EXP_"..trialNum, function(player, exp)
            local points = tpz.magian.evaluateTrialConditions(player, nil, trial)
            if points > 0 then
                tpz.magian.addTrialPoints(player, trialNum, trial, exp) -- or some conversion if applicable
            end
        end)
    end,
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

        -- Build a startableTrials for all other trials
        local startableTypes = { Kills = true, Effect = true, Special = true, }

        if trial.mainItem and startableTypes[trial.type] and trial.previousTrial == 0 then
            tpz.magian.startableTrials[trial.mainItem] = tpz.magian.startableTrials[trial.mainItem] or {}
            tpz.magian.startableTrials[trial.mainItem][0] = trialNumber
        end
    end
end

tpz.magian.registerListeners = function(player)
    local activeTrials = tpz.magian.getActiveMagianTrials(player)
    printf("Registering magian listeners")
    for trialNum, data in pairs(activeTrials) do
        local trial = tpz.magian.trialDataById[trialNum]
        if trial and (trial.type == 'Special') then
            local listeners = trialListeners[trial.specialType]
            if listeners then
                listeners(player, trialNum, trial)
            end
        end
    end
end

tpz.magian.magianOnTrigger = function(player, npc, trade)
    local npc        = player:getEventTarget()
    local moogleData = magianMoogleInfo[npc:getName()]
    local moogle     = npc:getName()

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
    printf("[Magian] onTrade called for player %s", player:getName())

    if not player:hasKeyItem(tpz.ki.MAGIAN_TRIAL_LOG) then
        printf("[Magian] Player missing Magian Trial Log KI.")
        return
    end

    if trade:getSlotCount() == 0 then
        player:messageSpecial(ID.text.FULL_INVENTORY_AFTER_TRADE)
        printf("[Magian] Trade had no slots.")
        return
    end

    local tradedItem = trade:getItem()
    if not tradedItem then
        printf("[Magian] No traded item found.")
        return
    end

    local mainItemId = tradedItem:getID()
    local currentTrial = tradedItem:getTrialNumber()
    printf("[Magian] Item ID: %d, Trial Number: %d", mainItemId, currentTrial)

    -- Check if starting a new Items trial
    if tpz.magian.startableTrials[mainItemId] then
        for tradeItemId, trialNumber in pairs(tpz.magian.startableTrials[mainItemId]) do
            local trial = tpz.magian.trials[trialNumber]
            printf("[Magian] Checking startable Items trial %d for mainItemId %d", trialNumber, mainItemId)

            if trial and trial.type == 'Items' then
                -- Previous trial check
                if trial.previousTrial > 0 and (player:getCharVar("MagianTrial_" .. trial.previousTrial) ~= tpz.magian.TRIAL_COMPLETED) then
                    printf("[Magian] Previous trial %d not complete.", trial.previousTrial)
                    player:PrintToPlayer("You have not completed the previous trial, kupo!", 0, "Magian Moogle")
                    return true
                end

                -- Already completed trial check
                if player:getCharVar("MagianTrial_" .. trialNumber) == tpz.magian.TRIAL_COMPLETED then
                    printf("[Magian] Trial %d already completed, skipping.", trialNumber)
                    goto continueItemTrialLoop
                end

                if npcUtil.tradeHas(trade, {mainItemId, tradeItemId}) and (currentTrial == 0) then
                    printf("[Magian] Starting Items trial %d", trialNumber)
                    player:confirmTrade()
                    player:addItem(mainItemId, 1, 0, 0, 0, 0, 0, 0, 0, 0, trialNumber)
                    player:messageSpecial(ID.text.MAGIAN_TRIAL_STARTED, tpz.ki.MAGIAN_TRIAL_LOG)
                    player:setCharVar("MagianTrial_" .. trialNumber, tpz.magian.TRIAL_ACCEPTED)
                    return
                end
            end
            ::continueItemTrialLoop::
        end
    end

    -- Check if starting a new Kills or Effect trial
    if tpz.magian.startableTrials[mainItemId] then
        for tradeItemId, trialNumber in pairs(tpz.magian.startableTrials[mainItemId]) do
            local trial = tpz.magian.trials[trialNumber]
            printf("[Magian] Checking startable trial %d for mainItemId %d", trialNumber, mainItemId)

            -- Supported trial types to start
            if trial and (trial.type == 'Kills' or trial.type == 'Effect' or trial.type == 'Special') then
                -- Previous trial check
                if trial.previousTrial > 0 and (player:getCharVar("MagianTrial_" .. trial.previousTrial) ~= tpz.magian.TRIAL_COMPLETED) then
                    printf("[Magian] Previous trial %d not complete.", trial.previousTrial)
                    player:PrintToPlayer("You have not completed the previous trial, kupo!", 0, "Magian Moogle")
                    return true
                end

                -- Already completed trial check
                if player:getCharVar("MagianTrial_" .. trialNumber) == tpz.magian.TRIAL_COMPLETED then
                    printf("[Magian] Trial %d already completed, skipping.", trialNumber)
                    goto continueTrialLoop
                end

                -- Confirm correct trade item (main item only, no trade item for Kills/Effect trials)
                if npcUtil.tradeHas(trade, {mainItemId}) and (currentTrial == 0) then
                    printf("[Magian] Starting trial %d of type %s", trialNumber, trial.type)
                    player:confirmTrade()
                    player:addItem(mainItemId, 1, 0, 0, 0, 0, 0, 0, 0, 0, trialNumber)
                    player:messageSpecial(ID.text.MAGIAN_TRIAL_STARTED, tpz.ki.MAGIAN_TRIAL_LOG)
                    player:setCharVar("MagianTrial_" .. trialNumber, tpz.magian.TRIAL_ACCEPTED)
                    return
                end
            end
            ::continueTrialLoop::
        end
    end

    -- Now, separately check for follow-up eligible Kills, Effect or special trials that are not in startableTrials
    for trialNumber, trial in pairs(tpz.magian.trials) do
        if trial.mainItem == mainItemId and (trial.type == 'Kills' or trial.type == 'Effect' or trial.type == 'Special') then
            if trial.previousTrial > 0 and player:getCharVar("MagianTrial_" .. trial.previousTrial) == tpz.magian.TRIAL_COMPLETED then
                if player:getCharVar("MagianTrial_" .. trialNumber) ~= tpz.magian.TRIAL_COMPLETED then
                    printf("[Magian] Eligible for next trial %d after %d", trialNumber, trial.previousTrial)
                    if npcUtil.tradeHas(trade, {mainItemId}) and (currentTrial == 0) then
                        printf("[Magian] Starting follow-up %s trial %d", trial.type, trialNumber)
                        local tradedItem = trade:getItem()
                        local augments = tpz.itemUtils.GetItemAugments(tradedItem)

                        local augTable = {}
                        for i = 0, 4 do
                            augTable[i+1] = {id=0, value=0}
                        end
                        for _, aug in ipairs(augments) do
                            augTable[aug.slot + 1] = {id = aug.id, value = aug.value}
                        end

                        local addItemArgs = tpz.itemUtils.BuildAddItemArgs(augTable, trialNumber)
                        printf("[AddItemArgs] %s", table.concat(addItemArgs, ", "))

                        player:confirmTrade()
                        player:addItem(mainItemId, 1, unpack(addItemArgs))
                        player:messageSpecial(ID.text.MAGIAN_TRIAL_STARTED, tpz.ki.MAGIAN_TRIAL_LOG)
                        player:setCharVar("MagianTrial_" .. trialNumber, tpz.magian.TRIAL_ACCEPTED)
                        return
                    end
                end
            end
        end
    end

    -- If item has an active trial, attempt to process it
    if currentTrial > 0 then
        printf("[Magian] Processing existing trial %d", currentTrial)
        local trial = tpz.magian.trialDataById[currentTrial]
        if trial then
            local handler = magianTrials[trial.type]
            local callWrapper = magianTrials.Call[trial.type]
            if handler and callWrapper then
                printf("[Magian] Found handler for trial type %s", trial.type)
                local handled = callWrapper(handler, player, npc, trade, trial, currentTrial)
                if handled then
                    printf("[Magian] Trial %d handled successfully.", currentTrial)
                    return
                end
            end
        end
    end

    -- Fallback messages
    if (currentTrial == 0) then
        printf("[Magian] No trial found on item.")
        player:messageSpecial(ID.text.MAGIAN_NO_TRIAL)
    else
        printf("[Magian] Trial %d is still active.", currentTrial)
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

-- Kill trials
tpz.magian.checkMagianTrial = function (player, mob, isKiller, isWeaponSkillKill)
    printf("[Magian] Checking Magian Trials for player %s", player:getName())

    local activeTrials = tpz.magian.getActiveMagianTrials(player)
    printf("[Magian] Found %d active trial(s)", table.getn(activeTrials))

    if player:checkKillCredit(mob) then
        for trialNum, data in pairs(activeTrials) do
            printf("[Magian] Checking trial %d (itemId: %d in slot %d)", trialNum, data.itemId, data.slot)
            local trial = tpz.magian.trialDataById[trialNum]
            if trial and (trial.type == 'Kills') then
                printf("[Magian] Trial %d is a Kills trial of type %s", trialNum, trial.subType)

                local points = tpz.magian.evaluateTrialConditions(player, mob, trial)
                if points > 0 then
                    tpz.magian.addTrialPoints(player, trialNum, trial, points)
                end
            end
        end
    end
end

tpz.magian.checkMagianTrialEffects = function(player, mob, effect)
    printf("[Magian] Checking Magian Trials for player %s", player:getName())

    local activeTrials = tpz.magian.getActiveMagianTrials(player)
    printf("[Magian] Found %d active trial(s)", table.getn(activeTrials))

    if player:checkKillCredit(mob) then
        for trialNum, data in pairs(activeTrials) do
            printf("[Magian] Checking trial %d (itemId: %d in slot %d)", trialNum, data.itemId, data.slot)
            local trial = tpz.magian.trialDataById[trialNum]
            if trial and (trial.type == 'Effect') then
                tpz.magian.processTrialEffect(player, trialNum, trial, effect, trial.effect)
            end
        end
    end
end

tpz.magian.addTrialPoints = function(player, trialNum, trial, points)
    local current = player:getCharVar("MagianKills_" .. trialNum) + points
    local remaining = trial.numRequired - current

    player:setCharVar("MagianKills_" .. trialNum, current)

    printf("[Magian] Added %d point(s) to trial %d (now %d/%d)", points, trialNum, current, trial.numRequired)

    if current >= trial.numRequired then
        player:messageCombat(player, trialNum, 0, tpz.msg.combat.MAGIAN_TRIAL_COMPLETE)
        player:setCharVar("MagianTrial_" .. trialNum, tpz.magian.TRIAL_COMPLETED)
    else
        player:messageCombat(player, trialNum, remaining, tpz.msg.combat.MAGIAN_TRIAL_PROGRESS)
    end
end

tpz.magian.evaluateTrialConditions = function(player, mob, trial, skillId, damage)
    local points = 0

    -- If a mob is required, but none provided (like EXP without kill criteria), bail
    if (trial.mob or trial.species or trial.element or trial.ws or trial.effect) and not mob then
        return 0
    end

    -- Dispatch table for eligibility checks
    local eligibilityChecks = {
        ['Family'] = function(player, mob, trial)
            for _, familyId in ipairs(trial.mob or {}) do
                if familyId == mob:getFamily() then return true end
            end
        end,

        ['Pool'] = function(player, mob, trial)
            for _, poolId in ipairs(trial.mob or {}) do
                if poolId == mob:getPool() then return true end
            end
        end,

        ['Species'] = function(player, mob, trial)
            for _, speciesId in ipairs(trial.species or {}) do
                if speciesId == mob:getSystem() then return true end
            end
        end,

        ['Elemental'] = function(player, mob, trial)
            return (mob:getLocalVar("ElementKilledBy") - 5) == trial.element
        end,

        ['WSKill'] = function(player, mob, trial)
            return mob:getLocalVar("WSKilledBy") == trial.ws
        end,

        ['StatusEffect'] = function(player, mob, trial)
            return mob:hasStatusEffect(trial.effect)
        end,

        ['Zone'] = function(player, mob, trial)
            for _, zoneId in ipairs(trial.zone or {}) do
                if zoneId == player:getZoneID() then return true end
            end
        end,

        ['WSDamage'] = function(player, mob, trial, skillId, damage)
            for _, expectedWsId in ipairs(trial.wsId or {}) do
                if expectedWsId == skillId and damage and damage > trial.wsDmg then return true end
            end
        end,

        ['WSUse'] = function(player, mob, trial, skillId, damage)
            for _, expectedWsId in ipairs(trial.wsId or {}) do
                if expectedWsId == skillId then return true end
            end
        end,

        ['ExperiencePoints'] = function(player, mob, trial)
            -- If you're getting EXP, and trial allows it, it's always eligible
            return true
        end,
    }

    -- If trial has a subType or specialType, check it
    if trial.subType then
        local checkFunc = eligibilityChecks[trial.subType]
        if not checkFunc or not checkFunc(player, mob, trial, skillId, damage) then
            return 0
        end
    end

    if trial.specialType then
        local checkFunc = eligibilityChecks[trial.specialType]
        if not checkFunc or not checkFunc(player, mob, trial, skillId, damage) then
            return 0
        end
    end

    -- Day/weather conditions
    local isDayWeatherTrial = (trial.weather or trial.day)
    if isDayWeatherTrial then
        -- Weather (+5)
        if trial.weather then
            local currentWeather = player:getWeather(true)
            for _, w in ipairs(trial.weather) do
                if w == currentWeather then
                    points = points + 5
                    break
                end
            end
        end

        -- Day (+1)
        if trial.day and VanadielDayOfTheWeek() == trial.day then
            points = points + 1
        end

        -- If no points awarded by day/weather, exit
        if points == 0 then
            return 0
        end
    else
        -- No day/weather restrictions = 1 point
        points = 1
    end

    return points
end

tpz.magian.processTrialEffect = function(player, trialNum, trial, checkValue, expectedValue)
    if (checkValue == expectedValue) then
        local effects = player:getCharVar("MagianEffects_" .. trialNum) + 1
        local remainingEffects = trial.numRequired - effects
        player:setCharVar("MagianEffects_" .. trialNum, effects)

        printf("[Magian] Incremented effect for trial %d to %d", trialNum, effects)

        if (effects >= trial.numRequired) then
            player:messageCombat(player, trialNum, 0, tpz.msg.combat.MAGIAN_TRIAL_COMPLETE)
            player:setCharVar("MagianTrial_" .. trialNum, tpz.magian.TRIAL_COMPLETED)
        else
            player:messageCombat(player, trialNum, remainingEffects, tpz.msg.combat.MAGIAN_TRIAL_PROGRESS)
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
            -- printf("[Magian] Slot %d is empty.", slot)
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
    printf("[Magian] Processing Kills trial %d", trialNumber)

    if trial.previousTrial > 0 and (player:getCharVar("MagianTrial_" .. trial.previousTrial) ~= tpz.magian.TRIAL_COMPLETED) then
        printf("[Magian] Previous trial %d not complete.", trial.previousTrial)
        player:PrintToPlayer("You have not completed the previous trial, kupo!", 0, "Magian Moogle")
        return true
    end

    if npcUtil.tradeHas(trade, { trial.mainItem }) then
        local killsDone = player:getCharVar("MagianKills_" .. trialNumber)
        printf("[Magian] Player has %d/%d kills.", killsDone, trial.numRequired)

        if killsDone >= trial.numRequired then
            if tpz.magian.IsValidReward(player, npc, trade, trial.rewardItem.itemId) then
                printf("[Magian] Player eligible for reward %d", trial.rewardItem.itemId)
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
                printf("[Magian] Player already has reward %d", trial.rewardItem.itemId)
                player:messageSpecial(ID.text.MAGIAN_ALREADY_HAVE_ITEM, trial.rewardItem.itemId)
            end
            return true
        else
            printf("[Magian] Not enough kills for trial %d", trialNumber)
        end
    end

    return false
end

magianTrials.Effect = function(player, npc, trade, trial, trialNumber)
    printf("[Magian] Processing Effect trial %d", trialNumber)

    if trial.previousTrial > 0 and (player:getCharVar("MagianTrial_" .. trial.previousTrial) ~= tpz.magian.TRIAL_COMPLETED) then
        printf("[Magian] Previous trial %d not complete.", trial.previousTrial)
        player:PrintToPlayer("You have not completed the previous trial, kupo!", 0, "Magian Moogle")
        return true
    end

    if npcUtil.tradeHas(trade, { trial.mainItem }) then
        local effects = player:getCharVar("MagianEffects_" .. trialNumber)
        printf("[Magian] Player has %d/%d effects landed.", effects, trial.numRequired)

        if effects >= trial.numRequired then
            if tpz.magian.IsValidReward(player, npc, trade, trial.rewardItem.itemId) then
                printf("[Magian] Player eligible for reward %d", trial.rewardItem.itemId)
                local flatAugments = {}
                for _, augPair in ipairs(trial.rewardItem.itemAugments) do
                    for _, val in ipairs(augPair) do
                        table.insert(flatAugments, val)
                    end
                end

                player:confirmTrade()
                player:addItem(trial.rewardItem.itemId, 1, unpack(flatAugments))
                player:setCharVar("MagianTrial_" .. trialNumber, tpz.magian.TRIAL_COMPLETED)
                player:setCharVar("MagianEffects_" .. trialNumber, 0)
                player:messageSpecial(ID.text.MAGIAN_TRIAL_COMPLETE, trial.rewardItem.itemId)
                player:messageSpecial(ID.text.ITEM_OBTAINED, trial.rewardItem.itemId)
            else
                printf("[Magian] Player already has reward %d", trial.rewardItem.itemId)
                player:messageSpecial(ID.text.MAGIAN_ALREADY_HAVE_ITEM, trial.rewardItem.itemId)
            end
            return true
        else
            printf("[Magian] Not enough effect procs for trial %d", trialNumber)
        end
    end

    return false
end

-- Same as kills
magianTrials.Special = function(player, npc, trade, trial, trialNumber)
    printf("[Magian] Processing Kills trial %d", trialNumber)

    if trial.previousTrial > 0 and (player:getCharVar("MagianTrial_" .. trial.previousTrial) ~= tpz.magian.TRIAL_COMPLETED) then
        printf("[Magian] Previous trial %d not complete.", trial.previousTrial)
        player:PrintToPlayer("You have not completed the previous trial, kupo!", 0, "Magian Moogle")
        return true
    end

    if npcUtil.tradeHas(trade, { trial.mainItem }) then
        local killsDone = player:getCharVar("MagianKills_" .. trialNumber)
        printf("[Magian] Player has %d/%d kills.", killsDone, trial.numRequired)

        if killsDone >= trial.numRequired then
            if tpz.magian.IsValidReward(player, npc, trade, trial.rewardItem.itemId) then
                printf("[Magian] Player eligible for reward %d", trial.rewardItem.itemId)
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
                printf("[Magian] Player already has reward %d", trial.rewardItem.itemId)
                player:messageSpecial(ID.text.MAGIAN_ALREADY_HAVE_ITEM, trial.rewardItem.itemId)
            end
            return true
        else
            printf("[Magian] Not enough kills for trial %d", trialNumber)
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
    Effect = function(handler, player, npc, trade, trial, trialNumber)
        return handler(player, npc, trade, trial, trialNumber)
    end,
    Special = function(handler, player, npc, trade, trial, trialNumber) -- Same as kills
        return handler(player, npc, trade, trial, trialNumber)
    end,
}
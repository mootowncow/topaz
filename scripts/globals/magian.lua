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
-- TODO: Need to make sure kills give XP in order to give credit!
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

local trialConditions =
{
    ['Family'] = function(player, mob, isKiller, isWeaponSkillKill, trialNum, trial)
        local mobFamily = mob:getFamily()
        printf("[Magian] Mob family: %d. Trial requires families: %s", mobFamily, table.concat(trial.mob, ", "))

        for _, familyId in ipairs(trial.mob) do
            if (mobFamily == familyId) then
                local kills = player:getCharVar("MagianKills_" .. trialNum) + 1
                local remainingKills = trial.numRequired - kills 
                player:setCharVar("MagianKills_" .. trialNum, kills)

                printf("[Magian] Incremented kills for trial %d to %d", trialNum, kills)

                if kills >= trial.numRequired then
                    player:messageCombat(player, trialNum, 0, tpz.msg.combat.MAGIAN_TRIAL_COMPLETE)
                    player:setCharVar("MagianTrial_" .. trialNum, tpz.magian.TRIAL_COMPLETED)
                else
                    player:messageCombat(player, trialNum, remainingKills, tpz.msg.combat.MAGIAN_TRIAL_PROGRESS)
                end
                break
            end
        end
    end,

    ['Pool'] = function(player, mob, isKiller, isWeaponSkillKill, trialNum, trial)
        local mobPool = mob:getPool()
        printf("[Magian] Mob pool: %d. Trial requires pools: %s", mobPool, table.concat(trial.mob, ", "))

        for _, poolId in ipairs(trial.mob) do
            if (mobPool == poolId) then
                local kills = player:getCharVar("MagianKills_" .. trialNum) + 1
                local remainingKills = trial.numRequired - kills
                player:setCharVar("MagianKills_" .. trialNum, kills)

                printf("[Magian] Incremented kills for trial %d to %d", trialNum, kills)

                if kills >= trial.numRequired then
                    player:messageCombat(player, trialNum, 0, tpz.msg.combat.MAGIAN_TRIAL_COMPLETE)
                    player:setCharVar("MagianTrial_" .. trialNum, tpz.magian.TRIAL_COMPLETED)
                else
                    player:messageCombat(player, trialNum, remainingKills, tpz.msg.combat.MAGIAN_TRIAL_PROGRESS)
                end
                break
            end
        end
    end,

    ['Species'] = function(player, mob, isKiller, isWeaponSkillKill, trialNum, trial)
        local species = mob:getSystem()
    end,

    ['Name'] = function(player, mob, isKiller, isWeaponSkillKill, trialNum, trial)
        local name = mob:getName()
    end,

    ['DayWeather'] = function(player, mob, isKiller, isWeaponSkillKill, trialNum, trial)
        local weather = player:getWeather()
    end,

    ['WSKill'] = function(player, mob, isKiller, isWeaponSkillKill, trialNum, trial)
        local wsId = mob:getLocalVar("WSKilledBy")

        if isKiller and (wsId == trial.ws) then
            local kills = player:getCharVar("MagianKills_" .. trialNum) + 1
            local remainingKills = trial.numRequired - kills
            player:setCharVar("MagianKills_" .. trialNum, kills)

            printf("[Magian] Incremented WS kills for trial %d to %d", trialNum, kills)

            if kills >= trial.numRequired then
                player:messageCombat(player, trialNum, 0, tpz.msg.combat.MAGIAN_TRIAL_COMPLETE)
                player:setCharVar("MagianTrial_" .. trialNum, tpz.magian.TRIAL_COMPLETED)
            else
                player:messageCombat(player, trialNum, remainingKills, tpz.msg.combat.MAGIAN_TRIAL_PROGRESS)
            end
        end
    end,

    ['Elemental'] = function(player, mob, isKiller, isWeaponSkillKill, trialNum, trial)
        local element = mob:getLocalVar("ElementKilledBy") - 5 -- The var is set by damage type, and damage type elements start at 6 for fire
        --printf("Element %d, trial element: %d", element, trial.element)

        if isKiller and (element == trial.element) then
            local kills = player:getCharVar("MagianKills_" .. trialNum) + 1
            local remainingKills = trial.numRequired - kills
            player:setCharVar("MagianKills_" .. trialNum, kills)

            printf("[Magian] Incremented kills for trial %d to %d", trialNum, kills)

            if kills >= trial.numRequired then
                player:messageCombat(player, trialNum, 0, tpz.msg.combat.MAGIAN_TRIAL_COMPLETE)
                player:setCharVar("MagianTrial_" .. trialNum, tpz.magian.TRIAL_COMPLETED)
            else
                player:messageCombat(player, trialNum, remainingKills, tpz.msg.combat.MAGIAN_TRIAL_PROGRESS)
            end
        end
    end,

    ['Enfeebled'] = function(player, mob, isKiller, isWeaponSkillKill, trialNum, trial)
        local effect = trial.Effect
        if mob:hasStatusEffect(trial.Effect) then
            -- do stuff
        end
    end,

    ['Effect'] = function(player, mob, isKiller, isWeaponSkillKill, trialNum, trial)
        -- How to do this? Need a listener to applying effects...?
        -- spell:takeEffect() somewhere for spells (where CE/VE is done) in C++
        -- or in magic.lua bluemagic.lua TryApplyEffect / BLUTryApplyEffect?
    end
}

local trialListeners =
{
    ['WeaponSkill'] = function(player, trialNum, trial)
        player:addListener("WEAPONSKILL_USE", "MAGIAN_USE_WS", function(player, target, wsId)
        end)
    end,

    ['WSDamage'] = function(player, trialNum, trial)
        player:addListener("WEAPONSKILL_USE", "MAGIAN_WS_DAMAGE", function(player, target, wsId)
        end)
    end,

    ['ExperiencePoints'] = function(player, trialNum, trial)
        player:addListener("EXPERIENCE_POINTS", "MAGIAN_GAIN_EXP", function(player, exp)
        end)
    end
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
        if trial.mainItem and trial.type == 'Kills' and trial.previousTrial == 0 then
            tpz.magian.startableTrials[trial.mainItem] = tpz.magian.startableTrials[trial.mainItem] or {}
            tpz.magian.startableTrials[trial.mainItem][0] = trialNumber
        end
    end
end

tpz.magian.registerListeners = function(player)
    -- Remove any existing Magian listeners for this player to avoid duplicates
    player:removeListener("MAGIAN_USE_WS")
    player:removeListener("MAGIAN_WS_DAMAGE")
    player:removeListener("MAGIAN_GAIN_EXP")

    local activeTrials = tpz.magian.getActiveMagianTrials(player)

    for trialNum, data in pairs(activeTrials) do
        local trial = tpz.magian.trialDataById[trialNum]
        if trial and (trial.type == 'Kills') then
            local listeners = trialListeners[trial.killType]
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

    -- Check if starting a new Kills trial
    if tpz.magian.startableTrials[mainItemId] then
        for tradeItemId, trialNumber in pairs(tpz.magian.startableTrials[mainItemId]) do
            local trial = tpz.magian.trials[trialNumber]
            printf("[Magian] Checking startable Kills trial %d for mainItemId %d", trialNumber, mainItemId)

            if trial and trial.type == 'Kills' then
                -- Previous trial check
                if trial.previousTrial > 0 and (player:getCharVar("MagianTrial_" .. trial.previousTrial) ~= tpz.magian.TRIAL_COMPLETED) then
                    printf("[Magian] Previous trial %d not complete.", trial.previousTrial)
                    player:PrintToPlayer("You have not completed the previous trial, kupo!", 0, "Magian Moogle")
                    return true
                end

                -- Already completed trial check
                if player:getCharVar("MagianTrial_" .. trialNumber) == tpz.magian.TRIAL_COMPLETED then
                    printf("[Magian] Trial %d already completed, skipping.", trialNumber)
                    goto continueKillsTrialLoop
                end

                if npcUtil.tradeHas(trade, {mainItemId}) and (currentTrial == 0) then
                    printf("[Magian] Starting Kills trial %d", trialNumber)
                    player:confirmTrade()
                    player:addItem(mainItemId, 1, 0, 0, 0, 0, 0, 0, 0, 0, trialNumber)
                    player:messageSpecial(ID.text.MAGIAN_TRIAL_STARTED, tpz.ki.MAGIAN_TRIAL_LOG)
                    player:setCharVar("MagianTrial_" .. trialNumber, tpz.magian.TRIAL_ACCEPTED)
                    return
                end
            end
            ::continueKillsTrialLoop::
        end
    end

    -- Now, separately check for follow-up eligible Kills trials that are not in startableTrials
    for trialNumber, trial in pairs(tpz.magian.trials) do
        if trial.mainItem == mainItemId and trial.type == 'Kills' then
            if trial.previousTrial > 0 and player:getCharVar("MagianTrial_" .. trial.previousTrial) == tpz.magian.TRIAL_COMPLETED then
                if player:getCharVar("MagianTrial_" .. trialNumber) ~= tpz.magian.TRIAL_COMPLETED then
                    printf("[Magian] Eligible for next trial %d after %d", trialNumber, trial.previousTrial)
                    if npcUtil.tradeHas(trade, {mainItemId}) and (currentTrial == 0) then
                        printf("[Magian] Starting follow-up Kills trial %d", trialNumber)
                        local tradedItem = trade:getItem()
                        local augments = tpz.itemUtils.GetItemAugments(tradedItem) -- Get augments currently on items to readd later

                        -- Make sure augments are sorted or placed by slot index 0-4 in order
                        local augTable = {}
                        for i = 0, 4 do
                            augTable[i+1] = {id=0, value=0}
                        end
                        for _, aug in ipairs(augments) do
                            augTable[aug.slot + 1] = {id = aug.id, value = aug.value}
                        end

                        local addItemArgs = tpz.itemUtils.BuildAddItemArgs(augTable, trialNumber) -- Stored augments to readd
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

tpz.magian.checkMagianTrial = function (player, mob, isKiller, isWeaponSkillKill)
    printf("[Magian] Checking Magian Trials for player %s", player:getName())

    local activeTrials = tpz.magian.getActiveMagianTrials(player)
    printf("[Magian] Found %d active trial(s)", table.getn(activeTrials))

    if player:checkKillCredit(mob) then
        for trialNum, data in pairs(activeTrials) do
            printf("[Magian] Checking trial %d (itemId: %d in slot %d)", trialNum, data.itemId, data.slot)
            local trial = tpz.magian.trialDataById[trialNum]
            if trial and (trial.type == 'Kills') then
                printf("[Magian] Trial %d is a Kills trial of type %s", trialNum, trial.killType)

                local conditions = trialConditions[trial.killType]

                if conditions then
                    conditions(player, mob, isKiller, isWeaponSkillKill, trialNum, trial)
                else
                    printf("[Magian] No handler for killType: %s", trial.killType)
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

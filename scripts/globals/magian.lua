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
require("scripts/globals/utils")
-----------------------------------
-- TODO: Test 'Special' trials and ExperiencePoints
-- TODO: Does 'Region' work? Not sure on lua binding
-- TODO: Addon for all the data
-- TODO: Magian oAT weapons can proc in either hand. i.e. dual wield a bronze sword and OAT antea, it can proc on bronze sword too
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

    for element, weatherList in pairs(tpz.weatherGroup) do
        local displayName = utils.PunctuateString(element)
        for _, weatherId in ipairs(weatherList) do
            tpz.weatherToElement[weatherId] = displayName
        end
    end

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
    -- WS USE
    player:addListener("WEAPONSKILL_USE", "MAGIAN_USE_WS", function(player, target, wsId)
        local activeTrials = tpz.magian.getActiveMagianTrials(player)
        for trialNum, _ in pairs(activeTrials) do
            local trial = tpz.magian.trialDataById[trialNum]
            if trial and trial.type == 'Special' and trial.specialType == 'WSUse' then
                local points = tpz.magian.evaluateTrialConditions(player, target, trial, wsId)
                if points > 0 then
                    tpz.magian.addTrialPoints(player, trialNum, trial, points)
                end
            end
        end
    end)

    -- WS DAMAGE
    player:addListener("WS_DMG_DONE", "MAGIAN_WS_DMG_DONE", function(player, target, damage, wsId)
        local activeTrials = tpz.magian.getActiveMagianTrials(player)
        for trialNum, _ in pairs(activeTrials) do
            local trial = tpz.magian.trialDataById[trialNum]
            if trial and trial.type == 'Special' and trial.specialType == 'WSDamage' then
                local points = tpz.magian.evaluateTrialConditions(player, target, trial, wsId, damage)
                if points > 0 then
                    tpz.magian.addTrialPoints(player, trialNum, trial, points)
                end
            end
        end
    end)

    -- EXP
    player:addListener("EXPERIENCE_POINTS", "MAGIAN_GAIN_EXP", function(player, exp)
        local activeTrials = tpz.magian.getActiveMagianTrials(player)
        for trialNum, _ in pairs(activeTrials) do
            local trial = tpz.magian.trialDataById[trialNum]
            if trial and trial.type == 'Special' and trial.specialType == 'ExperiencePoints' then
                local points = tpz.magian.evaluateTrialConditions(player, nil, trial)
                if points > 0 then
                    tpz.magian.addTrialPoints(player, trialNum, trial, exp)
                end
            end
        end
    end)
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

    local tradedItem = trade:getItem()
    if not tradedItem then
        printf("[Magian] No traded item found.")
        return
    end

    local mainItemId = tradedItem:getID()
    local currentTrial = tradedItem:getTrialNumber()

    if player:getFreeSlotsCount() < 1 then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, mainItemId)
        printf("[Magian] Trade had no slots.")
        return
    end 
    printf("[Magian] Item ID: %d, Trial Number: %d", mainItemId, currentTrial)

    -- Branching path check first
    local startable = tpz.magian.startableTrials[mainItemId]
    if currentTrial == 0 and startable and startable[0] then
        local trialNumber = startable[0]
        local trial = tpz.magian.trials[trialNumber]
        if trial.branches then
            for tradeItemId, branchTrial in pairs(trial.branches) do
                if npcUtil.tradeHas(trade, {mainItemId, tradeItemId}) then
                    printf("[Magian] Starting branch trial %d via item %d", branchTrial, tradeItemId)
                    player:confirmTrade()
                    player:addItem(mainItemId, 1, 0, 0, 0, 0, 0, 0, 0, 0, branchTrial)
                    player:messageSpecial(ID.text.MAGIAN_TRIAL_STARTED, tpz.ki.MAGIAN_TRIAL_LOG)
                    player:setCharVar("MagianTrial_"..trialNumber, tpz.magian.TRIAL_COMPLETED)
                    player:setCharVar("MagianTrial_"..branchTrial, tpz.magian.TRIAL_ACCEPTED)
                    tpz.magian.trialObjectivesText(player, tpz.magian.trials[branchTrial], branchTrial)
                    return
                end
            end
        end
    end

    -- Unified trialToStart finder for Kills/Effect/Special then Items
    local trialToStart = nil

    -- Kills/Effect/Special first
    if tpz.magian.startableTrials[mainItemId] then
        for _, trialNumber in pairs(tpz.magian.startableTrials[mainItemId]) do
            local trial = tpz.magian.trials[trialNumber]
            if trial and (trial.type == 'Kills' or trial.type == 'Effect' or trial.type == 'Special') then
                if trial.previousTrial > 0 and player:getCharVar("MagianTrial_"..trial.previousTrial) ~= tpz.magian.TRIAL_COMPLETED then
                    goto continueStartableTrialLoop
                end
                if player:getCharVar("MagianTrial_"..trialNumber) == tpz.magian.TRIAL_COMPLETED then
                    goto continueStartableTrialLoop
                end
                if npcUtil.tradeHas(trade, {mainItemId}) and currentTrial == 0 then
                    trialToStart = { number = trialNumber, data = trial }
                    break
                end
            end
            ::continueStartableTrialLoop::
        end
    end

    -- If no Kills/Effect/Special trial found, check Items trials
    if not trialToStart and tpz.magian.startableTrials[mainItemId] then
        for tradeItemId, trialNumber in pairs(tpz.magian.startableTrials[mainItemId]) do
            local trial = tpz.magian.trials[trialNumber]
            if trial and trial.type == 'Items' then
                if trial.previousTrial > 0 and player:getCharVar("MagianTrial_"..trial.previousTrial) ~= tpz.magian.TRIAL_COMPLETED then
                    goto continueItemsTrialLoop
                end
                if player:getCharVar("MagianTrial_"..trialNumber) == tpz.magian.TRIAL_COMPLETED then
                    goto continueItemsTrialLoop
                end
                if npcUtil.tradeHas(trade, {mainItemId}) and currentTrial == 0 then
                    trialToStart = { number = trialNumber, data = trial }
                    break
                end
            end
            ::continueItemsTrialLoop::
        end
    end

    -- Start selected trial if found
    if trialToStart then
        printf("[Magian] Starting trial %d of type %s", trialToStart.number, trialToStart.data.type)
        player:confirmTrade()
        player:addItem(mainItemId, 1, 0, 0, 0, 0, 0, 0, 0, 0, trialToStart.number)
        player:messageSpecial(ID.text.MAGIAN_TRIAL_STARTED, tpz.ki.MAGIAN_TRIAL_LOG)
        player:setCharVar("MagianTrial_"..trialToStart.number, tpz.magian.TRIAL_ACCEPTED)
        tpz.magian.trialObjectivesText(player, trialToStart.data, trialToStart.number)
        return
    end

    -- Check for follow-up eligible trials (not in startableTrials)
    for trialNumber, trial in pairs(tpz.magian.trials) do
        if trial.mainItem == mainItemId and (trial.type == 'Kills' or trial.type == 'Effect' or trial.type == 'Special') then
            if trial.previousTrial > 0 and player:getCharVar("MagianTrial_"..trial.previousTrial) == tpz.magian.TRIAL_COMPLETED and
               player:getCharVar("MagianTrial_"..trialNumber) ~= tpz.magian.TRIAL_COMPLETED then
                if npcUtil.tradeHas(trade, {mainItemId}) and currentTrial == 0 then
                    printf("[Magian] Starting follow-up %s trial %d", trial.type, trialNumber)
                    local augments = tpz.itemUtils.GetItemAugments(tradedItem)
                    local augTable = {}
                    for i=0,4 do augTable[i+1] = {id=0, value=0} end
                    for _, aug in ipairs(augments) do
                        augTable[aug.slot+1] = {id=aug.id, value=aug.value}
                    end
                    local addItemArgs = tpz.itemUtils.BuildAddItemArgs(augTable, trialNumber)
                    printf("[AddItemArgs] %s", table.concat(addItemArgs, ", "))
                    player:confirmTrade()
                    player:addItem(mainItemId, 1, unpack(addItemArgs))
                    player:messageSpecial(ID.text.MAGIAN_TRIAL_STARTED, tpz.ki.MAGIAN_TRIAL_LOG)
                    player:setCharVar("MagianTrial_"..trialNumber, tpz.magian.TRIAL_ACCEPTED)
                    tpz.magian.trialObjectivesText(player, trial, trialNumber)
                    return
                end
            end
        end
    end

    -- Active trial processing
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
    if currentTrial == 0 then
        printf("[Magian] No trial found on item.")
        player:messageSpecial(ID.text.MAGIAN_NO_TRIAL)
    else
        printf("[Magian] Trial %d is still active.", currentTrial)
        player:messageSpecial(ID.text.MAGIAN_TRIAL_ACTIVE)
        local trial = tpz.magian.trialDataById[currentTrial]
        if trial then
            tpz.magian.trialObjectivesText(player, trial, currentTrial)
        end
    end
end

tpz.magian.IsValidReward = function(player, npc, trade, rewardItem)
-- TODO: Not used. Could add lua binding to block getting multiple OAT weapons?
--[[    if IsRareItem(rewardItem) then
        if player:hasItem(rewardItem) then
            return false
        end
    end
    ]]

    return true
end

tpz.magian.trialObjectivesText = function(player, trial, trialNumber)
    local familyNames       = utils.generateEnumNameMap(tpz.mob.family)
    local poolNames         = utils.generateEnumNameMap(tpz.mob.pool)
    local speciesNames      = utils.generateEnumNameMap(tpz.eco)
    local regionNames       = utils.generateEnumNameMap(tpz.region)
    local dayNames          = utils.generateEnumNameMap(tpz.day)
    local elementNames      = utils.generateEnumNameMap(tpz.magic.ele)
    local effectNames       = utils.generateEnumNameMap(tpz.effect)
    local currentProgress   = player:getCharVar("MagianKills_" .. trialNumber)

    if (trial.type == 'Effect') then
        currentProgress = player:getCharVar("MagianEffects_" .. trialNumber)
    end

    player:queue(1000, function(player) 
        player:PrintToPlayer("Trial " .. trialNumber, 0xD, nil)

        -- Trial type
        player:PrintToPlayer("Type: " .. trial.type, 0xD, nil)

        -- Items
        if (trial.type == 'Items') then
            local itemObject = GetItem(trial.tradeItem)
            if itemObject then
                local itemName = string.gsub(itemObject:getName(), '_', ' ')
                itemName = utils.PunctuateString(itemName)
                player:PrintToPlayer("Item: " .. itemName, 0xD, nil)
            else
                player:PrintToPlayer("Item: Unknown", 0xD, nil) -- Shouldn't happen
            end
        end

        -- Kill type / sub type / special type
        if trial.killType then
            player:PrintToPlayer("Kill Type: " .. trial.killType, 0xD, nil)
        end

        if trial.subType then
            player:PrintToPlayer("Sub Type: " .. trial.subType, 0xD, nil)
        end

        if trial.specialType then
            player:PrintToPlayer("Special Type: " .. trial.specialType, 0xD, nil)
        end

        -- Kill types
        local killTargets = {
            ['Family'] = function()
                local families = ""
                for _, family in ipairs(trial.mob) do
                    families = families .. (familyNames[family] or "#" .. family) .. " "
                end
                player:PrintToPlayer("Target Families: " .. families, 0xD, nil)
            end,

            ['Specific'] = function()
                local pools = ""
                for _, pool in ipairs(trial.mob) do
                    pools = pools .. (poolNames[pool] or "#" .. pool) .. " "
                end
                player:PrintToPlayer("Target: " .. pools, 0xD, nil)
            end,

            ['Species'] = function()
                local ecos = ""
                for _, eco in ipairs(trial.mob) do
                    ecos = ecos .. (speciesNames[eco] or "#" .. eco) .. " "
                end
                player:PrintToPlayer("Species: " .. ecos, 0xD, nil)
            end,
        }

        if trial.mob and killTargets[trial.killType] then
            killTargets[trial.killType]()
        end

        -- Pet requirement
        if trial.pet then
            player:PrintToPlayer("Required Pet: " .. trial.pet, 0xD, nil)
        end

        -- Weapon skill requirements
        if trial.wsId then
            local wsList = table.concat(trial.wsId, " ")
            player:PrintToPlayer("Required WS: " .. wsList, 0xD, nil)
        end

        if trial.wsDmg then
            player:PrintToPlayer("Minimum WS Damage: " .. trial.wsDmg, 0xD, nil)
        end

        -- Element requirement
        if trial.element then
            player:PrintToPlayer("Required Element: " .. elementNames[trial.element], 0xD, nil)
        end

        if trial.effect then
            player:PrintToPlayer("Required Status Effect: " .. (effectNames[trial.effect] or "#" .. trial.effect), 0xD, nil)
        end

        if trial.effectElement then
            player:PrintToPlayer("Required Status Effect Element: " .. elementNames[trial.effectElement], 0xD, nil)
        end

        if trial.region then
            local regionText = ""
            for _, regionId in ipairs(trial.region) do
                regionText = regionText .. regionNames[regionId] .. " "
            end
            player:PrintToPlayer("Region(s): " .. regionText, 0xD, nil)
        end

        -- Weather requirement
        if trial.weather then
            local elements = {}
            if (trial.weather == 'Any') then
                elementList = 'Any active weather'
            else
                for _, weather in ipairs(trial.weather) do
                    local element = tpz.weatherToElement[weather] or "UNKNOWN"
                    elements[element] = true
                end
                local elementList = ""
                for elementName, _ in pairs(elements) do
                    elementList = elementList .. elementName .. " "
                end
            end
            player:PrintToPlayer("Required Weather: " .. elementList, 0xD, nil)
        end

        -- Day requirement
        if trial.day then
            player:PrintToPlayer("Required Day: " .. (dayNames[trial.day] or "#" .. trial.day), 0xD, nil)
        end

        -- Required kills/points
        player:PrintToPlayer("Required: " .. currentProgress .. "/" .. trial.numRequired, 0xD, nil)
    end)
end

-- Kill trials
tpz.magian.checkMagianTrial = function (player, mob, killer)
    --printf("[Magian] Checking Magian Trials for player %s", player:getName())

    local activeTrials = tpz.magian.getActiveMagianTrials(player)
    --printf("[Magian] Found %d active trial(s)", table.getn(activeTrials))

    if player:checkKillCredit(mob) then
        for trialNum, data in pairs(activeTrials) do
            printf("[Magian] Checking trial %d (itemId: %d in slot %d)", trialNum, data.itemId, data.slot)
            local trial = tpz.magian.trialDataById[trialNum]
            if trial and (trial.type == 'Kills') then
                printf("[Magian] Trial %d is a Kills trial of type %s", trialNum, trial.subType)

                local points = tpz.magian.evaluateTrialConditions(player, mob, trial, nil, nil, killer)
                if points > 0 then
                    tpz.magian.addTrialPoints(player, trialNum, trial, points)
                end
            end
        end
    end
end

-- Effect trials
tpz.magian.checkMagianTrialEffects = function(player, mob, effect, sourceType)
    --printf("[Magian] Checking Magian Trials for player %s", player:getName())

    local activeTrials = tpz.magian.getActiveMagianTrials(player)
    --printf("[Magian] Found %d active trial(s)", table.getn(activeTrials))

    if player:checkKillCredit(mob) then
        for trialNum, data in pairs(activeTrials) do
            local trial = tpz.magian.trialDataById[trialNum]

            if trial and trial.type == 'Effect' then
                if trial.subType == sourceType then
                    local points = tpz.magian.evaluateTrialConditions(player, mob, trial)
                    if points > 0 then
                        --printf("[Magian] Processing trial %d (effect: %d) from source %s", trialNum, trial.effect, sourceType or "None")
                        tpz.magian.processTrialEffect(player, trialNum, trial, effect, trial.effect)
                    else
                        --printf("[Magian] Skipped trial %d (did not meet trial conditions)", trialNum)
                    end
                else
                    --printf("[Magian] Skipped trial %d (subType mismatch: trial expects %s, got %s)", trialNum, trial.subType, sourceType)
                end
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

function PrintAllMobEffectsAndElements(mob)
    local effects = mob:getStatusEffects()
    printf("Mob has %d status effects:", #effects)

    for _, effect in ipairs(effects) do
        local effectId = effect:getType()
        local element = mob:getStatusEffectElement(effectId)
        printf("Effect ID: %d, Element: %d", effectId, element)
    end
end


tpz.magian.evaluateTrialConditions = function(player, mob, trial, skillId, damage, killer)
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

        ['Specific'] = function(player, mob, trial)
            for _, poolId in ipairs(trial.mob or {}) do
                if poolId == mob:getPool() then return true end
            end
        end,

        ['Species'] = function(player, mob, trial)
            for _, speciesId in ipairs(trial.mob or {}) do
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

        ['StatusEffectElement'] = function(player, mob, trial)
            local effectsAtDeath = mob:getStatusEffectsAtDeath()

            -- If no effects saved, immediately return false
            if effectsAtDeath == nil or #effectsAtDeath == 0 then
                printf("No effects recorded at death.")
                return false
            end

            -- effectsAtDeath is a table of { effectId = ..., element = ... }
            for _, effect in ipairs(effectsAtDeath) do
                printf("Effect ID at death: %d, Element: %d", effect.effectId, effect.element)
                if effect.element == trial.effectElement then
                    return true
                end
            end

            printf("No matching effects found in death snapshot.")
            return false
        end,

        ['AddEffect'] = function(player, mob, trial)
            return mob:hasStatusEffect(trial.effect)
        end,

        ['UnderEffect'] = function(player, mob, trial)
            return player:hasStatusEffect(trial.effect)
        end,

        ['Zone'] = function(player, mob, trial)
            for _, zoneId in ipairs(trial.zone or {}) do
                if zoneId == player:getZoneID() then return true end
            end
        end,

        ['Region'] = function(player, mob, trial)
            for _, regionId in ipairs(trial.region or {}) do
                if regionId == player:getCurrentRegion() then return true end
            end
        end,

        ['PetKill'] = function(player, mob, trial, skillId, damage, killer)
            if killer and killer:isPet() then
                if trial.pet then -- Specific pet(s) required
                    return killer:getName() == trial.pet
                else
                    return true -- Any pet kill qualifies
                end
            end
            return false -- No points if neither condition met
        end,

        ['Magic'] = function(player, mob, trial)
            return true
        end,

        ['Weather'] = function(player, mob, trial)
            return true
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

    -- If trial has a killType, subType or specialType, check it

    if trial.killType then
        local checkFunc = eligibilityChecks[trial.killType]
        if not checkFunc or not checkFunc(player, mob, trial, skillId, damage, killer) then
            return 0
        end
    end

    if trial.subType then
        local checkFunc = eligibilityChecks[trial.subType]
        if not checkFunc or not checkFunc(player, mob, trial, skillId, damage, killer) then
            return 0
        end
    end

    if trial.specialType then
        local checkFunc = eligibilityChecks[trial.specialType]
        if not checkFunc or not checkFunc(player, mob, trial, skillId, damage, killer) then
            return 0
        end
    end

    -- Day/weather conditions
    local isDayWeatherTrial = (trial.weather or trial.day)
    if isDayWeatherTrial then
        -- Weather (+5)
        if trial.weather then
            local currentWeather = player:getWeather(true)

            if (trial.weather == 'Any') then
                if (currentWeather >= tpz.weather.HOT_SPELL) then
                    points = points + 5
                end
            else
                for _, w in ipairs(trial.weather or {}) do
                    if w == currentWeather then
                        points = points + 5
                        break
                    end
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

            -- printf("[Magian] Slot %d has itemId: %d with trial number: %d", slot, itemId, trialNum)

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
    if npcUtil.tradeHas(trade, {{trial.tradeItem, trial.numRequired}}) then

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
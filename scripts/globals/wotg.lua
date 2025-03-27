-----------------------------------
--
--  WotG utilities
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/utils")
require("scripts/globals/status")
require("scripts/globals/zone")
require("scripts/globals/items")
require("scripts/globals/keyitems")
-----------------------------------
-- TODO:
-- Meta Progress properly going to 100% and Spawning
-- cooldown of 3m or something on entering a region so multiple players cant RNG spawn
-- tpz.wotg.RandomEvent need the forced spawn removed (randomEventWaves(player)) and should only spawn at 10% of time
tpz = tpz or {}
tpz.wotg = tpz.wotg or {}

tpz.wotg.NMMods = function(mob)
    if mob:getMainJob() == tpz.job.MNK then
        mob:setDamage(35)
    else
	    mob:setDamage(140)
    end
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.ACC, 25) 
    mob:addMod(tpz.mod.EVA, 25)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 60)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
end

tpz.wotg.QuadavTrashDrops = function(mob, player, isKiller, noKiller)
	if isKiller or noKiller then
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1500) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1000) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 500) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        -- Campaign Ops KI
        if  math.random(1,10000) <= 1 then
            utils.givePartyKeyItem(player, tpz.ki.DIAMOND_SEAL)
        end
    end
end

tpz.wotg.YagudoTrashDrops = function(mob, player, isKiller, noKiller)
	if isKiller or noKiller then
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1500) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1000) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 500) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        -- Campaign Ops KI
        if  math.random(1,10000) <= 1 then
            utils.givePartyKeyItem(player, tpz.ki.XICUS_ROSARY)
        end
    end
end

tpz.wotg.OrcTrashDrops = function(mob, player, isKiller, noKiller)
	if isKiller or noKiller then
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1500) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1000) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 500) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        -- Campaign Ops KI
        if  math.random(1,10000) <= 1 then
            utils.givePartyKeyItem(player, tpz.ki.TIGRIS_STONE)
        end
    end
end

tpz.wotg.MagianT1 = function(mob, player, isKiller, noKiller)
    player:addCurrency("allied_notes", 200)
	if isKiller or noKiller then
        if math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            if math.random(2) == 2 then
		        player:addTreasure(tpz.items.DAYBREAK_SOUL, mob)
            else
                player:addTreasure(tpz.items.TWILIGHT_SOUL, mob)
            end
	    end
    end
end

tpz.wotg.MagianT2 = function(mob, player, isKiller, noKiller)
    player:addCurrency("allied_notes", 300)
	if isKiller or noKiller then
        if math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            if math.random(2) == 2 then
		        player:addTreasure(tpz.items.INCRESCENT_SHADE, mob)
            else
                player:addTreasure(tpz.items.DECRESCENT_SHADE, mob)
            end
	    end
    end
end

tpz.wotg.MagianT3 = function(mob, player, isKiller, noKiller)
    player:addCurrency("allied_notes", 400)
	if isKiller or noKiller then 
        if math.random(1,10000) <= utils.getDropRate(mob, 2400) then 
		    player:addTreasure(tpz.items.SILVER_MIRROR, mob)
	    end
    end
end

tpz.wotg.MagianT4 = function(mob, player, isKiller, noKiller)
    player:addCurrency("allied_notes", 500)
	if isKiller or noKiller then
        if math.random(1,10000) <= utils.getDropRate(mob, 2400) then 
		    player:addTreasure(tpz.items.CHUNK_OF_RIFTSAND, mob)
	    end
    end
end

local waves = {}
local currentWave = 1
local mobFamily = {
    Scorpids = { 17478169, 17478170, 17478171, 17478172, 17478173, 17478174, 17478175, 17478176, 17478177, 17478178 },
    Funguars = { 17478179, 17478180, 17478181, 17478182, 17478183, 17478184, 17478185, 17478186, 17478187, 17478188 },
    Wespe = { 17478189, 17478190, 17478191, 17478192, 17478193, 17478194, 17478195, 17478196, 17478197, 17478198 },
    Saplings = { 17478199, 17478200, 17478201, 17478202, 17478203, 17478204, 17478205, 17478206, 17478207, 17478208 },
    Crawlers = { 17478209, 17478210, 17478211, 17478212, 17478213, 17478214, 17478215, 17478216, 17478217, 17478218 },
    Flies = { 17478219, 17478220, 17478221, 17478222, 17478223, 17478224, 17478225, 17478226, 17478227, 17478228 },
    Peistes = { 17478229, 17478230, 17478231, 17478232, 17478233, 17478234, 17478235, 17478236, 17478237, 17478238 }
}

local function pickRandom(t)
    return t[math.random(1, #t)]
end

local function pickRandomKey(t)
    local keys = {}
    for key in pairs(t) do
        table.insert(keys, key)
    end
    return keys[math.random(1, #keys)]
end

local function generateWave(player, usedMobs)
    local wave = {}
    local waveSize = math.random(1, 5)
    local zone = player:getZone()
    local wavesMsg = zone:getLocalVar("wavesMsg")
    
    for i = 1, waveSize do
        local family = pickRandomKey(mobFamily)  
        local mobID = pickRandom(mobFamily[family])  

        -- Ensure the mobID hasn't been used in previous waves
        while usedMobs[mobID] do
            mobID = pickRandom(mobFamily[family])  -- Pick a new mobID if it's already used
        end
        
        -- Add the mobID to the usedMobs tracker and the wave
        usedMobs[mobID] = true
        table.insert(wave, mobID)
        
        -- Print the current mobID of the mobs in the current wave
        print("Current mobID in wave " .. currentWave .. ": " .. mobID)
    end

    if (wavesMsg == 0) then
        utils.MessageParty(player, 'CODE: Waves START', 0xD, none)
        zone:setLocalVar("wavesMsg", 1)
    end

    return wave
end

local function randomEventWaves(player)
    waves = {} -- Reset waves for a new event
    currentWave = 1  -- Reset wave tracker
    local numWaves = math.random(1, 5)
    local zone = player:getZone()
    
    local usedMobs = {}  -- Table to track mobs already used
    
    for i = 1, numWaves do
        local wave = generateWave(player, usedMobs)  -- Pass the usedMobs tracker to each wave
        table.insert(waves, wave)  
    end

    zone:setLocalVar("eventActive", 1)
    zone:setLocalVar("wave", 1)
    zone:setLocalVar("maxWaves", numWaves)
end

local function randomEventDefense(player)
end

local function randomEventBoss(player)
end

local function randomEventSpecial(player)
end

local function ClearMsgVars(zone)
    zone:setLocalVar("wavesMsg", 0)
end

local function RandomEventComplete(player)
    local zone = player:getZone()
    local metaProgress = zone:getLocalVar("metaProgress")
    if metaProgress < 100 then
        zone:setLocalVar("metaProgress", math.min(metaProgress + 10, 100))
        utils.MessageParty(player, 'Meta progress: ' .. metaProgress .. '%', 0xD, none)
        ClearMsgVars(zone)
    end
end

local eventList = {
    [1] = randomEventWaves,
    [2] = randomEventDefense,
    [3] = randomEventBoss,
    [4] = randomEventSpecial,
}

tpz.wotg.RandomEvent = function(player, spawnChance)
    local zone = player:getZone()
    randomEventWaves(player) -- TODO: Remove after done testing
    if (math.random(100) <= spawnChance) and (zone:getLocalVar("eventActive") == 0) then
        eventList[math.random(#eventList)](player)
    end
end

tpz.wotg.spawnWave = function(player, waveIndex)
    local zone = player:getZone()
    if waveIndex < 1 or waveIndex > #waves then
        print("Invalid wave index: " .. waveIndex)
        return
    end

    local wave = waves[waveIndex]
    local waveSize = #wave  -- Get the number of mobs in this wave
    print("Spawning Wave " .. waveIndex)

    -- Reset wave progress for the new wave
    zone:setLocalVar("waveProgress", 0)

    for _, mobID in ipairs(wave) do
        print("Spawning Mob ID:", mobID)
        local mob = GetMobByID(mobID)
        if not mob:isSpawned() then
            mob:setSpawn(player:getXPos(), player:getYPos(), player:getZPos())
            SpawnMob(mobID)
            mob:updateEnmity(player)
            mob:addStatusEffect(tpz.effect.TERROR, 1, 0, 3)
        end
    end

    -- Set wave size as a local variable in the zone
    zone:setLocalVar("waveActive", 1)
    zone:setLocalVar("waveSize", waveSize)
    zone:setLocalVar("eventCompleted", 0)
    utils.MessageParty(player, 'Enemies appear around you!', 0xD, none)
end

tpz.wotg.progressCheck = function(player, zone)
    local currentWave = zone:getLocalVar("wave")
    local waveProgress = zone:getLocalVar("waveProgress")
    local waveSize = zone:getLocalVar("waveSize")
    local maxWaves = zone:getLocalVar("maxWaves")
    local eventCompleted = zone:getLocalVar("eventCompleted")

    -- Print the current wave details for debugging
    local debugTimer = zone:getLocalVar("debugTimer")
    if (os.time() >= debugTimer) then
        print(string.format("Wave: %d, Progress: %d, Size: %d, Max Waves: %d", currentWave, waveProgress, waveSize, maxWaves))
        zone:setLocalVar("debugTimer", os.time() + 10)
    end

    if (waveSize > 0) and (waveProgress >= waveSize) then
        if (currentWave +1 <= maxWaves) then
            printf("Increasing wave by 1")
            zone:setLocalVar("wave", currentWave +1)
            zone:setLocalVar("waveActive", 0)
        else
            -- All waves completed, end the event
            if (eventCompleted == 0) then
                RandomEventComplete(player)
                zone:setLocalVar("eventActive", 0)
                zone:setLocalVar("waveActive", 0)
                zone:setLocalVar("eventCompleted", 1)
            end
        end
    end
end

tpz.wotg.WaveonMobDeath = function(mob)
    local zone = mob:getZone()
    local waveProgress = zone:getLocalVar("waveProgress")

    printf("Mob dead, incrimenting wave progress by 1")
    zone:setLocalVar("waveProgress", waveProgress +1)
end

--[[    local zone = player:getZone()
    zone:setLocalVar("test", 64)
    local testVar = zone:getLocalVar("test")
    print("testVar is: %d", testVar)
]]
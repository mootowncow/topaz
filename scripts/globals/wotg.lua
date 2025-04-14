-----------------------------------
--
--  WotG utilities
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/mobs")
require("scripts/globals/msg")
require("scripts/globals/utils")
require("scripts/globals/status")
require("scripts/globals/zone")
require("scripts/globals/items")
require("scripts/globals/keyitems")
-----------------------------------
-- TODO:
-- Meta progress increase based on event done (i.e. bosses give 10%, waves give 5%)
-- tpz.wotg.RandomEvent need the forced spawn removed (randomEventWaves(player)) and should only spawn at 10% of time
--  weather related event (during weather only)
--  undead related event (night only)
-- augmented items from events, fomor bosses drop their "Finished" synthesized weapons with augments
-- OR drop runes (the things from hunts) from all events and they go into the weapons fomor bosses weapons
-- meta boss based on zone, can use a table like mobFamily and first key can be zone name via tpz enum
-- Mimics that are "Traps" that spawn enemies then give loot after
-- Boss death needs to check tpz.wotg.progressCheck and zone:setLocalVar("eventCompleted", 1) and add to meta progress(?)
-- Check if waves works properly still, I changed the var to set to tpz.wotg.events.Waves instead of 1
-- test temps with more players
-- events can spawn in same place x2 in a row, fix
-- elite/champion packs on waves/defense? can have positive auras buffing other mobs in wave or debuffing players
-- logic for mob despawning maybe? despawn event/mobs after inactive for 5m?
-- some NM to reflect spell casts, and some NM (scorpion?) to counter WS with a TP move onto that player
-- give one of the trash mobs hastega (make it II effect) regenga IV, etc
-- has to be able to AOE it onto other mobs so needs to be in family somehow...or just hard code AOEing it on spellcast
-- Fomors (Lugh etc) detect magic AND sound
-- Test if Witchweed properly levels up still (even if you stun it after bee dies)
-- Make sure Lugh levels up on heat breath / exuviation
tpz = tpz or {}
tpz.wotg = tpz.wotg or {}

tpz.wotg.regionsData = {
    [tpz.zone.CRAWLERS_NEST_S] = {
        amount = 12
    }
}

-- These two tables need to match
tpz.wotg.events = {
    Waves       = 1,
    Defense     = 2,
    Boss        = 3,
    Mimic       = 4,
    Special     = 5
}
-- These two tables need to match
local eventList = {
    [1] = randomEventWaves,
    [2] = randomEventDefense,
    [3] = randomEventBoss,
    [4] = randomEventMimic,
    [5] = randomEventSpecial,
}

local mobFamily = {
    [tpz.zone.CRAWLERS_NEST_S] = {
        Scorpids = { 17478169, 17478170, 17478171, 17478172, 17478173, 17478174, 17478175, 17478176, 17478177, 17478178 },
        Funguars = { 17478179, 17478180, 17478181, 17478182, 17478183, 17478184, 17478185, 17478186, 17478187, 17478188 },
        Wespe = { 17478189, 17478190, 17478191, 17478192, 17478193, 17478194, 17478195, 17478196, 17478197, 17478198 },
        Saplings = { 17478199, 17478200, 17478201, 17478202, 17478203, 17478204, 17478205, 17478206, 17478207, 17478208 },
        Crawlers = { 17478209, 17478210, 17478211, 17478212, 17478213, 17478214, 17478215, 17478216, 17478217, 17478218 },
        Flies = { 17478219, 17478220, 17478221, 17478222, 17478223, 17478224, 17478225, 17478226, 17478227, 17478228 },
        Peistes = { 17478229, 17478230, 17478231, 17478232, 17478233, 17478234, 17478235, 17478236, 17478237, 17478238 }
    }
}

local bosses = {
    -- Scorpion(Gold), Rafflesia, Gnat, Ladybug, Slug, Peiste
    [tpz.zone.CRAWLERS_NEST_S] = { 17478239, 17478240, 17478241, 17478242, 17478243, 17478244 },
}

local metaBosses = {
    [tpz.zone.CRAWLERS_NEST_S] = { Id = 17477708, Pos = 'E-7' }, -- Lugh
}

local waves = {}
local currentWave = 1

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

local function generateActiveRegions(zone)
    local zoneId = zone:getID()
    local regionsAmount = tpz.wotg.regionsData[zoneId].amount
    local regionsGenerated = regionsAmount / 4 -- 25% of total regions active at once
    local lastRegion = zone:getLocalVar("lastRegion")
    tpz.wotg.activeRegions[zoneId] = {}

    -- Build a list of region IDs excluding the lastRegion
    local availableRegions = {}
    for i = 1, regionsAmount do
        if i ~= lastRegion then
            table.insert(availableRegions, i)
        end
    end

    -- Shuffle the availableRegions list (this ensures same region won't be picked multiple times)
    for i = #availableRegions, 2, -1 do
        local j = math.random(i)
        availableRegions[i], availableRegions[j] = availableRegions[j], availableRegions[i]
    end

    -- Select the first N shuffled regions
    for i = 1, math.min(regionsGenerated, #availableRegions) do
        table.insert(tpz.wotg.activeRegions[zoneId], availableRegions[i])
    end

    local activeRegions = tpz.wotg.getActiveRegions(zoneId)
    printf("Generating active regions")
    if activeRegions then
        print("Active regions for zone " .. zoneId .. ":")
        for i, regionID in ipairs(activeRegions) do
            print("Region " .. i .. ": " .. regionID)
        end
    else
        print("No active regions found for zone " .. zoneId)
    end
end

local function GiveTempItems(player, amount)
    local ID = zones[player:getZoneID()]

    local tempsData = {
        Potion = {
            tpz.items.LUCID_POTION_I, tpz.items.LUCID_POTION_II, tpz.items.LUCID_POTION_III,
            tpz.items.DUSTY_POTION, tpz.items.FLASK_OF_HEALING_MIST, tpz.items.FLASK_OF_HEALING_POWDER
        },

        Ether = { 
            tpz.items.LUCID_ETHER_I, tpz.items.LUCID_ETHER_II, tpz.items.LUCID_ETHER_III,
            tpz.items.DUSTY_ETHER, tpz.items.FLASK_OF_MANA_MIST, tpz.items.PINCH_OF_MANA_POWDER
        },

        Elixir = {
            tpz.items.LUCID_ELIXIR_I, tpz.items.LUCID_ELIXIR_II, tpz.items.DUSTY_ELIXIR
        },

        Pet = {
            tpz.items.TUBE_OF_HEALING_SALVE_I, tpz.items.TUBE_OF_HEALING_SALVE_II,
            tpz.items.TUBE_OF_CLEAR_SALVE_I, tpz.items.TUBE_OF_CLEAR_SALVE_II
        },

        Boosts = {
            tpz.items.BOTTLE_OF_BODY_BOOST, tpz.items.BOTTLE_OF_MANA_BOOST,
        },

        Drinks = {
            tpz.items.BOTTLE_OF_STALWARTS_TONIC, tpz.items.BOTTLE_OF_STALWARTS_GAMBIR,
            tpz.items.BOTTLE_OF_ASCETICS_TONIC, tpz.items.BOTTLE_OF_ASCETICS_GAMBIR,
            tpz.items.BOTTLE_OF_CHAMPIONS_TONIC, tpz.items.BOTTLE_OF_CHAMPIONS_GAMBIR,
            tpz.items.BOTTLE_OF_FANATICS_DRINK, tpz.items.BOTTLE_OF_FOOLS_DRINK,
            tpz.items.BOTTLE_OF_FANATICS_TONIC, tpz.items.BOTTLE_OF_FOOLS_TONIC,
            tpz.items.PINCH_OF_FANATICS_POWDER, tpz.items.PINCH_OF_FOOLS_POWDER,
            tpz.items.BOTTLE_OF_BERSERKERS_DRINK, tpz.items.BOTTLE_OF_SWIFTSHOT_DRINK,
            tpz.items.BOTTLE_OF_BERSERKERS_TONIC, tpz.items.BOTTLE_OF_SWIFTSHOT_TONIC,
            tpz.items.BOTTLE_OF_BARBARIANS_DRINK, tpz.items.BOTTLE_OF_FIGHTERS_DRINK, tpz.items.BOTTLE_OF_ORACLES_DRINK,
            tpz.items.BOTTLE_OF_ASSASSINS_DRINK, tpz.items.BOTTLE_OF_SPYS_DRINK, tpz.items.BOTTLE_OF_BRAVERS_DRINK,
            tpz.items.BOTTLE_OF_SOLDIERS_DRINK, tpz.items.BOTTLE_OF_CHAMPIONS_DRINK, tpz.items.BOTTLE_OF_MONARCHS_DRINK,
            tpz.items.BOTTLE_OF_GNOSTICS_DRINK, tpz.items.BOTTLE_OF_CLERICS_DRINK, tpz.items.BOTTLE_OF_SHEPHERDS_DRINK,
            tpz.items.BOTTLE_OF_SPRINTERS_DRINK, tpz.items.BOTTLE_OF_VICARS_DRINK
        },

        Wings = {
            tpz.items.DAEDALUS_WING, tpz.items.PAIR_OF_LUCID_WINGS_I, tpz.items.PAIR_OF_LUCID_WINGS_II,
            tpz.items.DUSTY_WING
        },

        Reraise = {
            tpz.items.DUSTY_SCROLL_OF_RERAISE
        }
    }

    local mainJob = player:getMainJob()
    local isPetJob =
    mainJob == tpz.job.BST or
    mainJob == tpz.job.SMN or
    mainJob == tpz.job.PUP

    -- Build the pool of temps
    local tempPool = {}
    for category, temps in pairs(tempsData) do
        if (category ~= "Pet") or isPetJob then
            for _, temp in ipairs(temps) do
                table.insert(tempPool, temp)
            end
        end
    end

    -- Give temp items
    local tempsGiven = 0
    local addedItems = {}
    while (tempsGiven < amount) do
        local randomItem = tempPool[math.random(#tempPool)]

        if randomItem and not addedItems[randomItem] then
            if not player:hasItem(randomItem) then
                player:addTempItem(randomItem)
                player:messageName(ID.text.OBTAINED_TEMP_ITEM, player, randomItem, 0, 0, 0, nil)
                addedItems[randomItem] = true
                tempsGiven = tempsGiven + 1
            end
        end
    end
end

local function ProgressMeta(player, zone)
    local metaProgress = zone:getLocalVar("metaProgress")
    if metaProgress < 100 then
        zone:setLocalVar("metaProgress", math.min(metaProgress + 5, 100))
        utils.MessageParty(player, 'Meta progress: ' .. zone:getLocalVar("metaProgress") .. '%', 0xD, none)
        generateActiveRegions(zone)
    end
 end

local function ClearMsgVars(zone)
    zone:setLocalVar("wavesMsg", 0)
end

local function generateMob(mob)
    local mobTypeData = {
       { Type = 'Normal',    Chance = 80 },
       { Type = 'Champion',  Chance = 10 },
       { Type = 'Elite',     Chance = 10 },
    }
end

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
    local zoneId = player:getZoneID()
    local wavesMsg = zone:getLocalVar("wavesMsg")
    local currentWave = zone:getLocalVar("wave") -- Ensure currentWave is defined

    if not mobFamily[zoneId] then
        print("No mob family defined for zone ID: " .. zoneId)
        return wave
    end

    for i = 1, waveSize do
        local family = pickRandomKey(mobFamily[zoneId]) -- Pick a random family from this zone
        local mobID = pickRandom(mobFamily[zoneId][family]) -- Pick a random mob from that family

        -- Ensure the mobID hasn't been used in previous waves
        while usedMobs[mobID] do
            mobID = pickRandom(mobFamily[zoneId][family]) -- Pick a new mobID if it's already used
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

    zone:setLocalVar("eventActive", tpz.wotg.events.Waves)
    zone:setLocalVar("wave", 1)
    zone:setLocalVar("maxWaves", numWaves)
end

local function randomEventDefense(player)
end

local function randomEventBoss(player)
    local zone = player:getZone()
    local zoneId = player:getZoneID()
    local bossMsg = zone:getLocalVar("bossMsg")

    if not mobFamily[zoneId] then
        print("No bosses defined for zone ID: " .. zoneId)
        return
    end

    local bossList = bosses[zoneId]
    local bossID = bossList[math.random(#bossList)]

    local xPos, yPos, zPos = player:getXPos(), player:getYPos(), player:getZPos()
    local posOffset = 0.5
    player:queue(5000, function(player) -- 5s wait before spawning a boss
        local boss = GetMobByID(bossID)
        if not boss:isSpawned() then
            boss:setSpawn(xPos + posOffset, yPos, zPos + posOffset)
            SpawnMob(bossID)
            boss:updateEnmity(player)
            boss:updateClaim(player)
            boss:addStatusEffect(tpz.effect.TERROR, 1, 0, 3)
            posOffset = posOffset + 0.5
        end
        utils.MessageParty(player, 'A ferocious enemy appears!', 0xD, none)
    end)

    utils.MessageParty(player, 'CODE: Boss START', 0xD, none)
    zone:setLocalVar("eventActive", tpz.wotg.events.Boss)
end

local function randomEventMimic(player)
    local zone = player:getZone()
    local mimic, treasureChest = 17478246, 17478247
    local chestId = math.random(mimic, treasureChest) -- Either spawn a mimic or treasure chest
    local chest = GetEntityByID(chestId)

    local xPos, yPos, zPos, zRot = player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos()
    local posOffset = 0.5
    player:queue(5000, function(player) 
        if not chest:isSpawned() then
            chest:setSpawn(xPos + posOffset, yPos, zPos + posOffset)
            chest:spawn()
            if (chestId == treasureChest) then
                chest:setPos(xPos + posOffset, yPos, zPos + posOffset, zRot)
                chest:setStatus(tpz.status.NORMAL)
            end
        end
    end)
    utils.MessageParty(player, 'A peculiar chest appears!', 0xD, none)
    zone:setLocalVar("eventActive", tpz.wotg.events.Mimic)
end

local function randomEventSpecial(player)
end

local function RandomEventComplete(player)
    local zone = player:getZone()
    local amount = math.random(1, 3)
    for _, member in pairs(player:getAlliance()) do
        GiveTempItems(member, amount)
    end
    ProgressMeta(player, zone)
    ClearMsgVars(zone)
end

local function SpawnMetaBoss(player, zone)
    local zoneId = player:getZoneID()
    local bossData = metaBosses[zoneId]
    -- TODO: Spams has spawned, doesnt spawn him
    -- Need to set eventActive and add entry for metaBoss

    if not bossData then
        printf("SpawnMetaBoss: No meta boss found.")
        return
    end

    player:queue(5000, function(player) -- 5s wait before spawning
        local bossId = bossData.Id
        local spawnPos = bossData.Pos
        local boss = GetMobByID(bossId)
        local mobName = MobName(boss)

        if not boss:isSpawned() then
            SpawnMob(bossId)
        end

        utils.MessageParty(player, mobName .. " has spawned at " .. spawnPos .. "!", 0xD, nil)
    end)
end

local modByMobName =
{
    ['Selket'] = function(mob)
        mob:setDamage(150)
        mob:setDelay(4000)
        mob:addMod(tpz.mod.REGAIN, 50)
        mob:setMod(tpz.mod.MDEF, 60)
        mob:setModelSize(3)
        -- Perma undispellable Ice Spikes
        mob:addStatusEffect(tpz.effect.CLOD_SPIKES, 25, 0, 0)
        local clodSpikes = mob:getStatusEffect(tpz.effect.CLOD_SPIKES)
        clodSpikes:unsetFlag(tpz.effectFlag.DISPELABLE)

        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 90, hpp = 90},
            },
        })
    end,

    ['Witchweed'] = function(mob)
        mob:setDamage(150)
        mob:setMod(tpz.mod.MDEF, 60)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 207)
        mob:setMobMod(tpz.mobMod.FRIENDLY_FIRE, 1)
    end,

    ['Honey_Wespe'] = function(mob)
        local witchweed = GetMobByID(17478240)
        local pos = witchweed:getPos()
        if witchweed:isAlive() then
            mob:pathTo(pos.x, pos.y, pos.z)
        end
        mob:addImmunity(tpz.immunity.SLEEP)
        mob:addImmunity(tpz.immunity.GRAVITY)
        mob:addImmunity(tpz.immunity.BIND)
        mob:addImmunity(tpz.immunity.TERROR)
        mob:addImmunity(tpz.immunity.CHARM)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
        mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
        mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 1)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)
    end,

    ['Sciaridae'] = function(mob)
        mob:setDamage(75)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 50)
        mob:setMod(tpz.mod.MDEF, 60)
        mob:addMod(tpz.mod.EVA, 50)

        tpz.mix.jobSpecial.config(mob, {
            between = 120,
            specials =
            {
                {id = tpz.jsa.PERFECT_DODGE, cooldown = 360, hpp = 90},
                {id = tpz.jsa.ELEMENTAL_SFORZO, cooldown = 360, hpp = 90},
            },
        })
    end,

    ['Coccineus'] = function(mob)
        mob:setDamage(150)
        mob:setMod(tpz.mod.MDEF, 24)
        mob:setMod(tpz.mod.LTNG_ABSORB, 100)

        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.CHAINSPELL, cooldown = 120, hpp = 90},
            },
        })
    end,

    ['Gastropoda'] = function(mob)
        mob:setDamage(125)
        mob:setMod(tpz.mod.MDEF, 24)
        mob:setMod(tpz.mod.UDMGPHYS, -25)

        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.MEIKYO_SHISUI, cooldown = 90, hpp = 90},
            },
        })
    end,

    ['Wadjet'] = function(mob)
        mob:setDamage(150)
        mob:setMod(tpz.mod.MDEF, 60)
        mob:setMod(tpz.mod.EEM_TERROR, 5)
        mob:AnimationSub(1) -- Gaze petrification
        mob:setModelSize(3)
    end,

    ['Lugh'] = function(mob)
        mob:addMod(tpz.mod.DEFP, 25)
        mob:addMod(tpz.mod.EVA, 25)
        mob:addMod(tpz.mod.MDEF, 24)
        mob:setMod(tpz.mod.VIT, 175)
        mob:setMod(tpz.mod.REGEN, 25)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
        mob:setMod(tpz.mod.FIRE_ABSORB, 100)
        mob:addImmunity(tpz.immunity.SILENCE)
        mob:addImmunity(tpz.immunity.PARALYZE)
        mob:setMobMod(tpz.mobMod.DRAW_IN, 2)

    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MIGHTY_STRIKES, hpp = 50},
        },
    })
    end,
}

local mobRoamByMobName =
{
    ['Honey_Wespe'] = function(mob)
        local witchweed = GetMobByID(17478240)
        local pos = witchweed:getPos()
        if witchweed:isAlive() then
            mob:pathTo(pos.x, pos.y, pos.z)
        end
    end,
}

local mixinByMobName =
{
}

local mobFightByMobName =
{
    ['Selket'] = function(mob, target)
        local maxHP = mob:getMaxHP()
        local currentHP = mob:getHP()
        local hpPercent = (currentHP / maxHP) * 100

        -- Delay scaling: Starts at 4000ms, decreases as HP gets lower
        --[[
        HP %	Delay (ms)
        100%	4000
        75%	    3250
        50%	    2500
        25%	    1750
        1%	    1500
        ]]
        local newDelay = 4000 - ((100 - hpPercent) * 30) -- Adjust factor as needed

        -- Ensure delay doesn't go below a minimum value (e.g., 1500ms)
        newDelay = math.max(newDelay, 1500)

        mob:setDelay(newDelay)
    end,

    ['Witchweed'] = function(mob, target)
        local bee = GetMobByID(17478245)
	    local beeTimer = mob:getLocalVar("beeTimer")
        local beeEatTimer = mob:getLocalVar("beeEatTimer")
        local lvlUp = mob:getLocalVar("lvlUp")

        -- Spawns a bee next to it, after a certain amount of time will consume the bee then level up
        -- If the bee dies in this fashion, levels up and gains access to Soothing Aroma (AOE Charm)
        if not bee:isSpawned() then
            if (beeTimer == 0) then
                mob:setLocalVar("beeTimer", os.time() + 15)
            elseif (os.time() >= beeTimer) then
                bee:setSpawn(mob:getXPos() + math.random(2, 5), mob:getYPos(), mob:getZPos() + math.random(1, 3))
                utils.spawnPetInBattle(mob, bee)
                mob:setLocalVar("beeTimer", os.time() + 60)
                mob:setLocalVar("beeEatTimer", os.time() + 30)
            end
        end

        -- "Eats" the bee after a certain amount of time
        if (beeEatTimer == 0) then
            mob:setLocalVar("beeEatTimer", os.time() + 45)
        elseif
            not IsMobBusy(mob) and
            not mob:hasPreventActionEffect() and
            (os.time() >= beeEatTimer) and
            bee:isAlive() and
            (mob:checkDistance(bee) <= 5)
        then
            mob:useMobAbility(tpz.mob.skills.BLOODY_CARESS, bee)
            mob:setLocalVar("beeEatTimer", os.time() + 60)
        end

        -- "Eating" the bee levels up Witchweed and gains access to Soothing Aroma (AOE Charm)
        if
            (lvlUp > 0) and
            not IsMobBusy(mob) and
            not mob:hasPreventActionEffect()
        then
            local level = mob:getMainLvl()
            mob:useMobAbility(tpz.mob.skills.LEVEL_UP, mob)
            mob:setMobLevel(level +1)
            -- Mods and Mobmods are cleared on leveling up, need to readd them
            tpz.wotg.onMobSpawn(mob)
            mob:setMobMod(tpz.mobMod.SKILL_LIST, 1208)
            mob:setLocalVar("lvlUp", 0)
        end

        -- Handle Bloody Caress being interrupted
        mob:addListener("WEAPONSKILL_STATE_INTERRUPTED", "URD_WS_INTERRUPTED", function(mob, skillID)
            if (skillID == tpz.mob.skills.BLOODY_CARESS) then
                mob:setLocalVar("beeEatTimer", os.time() + 1)
            end
        end)

        -- "Consuming" the Bee
        mob:addListener("WEAPONSKILL_STATE_EXIT", "WITCHWEED_MOBSKILL_FINISHED", function(mob, skillID)
            if (skillID == tpz.mob.skills.BLOODY_CARESS) then
                local level = mob:getMainLvl()
                local bee = GetMobByID(17478245)
                if bee:isAlive() then
                    bee:setHP(0)
                    mob:setLocalVar("lvlUp", 1)
                end
            end
        end)
    end,

    ['Honey_Wespe'] = function(mob, target)
        local Allegiance = mob:getAllegiance()
        local witchweed = GetMobByID(17478240)
        local pos = witchweed:getPos()
        if witchweed:isAlive() then
        mob:pathTo(pos.x, pos.y, pos.z)
        end
    end,

    ['Sciaridae'] = function(mob, target)
    end,

    ['Coccineus'] = function(mob, target)
        -- While chainspell is active: 1k+ Earth damage magic bursts procs (silence) and removes Chainspell
        mob:addListener("SPELL_DMG_TAKEN", "COCCINEUS_SPELL_DMG_TAKEN", function(mob, caster, spell, amount, msg)
            local element = spell:getElement()

            if (element == tpz.magic.ele.EARTH) and (amount >= 1000) then
                if (msg == tpz.msg.basic.MAGIC_BURST_BLACK) or (msg == tpz.msg.MAGIC_BURST_BREATH) then
                    local duration = 30
                    BreakMob(mob, caster, tpz.procEffect.NONE, duration, tpz.procType.SILENCE)
                    mob:delStatusEffect(tpz.effect.CHAINSPELL)
                end
            end
        end)
    end,

    ['Gastropoda'] = function(mob, target)
        local auraParams = {
            radius = 10,
            corrupt = true,
            power = 1,
            duration = 30,
            auraNumber = 1
        }

        local sdtWeaknesses = {
            [1] = tpz.mod.SDT_EARTH,
            [2] = tpz.mod.SDT_WATER,
            [3] = tpz.mod.SDT_WIND,
            [4] = tpz.mod.SDT_FIRE,
            [5] = tpz.mod.SDT_ICE,
            [6] = tpz.mod.SDT_THUNDER,
        }

        local defaultSDT = 20
        local highSDT = 100
        local battleTime = mob:getBattleTime()
        local resChangeTimer = mob:getLocalVar("resChangeTimer")
        local resistance = mob:getLocalVar("resistance")

        if (resChangeTimer == 0) then
            mob:setLocalVar("resChangeTimer", math.random(60, 90))
        end

        if (battleTime >= resChangeTimer) then
            mob:setLocalVar("resChangeTimer", battleTime + math.random(60, 90))
            mob:setLocalVar("resistance", math.random(6))
        end

        -- Rotates elemental resistances every 60-90s
        if sdtWeaknesses[resistance] then
            for _, mod in ipairs({
                tpz.mod.SDT_FIRE, tpz.mod.SDT_ICE, tpz.mod.SDT_WIND, tpz.mod.SDT_EARTH,
                tpz.mod.SDT_THUNDER, tpz.mod.SDT_WATER, tpz.mod.SDT_LIGHT, tpz.mod.SDT_DARK
            }) do
                mob:setMod(mod, (mod == sdtWeaknesses[resistance]) and highSDT or defaultSDT)
            end
        end

        -- Corrupts a buff on nearby players every 3 seconds
        AddMobAura(mob, target, auraParams)
        TickMobAura(mob, target, auraParams)
    end,

    ['Wadjet'] = function(mob, target)
        local animationSub = mob:AnimationSub()
        mob:AnimationSub(1) -- Perma gaze petrification (unless procced)

		if (animationSub == 1) then
            local nearbyEnemies = mob:getNearbyEntities(15)
            if (nearbyEnemies ~= nil) then 
                for _,v in pairs(nearbyEnemies) do
                    if
                        mob:isFacing(v) and
                        v:isFacing(mob) and
                        not v:isNPC() and
                        not v:hasStatusEffect(tpz.effect.FEALTY) and
                        not v:hasStatusEffect(tpz.effect.BLINDNESS) and
                        (v:getID() ~= mob:getID())
                    then
                        v:delStatusEffectSilent(tpz.effect.PETRIFICATION)
                        v:addStatusEffect(tpz.effect.PETRIFICATION, 1, 0, 5)
                    end
                end
		    end
        end
        -- 1k+ Fire damage magic bursts procs (terror) and removes gaze petrification
        mob:addListener("SPELL_DMG_TAKEN", "WADJET_SPELL_DMG_TAKEN", function(mob, caster, spell, amount, msg)
            local element = spell:getElement()

            if (element == tpz.magic.ele.FIRE) and (amount >= 1000) then
                if (msg == tpz.msg.basic.MAGIC_BURST_BLACK) or (msg == tpz.msg.MAGIC_BURST_BREATH) then
                    local duration = 60
                    BreakMob(mob, caster, tpz.procEffect.NONE, duration, tpz.procType.TERROR)
                end
            end
        end)

        -- Gaze petrification is removed while terrored
        if mob:hasStatusEffect(tpz.effect.TERROR) then
            mob:AnimationSub(0)
        else
            mob:AnimationSub(1)
        end
        
        -- Resets enmity on auto-attacks
        mob:addListener("ATTACK","WADJET_ATTACK", function(mob)
            local target = mob:getTarget()
            mob:resetEnmity(target)
        end)
    end,

    ['Lugh'] = function(mob, target)
        -- Levels up when a player/trust dies, on successful Heat Breath / Exuviation casts
        local lvlUp = mob:getLocalVar("lvlUp")
        if
            (lvlUp > 0) and
            not IsMobBusy(mob) and
            not mob:hasPreventActionEffect()
        then
            local level = mob:getMainLvl()
            mob:useMobAbility(tpz.mob.skills.LEVEL_UP, mob)
            mob:setMobLevel(level +1)
            -- Mods and Mobmods are cleared on leveling up, need to readd them
            tpz.wotg.onMobSpawn(mob)
            mob:setLocalVar("lvlUp", 0)
        end

        mob:addListener("MAGIC_STATE_EXIT", "LUGH_MAGIC_STATE_EXIT", function(mob, spell)
            if (spell:getID() == tpz.magic.spell.HEAT_BREATH) or (spell:getID() == tpz.magic.spell.EXUVIATION) then
                mob:setLocalVar("lvlUp", 1)
            end
        end)
        mob:addListener("PLAYER_DEATH", "LUGH_PLAYER_DEATH", function(mob, player)
            mob:setLocalVar("lvlUp", 1)
        end)
    end,
}

local mobWSPrepareByMobName =
{
    ['Angry_Scorpion'] = function(mob, target)
        -- Prefer using Hell Scissors over other TP moves
        local roll = math.random()
        if roll < 0.50 then
            return tpz.mob.skills.HELL_SCISSORS
        else
            return math.random(tpz.mob.skills.NUMBING_BREATH, tpz.mob.skills.SHARP_STRIKE)
        end
    end,

    ['Selket'] = function(mob, target)
        -- Prefer using Hell Scissors over other TP moves
        local roll = math.random()
        if roll < 0.50 then
            return tpz.mob.skills.HELL_SCISSORS
        else
            return math.random(tpz.mob.skills.NUMBING_BREATH, tpz.mob.skills.SHARP_STRIKE)
        end
    end,

    ['Lugh'] = function(mob, target)
    end,
}

local mobDeathByMobName =
{
    ['Witchweed'] = function(mob)
        local bee = 17478245
        DespawnMob(bee)
    end,

    ['Honey_Wespe'] = function(mob, player, isKiller, noKiller)
        local witchweed = GetMobByID(17478240)
        witchweed:setLocalVar("beeTimer", os.time() + 45)
    end,
}

local mobDespawnByMobName =
{
    ['Witchweed'] = function(mob)
        local bee = 17478245
        DespawnMob(bee)
    end,
}

tpz.wotg.onMobSpawn = function(mob)
    mob:setDamage(150)
    mob:setMod(tpz.mod.ATTP, 25)
    mob:setMod(tpz.mod.DEFP, 25)
    mob:setMod(tpz.mod.EEM_SILENCE, 5)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)

    local mobName = mob:getName()
    local mods = modByMobName[mobName]

    if mods then
        mods(mob)
    end
end

tpz.wotg.onMobRoam = function(mob, target)
    local mobName  = mob:getName()
    local mobRoam = mobRoamByMobName[mobName]

    if mobRoam then
        mobRoam(mob, target)
    end
end

tpz.wotg.onMobFight = function(mob, target)
    local mobName  = mob:getName()
    local mixin    = mixinByMobName[mobName]
    local mobFight = mobFightByMobName[mobName]

    if mixin then
        mixin(mob, target)
    end

    if mobFight then
        mobFight(mob, target)
    end
end

tpz.wotg.onMobWeaponSkillPrepare = function(mob, target)
    local mobName  = mob:getName()
    local mobWSPrepare = mobWSPrepareByMobName[mobName]


    if mobWSPrepare then
        return mobWSPrepare(mob, target)
    end
end

local eventOnMobDeath = {}
function eventOnMobDeath.Waves(mob, player, isKiller, noKille)
    local zone = mob:getZone()
    local waveProgress = zone:getLocalVar("waveProgress")

    -- printf("Mob dead, incrementing wave progress by 1")
    zone:setLocalVar("waveProgress", waveProgress + 1)
end

function eventOnMobDeath.Boss(mob, player, isKiller, noKiller)
    local zone = player:getZone()
    local amount = math.random(2, 4)
    GiveTempItems(player, amount)
    ClearMsgVars(zone)
    zone:setLocalVar("eventActive", 0)
    if isKiller or noKiller then
        ProgressMeta(player, zone)
    end
end

function eventOnMobDeath.Mimic(mob, player, isKiller, noKille)
    local zone = player:getZone()
    local amount = math.random(3, 5)
    GiveTempItems(player, amount)
    ClearMsgVars(zone)
    zone:setLocalVar("eventActive", 0)
    if isKiller or noKiller then
        ProgressMeta(player, zone)
    end
end

tpz.wotg.WaveonMobDeath = function(mob)
    local zone = mob:getZone()
    local waveProgress = zone:getLocalVar("waveProgress")

    -- printf("Mob dead, incrimenting wave progress by 1")
    zone:setLocalVar("waveProgress", waveProgress +1)
end

tpz.wotg.onMobDeath = function (mob, player, isKiller, noKiller, event)
    local mobName  = mob:getName()
    local mobDeath = mobDeathByMobName[mobName]

    if mobDeath then
        mobDeath(mob, player, isKiller, noKiller)
    end

    if (event ~= nil) then
        for eventName, eventID in pairs(tpz.wotg.events) do
            if event == eventID and eventOnMobDeath[eventName] then
                eventOnMobDeath[eventName](mob, player, isKiller, noKiller)
                return
            end
        end
    end
end

tpz.wotg.onMobDespawn = function (mob)
    local mobName  = mob:getName()
    local mobDespawn = mobDespawnByMobName[mobName]

    if mobDespawn then
        mobDespawn(mob)
    end
end

tpz.wotg.activeRegions = {}
tpz.wotg.onInitialize = function(zone)
    generateActiveRegions(zone)
end

tpz.wotg.getActiveRegions = function(zone)
    return tpz.wotg.activeRegions[zone]
end

tpz.wotg.RandomEvent = function(player)
    local zone = player:getZone()
    randomEventMimic(player) -- TODO: Remove after done testing
    -- eventList[math.random(#eventList)](player) -- TODO: Uncomment after testing
end

tpz.wotg.spawnWave = function(player, waveIndex)
    local zone = player:getZone()
    if waveIndex < 1 or waveIndex > #waves then
        print("Invalid wave index: " .. waveIndex)
        return
    end

    local wave = waves[waveIndex]
    local waveSize = #wave  -- Get the number of mobs in this wave

    -- Reset wave progress for the new wave 
    zone:setLocalVar("waveProgress", 0)

    local xPos, yPos, zPos = player:getXPos(), player:getYPos(), player:getZPos()
    local posOffset = 0
    player:queue(5000, function(player) -- 5s wait before spawning a wave
        for _, mobID in ipairs(wave) do
            print("Spawning Mob ID:", mobID)
            local mob = GetMobByID(mobID)
            if not mob:isSpawned() then
                mob:setSpawn(xPos + posOffset, yPos, zPos + posOffset)
                SpawnMob(mobID)
                mob:updateEnmity(player)
                mob:updateClaim(player)
                mob:addStatusEffect(tpz.effect.TERROR, 1, 0, 3)
                posOffset = posOffset + 0.5
            end
        end
        print("Spawning Wave " .. waveIndex)
        utils.MessageParty(player, 'Enemies appear around you!', 0xD, none)
    end)

    -- Set wave size as a local variable in the zone
    zone:setLocalVar("waveActive", 1)
    zone:setLocalVar("waveSize", waveSize)
    zone:setLocalVar("eventCompleted", 0)
end

tpz.wotg.distributeChestLoot = function(player, chest)
    local zone = player:getZone()
    local chestLooted = chest:getLocalVar("looted")
    if (chestLooted == 0) then
        local amount = math.random(3, 5)
        for _, member in pairs(player:getAlliance()) do
            GiveTempItems(member, amount)
        end
        chest:setLocalVar("looted", 1)

        zone:setLocalVar("eventActive", 0)
        ProgressMeta(player, zone)
        ClearMsgVars(zone)

        -- Despawn chest after 30 seconds
        chest:queue(30000, function(chest)
            chest:AnimationSub(0)
            chest:setStatus(tpz.status.DISAPPEAR)
        end)
    end
end

tpz.wotg.progressCheck = function(player, zone)
    local currentWave = zone:getLocalVar("wave")
    local waveProgress = zone:getLocalVar("waveProgress")
    local waveSize = zone:getLocalVar("waveSize")
    local maxWaves = zone:getLocalVar("maxWaves")
    local eventCompleted = zone:getLocalVar("eventCompleted")
    local metaProgress = zone:getLocalVar("metaProgress")

    -- Print the current wave details for debugging
    local debugTimer = zone:getLocalVar("debugTimer")
    if (os.time() >= debugTimer) then
        -- print(string.format("Wave: %d, Progress: %d, Size: %d, Max Waves: %d", currentWave, waveProgress, waveSize, maxWaves))
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

    if (metaProgress >= 100) then
        SpawnMetaBoss(player, zone)
    end
end
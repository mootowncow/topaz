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
-- elite/champion packs on waves/defense? can have positive auras buffing other mobs in wave or debuffing players
-- logic for mob despawning maybe? despawn event/mobs after inactive for 5m?
-- some NM to reflect spell casts, and some NM (scorpion?) to counter WS with a TP move onto that player
-- give one of the trash mobs hastega (make it II effect) regenga IV, etc
-- has to be able to AOE it onto other mobs so needs to be in family somehow...or just hard code AOEing it on spellcast
-- Fomors (Lugh etc) detect magic AND sound
-- Delete tpz.wotg.WaveonMobDeath?
-- Zone wide damage in certain areas like undispellable poison etc. Environmental effects
-- Test elite champ etc mobs with auras
-- Add a way to re-add +augment mod incase of DC
-- Test values given by augments with prints
-- Test SAVETP mod
-- Test if mob OFFENSIVE auras still work (TickMobAura) and don't AOE onto other nearby mobs
-- Test if BreakMob still works and works if a trust breaks the mob
-- Concordia etc weapon stats (Maybe make for jobs that normally don't use that weapon as a main wep?)
-- Test spell crit
-- Should marine Mayhem be (If this attack puts targets HP below 50%, then insta kill)?
-- Mobs that res eachother?
-- Trusts need to use holy waters when doomed
-- Make sure all spikes still work properly
-- Fomors (Lugh etc) special mobmod to ignore enmity and only focus whatever did newest CE/VE? read bg wiki page for tethra/etniu
-- Mechanics like abyssea for killing mobs? atmas to collect? stat boosts for clearing every zone boss? meta progression? 1 attribute boost per bos?
-- Store augment buff in one of the atma or stat buffs.
-- Titles to fomors
-- Earth bosses gain stoneskin (undispellable) after using TP moves
-- Wind bosses gain blink (undispellable) after using TP moves
-- Dark bosses ga magic stoneskin (undispellable) after using TP moves
-- Light bosses gain regain (undispellable) after using TP moves
-- Add ranged eva mod, give to some bosses
-- Add magic crit def mod, give to some bosses
-- Add magic crit hit rate reduction mod, give to some bosses
-- Add magic crit to some bosses
-- Knechts_Corpselight move logic onMobRoam too
-- Arg for setlevel and calcmobstate to heal the mob (false for these NMs)
-- Change text color for messages

tpz = tpz or {}
tpz.wotg = tpz.wotg or {}

tpz.wotg.regionsData = {
    [tpz.zone.CRAWLERS_NEST_S] = {
        amount = 12,
        environmental = {
            { Region = 13,
                Effect = tpz.effect.POISON,
                Power = 50,
                Tick = 3,
                Duration = 30,
                Msg = 'toxic'
            },
            { Region = 14,
                Effect = tpz.effect.SLOW,
                Effect2 = tpz.effect.WEIGHT,
                Power = 2500,
                Power2 = 1200,
                Tick = 0,
                Tick2 = 0,
                Duration = 30,
                Msg = 'time-warped'
            },
            { Region = 15,
                Effect = tpz.effect.CURSE_I,
                Power = 25,
                Tick = 0,
                Duration = 30,
                Msg = 'hexed'
            },
            { Region = 16,
                Effect = tpz.effect.PARALYSIS,
                Power = 45,
                Tick = 0,
                Duration = 30,
                Msg = 'freezing'
            },
        }
    },
    [tpz.zone.GARLAIGE_CITADEL_S] = {
    },
    [tpz.zone.THE_ELDIEME_NECROPOLIS_S] = {
    }
}

tpz.wotg.mobTypes = {
    Normal     = 1,
    Champion   = 2,
    Elite      = 3,
}

-- These two tables need to match
tpz.wotg.events = {
    Waves       = 1,
    Defense     = 2,
    Boss        = 3,
    Mimic       = 4,
    Special     = 5,
    MetaBoss    = 6
}
-- These two tables need to match
local eventList = {
    [1] = randomEventWaves,
    [2] = randomEventDefense,
    [3] = randomEventBoss,
    [4] = randomEventMimic,
    [5] = randomEventSpecial,
    [5] = randomEventMetaBoss,
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

local augments = {
    [tpz.zone.CRAWLERS_NEST_S] = {
        [tpz.items.WHITE_CLOAK] =
        {
            {
                stat = tpz.augments.MATT, 
                minimum = 4,
                maximum = 9
            },
            {
                stat = tpz.augments.ELEM, 
                minimum = 3,
                maximum = 7
            },
            {
                stat = tpz.augments.CONSERVE_MP, 
                minimum = 1,
                maximum = 3
            },
            {
                stat = tpz.augments.MAGIC_CRITHITRATE, 
                minimum = 3,
                maximum = 5
            },
            {
                stat = tpz.augments.INT, 
                minimum = 1,
                maximum = 3
            },
        },
        [tpz.items.BLACK_MITTS] =
        {
            {
                stat = tpz.augments.MND, 
                minimum = 4,
                maximum = 7
            },
            {
                stat = tpz.augments.ENFEEBLE, 
                minimum = 1,
                maximum = 5
            },
            {
                stat = tpz.augments.MP, 
                minimum = 5,
                maximum = 25
            },
            {
                stat = tpz.augments.CONSERVE_MP, 
                minimum = 1,
                maximum = 2
            },
            {
                stat = tpz.augments.MACC, 
                minimum = 1,
                maximum = 3
            },
        },
        [tpz.items.WHITE_SLACKS] =
        {
            {
                stat = tpz.augments.ENH_MAGIC_DURATION, 
                minimum = 4,
                maximum = 10
            },
            {
                stat = tpz.augments.MP, 
                minimum = 5,
                maximum = 25
            },
            {
                stat = tpz.augments.ENHANCE, 
                minimum = 1,
                maximum = 5
            },
            {
                stat = tpz.augments.CONSERVE_MP, 
                minimum = 1,
                maximum = 2
            },
            {
                stat = tpz.augments.CURE_SPELLCASTING_TIME_MINUS, 
                minimum = 1,
                maximum = 2
            },
        },
        [tpz.items.MOCCASINS] =
        {
            {
                stat = tpz.augments.MAGIC_BURST_DMG, 
                minimum = 3,
                maximum = 6
            },
            {
                stat = tpz.augments.MACC, 
                minimum = 3,
                maximum = 6
            },
            {
                stat = tpz.augments.MP, 
                minimum = 5,
                maximum = 25
            },
            {
                stat = tpz.augments.MAGIC_CRITHITRATE, 
                minimum = 1,
                maximum = 2
            },
            {
                stat = tpz.augments.INT, 
                minimum = 1,
                maximum = 3
            },
        }
    },

    [tpz.zone.THE_ELDIEME_NECROPOLIS_S] = {
        [tpz.items.WOOL_CAP] =
        {
            {
                stat = tpz.augments.PET_DT, 
                minimum = 2,
                maximum = 5
            },
            {
                stat = tpz.augments.PET_STR, 
                minimum = 1,
                maximum = 3
            },
            {
                stat = tpz.augments.PET_ACC_RACC, 
                minimum = 2,
                maximum = 6
            },
            {
                stat = tpz.augments.MP, 
                minimum = 10,
                maximum = 20
            },
            {
                stat = tpz.augments.PET_DOUBLE_ATTACK, 
                minimum = 1,
                maximum = 2
            },
        },
        [tpz.items.WOOL_GAMBISON] =
        {
            {
                stat = tpz.augments.EVA, 
                minimum = 7,
                maximum = 11
            },
            {
                stat = tpz.augments.VIT, 
                minimum = 5,
                maximum = 12
            },
            {
                stat = tpz.augments.DEF, 
                minimum = 15,
                maximum = 35
            },
            {
                stat = tpz.augments.HP, 
                minimum = 15,
                maximum = 30
            },
            {
                stat = tpz.augments.PDT, 
                minimum = 2,
                maximum = 4
            },
        },
        [tpz.items.WOOL_BRACERS] =
        {
            {
                stat = tpz.augments.EVA, 
                minimum = 7,
                maximum = 15
            },
            {
                stat = tpz.augments.ACC, 
                minimum = 1,
                maximum = 6
            },
            {
                stat = tpz.augments.HP, 
                minimum = 10,
                maximum = 20
            },
            {
                stat = tpz.augments.SUBTLE_BLOW, 
                minimum = 1,
                maximum = 3
            },
            {
                stat = tpz.augments.COUNTER, 
                minimum = 1,
                maximum = 5
            },
        },
        [tpz.items.WOOL_HOSE] =
        {
            {
                stat = tpz.augments.SNAP_SHOT, 
                minimum = 2,
                maximum = 5
            },
            {
                stat = tpz.augments.STR, 
                minimum = 1,
                maximum = 3
            },
            {
                stat = tpz.augments.AGI, 
                minimum = 1,
                maximum = 3
            },
            {
                stat = tpz.augments.HP, 
                minimum = 10,
                maximum = 25
            },
            {
                stat = tpz.augments.MARKSMANSHIP, 
                minimum = 1,
                maximum = 5
            },
        },
        [tpz.items.WOOL_SOCKS] =
        {
            {
                stat = tpz.augments.SKILLCHAINDMG, 
                minimum = 4,
                maximum = 7
            },
            {
                stat = tpz.augments.ATT, 
                minimum = 1,
                maximum = 5
            },
            {
                stat = tpz.augments.STORETP, 
                minimum = 1,
                maximum = 3
            },
            {
                stat = tpz.augments.HP, 
                minimum = 10,
                maximum = 20
            },
            {
                stat = tpz.augments.STR, 
                minimum = 1,
                maximum = 4
            },
        }
    },

    [tpz.zone.GARLAIGE_CITADEL_S] = {
        [tpz.items.ALUMINE_SALADE] =
        {
            {
                stat = tpz.augments.DUAL_WIELD, 
                minimum = 1,
                maximum = 5
            },
            {
                stat = tpz.augments.DEF, 
                minimum = 15,
                maximum = 35
            },
            {
                stat = tpz.augments.ICERES, 
                minimum = 10,
                maximum = 20
            },
            {
                stat = tpz.augments.HP, 
                minimum = 10,
                maximum = 20
            },
            {
                stat = tpz.augments.KATANA, 
                minimum = 1,
                maximum = 5
            },
        },
        [tpz.items.ALUMINE_HAUBERT] =
        {
            {
                stat = tpz.augments.ENHANCE, 
                minimum = 6,
                maximum = 12
            },
            {
                stat = tpz.augments.HP, 
                minimum = 15,
                maximum = 35
            },
            {
                stat = tpz.augments.WINDRES, 
                minimum = 15,
                maximum = 30
            },
            {
                stat = tpz.augments.DEF, 
                minimum = 15,
                maximum = 35
            },
            {
                stat = tpz.augments.SPELLINTERRUPT, 
                minimum = 9,
                maximum = 15
            },
        },
        [tpz.items.ALUMINE_MOUFLES] =
        {
            {
                stat = tpz.augments.PET_HASTE, 
                minimum = 2,
                maximum = 5
            },
            {
                stat = tpz.augments.PET_DEF, 
                minimum = 2,
                maximum = 5
            },
            {
                stat = tpz.augments.PET_ATTK_RATTK, 
                minimum = 15,
                maximum = 35
            },
            {
                stat = tpz.augments.PET_ACC_RACC, 
                minimum = 2,
                maximum = 5
            },
            {
                stat = tpz.augments.SIC_READY_CDR, 
                minimum = 2,
                maximum = 5
            },
        },
        [tpz.items.ALUMINE_BRAYETTES] =
        {
            {
                stat = tpz.augments.SHIELD, 
                minimum = 7,
                maximum = 12
            },
            {
                stat = tpz.augments.EARTHRES, 
                minimum = 10,
                maximum = 20
            },
            {
                stat = tpz.augments.HP, 
                minimum = 15,
                maximum = 25
            },
            {
                stat = tpz.augments.DEF, 
                minimum = 15,
                maximum = 35
            },
            {
                stat = tpz.augments.ENMITY, 
                minimum = 3,
                maximum = 7
            },
        },
        [tpz.items.ALUMINE_SOLERETS] =
        {
            {
                stat = tpz.augments.DT, 
                minimum = 2,
                maximum = 5
            },
            {
                stat = tpz.augments.DARKRES, 
                minimum = 10,
                maximum = 20
            },
            {
                stat = tpz.augments.DEF, 
                minimum = 15,
                maximum = 35
            },
            {
                stat = tpz.augments.HP, 
                minimum = 15,
                maximum = 25
            },
            {
                stat = tpz.augments.ENMITY, 
                minimum = 3,
                maximum = 7
            },
        }
    }
}

local function shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
end

local function GenerateAugments(player, chance)
    -- Roll a chance (1-100). Only proceed if the roll is within the success threshold.
    local roll = math.random(100)
    if roll > chance then
        return
    end

    if not player then
        return
    end

    local ID = zones[player:getZoneID()]
    local zoneAugments = augments[player:getZoneID()]
    if not zoneAugments then return end

    -- Get a random item key from this zone
    local itemList = {}
    for itemId in pairs(zoneAugments) do
        table.insert(itemList, itemId)
    end

    local item = itemList[math.random(#itemList)]
    local augmentOptions = zoneAugments[item]

    if not augmentOptions then
        printf("GenerateAugments: No augment options found for item %d", item)
        return
    end

    for _, member in pairs(player:getAlliance()) do
        local augments = {}
        local augmentIndex = 1
        local maxAugments = 1 + member:getMod(tpz.mod.PAST_DUNGEON_MASTER)

        local shuffled = {}
        for i = 1, #augmentOptions do
            shuffled[i] = augmentOptions[i]
        end
        shuffle(shuffled)

        for i = 1, math.min(maxAugments, #shuffled) do
            local augment = shuffled[i]
            local value = math.random(augment.minimum, augment.maximum)
            value = value - 1 -- Values start at 0. i.e. 1 value on an augment is equal to 2, 0 is equal to 1. 
            if value then
                augments[augmentIndex] = augment.stat
                augments[augmentIndex + 1] = value
                local augmentNames = utils.GetAugmentName()
                local statName = augmentNames[augment.stat]
                statName = utils.PunctuateString(statName)
                local itemdata = GetItem(item)
                local itemName = string.gsub(itemdata:getName(), '_', ' ');
                itemName = utils.PunctuateString(itemName)
                printf("Added augment for %s - Item: %s, Augment: %s Value %d (max augments: %d)", member:getName(), itemName, statName, value+1, maxAugments)
                augmentIndex = augmentIndex + 2
            else
                printf("Skipped augment: %s (value invalid)", tostring(augment.stat))
            end
            if augmentIndex > 10 then
                printf("Reached augment cap")
                break
            end
        end

        member:addItem(item, 1, augments[1], augments[2], augments[3], augments[4], augments[5], augments[6], augments[7], augments[8], augments[9], augments[10])
        member:messageSpecial(ID.text.ITEM_OBTAINED, item)
    end
end

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
    if (metaProgress < 100) then
        zone:setLocalVar("metaProgress", math.min(metaProgress + 5, 100))
        utils.MessageParty(player, 'Meta progress: ' .. zone:getLocalVar("metaProgress") .. '%', tpz.msg.textColor.HIDDEN, none)
        generateActiveRegions(zone)
    end
 end

 local function AddAugmentMod(player)
    local party = player:getParty()
    if player then
        if player:isTrust() or player:isPet() then
            party = player:getMaster():getParty()
        end
    end

    if party then
        for _, member in ipairs(party) do
            if member:isPC() then
                local augmentModPower = member:getMod(tpz.mod.PAST_DUNGEON_MASTER) or 0
                member:PrintToPlayer("You will now gain more augments on your items! (Amount: " .. augmentModPower .. ", max 5)", tpz.msg.textColor.HIDDEN, none)
            end
        end
    end
end

local function ClearMsgVars(zone)
    zone:setLocalVar("wavesMsg", 0)
end

local function GetMobType(mob)
    return mob:getLocalVar("wotgMobType")
end

local function PickMobType(mob, options)
    local totalWeight = 0
    for _, entry in ipairs(options) do
        totalWeight = totalWeight + entry.Chance
    end

    local roll = math.random(1, totalWeight)
    local runningSum = 0

    for _, entry in ipairs(options) do
        runningSum = runningSum + entry.Chance
        if roll <= runningSum then
            return entry.Type
        end
    end
end

local function GetmobTypeByName()
    local reverse = {}
    for k, v in pairs(tpz.wotg.mobTypes) do
        reverse[v] = k
    end
    return reverse
end

local function PickMobAura(mob)
    local auras = {
        { Effect = tpz.effect.GEO_ATTACK_BOOST,         Power = 33 },
        { Effect = tpz.effect.GEO_DEFENSE_BOOST,        Power = 33 },
        { Effect = tpz.effect.GEO_ACCURACY_BOOST,       Power = 50 },
        { Effect = tpz.effect.GEO_EVASION_BOOST,        Power = 50 },
        { Effect = tpz.effect.GEO_MAGIC_DEF_BOOST,      Power = 24 },
        { Effect = tpz.effect.GEO_MAGIC_EVASION_BOOST,  Power = 30 },
    }

    local selectedAura = auras[math.random(#auras)]
    mob:setLocalVar("wotgAuraEffect", selectedAura.Effect)
    mob:setLocalVar("wotgAuraPower", selectedAura.Power)
end

local mobTypeSpawn  = {
    [tpz.wotg.mobTypes.Champion] = function(player, mob)
        mob:setMod(tpz.mod.ATTP, 33)
        mob:setMod(tpz.mod.DEFP, 33)
        mob:setMod(tpz.mod.ACC, 20)
        mob:setMod(tpz.mod.EVA, 20)
        mob:addStatusEffect(tpz.effect.MAX_HP_BOOST, 25, 0, 0)
        mob:setHPP(100)
    end,

    [tpz.wotg.mobTypes.Elite] = function(player, mob)
        mob:setMod(tpz.mod.ATTP, 33)
        mob:setMod(tpz.mod.DEFP, 33)
        mob:setMod(tpz.mod.ACC, 20)
        mob:setMod(tpz.mod.EVA, 20)
        mob:addStatusEffect(tpz.effect.MAX_HP_BOOST, 50, 0, 0)
        mob:setHPP(100)
        PickMobAura(mob)
        player:setEntityFlags(tpz.entityFlags.SIZE_LARGE, mob:getID())
    end,
}

local mobTypeDeath = {
    [tpz.wotg.mobTypes.Champion] = function(player, mob)
        if (math.random(100) > 25) then
            for _, member in pairs(player:getAlliance()) do
                local amount = 1
                GiveTempItems(member, amount)
            end
        end
        local chance = 1
        GenerateAugments(player, chance)
    end,

    [tpz.wotg.mobTypes.Elite] = function(player, mob)
        for _, member in pairs(player:getAlliance()) do
            for _, member in pairs(player:getAlliance()) do
                local amount = 1
                GiveTempItems(member, amount)
            end
        end
        local chance = 5
        GenerateAugments(player, chance)
    end,
}

local function PrintMobTypeGeneration(mob)
    local mobType = GetMobType(mob)
    local mobTypeNames = GetmobTypeByName()
    local typeName = mobTypeNames[mobType] or "Unknown"
    typeName = utils.PunctuateString(typeName)
    local mobName = mob:getName()
    local mobId = mob:getID()
    printf("Mob Type Generated: %s [%d]: %s", mobName, mobId, typeName)
end

local function GenerateMob(player, mob)
    local typeData = {
        { Type = tpz.wotg.mobTypes.Normal,   Chance = 80 },
        { Type = tpz.wotg.mobTypes.Champion, Chance = 10 },
        { Type = tpz.wotg.mobTypes.Elite,    Chance = 10 },
    }

    local mobType = PickMobType(mob, typeData)
    local mobId = mob:getID()
    SpawnMob(mobId)
    mob:setLocalVar("wotgMobType", mobType)


    local spawnTypeHandler = mobTypeSpawn[mobType]
    if spawnTypeHandler then
        spawnTypeHandler(player, mob)
    end

    PrintMobTypeGeneration(mob) -- for debugging
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

local waves = {}
local currentWave = 1
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
        utils.MessageParty(player, 'CODE: Waves START', tpz.msg.textColor.HIDDEN, none)
        zone:setLocalVar("wavesMsg", 1)
    end

    return wave
end

local function randomEventWaves(player)
    waves = {} -- Reset waves for a new event
    currentWave = 1  -- Reset wave tracker
    local numWaves = math.random(2, 5)
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
        utils.MessageParty(player, 'A ferocious enemy appears!', tpz.msg.textColor.HIDDEN, none)
    end)

    utils.MessageParty(player, 'CODE: Boss START', tpz.msg.textColor.HIDDEN, none)
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
    utils.MessageParty(player, 'A peculiar chest appears!', tpz.msg.textColor.HIDDEN, none)
    zone:setLocalVar("eventActive", tpz.wotg.events.Mimic)
end

local function randomEventSpecial(player)
end

local function RandomEventComplete(player)
    local zone = player:getZone()
    local amount = math.random(1, 3)
    for _, member in pairs(player:getAlliance()) do
        GiveTempItems(member, amount)
        local chance = 25
        GenerateAugments(member, chance)
    end
    ProgressMeta(player, zone)
    ClearMsgVars(zone)
end

local function SpawnMetaBoss(player, zone)
    local zoneId = player:getZoneID()
    local bossData = metaBosses[zoneId]
    local eventActive = zone:getLocalVar("eventActive")
    -- TODO: Spams has spawned, doesnt spawn him
    -- Need to set eventActive and add entry for metaBoss
    if not bossData then
        printf("SpawnMetaBoss: No meta boss found.")
        return
    end

    if (eventActive > 0) then
        return
    end

    player:queue(30000, function(player) -- 30s wait before spawning
        local metaBossId = bossData.Id
        local spawnPos = bossData.Pos
        local metaBoss = GetMobByID(metaBossId)
        local metaBossName = MobName(metaBoss)

        if not boss:isSpawned() then
            SpawnMob(metaBossId)
            utils.MessageParty(player, metaBossName .. " has spawned at " .. spawnPos .. "!", tpz.msg.textColor.HIDDEN, nil)
        end
    end)
    zone:setLocalVar("eventActive", tpz.wotg.events.MetaBoss)
end

local modByMobName =
{
    ['Selket'] = function(mob)
        mob:setDelay(4000)
        mob:addMod(tpz.mod.REGAIN, 50)
        mob:setMod(tpz.mod.MDEF, 60)
        mob:setModelSize(3)
        -- Perma undispellable Clod Spikes
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
            {id = tpz.jsa.MIGHTY_STRIKES, hpp = math.random(10, 50)},
        },
    })
    end,

    ['Hound_of_Balthazar'] = function(mob)
        mob:setDamage(100)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
        mob:setMod(tpz.mod.FIRE_ABSORB, 100)
    end,

    ['Duke_Xavier'] = function(mob) -- Vampyr
        mob:setDamage(90)
        mob:setMod(tpz.mod.DEF, 1200)
        mob:setMod(tpz.mod.VIT, 150)
        mob:setMod(tpz.mod.WIND_ABSORB, 100)
        mob:setMod(tpz.mod.ENH_CASTING_TIME, 50)
        -- Perma undispellable Gale Spikes
        mob:addStatusEffect(tpz.effect.GALE_SPIKES, 25, 0, 0)
        local galeSpikes = mob:getStatusEffect(tpz.effect.GALE_SPIKES)
        galeSpikes:unsetFlag(tpz.effectFlag.DISPELABLE)

        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.ASTRAL_FLOW, hpp = math.random(10, 50)},
            },
        })
    end,

    ['Duke_Xaviers_Bat'] = function(mob)
        local NearbyPlayers = mob:getPlayersInRange(50)

        -- Fixates onto a random nearby player (NOT TRUST)
        if NearbyPlayers then
            for _, player in ipairs(NearbyPlayers) do
                mob:setMobMod(tpz.mobMod.FIXATE, player:getShortID())
            end
        end
    end,

    ['Tezcatli'] = function(mob) -- Corse
        mob:setMobMod(tpz.mobMod.SEVERE_SPELL_CHANCE, 25)
    end,

    ['Klagmuhme'] = function(mob) -- Corpselight
        mob:addMod(tpz.mod.QUICK_MAGIC, 10)
        mob:setMobMod(tpz.mobMod.SEVERE_SPELL_CHANCE, 25)
    end,

    ['Knecht'] = function(mob) -- Dvergr
        local partyWithCorpseLights = 19235
        mob:addMod(tpz.mod.DOUBLE_CAST, 20)
        mob:setMod(tpz.mod.RANGEDRES, 250)
        mob:setMobMod(tpz.mobMod.CUSTOMLINK, partyWithCorpseLights)
    end,

    ['Knechts_Corpselight'] = function(mob, target)
        local partyWithKnecht = 19235
        mob:setMobMod(tpz.mobMod.CUSTOMLINK, partyWithKnecht)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)
    end,

    ['Velfegor'] = function(mob) -- Tauri
        -- Perma undispellable Curse Spikes
        mob:addMod(tpz.mod.SPIKES, tpz.subEffect.CURSE_SPIKES)
    end,

    ['Kernunnos'] = function(mob) -- Gargouille
    end,

    ['Ethniu'] = function(mob)
    end,

    ['Tethra'] = function(mob)
    end,

    -- Lynx
    -- Djinn
    -- Cockatrice
    -- Bugard
    -- Ram
    -- Opo-opo
    -- Urganite
    -- Gnole
    -- Smilodon
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

    ['Hound_of_Balthazar'] = function(mob, target)
        local procDuration = mob:getLocalVar("procDuration")
        local auraParams = {
            radius = 20,
            effect = tpz.effect.PLAGUE,
            power = 3,
            duration = 3,
            auraNumber = 1
        }

        -- 1k+ Water magic bursts remove Plague aura for 60 seconds and applies Amnesia for 15 seconds
        mob:addListener("SPELL_DMG_TAKEN", "HoB_SPELL_DMG_TAKEN", function(mob, caster, spell, amount, msg)
            local element = spell:getElement()

            if (element == tpz.magic.ele.WATER) and (amount >= 1000) then
                if (msg == tpz.msg.basic.MAGIC_BURST_BLACK) or (msg == tpz.msg.MAGIC_BURST_BREATH) then
                    local duration = 15
                    BreakMob(mob, caster, tpz.procEffect.NONE, duration, tpz.procType.AMNESIA)
                    mob:setLocalVar("procced", os.time() + 60)
                end
            end
        end)

        -- 20 yard range 30/tick Plague aura
        if (os.time() >= procDuration) then
            AddMobAura(mob, target, auraParams)
            TickMobAura(mob, target, auraParams)
        end
    end,

    ['Duke_Xavier'] = function(mob, target)
        -- SMN/DRK. summons a red bat add that is not killed fast will charm a nearby player and bat costume them

        -- 500+ Cure magic bursts procs Amnesia for 60 seconds
        mob:addListener("SPELL_DMG_TAKEN", "XAVIER_SPELL_DMG_TAKEN", function(mob, caster, spell, amount, msg)
            local spellFamily = spell:getSpellFamily()

            if (spellFamily == tpz.magic.spellFamily.CURE) and (amount >= 500) then
                if (msg == tpz.msg.basic.MAGIC_BURST_BLACK) or (msg == tpz.msg.MAGIC_BURST_BREATH) then
                    local duration = 60
                    BreakMob(mob, caster, tpz.procEffect.NONE, duration, tpz.procType.AMNESIA)
                    mob:setLocalVar("procced", os.time() + 60)
                end
            end
        end)

        -- Astral flow summons 3 bats
        mob:addListener("WEAPONSKILL_STATE_EXIT", "XAVIER_MOBSKILL_FINISHED", function(mob, skillID)
            if (skillID == tpz.jsa.ASTRAL_FLOW) then
                for xavierBat = mob:getID()+1, mob:getID()+3 do
                    local bat = GetMobByID(xavierBat)
                    if bat then
                        bat:setSpawn(mob:getXPos() + math.random(2, 5), mob:getYPos(), mob:getZPos() + math.random(1, 3))
                        utils.spawnPetInBattle(mob, bat)
                    end
                end
            end
        end)
    end,

    ['Duke_Xaviers_Bat'] = function(mob, target)
        local battleTime = mob:getBattleTime()

        -- Charms a target player (NOT TRUST) after 30 seconds of being in combat
        if (battleTime >= 30) then
            mob:useMobAbility(tpz.jsa.CHARM)
        end
    end,

    ['Tezcatli'] = function(mob, target)
        -- Casts: Paralyga, Dispelga, Firaga III, Blizzaga III, Comet (Below 50%)
        local hpp = mob:getHPP()
        if (hpp < 50) then
            mob:addSpellListEntry(tpz.magic.spell.COMET)
        else
            mob:delSpelllistEntry(tpz.magic.spell.COMET)
        end

        -- Gains undispellable shock spikes while casting
        mob:addListener("MAGIC_START", "GOAFTRAP_MAGIC_START", function(mob, spell)
	        mob:addStatusEffect(tpz.effect.SHOCK_SPIKES, 15, 0, 0)
            local shockSpikes = mob:getStatusEffect(tpz.effect.SHOCK_SPIKES)
            shockSpikes:unsetFlag(tpz.effectFlag.DISPELABLE)
        end)
        mob:addListener("MAGIC_STATE_EXIT", "GOAFTRAP_MAGIC_STATE_EXIT", function(mob, spell)
            mob:delStatusEffectSilent(tpz.effect.SHOCK_SPIKES)
        end)

        -- Absorbs physical damage while readying TP moves
        mob:addListener("WEAPONSKILL_STATE_ENTER", "GOBLINTRAP_WS_STATE_ENTER", function(mob, skillID)
            mob:setMod(tpz.mod.PHYS_ABSORB, 100)
        end)

        mob:addListener("WEAPONSKILL_STATE_EXIT", "GOBLINTRAP_MOBSKILL_FINISHED", function(mob)
            mob:setMod(tpz.mod.PHYS_ABSORB, 0)
        end)
    end,

    ['Klagmuhme'] = function(mob, target)
        local hpp = mob:getHPP()

        -- Uses Death below 20% HP
        if (hpp < 20) then
            mob:addSpellListEntry(tpz.magic.spell.DEATH)
        else
            mob:delSpelllistEntry(tpz.magic.spell.DEATH)
        end
    end,

    ['Knecht'] = function(mob, target)
        -- WAR/DRK
        -- Double Cast (25%)
        -- Uses Cackle - > Hellsnap -> -ga (interrupting does not stop this combo)
        -- Two Corpselights connected to him, left one heals, right one -ga enfeebles players. Killing both forces a respawn of both, killing 1 does not
        -- Access to Thundris Shriek below 25%. 500+ damage, 50% para, 1m of humanoid killer
        local hpp = mob:getHPP()
        local lastHPP = mob:getLocalVar("last_spelllist_hpp")
        local spellListData = {
            {
                HP = 75,
                Spells = {
                    tpz.magic.spell.FIRAGA, tpz.magic.spell.BLIZZAGA, tpz.magic.spell.AEROGA,
                    tpz.magic.spell.STONEGA, tpz.magic.spell.THUNDAGA, tpz.magic.spell.WATERGA
                }
            },
            {
                HP = 25,
                Spells = {
                    tpz.magic.spell.FIRAGA_II, tpz.magic.spell.BLIZZAGA_II, tpz.magic.spell.AEROGA_II,
                    tpz.magic.spell.STONEGA_II, tpz.magic.spell.THUNDAGA_II, tpz.magic.spell.WATERGA_II
                }
            },
            {
                HP = 0,
                Spells = {
                    tpz.magic.spell.FIRAGA_III, tpz.magic.spell.BLIZZAGA_III, tpz.magic.spell.AEROGA_III,
                    tpz.magic.spell.STONEGA_III, tpz.magic.spell.THUNDAGA_III, tpz.magic.spell.WATERGA_III
                }
            }
        }

        -- Casts stronger spells as HP decreases
        -- 100-74% HP T1 -ga, 51-74 T2 -ga, 0-24 T3 -ga
        -- Only check to update spell list if mob HP was increased or decreased
        if (hpp ~= lastHPP) then
            -- Update stored HPP
            mob:setLocalVar("last_spelllist_hpp", hpp)

            -- Clear and rebuild spell list based on HP%
            mob:clearSpellList()

            for _, spellList in ipairs(spellListData) do
                if (hpp >= spellList.HP) then
                    for _, spellId in ipairs(spellList.Spells) do
                        mob:addSpellListEntry(spellId)
                    end
                    break -- Very important
                end
            end
        end
    end,

    ['Knechts_Corpselight'] = function(mob, target)
        local isHealer = (mob:getMainJob() == tpz.job.WHM)
        local isDebuffer = (mob:getMainJob() == tpz.job.RDM)
        local knecht = GetMobByID(17494856)

        -- Healer is always positioned to the left of Knecht, and debuffer to the right
        if knecht then
            local x, y, z = knecht:getPos()
            if isHealer then
                mob:setPos(x - 2, y, z)
            elseif isDebuffer then
                mob:setPos(x + 2, y, z)
            end
        end

        -- Always assist Knecht
        mob:setMobMod(tpz.mobMod.SHARE_TARGET, knecht:getShortID())
    end,

    ['Velfegor'] = function(mob, target)
        -- Access to Apocalyptic Ray (Conal Doom)
        local currentHP = mob:getHPP()
        local phaseData = {
            { HP = 10,     Var = 'meikyoShisui_10'   },
            { HP = 20,     Var = 'meikyoShisui_20'   },
            { HP = 30,     Var = 'meikyoShisui_30'   },
            { HP = 40,     Var = 'meikyoShisui_40'   },
            { HP = 50,     Var = 'meikyoShisui_50'   },
            { HP = 60,     Var = 'meikyoShisui_60'   },
            { HP = 70,     Var = 'meikyoShisui_70'   },
            { HP = 80,     Var = 'meikyoShisui_80'   },
            { HP = 90,     Var = 'meikyoShisui_90'   },
        }

        -- Every 10%, uses Meikyo Shisui and Apoc Ray x
        for _, phase in ipairs(phaseData) do
            if (currentHP <= phase.HP) and (mob:getLocalVar(phase.Var) == 0) then
                if
                    not IsMobBusy(mob) and
                    not mob:hasPreventActionEffect() and
                    not mob:hasStatusEffect(tpz.effect.MEIKYO_SHISUI)
                then
                    mob:setLocalVar(phase.Var, 1)
                    mob:useMobAbility(tpz.jsa.MEIKYO_SHISUI)
                    break
                end
            end
        end
    end,

    ['Kernunnos'] = function(mob, target)
        -- Alternates between flying / standing
        -- "Fly High" wyrm effect and 250/tick regain while flying.
        -- Only uses Dark Mist while flying (500+ damage)
        -- Stone forms every 20% HP, which is a full erase and grants him 500 damage spikes and 3000 magic SS. Immune to physical damage.
        -- Stone form is removed by breaking the magical stoneskin effect
        -- AoE Absorb-TP, Absorb-Attribute, Drain II, Aspir II, Stun, single target Dread Spikes
    end,

    ['Ethniu'] = function(mob, target)
    end,

    ['Tethra'] = function(mob, target)
    end,

    -- Lynx
        -- Charged whisker grants undispellable shock spikes, enthunder, and pulsing AoE thunder damage aura
        -- Aura removed by magic bursting 1k+ earth damage

    -- Djinn (Djinn mixin)
        -- DRK/DRK
        -- Casts storm on self then absorbs that element, SDT is changed to be weak to it's weakness and casts spells/enfeebles of that element

    -- Cockatrice
        -- WAR/DRK
        -- No SJ aura
        -- Contagion Transfer - AoE status transfers from the mob to all players within range.
        -- Sound Vacuum 10' AoE(not conal) mute.
        -- Enhancing magic casting time -50%
        -- Breakga, Stoneskin, Rasp, Stone IV, Stonega III

    -- Bugard
        -- THF/DRK
        -- Perma perfect dodge
        -- Nightmare Bugard moves
        -- Tyrant Tusk (If this attack puts targets HP below 50%, then insta kill)

    -- Ram
        -- WAR/SAM
        -- Keeps mighty strikes up at all times(uses it, isn't just a perma buff)
        -- Reduced move speed (40? 30?)
        -- NO_DR mob mod

    -- Opo-opo
        -- Doesn't auto and keeps distance (15.5 yalms). Stone Throw JA auto
        -- Claw Storm is also AOE Bio
        -- Magic Fruit 3.5s cast time
        -- Uses Vacant Gaze, dispels up to 3 effects
        -- Vicious Claw "Throat Stab" + Enmity reset

    -- Urganite
        -- Casts Holy II, Banishga III, Banish IV, Flash(AOE)
    -- Gnole
        -- Gnole mixin
        -- In "2 legs" mode, takes normal magical damage and has 100% counter and guard rate
        -- In "4 legs" mode, takes -95% magic damage, casts spells, and cannot counter or guard

    -- Smilodon
        -- Cures self with Cure V Curaga IV, buffs self with Haste II Temper etc
        -- Fixates on random target every 60-90s
}

local mobWSPrepareByMobName =
{
    ['Angry_Scorpion'] = function(mob, target)
        -- Prefer using Hell Scissors over other TP moves
        local roll = math.random()
        if (roll < 0.50) then
            return tpz.mob.skills.HELL_SCISSORS
        else
            return math.random(tpz.mob.skills.NUMBING_BREATH, tpz.mob.skills.SHARP_STRIKE)
        end
    end,

    ['Selket'] = function(mob, target)
        -- Prefer using Hell Scissors over other TP moves
        local roll = math.random()
        if (roll < 0.50) then
            return tpz.mob.skills.HELL_SCISSORS
        else
            return math.random(tpz.mob.skills.NUMBING_BREATH, tpz.mob.skills.SHARP_STRIKE)
        end
    end,

    ['Velfegor'] = function(mob, target)
        if mob:hasStatusEffect(tpz.effect.MEIKYO_SHISUI) then
            return tpz.mob.skills.APOCALYPTIC_RAY
        end
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
    mob:addMod(tpz.mod.SPELLINTERRUPT, 300)
    mob:setMod(tpz.mod.ATTP, 25)
    mob:setMod(tpz.mod.DEFP, 25)
    mob:setMod(tpz.mod.EEM_SILENCE, 5)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)

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

    if (GetMobType(mob) == tpz.wotg.mobTypes.Elite) then
        local auraParams = {
            radius = 10,
            effect = mob:getLocalVar("wotgAuraEffect"),
            power = mob:getLocalVar("wotgAuraPower"),
            duration = 30,
            auraNumber = 1
        }

        AddMobAura(mob, target, auraParams)
        TickMobBuffAura(mob, target, auraParams)
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
function eventOnMobDeath.Waves(mob, player, isKiller, noKiller)
    local zone = mob:getZone()
    local waveProgress = zone:getLocalVar("waveProgress")
    local mobType = GetMobType(mob)
    local deathTypeHandler = mobTypeDeath[mobType]

    if isKiller or noKiller then
        if deathTypeHandler then
            deathTypeHandler(player, mob)
        end
    end

    -- printf("Mob dead, incrementing wave progress by 1")
    zone:setLocalVar("waveProgress", waveProgress + 1)
end

function eventOnMobDeath.Boss(mob, player, isKiller, noKiller)
    local zone = player:getZone()
    local amount = math.random(2, 4)
    GiveTempItems(player, amount)
    ClearMsgVars(zone)
    if isKiller or noKiller then
        ProgressMeta(player, zone)
        local chance = 100
        GenerateAugments(player, chance)
    end
    zone:setLocalVar("eventActive", 0)
end

function eventOnMobDeath.Mimic(mob, player, isKiller, noKille)
    local zone = player:getZone()
    local amount = math.random(3, 5)
    GiveTempItems(player, amount)
    ClearMsgVars(zone)
    if isKiller or noKiller then
        ProgressMeta(player, zone)
        local chance = 100
        GenerateAugments(player, chance)
    end
    zone:setLocalVar("eventActive", 0)
end

function eventOnMobDeath.MetaBoss(mob, player, isKiller, noKiller)
    local zone = player:getZone()
    if isKiller or noKiller then
        local chance = 100
        GenerateAugments(player, chance)
        -- Increased number augments on items, removed by zoning
        for _, member in pairs(player:getAlliance()) do
            member:addMod(tpz.mod.PAST_DUNGEON_MASTER, 1)
        end
        AddAugmentMod(player)
        zone:setLocalVar("metaProgress", 0)
        zone:setLocalVar("eventActive", 0)
        utils.MessageParty(player, 'Meta progress: ' .. zone:getLocalVar("metaProgress") .. '%', tpz.msg.textColor.HIDDEN, none)
        end
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
    randomEventWaves(player) -- TODO: Remove after done testing
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
                GenerateMob(player, mob)
                mob:updateEnmity(player)
                mob:updateClaim(player)
                mob:addStatusEffect(tpz.effect.TERROR, 1, 0, 3)
                posOffset = posOffset + 0.5
            end
        end
        print("Spawning Wave " .. waveIndex)
        utils.MessageParty(player, 'Enemies appear around you!', tpz.msg.textColor.HIDDEN, none)
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

tpz.wotg.onZoneTick = function(player, zone, region)
    local currentWave = zone:getLocalVar("wave")
    local waveProgress = zone:getLocalVar("waveProgress")
    local waveSize = zone:getLocalVar("waveSize")
    local maxWaves = zone:getLocalVar("maxWaves")
    local eventCompleted = zone:getLocalVar("eventCompleted")
    local metaProgress = zone:getLocalVar("metaProgress")

    -- Progress check logic
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

    -- Environmental region logic
    if not region then
        return
    end

    local zoneId = zone:getID()
    local activeRegions = tpz.wotg.getActiveRegions(zoneId)
    local zoneData = tpz.wotg.regionsData[zoneId]
    local regionID = region:GetRegionID()

    if not zoneData.environmental then
        return
    end

    for _, environmentalData in ipairs(zoneData.environmental) do
        if (environmentalData.Region == regionID) then
            if not player:hasStatusEffect(environmentalData.Effect) then
                local party = player:getPartyWithTrusts()
                if party then
                    for _, member in ipairs(party) do
                        if environmentalData.Effect then
                            member:addStatusEffect(environmentalData.Effect, environmentalData.Power, environmentalData.Tick, environmentalData.Duration)
                            local effect = member:getStatusEffect(environmentalData.Effect)
                            if (effect ~= nil) then
                                effect:unsetFlag(tpz.effectFlag.WALTZABLE)
                            end
                        end
                        if environmentalData.Effect2 then
                            member:addStatusEffect(environmentalData.Effect2, environmentalData.Power2, environmentalData.Tick2, environmentalData.Duration)
                            local effect = member:getStatusEffect(environmentalData.Effect2)
                            if (effect ~= nil) then
                                effect:unsetFlag(tpz.effectFlag.WALTZABLE)
                            end
                        end
                    end
                end
                player:PrintToPlayer("The room is " .. environmentalData.Msg .. "!", 0xD, none)
            end
        end
    end
end

tpz.wotg.onRegionEnter = function(player, region)
    local zone = player:getZone()
    local zoneId = zone:getID()
    local activeRegions = tpz.wotg.getActiveRegions(zoneId)
    local regionID = region:GetRegionID()
    local regionEnterDelay = zone:getLocalVar("regionEnterDelay")
    local spawnChance = 10

    -- Event related regions
    if activeRegions then
        for _, activeRegionID in ipairs(activeRegions) do
            if (regionID == activeRegionID) then
                print("Player entered a random event region")
                if (os.time() >= regionEnterDelay) then
                    zone:setLocalVar("regionEnterDelay", os.time() + 10)
                    zone:setLocalVar("lastRegion", regionID)
                    tpz.wotg.RandomEvent(player)
                end
                break
            end
        end
    end
end
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
require("scripts/globals/titles")
-----------------------------------
-- TODO:
-- tpz.wotg.RandomEvent need the forced spawn removed (randomEventWaves(player)) and should only spawn at 10% of time
--  weather related event (during weather only)
--  undead related event (night only)
-- logic for mob despawning maybe? despawn event/mobs after inactive for 5m?
-- some NM to reflect spell casts, and some NM (scorpion?) to counter WS with a TP move onto that player
-- give one of the trash mobs hastega (make it II effect) regenga IV, etc
-- has to be able to AOE it onto other mobs so needs to be in family somehow...or just hard code AOEing it on spellcast
-- Delete tpz.wotg.WaveonMobDeath?
-- Add a way to re-add +augment mod incase of DC
-- Test values given by augments with prints
-- Test SAVETP mod
-- Test if mob OFFENSIVE auras still work (TickMobAura) and don't AOE onto other nearby mobs
-- Test if BreakMob still works and works if a trust breaks the mob
-- Mobs that res eachother?
-- Make sure all spikes still work properly
-- Fomors (Lugh etc) special mobmod to ignore enmity and only focus whatever did newest CE/VE? read bg wiki page for tethra/etniu
-- Mechanics like abyssea for killing mobs? atmas to collect? stat boosts for clearing every zone boss? meta progression? 1 attribute boost per bos?
-- Store augment buff in one of the atma or stat buffs or the abyssea buff itself.
-- Earth bosses gain stoneskin (undispellable) after using TP moves
-- Wind bosses gain blink (undispellable) after using TP moves
-- Dark bosses ga magic stoneskin (undispellable) after using TP moves
-- Light bosses gain regain (undispellable) after using TP moves
-- Add ranged eva mod, give to some bosses
-- Add magic crit def mod, give to some bosses
-- Add magic crit hit rate reduction mod, give to some bosses
-- Add magic crit to some bosses
-- Eldieme Goblin Pioneer lays mines/patrols (one by ethniu)
-- bosses and metaBosses tables needs eldieme and garlaige
-- Code or remove randomEventDefense from both tables
-- environmental for eldieme and garlaige
-- Crawlers Nest [S] chest/coffer still work?
-- Test DMG of djinn TP moves during day/night random times
-- randomEventMimic needs some logic (or wait / while isDead()?) to make sure it doesn't get "stuck" if mimic is in death state and another one is triggered
-- /heal show zone data (meta progress %) and augments power

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
                SubPower = 0,
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
                SubPower = 0,
                Msg = 'time-warped'
            },
            { Region = 15,
                Effect = tpz.effect.CURSE_I,
                Power = 25,
                Tick = 0,
                Duration = 30,
                SubPower = 0,
                Msg = 'hexed'
            },
            { Region = 16,
                Effect = tpz.effect.PARALYSIS,
                Power = 45,
                Tick = 0,
                Duration = 30,
                SubPower = 0,
                Msg = 'freezing'
            },
        }
    },
    [tpz.zone.GARLAIGE_CITADEL_S] = {
    },
    [tpz.zone.THE_ELDIEME_NECROPOLIS_S] = {
        amount = 14,
        environmental = {
            { Region = 5,
                Effect = tpz.effect.MUTE,
                Power = 1,
                Tick = 0,
                Duration = 30,
                SubPower = 0,
                Msg = 'devoid of oxygen'
            },
            { Region = 7,
                Effect = tpz.effect.BLINDNESS,
                Power = 255,
                Tick = 0,
                Duration = 30,
                SubPower = 0,
                Msg = 'pitch black'
            },
            { Region = 9,
                Effect = tpz.effect.AMNESIA,
                Power = 1,
                Tick = 0,
                Duration = 30,
                SubPower = 0,
                Msg = 'confusing'
            },
            { Region = 11,
                Effect = tpz.effect.DROWN,
                Power = 89,
                Tick = 3,
                Duration = 30,
                SubPower = 50,
                Msg = 'suffocating'
            },
        }
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
        Peistes = { 17478229, 17478230, 17478231, 17478232, 17478233, 17478234, 17478235, 17478236, 17478237, 17478238 },
    },

    [tpz.zone.GARLAIGE_CITADEL_S] = {
        Lynx   = {17449570, 17449571, 17449572, 17449573, 17449574, 17449575, 17449576, 17449577, 17449578, 17449579},
        Djinn  = {17449580, 17449581, 17449582, 17449583, 17449584, 17449585, 17449586, 17449587, 17449588, 17449589},
        Ziz    = {17449590, 17449591, 17449592, 17449593, 17449594, 17449595, 17449596, 17449597, 17449598, 17449599},
        Bugard = {17449600, 17449601, 17449602, 17449603, 17449604, 17449605, 17449606, 17449607, 17449608, 17449609},
        Ram    = {17449610, 17449611, 17449612, 17449613, 17449614, 17449615, 17449616, 17449617, 17449618, 17449619},
        Opoopo = {17449620, 17449621, 17449622, 17449623, 17449624, 17449625, 17449626, 17449627, 17449628, 17449629},
        Uragnite = {17449630, 17449631, 17449632, 17449633, 17449634, 17449635, 17449636, 17449637, 17449638, 17449639},
        Gnole  = {17449640, 17449641, 17449642, 17449643, 17449644, 17449645, 17449646, 17449647, 17449648, 17449649},
        Smilodon = {17449650, 17449651, 17449652, 17449653, 17449654, 17449655, 17449656, 17449657, 17449658, 17449659},
    },

    [tpz.zone.THE_ELDIEME_NECROPOLIS_S] = {
        Skeletons = { 17494789, 17494790, 17494791, 17494792, 17494793, 17494794, 17494795, 17494796, 17494797, 17494798 },
        Ghosts    = { 17494799, 17494800, 17494801, 17494802, 17494803, 17494804, 17494805, 17494806, 17494807, 17494808 },
        Hounds    = { 17494809, 17494810, 17494811, 17494812, 17494813, 17494814, 17494815, 17494816, 17494817, 17494818 },
        Doomed = { 17494819, 17494820, 17494821, 17494822, 17494823, 17494824, 17494825, 17494826, 17494827, 17494828 },
        Corse = { 17494829, 17494830, 17494831, 17494832, 17494833, 17494834, 17494835, 17494836, 17494837, 17494838 },
        Corpselight = { 17494839, 17494840, 17494841, 17494842, 17494843, 17494844, 17494845, 17494846, 17494847, 17494848 },
    },
}

local bosses = {
    -- Scorpion(Gold), Rafflesia, Gnat, Ladybug, Slug, Peiste
    [tpz.zone.CRAWLERS_NEST_S] = { 17478239, 17478240, 17478241, 17478242, 17478243, 17478244 },
    [tpz.zone.GARLAIGE_CITADEL_S] = { 17494849, 17494850, 17494854, 17494855,  17494856, 17494857, 17494858 },
    [tpz.zone.THE_ELDIEME_NECROPOLIS_S] = { },
}

local chests = {
    [tpz.zone.CRAWLERS_NEST_S] = { Mimic = 17478246, TreasureChest = 17478247 },
    --[tpz.zone.GARLAIGE_CITADEL_S] = { Mimic = , TreasureChest =  },
    [tpz.zone.THE_ELDIEME_NECROPOLIS_S] = { Mimic = 17494859, TreasureChest = 17494860 },
}

local metaBosses = {
    [tpz.zone.CRAWLERS_NEST_S] = {
        { Name = 'Lugh', Id = 17477708, Pos = 'E-7', Title = tpz.title.LUGH_EXORCIST },
    },
    [tpz.zone.GARLAIGE_CITADEL_S] = {
        { Name = 'Ethniu', Id = 17494093, Pos = 'K-7', Title = tpz.title.ETHNIU_EXORCIST },
        { Name = 'Tethra', Id = 17494213, Pos = 'K-12', Title = tpz.title.TETHRA_EXORCIST },
    },
    [tpz.zone.THE_ELDIEME_NECROPOLIS_S] = {}, -- tpz.title.ELATHA_EXORCIST, tpz.title.BUARAINECH_EXORCIST
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
                --printf("Added augment for %s - Item: %s, Augment: %s Value %d (max augments: %d)", member:getName(), itemName, statName, value+1, maxAugments)
                augmentIndex = augmentIndex + 2
            else
                printf("Skipped augment: %s (value invalid)", tostring(augment.stat))
            end
            if augmentIndex > 10 then
                --printf("Reached augment cap")
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
        if  math.random(1,10000) <= mob:getDropRate(240) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= mob:getDropRate(240) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= mob:getDropRate(150) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= mob:getDropRate(100) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= mob:getDropRate(50) then
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
        if  math.random(1,10000) <= mob:getDropRate(240) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= mob:getDropRate(240) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= mob:getDropRate(150) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= mob:getDropRate(100) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= mob:getDropRate(50) then
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
        if  math.random(1,10000) <= mob:getDropRate(240) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= mob:getDropRate(240) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= mob:getDropRate(150) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= mob:getDropRate(100) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= mob:getDropRate(50) then
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
        if math.random(1,10000) <= mob:getDropRate(240) then
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
        if math.random(1,10000) <= mob:getDropRate(240) then
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
        if math.random(1,10000) <= mob:getDropRate(240) then 
		    player:addTreasure(tpz.items.SILVER_MIRROR, mob)
	    end
    end
end

tpz.wotg.MagianT4 = function(mob, player, isKiller, noKiller)
    player:addCurrency("allied_notes", 500)
	if isKiller or noKiller then
        if math.random(1,10000) <= mob:getDropRate(240) then 
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
            tpz.items.TUBE_OF_CLEAR_SALVE_I, tpz.items.TUBE_OF_CLEAR_SALVE_II, tpz.items.BOTTLE_OF_SHEPHERDS_DRINK
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
            tpz.items.BOTTLE_OF_GNOSTICS_DRINK, tpz.items.BOTTLE_OF_CLERICS_DRINK,
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
        zone:queue(15000, function(zone)
            generateActiveRegions(zone)
        end)
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
    --printf("Mob Type Generated: %s [%d]: %s", mobName, mobId, typeName)
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
    local zoneId = zone:getID()
    local chestData = chests[zoneId]

    if not chestData then
        printf("No chest data for zoneId: %d", zoneId)
        return
    end

    local mimic = chestData.Mimic
    local treasureChest = chestData.TreasureChest
    local chestId = (math.random(100) <= 50) and mimic or treasureChest -- Either spawn a mimic or treasure chest
    local chest = GetEntityByID(chestId)
    printf("Chest ID: %d", chestId)

    local xPos, yPos, zPos, zRot = player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos()
    local posOffset = 0.5
    player:queue(5000, function(player) 
        if not chest:isSpawned() then
            chest:setSpawn(xPos + posOffset, yPos, zPos + posOffset)
            chest:spawn()
            if (chestId == treasureChest) then
                printf("Is treasure chest, setPos and status")
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
        if #bossData == 0 then
            return -- shouldn't happen
        end

        -- pick a random boss from the list
        local randomIndex = math.random(1, #bossData)
        local boss = bossData[randomIndex]

        local metaBossId = boss.Id
        local spawnPos = boss.Pos
        local metaBoss = GetMobByID(metaBossId)
        local metaBossName = MobName(metaBoss)

        if not metaBoss:isSpawned() then
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
        mob:setDamage(90)
        mob:addMod(tpz.mod.DEFP, 25)
        mob:addMod(tpz.mod.EVA, 25)
        mob:addMod(tpz.mod.MDEF, 24)
        mob:setMod(tpz.mod.VIT, 175)
        mob:setMod(tpz.mod.REGEN, 25)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
        mob:setMod(tpz.mod.FIRE_ABSORB, 100)
        mob:addImmunity(tpz.immunity.SILENCE)
        mob:addImmunity(tpz.immunity.BIND)
        mob:addImmunity(tpz.immunity.GRAVITY)
        mob:addImmunity(tpz.immunity.PETRIFY)
        mob:addImmunity(tpz.immunity.SLOW)
        mob:addImmunity(tpz.immunity.BLIND)
        mob:setMobMod(tpz.mobMod.DRAW_IN, 2)
        mob:setMobMod(tpz.mobMod.HUMANOID, 1)

        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 300, hpp = 35},
            },
        })
    end,

    ['Hound_of_Balthazar'] = function(mob)
        mob:setDamage(100)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
        mob:setMod(tpz.mod.FIRE_ABSORB, 100)
    end,

    ['Duke_Xavier'] = function(mob) -- Vampyr
        mob:setDamage(20)
        mob:setMod(tpz.mod.DEF, 1200)
        mob:setMod(tpz.mod.VIT, 150)
        mob:setMod(tpz.mod.WIND_ABSORB, 100)
        mob:setMod(tpz.mod.ENH_CASTING_TIME, 50)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
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
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
        mob:setMobMod(tpz.mobMod.SEVERE_CHANCE, 25)
    end,

    ['Klagmuhme'] = function(mob) -- Corpselight
        mob:addMod(tpz.mod.QUICK_MAGIC, 10)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
        mob:setMobMod(tpz.mobMod.SEVERE_CHANCE, 25)
    end,

    ['Knecht'] = function(mob) -- Dvergr
        local partyWithCorpseLights = 19235
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
        mob:addMod(tpz.mod.DOUBLE_CAST, 20)
        mob:setMod(tpz.mod.RANGEDRES, 250)
        mob:setMobMod(tpz.mobMod.CUSTOMLINK, partyWithCorpseLights)
    end,

    ['Knechts_Corpselight'] = function(mob, target)
        local partyWithKnecht = 19235
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
        mob:setMobMod(tpz.mobMod.CUSTOMLINK, partyWithKnecht)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
    end,

    ['Velfegor'] = function(mob) -- Tauri
        -- Perma undispellable Curse Spikes
        mob:addMod(tpz.mod.SPIKES, tpz.subEffect.CURSE_SPIKES)
    end,

    ['Kernunnos'] = function(mob) -- Gargouille
    end,

    ['Ethniu'] = function(mob)
        mob:setDamage(90)
        mob:addMod(tpz.mod.DEFP, 25)
        mob:addMod(tpz.mod.MDEF, 24)
        mob:setMod(tpz.mod.VIT, 175)
        mob:setMod(tpz.mod.REGEN, 25)
        mob:setMod(tpz.mod.WIND_ABSORB, 100)
        mob:addImmunity(tpz.immunity.SILENCE)
        mob:addImmunity(tpz.immunity.BIND)
        mob:addImmunity(tpz.immunity.GRAVITY)
        mob:addImmunity(tpz.immunity.PETRIFY)
        mob:addImmunity(tpz.immunity.SLOW)
        mob:addImmunity(tpz.immunity.BLIND)
        mob:setMobMod(tpz.mobMod.DRAW_IN, 2)
        mob:setMobMod(tpz.mobMod.HUMANOID, 1)

        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.PERFECT_DODGE, cooldown = 300, hpp = 35},
            },
        })
    end,

    ['Tethra'] = function(mob)
        mob:addMod(tpz.mod.DEFP, 25)
        mob:addMod(tpz.mod.MDEF, 24)
        mob:setMod(tpz.mod.VIT, 175)
        mob:setMod(tpz.mod.REGEN, 25)
        mob:setMod(tpz.mod.EARTH_ABSORB, 100)
        mob:addImmunity(tpz.immunity.SILENCE)
        mob:addImmunity(tpz.immunity.BIND)
        mob:addImmunity(tpz.immunity.GRAVITY)
        mob:addImmunity(tpz.immunity.PETRIFY)
        mob:addImmunity(tpz.immunity.SLOW)
        mob:addImmunity(tpz.immunity.BLIND)
        mob:addImmunity(tpz.immunity.PARALYZE)
        mob:setMobMod(tpz.mobMod.DRAW_IN, 2)
        mob:setMobMod(tpz.mobMod.HUMANOID, 1)

        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.MANAFONT, cooldown = 300, hpp = 35},
            },
        })
    end,

    ['Anhur'] = function(mob)
    end,

    ['Barqan'] = function(mob)
    end,

    ['Ahmet'] = function(mob)
        mob:setMod(tpz.mod.ENH_CASTING_TIME, 50)
    end,

    ['Shedyet'] = function(mob)
        mob:addStatusEffect(tpz.effect.PERFECT_DODGE)
    end,

    ['Khnum'] = function(mob)
        mob:setMobMod(tpz.mobMod.NO_DR, 1)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, -25)

        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 30, hpp = 100},
            },
        })
    end,

    ['Aegyptopithecus'] = function(mob)
    end,

    ['Ammonoidea'] = function(mob)
    end,

    ['Anubis'] = function(mob)
    end,

    ['Amunet'] = function(mob)
    end,

    -- Lynx
    -- Djinn
    -- Ziz
    -- Bugard
    -- Ram
    -- Opo-opo
    -- Urganite
    -- Gnole
    -- Smilodon (Use model 0x0000C80800000000000000000000000000000000)
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

    ['Knechts_Corpselight'] = function(mob)
        local isHealer = (mob:getMainJob() == tpz.job.WHM)
        local isDebuffer = (mob:getMainJob() == tpz.job.RDM)
        local knecht = GetMobByID(17494856)

        -- Healer is always positioned to the left of Knecht, and debuffer to the right
        if
            knecht and
            not IsMobBusy(mob) and
            not mob:hasPreventActionEffect()
        then
            local pos = knecht:getPos()
            local rot = knecht:getRotPos() * (2 * math.pi / 256)

            local distance = 2

            if isDebuffer then
                local offsetX = math.cos(rot + math.pi / 2) * distance
                local offsetZ = math.sin(rot + math.pi / 2) * distance
                mob:setPos(pos.x + offsetX, pos.y, pos.z + offsetZ)
            elseif isHealer then
                local offsetX = math.cos(rot - math.pi / 2) * distance
                local offsetZ = math.sin(rot - math.pi / 2) * distance
                mob:setPos(pos.x + offsetX, pos.y, pos.z + offsetZ)
            end
        end

        -- Always assist Knecht
        mob:setMobMod(tpz.mobMod.SHARE_TARGET, knecht:getShortID())
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
            mob:setMobLevel(level +1, false)
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

		if (animationSub == 1) then
            local gazeTick = mob:getLocalVar("gazeTick")
            if (os.time() >= gazeTick) then
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
                            v:addStatusEffect(tpz.effect.PETRIFICATION, 1, 0, 3)
                        end
                    end
		        end
                mob:setLocalVar("gazeTick", os.time() +3)
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

        -- Perma gaze petrification (unless procced)
        -- Gaze petrification is removed while terrored or Blinded
        if mob:hasStatusEffect(tpz.effect.TERROR) or mob:hasStatusEffect(tpz.effect.BLINDNESS) then
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
        local lvlUp = mob:getLocalVar("lvlUp")
        if
            (lvlUp > 0) and
            not IsMobBusy(mob) and
            not mob:hasPreventActionEffect()
        then
            local level = mob:getMainLvl()
            mob:useMobAbility(tpz.mob.skills.LEVEL_UP, mob)
            mob:setMobLevel(level +1, false)
            -- Mods and Mobmods are cleared on leveling up, need to readd them
            tpz.wotg.onMobSpawn(mob)
            mob:setLocalVar("lvlUp", 0)
        end

        -- Levels up when a player/trust dies, on successful Heat Breath / Exuviation casts
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
        local timedBat = GetMobByID(17494851)
        local batIsRoaming = GetMobAction(17494851) == tpz.act.ROAMING
	    local batTimer = mob:getLocalVar("batTimer")

        -- Summons a red bat add that is not killed fast will charm a nearby player and bat costume them
        if
            not timedBat:isSpawned() and
            not IsMobBusy(mob) and
            not mob:hasPreventActionEffect() and
            not mob:hasStatusEffect(tpz.effect.ASTRAL_FLOW)
        then
            if (batTimer == 0) then
                mob:setLocalVar("batTimer", os.time() + 45)
            elseif (os.time() >= batTimer) then
                timedBat:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 2))
                utils.spawnPetInBattle(mob, timedBat)
                mob:setLocalVar("batTimer", os.time() + 90)
            end
        end

        for xavierBat = mob:getID() + 1, mob:getID() + 3 do
            local bat = GetMobByID(xavierBat)
            if bat and bat:isSpawned() and GetMobAction(xavierBat) == tpz.act.ROAMING then
                local NearbyPlayers = mob:getPlayersInRange(50)
                if NearbyPlayers and #NearbyPlayers > 0 then
                    local randomTarget = NearbyPlayers[math.random(1, #NearbyPlayers)]
                    if randomTarget:isAlive() and randomTarget:getAllegiance() ~= mob:getAllegiance() then
                        bat:updateEnmity(randomTarget)
                    end
                end
            end
        end

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
                        bat:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 2))
                        bat:spawn()
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
        local hpp = mob:getHPP()

        -- Casts: Paralyga, Dispelga, Firaga III, Blizzaga III, Comet (Below 50%)
        if (hpp < 50) then
            mob:addSpellListEntry(tpz.magic.spell.COMET)
        else
            mob:delSpelllistEntry(tpz.magic.spell.COMET)
        end

        -- Gains undispellable shock spikes while casting
        mob:addListener("MAGIC_START", "TAZCATLI_MAGIC_START", function(mob, spell)
	        mob:addStatusEffect(tpz.effect.SHOCK_SPIKES, 15, 0, 0)
            local shockSpikes = mob:getStatusEffect(tpz.effect.SHOCK_SPIKES)
            shockSpikes:unsetFlag(tpz.effectFlag.DISPELABLE)
        end)
        mob:addListener("MAGIC_STATE_EXIT", "TAZCATLI_MAGIC_STATE_EXIT", function(mob, spell)
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

        -- Two Corpselights connected to him, left one heals, right one -ga enfeebles players. Killing both forces a respawn of both, killing 1 does not
        local healer = GetMobByID(17494861)
        local debuffer = GetMobByID(17494862)

        if not healer:isSpawned() and not debuffer:isSpawned() and mob:isAutoAttackEnabled() then
            healer:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 2))
            debuffer:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 2))
            utils.spawnPetInBattle(mob, { healer, debuffer })
        end

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

        -- Access to Thundris Shriek below 25%. 500+ damage, 50% para, 1m of humanoid killer
        if (hpp < 25) then
            mob:addSkillListEntry(tpz.mob.skills.THUNDRIS_SHRIEK)
        else
            mob:delSkillListEntry(tpz.mob.skills.THUNDRIS_SHRIEK)
        end
    end,

    ['Knechts_Corpselight'] = function(mob, target)
        local isHealer = (mob:getMainJob() == tpz.job.WHM)
        local isDebuffer = (mob:getMainJob() == tpz.job.RDM)
        local knecht = GetMobByID(17494856)

        -- Healer is always positioned to the left of Knecht, and debuffer to the right
        if
            knecht and
            not IsMobBusy(mob) and
            not mob:hasPreventActionEffect()
        then
            local pos = knecht:getPos()
            local rot = knecht:getRotPos() * (2 * math.pi / 256)

            local distance = 2

            if isDebuffer then
                local offsetX = math.cos(rot + math.pi / 2) * distance
                local offsetZ = math.sin(rot + math.pi / 2) * distance
                mob:setPos(pos.x + offsetX, pos.y, pos.z + offsetZ)
            elseif isHealer then
                local offsetX = math.cos(rot - math.pi / 2) * distance
                local offsetZ = math.sin(rot - math.pi / 2) * distance
                mob:setPos(pos.x + offsetX, pos.y, pos.z + offsetZ)
            end
        end

        -- Always assist Knecht
        mob:setMobMod(tpz.mobMod.SHARE_TARGET, knecht:getShortID())
    end,

    ['Velfegor'] = function(mob, target)
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

        -- Every 10%, uses Meikyo Shisui and Apocalyptic Ray x3
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
        local animation = {
            GROUNDED    = 0,
            FLYING      = 1,
            STONEFORM   = 2
        }
        local skillList = {
            tpz.mob.skills.TRIUMPHANT_ROAR,
            tpz.mob.skills.TERROR_EYE,
            tpz.mob.skills.BLOODY_CLAW

        }
        local phaseData = {
            { HP = 20,     Var = 'stoneform_20'   },
            { HP = 40,     Var = 'stoneform_40'   },
            { HP = 60,     Var = 'stoneform_60'   },
            { HP = 80,     Var = 'stoneform_80'   },
        }
        local changeTime = mob:getLocalVar("changeTime")
        local waitTimer = mob:getLocalVar("waitTimer")
        local battleTime = mob:getBattleTime()
        local currentHP = mob:getHPP()

        -- "Too High" wyrm effect and 250/tick regain while flying.
        -- Only uses Shadow Burst while flying (500+ damage)
        if (mob:AnimationSub() == animation.FLYING) then
            mob:SetAutoAttackEnabled(true)
            mob:SetMagicCastingEnabled(true)
            mob:SetMobAbilityEnabled(true)
            mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 0, 0, 1)
            mob:addSkillListEntry(math.random(tpz.mob.skills.DARK_ORB, tpz.mob.skills.DARK_MIST))
            mob:setMod(tpz.mod.REGAIN, 250)
        elseif (mob:AnimationSub() == animation.STONEFORM) then
            mob:SetAutoAttackEnabled(false)
            mob:SetMagicCastingEnabled(false)
            mob:SetMobAbilityEnabled(false)
            mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
            mob:addStatusEffect(tpz.effect.DAMAGE_SPIKES, 500, 0, 1)
            mob:setMod(tpz.mod.REGAIN, 0)
            mob:setMod(tpz.mod.UDMGPHYS, -100)
            mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN)) -- Disable no turn
        elseif (mob:AnimationSub() == animation.GROUNDED) then
            mob:setMod(tpz.mod.REGAIN, 0)
            for _, skills in ipairs (skillList) do
                mob:addSkillListEntry(skills)
            end
        end

        if (os.time() <= waitTimer) then
            return
        end

        -- Alternates between flying / standing
        if (changeTime == 0) then
            mob:setLocalVar("changeTime", math.random(20, 30))
        end

        if (mob:AnimationSub() == animation.STONEFORM) and not mob:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then
            mob:setLocalVar("changeTime", battleTime + math.random(60, 90))
            mob:SetAutoAttackEnabled(true)
            mob:SetMagicCastingEnabled(true)
            mob:SetMobAbilityEnabled(true)
            mob:setMod(tpz.mod.UDMGPHYS, 0)
            mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
            mob:AnimationSub(animation.GROUNDED)
            mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN))) -- Enable no turn
            mob:setLocalVar("waitTimer", os.time() + 5)
            return
        end

        if
            (battleTime >= changeTime) and
                (mob:AnimationSub() ~= animation.STONEFORM) and
                not IsMobBusy(mob) and
                not mob:hasPreventActionEffect()
        then
            if (mob:AnimationSub() == animation.FLYING) then
                mob:AnimationSub(animation.GROUNDED)
            else
                mob:AnimationSub(animation.FLYING)
            end

            mob:clearSkillList()
            mob:setLocalVar("changeTime", battleTime + math.random(20, 30))
            mob:setLocalVar("waitTimer", os.time() + 5)
            return
        end

        -- Every 20% Stone forms which is a full erase and grants him 500 damage spikes and 3000 magic SS. Immune to physical damage.
        -- Removed by breaking the magical stoneskin effect
        for _, phase in ipairs(phaseData) do
            if (currentHP <= phase.HP) and (mob:getLocalVar(phase.Var) == 0) then
                if
                    (mob:AnimationSub() == animation.GROUNDED) and
                    not IsMobBusy(mob) and
                    not mob:hasPreventActionEffect()
                then
                    mob:setLocalVar(phase.Var, 1)
                    mob:removeAllNegativeEffects()
                    mob:AnimationSub(animation.STONEFORM)
                    mob:addStatusEffect(tpz.effect.MAGIC_SHIELD, 3000, 3, 0)
                    mob:setLocalVar("waitTimer", os.time() + 5)
                    break
                end
            end
        end
    end,

    ['Ethniu'] = function(mob, target)
        local lvlUp = mob:getLocalVar("lvlUp")
        local level = mob:getMainLvl()
        -- Only levels up 10 times max
        if
            (lvlUp > 0) and
            (level < 90) and
            not IsMobBusy(mob) and
            not mob:hasPreventActionEffect()
        then
            mob:useMobAbility(tpz.mob.skills.LEVEL_UP, mob)
            mob:setMobLevel(level +1, false)
            -- Mods and Mobmods are cleared on leveling up, need to readd them
            tpz.wotg.onMobSpawn(mob)
            mob:setLocalVar("lvlUp", 0)
        end

        -- Gains an invisible silence aura (~20') during Perfect Dodge.
        -- Gains an enhanced rate of Triple Attack rate during Perfect Dodge.
        -- Does not cast or use TP moves during Perfect Dodge.
        if mob:hasStatusEffect(tpz.effect.PERFECT_DODGE) then
            local auraParams = {
                radius = 20,
                effect = tpz.effect.SILENCE,
                power = 1,
                duration = 30,
                auraNumber = 1
            }

            mob:setMod(tpz.mod.TRIPLE_ATTACK, 100)
            mob:SetMagicCastingEnabled(false)
            mob:SetMobAbilityEnabled(false)
            AddMobAura(mob, target, auraParams)
            TickMobAura(mob, target, auraParams)
        else
            mob:setMod(tpz.mod.TRIPLE_ATTACK, 5)
            mob:SetMagicCastingEnabled(true)
            mob:SetMobAbilityEnabled(true)
        end

        -- Levels up on successful Elemental / Enfeebling casts
        mob:addListener("MAGIC_STATE_EXIT", "ETHNIU_MAGIC_STATE_EXIT", function(mob, spell)
            local skill = spell:getSkillType()
            if (skill == tpz.skill.ELEMENTAL_MAGIC) or (skill == tpz.skill.ENFEEBLING_MAGIC) then
                mob:setLocalVar("lvlUp", 1)
            end
        end)
    end,

    ['Tethra'] = function(mob, target)
        local lvlUp = mob:getLocalVar("lvlUp")
        if
            (lvlUp > 0) and
            not IsMobBusy(mob) and
            not mob:hasPreventActionEffect()
        then
            local level = mob:getMainLvl()
            mob:useMobAbility(tpz.mob.skills.LEVEL_UP, mob)
            mob:setMobLevel(level +1, false)
            -- Mods and Mobmods are cleared on leveling up, need to readd them
            tpz.wotg.onMobSpawn(mob)
            mob:setLocalVar("lvlUp", 0)
        end

        -- Offensive JA's level him up if he is NOT casting.
        -- Offensive JA's and magic reset it's hate on everyone but the person who used the JA
        mob:addListener("ABILITY_TAKE", "TETHRA_ABILITY_TAKE", function(mob, user, ability, action)
            local abilityMsg = ability:getMsg()
            local act = mob:getCurrentAction()
        local validProc =
            abilityMsg ~= tpz.msg.basic.JA_MISS and
            abilityMsg ~= tpz.msg.basic.SHADOW_ABSORB and
            act ~= tpz.act.MAGIC_START and
            act ~= tpz.act.MAGIC_CASTING and
            act ~= tpz.act.MAGIC_FINISH and
            mob:getTarget():getShortID() ~= user:getShortID() and
            not mob:hasPreventActionEffect()

            -- Pet assault JA's shouldn't proc
            if validProc then
                local enmityList = mob:getEnmityList()
                if enmityList then
                    for _, enmity in ipairs(enmityList) do
                        if (user:getID() ~= enmity.entity:getID()) then
                            mob:resetEnmity(enmity.entity)
                        end
                    end
                end
                mob:setLocalVar("lvlUp", 1)
            end
        end)

        -- Offensive JA's and magic reset it's hate on everyone but the person who used the JA
        -- Counters magic casts with Stone IV onto it's current target ONLY IF HATE IS SWAPPED OFF.
        -- I.e. if a pld tanking it uses flash it won't counter
        mob:addListener("SPELL_DMG_TAKEN", "ETHRA_SPELL_DMG_TAKEN", function(mob, caster, spell)
           if
                mob:getTarget():getShortID() ~= caster:getShortID() and
                not IsMobBusy(mob) and
                not mob:hasPreventActionEffect()
           then
                local enmityList = mob:getEnmityList()
                if enmityList then
                    for _, enmity in ipairs(enmityList) do
                        if (caster:getID() ~= enmity.entity:getID()) then
                            mob:resetEnmity(enmity.entity)
                        end
                    end
                end
                mob:castSpell(tpz.magic.spell.STONE_IV)
           end
        end)

        -- Absorbs magic damage while casting
        mob:addListener("MAGIC_START", "TETHRA_MAGIC_START", function(mob, spell)
            mob:setMod(tpz.mod.MAGIC_ABSORB, 100)
        end)
        mob:addListener("MAGIC_STATE_EXIT", "TETHRA_MAGIC_STATE_EXIT", function(mob, spell)
            mob:setMod(tpz.mod.MAGIC_ABSORB, 0)
        end)
    end,

    ['Anhur'] = function(mob, target)
    -- Lynx
        if (mob:getLocalVar("dmgAura") > 0) then
            local radius = 10
            local damage = 100
            local tick = 3
            TickDamageAura(mob, target, radius, damage, tpz.attackType.MAGICAL, tpz.magic.ele.THUNDER, tick)
            mob:addStatusEffect(tpz.effect.ENTHUNDER, 150, 0, 3)
            mob:addStatusEffect(tpz.effect.SHOCK_SPIKES, 25, 0, 3)
            mob:setEffectUndispellable(tpz.effect.ENTHUNDER)
            mob:setEffectUndispellable(tpz.effect.SHOCK_SPIKES)
        end

        -- Charged whisker grants undispellable shock spikes, enthunder, and pulsing AoE thunder damage aura
        mob:addListener("WEAPONSKILL_STATE_EXIT", "ANHUR_MOBSKILL_FINISHED", function(mob, skillID)
            if (skillID == tpz.mob.skills.CHARGED_WHISKER) then
                mob:setLocalVar("dmgAura", 1)
            end
        end)

        -- Aura removed by magic bursting 1k+ earth damage
        mob:addListener("SPELL_DMG_TAKEN", "ANHUR_SPELL_DMG_TAKEN", function(mob, caster, spell, amount, msg)
            local element = spell:getElement()

            if (element == tpz.magic.ele.EARTH) and (amount >= 1000) then
                if (msg == tpz.msg.basic.MAGIC_BURST_BLACK) or (msg == tpz.msg.MAGIC_BURST_BREATH) then
                    local duration = 30
                    BreakMob(mob, caster, tpz.procEffect.NONE, duration, tpz.procType.TERROR)
                    mob:delStatusEffectSilent(tpz.effect.ENTHUNDER)
                    mob:delStatusEffectSilent(tpz.effect.SHOCK_SPIKES)
                    mob:setLocalVar("dmgAura", 0)
                end
            end
        end)
    end,

    ['Barqan'] = function(mob, target)
    -- Djinn
    -- TODO: tartarean_storm animationId
        local stormCD = mob:getLocalVar("stormCD")
        local battleTime = mob:getBattleTime()
        local storms = { 99, 113, 114, 115, 116, 117, 118, 119 }
        local stormSDT = {
            [tpz.effect.FIRESTORM]    = { strong = tpz.mod.SDT_ICE,    weak = tpz.mod.SDT_WATER },
            [tpz.effect.HAILSTORM]    = { strong = tpz.mod.SDT_WIND,   weak = tpz.mod.SDT_FIRE  },
            [tpz.effect.WINDSTORM]    = { strong = tpz.mod.SDT_EARTH,  weak = tpz.mod.SDT_ICE   },
            [tpz.effect.SANDSTORM]    = { strong = tpz.mod.SDT_THUNDER,weak = tpz.mod.SDT_WIND  },
            [tpz.effect.THUNDERSTORM] = { strong = tpz.mod.SDT_WATER,  weak = tpz.mod.SDT_EARTH },
            [tpz.effect.RAINSTORM]    = { strong = tpz.mod.SDT_FIRE,   weak = tpz.mod.SDT_THUNDER},
            [tpz.effect.AURORASTORM]  = { strong = tpz.mod.NONE,       weak = tpz.mod.SDT_LIGHT },
            [tpz.effect.VOIDSTORM]    = { strong = tpz.mod.NONE,       weak = tpz.mod.SDT_DARK  },
        }

        local allSDTMods = {
            tpz.mod.SDT_FIRE,
            tpz.mod.SDT_ICE,
            tpz.mod.SDT_WIND,
            tpz.mod.SDT_EARTH,
            tpz.mod.SDT_THUNDER,
            tpz.mod.SDT_WATER,
            tpz.mod.SDT_LIGHT,
            tpz.mod.SDT_DARK,
        }

        local spellList =
        {
            [tpz.effect.FIRESTORM]    = { tpz.magic.spell.FIRE_IV,      tpz.magic.spell.FIRAGA_III,    tpz.magic.spell.ADDLE },
            [tpz.effect.HAILSTORM]    = { tpz.magic.spell.BLIZZARD_IV,  tpz.magic.spell.BLIZZAGA_III,  tpz.magic.spell.BINDGA, tpz.magic.spell.PARALYGA },
            [tpz.effect.WINDSTORM]    = { tpz.magic.spell.AERO_IV,      tpz.magic.spell.AEROGA_III,    tpz.magic.spell.SILENCEGA, tpz.magic.spell.GRAVIGA },
            [tpz.effect.SANDSTORM]    = { tpz.magic.spell.STONE_IV,     tpz.magic.spell.STONEGA_III,   tpz.magic.spell.SLOWGA, tpz.magic.spell.BREAKGA },
            [tpz.effect.THUNDERSTORM] = { tpz.magic.spell.THUNDER_IV,   tpz.magic.spell.THUNDAGA_III,  tpz.magic.spell.STUN },
            [tpz.effect.RAINSTORM]    = { tpz.magic.spell.WATER_IV,     tpz.magic.spell.WATERGA_III,   tpz.magic.spell.POISONGA_II },
            [tpz.effect.AURORASTORM]  = { tpz.magic.spell.HOLY_II,      tpz.magic.spell.BANISHGA_III,  tpz.magic.spell.DIAGA_II, tpz.magic.spell.FLASH },
            [tpz.effect.VOIDSTORM]    = { tpz.magic.spell.COMET,        tpz.magic.spell.NOCTOHELIX,    tpz.magic.spell.SLEEPGA_II, tpz.magic.spell.BLINDGA,  tpz.magic.spell.DISPELGA },
        }

        -- DRK/DRK
        -- Casts storm on self then absorbs that element, SDT is changed to be weak to it's weakness and casts spells/enfeebles of that element
        -- Cast a random storm every minute
        if (battleTime <= stormCD) then
            mob:setLocalVar("buffCD", battletime + 60)
            mob:castSpell(storms[math.random(#storms)])
        end

        mob:addListener("MAGIC_USE", "DJINN_MAGIC_USE", function(mob, target, spell, action)
            local spellID = spell:getID()
            if spellID == 99 or (spellID >= 113 and spellID < 120) then
                -- Absorb the spell's element
                mob:setMod(tpz.mod.FIRE_ABSORB + spell:getElement() - 1, 100)

                -- Check active storm and apply SDT changes
                for effectType, sdtMods in pairs(stormSDT) do
                    if mob:hasStatusEffect(effectType) then
                        for _, modID in ipairs(allSDTMods) do
                            if modID == sdtMods.strong then
                                mob:setMod(modID, 5) -- Strong
                            elseif modID == sdtMods.weak then
                                mob:setMod(modID, 100) -- Weak
                            else
                                mob:setMod(modID, 50) -- Rest
                            end
                        end
                    end
                end
            end
        end)

        mob:addListener("EFFECT_GAIN", "BARQAN_EFFECT_GAIN", function(mob, effect)
            local effectType = effect:getType()

            -- Update spell list based on currently active Storm
            if effectType >= tpz.effect.FIRESTORM and effectType <= tpz.effect.VOIDSTORM then
                mob:clearSpellList()

                local spells = spellList[effectType]
                if spells then
                    for _, spellId in ipairs(spells) do
                        mob:addSpellListEntry(spellId)
                    end
                end
            end
        end)

        mob:addListener("EFFECT_LOSE", "BARQAN_EFFECT_LOSE", function(mob, effect)
            local effectType = effect:getType()
            if effectType >= tpz.effect.FIRESTORM and effectType <= tpz.effect.VOIDSTORM then
                -- Remove absorb
                mob:setMod(tpz.mod.FIRE_ABSORB + effectType - tpz.effect.FIRESTORM, 0)

                -- Reset all SDT mods to 50 (normal)
                for _, modID in ipairs(allSDTMods) do
                    mob:setMod(modID, 50)
                end
            end
        end)
    end,

    ['Ahmet'] = function(mob, target)
    -- Ziz
        -- WAR/DRK
        -- No SJ aura
        local auraParams = {
            radius = 20,
            effect = tpz.effect.OBLIVISCENCE,
            power = 1,
            duration = 30,
            auraNumber = 1
        }
        AddMobAura(mob, target, auraParams)
        TickMobAura(mob, target, auraParams)
        -- Contagion Transfer - AoE status transfers from the mob to all players within range.
        -- Sound Vacuum 10' AoE(not conal) mute.
        -- Breakga, Stoneskin, Rasp, Stone IV, Stonega III
    end,

    ['Shedyet'] = function(mob, target)
    -- Bugard
        -- THF/DRK
        -- Perma perfect dodge
        -- Nightmare Bugard moves
        -- Tyrant Tusk (If this attack puts targets HP below 50%, then insta kill)
    end,

    ['Khnum'] = function(mob, target)
    -- Ram (Use Model: 0x0000680A00000000000000000000000000000000)
        -- WAR/SAM
        -- Keeps mighty strikes up at all times(uses it, isn't just a perma buff)
    end,

    ['Aegyptopithecus'] = function(mob, target)
    -- Opo-opo
        -- RNG/WAR
        -- Stand back, doesn't auto-attack, only uses ranged attacks (Stone Throw animation)
        -- Claw Storm is also AOE Bio
        -- Magic Fruit 3.5s cast time
        -- Uses Vacant Gaze, dispels up to 3 effects
        -- Vicious Claw "Throat Stab" + Enmity reset
    end,

    ['Ammonoidea'] = function(mob, target)
    -- Urganite
        -- Casts Holy II, Banishga III, Banish IV, Flash(AOE)
    end,

    ['Anubis'] = function(mob, target)
    -- Gnole
        -- Gnole mixin
        -- animsub 1= standing, animsub 0 = all fours
        local animation = {
            FOURLEGS    = 0,
            STANDING    = 1,
        }

        -- In "4 legs" mode, takes -95% magic damage, casts spells, and cannot counter or guard
        -- In "2 legs" mode, takes normal magical damage and has capped counter and guard rate
        if (mob:AnimationSub() == animation.FOURLEGS) then
            mob:setMod(tpz.mod.UDMGMAGIC, -95)
            mob:setMod(tpz.mod.COUNTER, 0)
            mob:setMod(tpz.mod.GUARD_PERCENT, 0)
            mob:SetMagicCastingEnabled(true)
            mob:addStatusEffect(tpz.effect.AVOIDANCE_DOWN)
        elseif (mob:AnimationSub() == animation.STANDING) then
            mob:setMod(tpz.mod.UDMGMAGIC, 0)
            mob:setMod(tpz.mod.COUNTER, 100)
            mob:setMod(tpz.mod.GUARD_PERCENT, 1000)
            mob:SetMagicCastingEnabled(false)
            mob:delStatusEffectSilent(tpz.effect.AVOIDANCE_DOWN)
        end
    end,

    ['Amunet'] = function(mob, target)
    -- Smilodon (Use model 0x0000C80800000000000000000000000000000000)
        -- Cures self with Cure V Curaga IV, buffs self with Haste II Temper etc
        -- Fixates on random target every 60-90s
	    local fixateTimer = mob:getLocalVar("fixateTimer")

        if (fixateTimer == 0) then
            mob:setLocalVar("fixateTimer", os.time() + 5)
        elseif (os.time() >= fixateTimer) then
            local enmityList = mob:getEnmityList()
            for _, enmity in ipairs(enmityList) do
                if enmityList and #enmityList > 0 then
                    local randomTarget = enmityList[math.random(1,#enmityList)];
                    mob:setLocalVar("fixateTarget", randomTarget.entity:getShortID())
                end
            end
            local fixateTarget = mob:getLocalVar("fixateTarget")
            if (fixateTarget > 0) then
                mob:setMobMod(tpz.mobMod.FIXATE, fixateTarget)
            end
            mob:setLocalVar("fixateTimer", os.time() + math.random(60, 90))
        end
    end,
}

local mobSpellPrecastByMobName =
{
    ['Hound_of_Balthazar'] = function(mob, spell)
        local aoeSpellList = {
            tpz.magic.spell.ADDLE,
        }

        -- AoE Addle
        for _, spellId in pairs (aoeSpellList) do
            if (spell:getID() == spellId) then
                spell:setAoE(tpz.magic.aoe.RADIAL)
                spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
                spell:setRadius(15)
                break
	        end
        end
    end,

    ['Knechts_Corpselight'] = function(mob, spell)
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setRadius(10)
    end,

    ['Kernunnos'] = function(mob, spell)
        local aoeSpellList = {
            tpz.magic.spell.ABSORB_TP,
            tpz.magic.spell.ABSORB_ATTRI,
            tpz.magic.spell.DRAIN_II,
            tpz.magic.spell.ASPIR_II,
            tpz.magic.spell.STUN,
        }
        -- AoE Absorb-TP, Absorb-Attribute, Drain II, Aspir II and  Stun
        for _, spellId in pairs (aoeSpellList) do
            if (spell:getID() == spellId) then
                spell:setAoE(tpz.magic.aoe.RADIAL)
                spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
                spell:setRadius(10)
                break
	        end
        end
    end,

    ['Tethra'] = function(mob, spell)
        -- Quake is AOE during Manafont
        if mob:hasStatusEffect(tpz.effect.MANAFONT) then
            if (spell:getID() == tpz.magic.spell.QUAKE) then
                spell:setAoE(tpz.magic.aoe.RADIAL)
                spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
                spell:setRadius(10)
            end
        end
    end,

    ['Barqan'] = function(mob, spell)
        local aoeSpellList = {
            tpz.magic.spell.ADDLE,
            tpz.magic.spell.STUN,
            tpz.magic.spell.COMET,
            tpz.magic.spell.NOCTOHELIX,
            tpz.magic.spell.FLASH
        }

        for _, spellId in pairs (aoeSpellList) do
            if (spell:getID() == spellId) then
                spell:setAoE(tpz.magic.aoe.RADIAL)
                spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
                spell:setRadius(15)
                break
	        end
        end
    end,

    ['Ammonoidea'] = function(mob, spell)
        if (spell:getID() == tpz.magic.spell.FLASH) then
            spell:setAoE(tpz.magic.aoe.RADIAL)
            spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
            spell:setRadius(15)
        end
    end,
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

    ['Duke_Xavier'] = function(mob)
        for xavierBat = mob:getID() + 1, mob:getID() + 3 do
            DespawnMob(xavierBat)
        end
    end,

    ['Knecht'] = function(mob)
        DespawnMob(17494861)
        DespawnMob(17494862)
    end,
}

local mobDespawnByMobName =
{
    ['Witchweed'] = function(mob)
        local bee = 17478245
        DespawnMob(bee)
    end,

    ['Duke_Xavier'] = function(mob)
        for xavierBat = mob:getID() + 1, mob:getID() + 3 do
            DespawnMob(xavierBat)
        end
    end,

    ['Knecht'] = function(mob)
        DespawnMob(17494861)
        DespawnMob(17494862)
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

tpz.wotg.onSpellPrecast = function(mob, spell)
    local mobName  = mob:getName()
    local mobSpellPrecast = mobSpellPrecastByMobName[mobName]

    if mobSpellPrecast then
        mobSpellPrecast(mob, spell)
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
    local zoneId = zone:getID()
    local bossData = metaBosses[zoneId]

    if bossData == nil then
        return -- no meta bosses for this zone
    end

    if isKiller or noKiller then
        local chance = 100
        GenerateAugments(player, chance)

        for _, member in pairs(player:getAlliance()) do
            member:addMod(tpz.mod.PAST_DUNGEON_MASTER, 1)
        end

        AddAugmentMod(player)
        zone:setLocalVar("metaProgress", 0)
        zone:setLocalVar("eventActive", 0)
        utils.MessageParty(player, 'Meta progress: ' .. zone:getLocalVar("metaProgress") .. '%', tpz.msg.textColor.HIDDEN, nil)
    end

    for _, boss in pairs(bossData) do
        if mob:getID() == boss.Id then
            player:addTitle(boss.Title)
        end
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
    randomEventMimic(player) -- TODO: Remove after done testing
    --eventList[math.random(#eventList)](player) -- TODO: Does this work?
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

        -- Despawn chest after 10 seconds
        chest:queue(10000, function(chest)
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
                            member:addStatusEffect(environmentalData.Effect, environmentalData.Power, environmentalData.Tick, environmentalData.Duration, 0, environmentalData.SubPower)
                            local effect = member:getStatusEffect(environmentalData.Effect)
                            if (effect ~= nil) then
                                effect:unsetFlag(tpz.effectFlag.WALTZABLE)
                            end
                        end
                        if environmentalData.Effect2 then
                            member:addStatusEffect(environmentalData.Effect2, environmentalData.Power2, environmentalData.Tick2, environmentalData.Duration, 0, environmentalData.SubPower)
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

    if (regionID <= 14) then
        printf("Player entered RegionId: %d", regionID)
    end

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
-----------------------------------
--
--  Walk of Echoes utilities
--
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/mobs")
require("scripts/globals/zone")
require("scripts/globals/msg")
require("scripts/globals/utils")
require("scripts/globals/npc_util")
require("scripts/globals/spell_data")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/titles")
--------------------------------------

-- TODO: Add logic for "Assess the situation"
-- TODO: Finish random temps list
-- TODO: Wizard / Giants drink dura and %
-- TODO: Coffer doesn't properly work if < 6 items, works at >= 6. tpz.woe.TreasureCoffer.onTrigger/ tpz.woe.TreasureCoffer.onTrigger.onEventUpdate broken
-- TODO: Craft mats from boss, too. Maybe used to make new gear? Voidwalker gear? Or abyssea crafted gear? Or furia / ebur / w/e Synergy sets with new stats? or Lore Robe / Gules Harness / ??? sets
-- TODO: Temps from kills, too?
-- TODO: Magic cool on everything
-- TODO: Magian trials for emp weapons
-- TODO: Code emp weapon skill unlock events
-- TODO: Temps drop from killing mobs (pretty often). Strange milk, strange juice, body boost, mana boost, healing salve I, clerics drink, lucid ether, clear salve, instant rr, berserkers drink, mana powder, healing mist, mana mist
-- Catholicion, catholicion +1
-- TODO: Use addon to capture models
-- TODO: New spell scrolls?
-- TODO: Misc items, new jewels like Fulmenite and new ore like Durium Ore? Or save for Abyssea?
-- TODO: Give Wizards / Giants drink to trusts (and pets?) also when a player uses
-- TODO: Fill Misc item list
-- TODO: All members Fallen msg: [13:17:55] [CSData] Type: MsgID, EventID: 7260, Params: 67, 0, 734000, 3
-- TODO: Save temp gained between runs into other walks. Prob save temps by zone ID and load them by zone ID if applicable, maybe LSB has for abyssea?
-- TODO: delTempItems(player, temps) doesn't work and should only delete when in lobby but not remove from saved sql database for that player and zone. Maybe delItem() doesn't work with tpz.inv.TEMPITEMS?
-- TODO: Tune Weaponskills, they should all be replacements to level 55-60 multihits (can swap around stuff like Entropy/Stardiver here and Quietus/Calamns from WOTG relics instead...MAYBE.)

-- Drops https://www.bg-wiki.com/ffxi/Walk_of_Echoes_Battlefield_Rewards
-- Drop rate changes: https://www.ffxiah.com/forum/topic/27894/dev1096-walk-of-echoes-adjustments/
-- Info: https://www.bluegartr.com/threads/95043-Walk-of-Echoes
-- https://ffxiclopedia.fandom.com/wiki/Category:Walk_of_Echoes_Battlefields

tpz = tpz or {}
tpz.woe = tpz.woe or {}

local item = tpz.items
local title = tpz.title

local entryEvent = 44
local entryKI = tpz.ki.KUPOFRIEDS_MEDALLION
local lobbyPos = { X = -420, Y = 14, Z =-32, Rot = 192 }
local leaveWoeEvent = 1004
local timeLimit = 2700
local failEvent = 1002
local walkData =
{
    [1] =
    {
        -- Cyanic Crab, lvl { 77 }, Model { Blue }, Size { Small }  HP {9175}, Amount { 9 }, Ids {}  Partied { 4, need ids }, Boss { False }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Enwater, Water II, Waterga II }, TP Moves: { Crab}
        -- Damask Crab, lvl { 77 }, Model { Red }, Size { Small }  HP {9175} Amount { 9 }, Ids {} Partied { 4, need ids }, Boss { False }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Poisonga II, Waterga II, Water IV }, TP Moves: { Crab}
        -- Caldera Crab, lvl { 80 }, Model { Barnacle }, Size { Small? } HP { 19750 }, Ids {},  Amount { 3 }, Partied { 3 }, Boss { True }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Water IV, Waterga III }, TP Moves: { Mega Scissors, Venom Shower (Goes off without target?), Normal Crab Moves (Metallic Body ~500 SS, undispellable) } 
            -- Cast Timer { :47 -> :14 - > :53 - > :34 - > 16 }
            -- Mechanics { Uses Mega Scissors x3 in a row <= 75% HP, High Store TP. Plague Aura after using Venom Shower for (50/tick) ~20 seconds } Proc { Flash Red Terror, ~5-10s }
        -- Crabs from deeper in the battlefield will come to the defeated crab's corpse. Make sure you are at least 16' from the corpse and you will not be aggrod.
        -- Upon killing crabs, occasionally the boss Caldera Crab will come to its aid, running to where the crab was killed.
        -- 15 yard aggro range
        -- Completion: Caldera crabs dead
        Events      = { Conflux = 1000, Entry = 7033, Exit = 1001 },
        StartPos    = { X =-574, Y = 18, Z =734, Rot = 62 },
        Mobs        = { IdStart = 17522689, IdEnd = 17522709, Lvl = 77 },
        Boss        = 'Caldera_Crab',
        Progress    = 3,
        Drops       = { item.THRIFT_GLOVES, item.BELISAMAS_ROPE, item.ARDOR_PENDANT, item.KARAGOZ_MANTLE },
        SetDrop     = { item.ASKAR_GAMBIERAS },
        Title       = { title.TORCHBEARER_OF_THE_1ST_WALK },
        Experience  = 1500
    },
    [2] =
    {
        -- Grenade Syrup lvl { 77 }, Model { 0x0000260100000000000000000000000000000000 }, Size { Small }  Amount { 9 }, Ids {} Partied { 4, need ids }, Boss { False }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Blind, Bio III }, TP Moves: { Mucus Spread}
        -- Morbid Molasses, lvl { 80 }, Model { 0x0000250100000000000000000000000000000000 }, Size { Large } Ids {},  Amount { 3 }, Partied { 3 }, Boss { True }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Blindga, Dispelga, Sleepga II }, TP Moves: { Dissolve , Cytokinesis, Mucus Spread (All before next go off even if no targets in range), Fluid Spread } 
        -- 3-4 Grenade Syrups with a Morbid Molasses
        -- Killing Morbid Molasses kills the Grenade Syrups partied with them
        -- 15 yard aggro range
        Events      = { Conflux = 1000, Entry = 7033, Exit = 1001 },
        StartPos    = { X =-574, Y = 18, Z =734, Rot = 157 }, -- TODO
        Mobs        = { IdStart = 12522699, IdEnd = 12522709, Lvl = 77 }, -- TODO
        Boss        = 'Morbid_Molasses',
        Progress    = 4,
        Drops       = { item.THRIFT_GLOVES, item.BELISAMAS_ROPE, item.ARDOR_PENDANT, item.KARAGOZ_MANTLE },
        SetDrop     = { item.DENALI_GAMASHES, item.GOLIARD_CLOGS },
        Title       = { title.TORCHBEARER_OF_THE_2ND_WALK },
        Experience  = 1500
    },
    [3] =
    {
        -- Grenade Syrup lvl { 77 }, Model { 0x0000260100000000000000000000000000000000 }, Size { Small }  Amount { 9 }, Ids {} Partied { 4, need ids }, Boss { False }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Blind, Bio III }, TP Moves: { Mucus Spread}
        -- Morbid Molasses, lvl { 80 }, Model { 0x0000250100000000000000000000000000000000 }, Size { Large } Ids {},  Amount { 3 }, Partied { 3 }, Boss { True }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Blindga, Dispelga, Sleepga II }, TP Moves: { Dissolve , Cytokinesis, Mucus Spread (All before next go off even if no targets in range), Fluid Spread } 
        -- 3-4 Grenade Syrups with a Morbid Molasses
        -- Killing Morbid Molasses kills the Grenade Syrups partied with them
        -- 15 yard aggro range
        Events      = { Conflux = 1000, Entry = 7033, Exit = 1001 },
        StartPos    = { X =-574, Y = 18, Z =734, Rot = 157 }, -- TODO
        Mobs        = { IdStart = 12522699, IdEnd = 12522709, Lvl = 77 }, -- TODO
        Boss        = 'Caldera_Crab', -- TODO
        Progress    = 3, -- TODO
        Drops       = { item.THRIFT_GLOVES, item.BELISAMAS_ROPE, item.ARDOR_PENDANT, item.KARAGOZ_MANTLE },
        SetDrop     = { item.GOLIARD_CLOGS },
        Title       = { title.TORCHBEARER_OF_THE_2ND_WALK },
        Experience  = 1500
    },


    Temps =
    {
        Starter = 
        {
            item.LUCID_POTION_III, item.LUCID_ETHER_III, item.MEGALIXIR, item.TUBE_OF_HEALING_SALVE_II, item.BOTTLE_OF_CATHOLICON, item.BOTTLE_OF_VICARS_DRINK, item.TUBE_OF_CLEAR_SALVE_II,
            item.DUSTY_WING, item.SCROLL_OF_INSTANT_RERAISE, item.DUSTY_SCROLL_OF_RERAISE, item.BOTTLE_OF_GIANTS_DRINK, item.BOTTLE_OF_WIZARDS_DRINK, item.BOTTLE_OF_FANATICS_DRINK, item.BOTTLE_OF_FOOLS_DRINK,
            item.BOTTLE_OF_ASCETICS_TONIC, item.BOTTLE_OF_CHAMPIONS_TONIC, item.BOTTLE_OF_BRAVERS_DRINK, item.BOTTLE_OF_MONARCHS_DRINK, item.BOTTLE_OF_BERSERKERS_TONIC, item.BOTTLE_OF_SWIFTSHOT_TONIC
        },
        Random =
        {
            item.TUBE_OF_HEALING_SALVE_I, item.TUBE_OF_CLEAR_SALVE_I, item.BOTTLE_OF_CATHOLICON_HQ
        }
    },
    ExtraDrops =
    {
        -- Coins and pouches share a group, one or other per slot]
        Coins       =   { item.COIN_OF_ADVANCEMENT, item.COIN_OF_BIRTH, item.COIN_OF_DECAY, item.COIN_OF_GLORY, item.COIN_OF_RUIN },
        Pouches     =   { item.FRAYED_POUCH_OF_ADVANCEMENT, item.FRAYED_POUCH_OF_BIRTH, item.FRAYED_POUCH_OF_DECAY, item.FRAYED_POUCH_OF_GLORY, item.FRAYED_POUCH_OF_RUIN, item.POUCH_OF_LIMINAL_RESIDUE },
        Scrolls     =   { }, -- t5 scrolls, nocturne, cura III, Jubaku: Ni
        Misc        =   { }, --ores, cloth, etc
    }
}
local failState =
{
    Time = 1,
    Defeat = 2
}

-- Treasure Coffer functions
local function GetPlayerCofferLoot(player)
    local items = {}
    for i = 1,10 do
        items[i] = player:getCharVar("[WoE]CofferLoot_" .. tostring(i))
        if items[i] == 0 then items[i] = nil end
    end
    return items;
end

local function SavePlayerCofferLoot(player, items)
    for i = 1,10 do
        if items[i] then
            player:setCharVar("[WoE]CofferLoot_" .. tostring(i), items[i])
        else
            player:setCharVar("[WoE]CofferLoot_" .. tostring(i), 0) 
        end
    end
end

local function ClearPlayerCofferLoot(player)
    SavePlayerCofferLoot(player, {})
end

local function generateTreasureCofferLoot(player, walk)
    local loot = {}
    local drops = walkData.ExtraDrops

    local total = math.random(2, 10)

    -- pick random slots for rare checks
    local accSlot = math.random(total)
    local setSlot = math.random(total)

    for i = 1, total do
        local item

        -- Accessory roll (5%)
        if i == accSlot and math.random(100) <= 5 then
            local pool = walkData[1].Drops
            item = pool[math.random(#pool)]

        -- Armor roll (1%)
        elseif i == setSlot and math.random(100) <= 1 then
            local pool = walkData[1].SetDrop
            item = pool[math.random(#pool)]

        else
            local roll = math.random(1,3)

            if roll == 1 then
                local pool = math.random(1,2) == 1 and drops.Coins or drops.Pouches
                item = pool[math.random(#pool)]

            elseif roll == 2 and #drops.Misc > 0 then
                item = drops.Misc[math.random(#drops.Misc)]

            else
                local pool = math.random(1,2) == 1 and drops.Coins or drops.Pouches
                item = pool[math.random(#pool)]
            end
        end

        table.insert(loot, item)
    end

    SavePlayerCofferLoot(player, loot)
    return loot
end

-- Walk functions
activeWalks = {}
local function getActiveWalks(zone)
    for walk = 1, 15 do
        if zone:getLocalVar("WalkTimer_" .. walk) > 0 then
            activeWalks[walk] = true
        else
            activeWalks[walk] = nil
        end
    end

    return activeWalks
end

local function resetWalkVars(zone, walk)
    zone:setLocalVar("WalkTimer_" .. walk, 0)
    zone:setLocalVar("WalkProgress_" .. walk, 0)
    zone:setLocalVar("Endowed_" .. walk, 0)
end

local function createWalk(player, walk)
    local zone = player:getZone()

    -- Check if Walk is already active
    if zone:getLocalVar("WalkTimer_" .. walk) > os.time() then return end

    tpz.woe.mob.spawnWalkMobs(walk)
    activeWalks[walk] = true
    zone:setLocalVar("WalkTimer_" .. walk,os.time() + 2700)
end

local function addTempItems(player, temps, silent)
    local ID = zones[player:getZoneID()]
    
    -- Create table of temps
    local givenTemps = {}
    if type(temps) == "number" then
        givenTemps = {temps}
    elseif type(temps) == "table" then
        givenTemps = temps
    else
        print(string.format("ERROR: invalid temps parameter given to walk_of_echoes.lua addTempItems in zone %s.", player:getZoneName()))
        return false
    end
    -- Add temp items
    for _, tempId in pairs(givenTemps) do
        if not player:hasItem(tempId) then
            player:addTempItem(tempId)
        end
    end

    -- Display message if silent isn't true 
    if not silent then
        if #givenTemps > 1 then
            player:messageSpecial(ID.text.OBTAINS_MULTIPLE_TEMPS, #givenTemps)
        else
            player:messageSpecial(ID.text.OBTAINS_TEMP_ITEM, givenTemps[1])
        end
    end
    return true
end

local function addRandomTempItem(player, silent)
    local party = player:getParty() or { player }

    for _, partyMember in pairs(party) do
        local possibleTemp = {}

        -- Combine both Starter and Random temps, then create a table of temps the player does not have
        for _, list in ipairs({ walkData.Temps.Starter, walkData.Temps.Random }) do
            for _, item in ipairs(list) do
                if not partyMember:hasItem(item) then
                    table.insert(possibleTemp, item)
                end
            end
        end

        -- Pick a random temp the player doesn't have from random and starter temp tables
        if #possibleTemp > 0 then
            local temp = possibleTemp[math.random(#possibleTemp)]
            addTempItems(partyMember, temp, silent)
        end
    end
end

local function delTempItems(player, temps)
    -- Create table of temps
    local givenTemps = {}
    if type(temps) == "number" then
        givenTemps = {temps}
    elseif type(temps) == "table" then
        givenTemps = temps
    else
        print(string.format("ERROR: invalid temps parameter given to walk_of_echoes.lua delTempItems in zone %s.", player:getZoneName()))
        return false
    end

    -- delete key items to player, with message
    for _, tempId in pairs(givenTemps) do
        player:delItem(tempId, 1, tpz.inv.TEMPITEMS)
    end
    return true
end

-- Mob functions
tpz.woe.mob = tpz.woe.mob or {}

local modByMobName =
{
    ['Caldera_Crab'] = function(mob)
        mob:setMobMod(tpz.mobMod.LINK_RADIUS, 50)
    end,
}

local mixinByMobName =
{
    mob:addListener("MAGIC_HIT", "CALDERA_CRAB_MAGIC_HIT", function(caster, mob, spell)
        if (spell:getID() == tpz.magic.spell.FLASH) then
            local duration = 10
            BreakMob(target, caster, tpz.procEffect.NONE, duration, tpz.procType.TERROR)
        end
    end)
}

local mobEngagedByMobName =
{
    ['Caldera_Crab'] = function(mob, target)
    end,
}

local mobFightByMobName =
{
    ['Caldera_Crab'] = function(mob, target)
    end,
}

local mobAdditionalEffectByMobName =
{
    ['Caldera_Crab'] = function(mob, target, damage)
    end,
}

local mobDisengageByMobName =
{
    ['Caldera_Crab'] = function(mob)
    end,
}

local mobDespawnByMobName =
{
    ['Caldera_Crab'] = function(mob)
    end,
}

local mobDeathByMobName =
{
    ['Caldera_Crab'] = function(mob, player, isKiller, noKiller)
    end,
}

tpz.woe.mob.onMobSpawn = function(mob)
    if mob:getMainJob() ~= tpz.job.MNK then
        mob:setDamage(150)
    else
        mob:setDamage(75)
    end

    mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 20)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.NO_DESPAWN, 1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.AGGRO_SIGHT, 0)
    mob:setMobMod(tpz.mobMod.AGGRO_SOUND, 1)
    mob:setMobMod(tpz.mobMod.TRUE_SOUND, 1)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.CUSTOMLINK, 3278)

    mob:addImmunity(tpz.immunity.SLEEP)
    mob:addImmunity(tpz.immunity.GRAVITY)
    mob:addImmunity(tpz.immunity.BIND)
    mob:addImmunity(tpz.immunity.SILENCE)
    mob:addImmunity(tpz.immunity.PETRIFY)

    mob:addMod(tpz.mod.ATTP, 50)
    mob:addMod(tpz.mod.DEFP, 50)
    mob:addMod(tpz.mod.ACC, 25)
    mob:addMod(tpz.mod.EVA, 25)
    mob:addMod(tpz.mod.MATT, 50)
    mob:addMod(tpz.mod.UDMGMAGIC, -30)
    mob:addMod(tpz.mod.REFRESH, 400)

    local mobName = mob:getName()
    local mods = modByMobName[mobName]

    if mods then
        mods(mob)
    end
end

tpz.woe.mob.onMobEngaged = function(mob, target)
    local mobName  = mob:getName()
    local mobEngaged = mobEngagedByMobName[mobName]

    if mobEngaged then
        mobEngaged(mob, target)
    end
end

tpz.woe.mob.onMobFight = function(mob, target)
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

tpz.woe.mob.onAdditionalEffect = function(mob, target, damage)
    local mobName  = mob:getName()
    local additionalEffect = mobAdditionalEffectByMobName[mobName]

    if additionalEffect then
        additionalEffect(mob, target, damage)
    end
end

tpz.woe.mob.onMobDisengage = function(mob)
    local mobName  = mob:getName()
    local mobDisengage = mobDisengageByMobName[mobName]

    if mobDisengage then
        mobDisengage(mob)
    end
end

tpz.woe.mob.onMobDeath = function(mob, player, isKiller, noKiller)
    local mobName  = mob:getName()
    local mobDeath = mobDeathByMobName[mobName]

    if isKiller or noKiller then
        local zone = mob:getZone()
        local walk = mob:getLocalVar("CurrentWalk")
        local boss = mob:getName() == walkData[walk].Boss

        if boss then
            tpz.woe.incrementProgress(zone, walk)
        else
            tpz.woe.mob.rollForTemps(mob, player, isKiller, noKiller)
            tpz.woe.mob.rollForEndowed(mob, player, isKiller, noKiller)
        end
    end

    -- TODO: Maybe needs to be inside isKiller or noKiller?
    if mobDeath then
        mobDeath(mob, player, isKiller, noKiller)
    end
end

tpz.woe.onMobDespawn = function(mob)
    local mobName  = mob:getName()
    local mobDespawn = mobDespawnByMobName[mobName]

    if mobDespawn then
        mobDespawn(mob)
    end
end

tpz.woe.mob.spawnWalkMobs = function(walk)
    local data = walkData[walk]

    if not data then return end

    for mobId = data.Mobs.IdStart, data.Mobs.IdEnd do
        local mob = GetMobByID(mobId)

        if mob and not mob:isSpawned() then
            mob:spawn()
            mob:addStatusEffect(tpz.effect.BATTLEFIELD, walk, 0, 0)
            mob:setLocalVar("CurrentWalk", walk)
        end
    end
end

tpz.woe.mob.despawnWalkMobs = function(walk)
    local data = walkData[walk]

    if not data then return end

    for mobId = data.Mobs.IdStart, data.Mobs.IdEnd do
        local mob = GetMobByID(mobId)

        if mob and mob:isSpawned() then
            DespawnMob(mobId)
        end
    end
end

-- TODO: Test roll for temps and endowed with 2 players (incase of msg spam). Test resetWalkVars (on completion and timing out), testing completing, / failing walk (dying or time running out). make sure bf status is removed
tpz.woe.mob.rollForTemps = function(mob, player, isKiller, noKiller)
    if math.random(100) <= 10 then
        addRandomTempItem(player, false)
    end
end

tpz.woe.mob.rollForEndowed = function(mob, player, isKiller, noKiller)
    local walk = mob:getLocalVar("CurrentWalk")
    local zone = mob:getZone()

    if zone:getLocalVar("Endowed_" .. walk) > 0 then return end

    if math.random(100) <= 5 then
        local ID = zones[player:getZoneID()]
        local data = walkData[walk]


        if not data then return end

        for mobId = data.Mobs.IdStart, data.Mobs.IdEnd do
            local currentMob = GetMobByID(mobId)

            currentMob:addMod(tpz.mod.ATTP, -25)
            currentMob:addMod(tpz.mod.DEFP, -25)
            currentMob:addMod(tpz.mod.ACC, -12)
            currentMob:addMod(tpz.mod.EVA, -12)
            currentMob:addMod(tpz.mod.MATT, -25)
            currentMob:addMod(tpz.mod.UDMGMAGIC, 13)
        end

        addRandomTempItem(player, true)
        utils.MessageSpecialParty(player, ID.text.WALK_NOW_ENDOWED)
        zone:setLocalVar("Endowed_" .. walk, 1)
    end
end

local function startWalk(player, walk)
    local ID = zones[player:getZoneID()]
    local zone = player:getZone()
    local data = walkData[walk]

    if not data then return end
    if not player:hasKeyItem(entryKI) then return end

    player:delKeyItem(entryKI)
    player:messageSpecial(ID.text.ENTERING_BF)
    player:messageSpecial(ID.text.KEY_ITEM_FADES, entryKI)

    createWalk(player, walk)

    local timer = zone:getLocalVar("WalkTimer_" .. walk)

    delTempItems(player, walkData.Temps.Starter)
    delTempItems(player, walkData.Temps.Random)
    addTempItems(player, walkData.Temps.Starter, false)
    player:setCharVar("[WoE]CurrentWalk", walk)
    player:setMod(tpz.mod.EXPERIENCE_RETAINED, 100)
    player:countdown(timer - os.time())
    player:addStatusEffect(tpz.effect.BATTLEFIELD, walk, 0, 0)
end

local function exitWalk(player)
    local walk = player:getCharVar("[WoE]CurrentWalk")

    if walk == 0 then return end

    delTempItems(player, walkData.Temps.Starter)
    delTempItems(player, walkData.Temps.Random)
    player:setLocalVar("raiseTimer", 0)
    player:setCharVar("[WoE]CurrentWalk", 0)
    player:setLocalVar("defeatTimer", 0)
    player:countdown(0)
    player:delStatusEffectSilent(tpz.effect.BATTLEFIELD)
end

local function failWalk(player, fail)
    local ID = zones[player:getZoneID()]
    local walk = player:getCharVar("[WoE]CurrentWalk")

    if walk == 0 then return end

    -- TODO: All party members present have fallen in battle.
    -- TODO: Now exiting...
    -- TODO: Update sets pos of player I assume
    --[13:20:54] [CSData] Type: Start, EventID: 1002, Params: 4294547296, 13500, 4294935296, 3072, 0, 0, 0, 0
    --[13:20:59] [CSData] Type: Update, EventID: 0, Params: 12, 13500, 4294935296, 3072, 0, 0, 0, 0

    if fail == failState.Time then
        activeWalks[walk] = nil
        player:messageSpecial(ID.text.TIMES_UP)
    elseif fail == failState.Defeat then
        player:messageSpecial(ID.text.FALLEN_NOW_EXITING)
    end
    player:startEvent(1002, 4294547296, 13500, 4294935296, 3072, 0, 0, 0, 0)
    exitWalk(player)
end

local function getProgress(zone, walk)
    return zone:getLocalVar("WalkProgress_" .. walk)
end

local function completeWalk(player)
    local ID = zones[player:getZoneID()]
    local walk = player:getCharVar("[WoE]CurrentWalk")

    player:messageSpecial(ID.text.VANQUISHED_ALL_FOES)
    player:messageSpecial(ID.text.OBTAIN_COFFER_REWARDS)
    player:startEvent(1003, 4294547296, 13500, 4294935296, 3072, 0, 0, 0, 0)
    generateTreasureCofferLoot(player, walk)
    exitWalk(player)
end

tpz.woe.incrementProgress = function(zone, walk)
    -- printf("Incrementing progress by 1. Old: %d New: %d", zone:getLocalVar("WalkProgress_" .. walk) -1, zone:getLocalVar("WalkProgress_" .. walk))
    zone:setLocalVar("WalkProgress_" .. walk, zone:getLocalVar("WalkProgress_" .. walk) +1)
end

tpz.woe.saveExperience = function(player)
    local walk = player:getCharVar("[WoE]CurrentWalk")

    player:setCharVar("[WoE]PendingExperience", walkData[walk].Experience)
    player:setCharVar("[WoE]CurrentWalk", 0)
end

tpz.woe.sendReraise = function (player)
    player:allowSendRaisePrompt()
    player:sendRaise(3)
end

-- Zone functions
tpz.woe.zone = tpz.woe.zone or {}

tpz.woe.zone.onEventUpdate = function(player, csid, option)
    if csid == 1002 then -- Failed WoE Walk, return to lobby
        player:updateEvent(12, 13500, 4294935296, 3072, 0, 0, 0, 0)
    elseif csid == 1003 then -- Successfully completed the walk
        player:updateEvent(72, 13500, 4294935296, 3072, 0, 0, 0, 0)
        tpz.woe.saveExperience(player)
    end
end

tpz.woe.zone.onEventFinish = function(player, csid, option)
    if csid == 1003 then -- Successfully completed the walk
    end
end

tpz.woe.zone.onZoneTick = function(player, zone, region)
    local players = zone:getPlayers()
    local ID = zones[player:getZoneID()]

    -- Debug temp randomizing
    -- local wait = player:getLocalVar("[Temps]wait")
    -- if wait == 0 then
    --     player:setLocalVar("[Temps]wait", os.time() +3)
    -- elseif os.time() > wait then
    --     addRandomTempItem(player, false)
    --     player:setLocalVar("[Temps]wait", os.time() +3)
    -- end

    -- Raise any dead players in the zone, regardless of if they're in a walk or not
    for _, char in pairs(players) do
        local raiseTimer = char:getLocalVar("raiseTimer")

        -- Add a 5s delay before sending the Reraise
        if char:isDead() then
            if raiseTimer == 0 then
                char:setLocalVar("raiseTimer", os.time() + 5)
            elseif os.time() >= raiseTimer then
                tpz.woe.sendReraise(char)
                char:setLocalVar("raiseTimer", 0)
            end
        else
            -- Check if player has any pending experience to gain
            local pendingExperience = char:getCharVar("[WoE]PendingExperience")
            if pendingExperience > 0 then
                char:addExp(char:getCharVar("[WoE]PendingExperience"))
                char:setCharVar("[WoE]PendingExperience", 0)
            end
            char:setLocalVar("raiseTimer", 0)
        end
    end

    -- Group players by walk
    local playersByWalk = {}

    for _, char in pairs(players) do
        local walk = char:getCharVar("[WoE]CurrentWalk")

        if walk > 0 then
            playersByWalk[walk] = playersByWalk[walk] or {}
            table.insert(playersByWalk[walk], char)
        end
    end

    -- Check each player inside a walk
    for walk, walkPlayers in pairs(playersByWalk) do
        local timer = zone:getLocalVar("WalkTimer_" .. walk)

        if timer > 0 then
            -- Debug testing
            -- zone:setLocalVar("WalkTimer_" .. walk, os.time() + 5)
            -- for _, char in pairs(walkPlayers) do
            --     char:countdown(5)
            -- end

            local remaining = math.max(0, timer - os.time())
            local minutes = math.floor(remaining / 60)
            local seconds = remaining % 60

            -- Display time remaining message every minute start at 5 minutes left
            local remainingMsgDelay = zone:getLocalVar("WalkMinute_" .. walk)
            if minutes > 0 and minutes <= 5 and remaining % 60 == 0 and os.time() > remainingMsgDelay then  -- Every minute (exactly)
                zone:setLocalVar("WalkMinute_" .. walk, os.time() +3)
                for _, char in pairs(walkPlayers) do
                    char:messageSpecial(ID.text.MINUTES_REMAINING, minutes, minutes, minutes, minutes)
                end
            end

            -- Check if Walk should be completed
            local objective = walkData[walk].Progress
            local progress = getProgress(zone, walk)

            if (progress >= objective) then
                for _, char in pairs(walkPlayers) do
                    completeWalk(char)
                end
                tpz.woe.mob.despawnWalkMobs(walk)
                resetWalkVars(zone, walk)
            end

            local allDead = true

            for _, char in pairs(walkPlayers) do
                if not char:isDead() then
                    allDead = false
                end
            end

            -- Party wipe logic
            if allDead then
                for _, char in pairs(walkPlayers) do
                    local defeatTimer = char:getLocalVar("defeatTimer")

                    if defeatTimer == 0 then
                        char:setLocalVar("defeatTimer", os.time() + 180)
                        char:messageSpecial(ID.text.ALL_MEMBERS_FALEN, 0, 0, 7200, 3)
                    elseif os.time() > defeatTimer then -- Return player to lobby after 3 minutes
                        failWalk(char, failState.Defeat)
                    end
                end
            else
                for _, char in pairs(walkPlayers) do
                    char:setLocalVar("defeatTimer", 0)
                end
            end
        end
    end

     -- Walk timer ran out, cancel walk
    for walk = 1, 15 do
        -- Debug Testing
        -- local currentWalk = 1 -- Which walk to adjust time for
        -- zone:setLocalVar("WalkTimer_" .. currentWalk, os.time() + 5)

        local timer = zone:getLocalVar("WalkTimer_" .. walk)

        if timer > 0 then

            -- Debug testing
            -- local remaining = math.max(0, timer - os.time())
            -- local minutes = math.floor(remaining / 60)
            -- local seconds = remaining % 60
            -- printf("[%d] Time Remaining: %02d:%02d", walk, minutes, seconds)

            if os.time() > timer then
                for _, char in pairs(players) do
                    local playersCurrentWalk = char:getCharVar("[WoE]CurrentWalk")

                    if (walk == playersCurrentWalk) then
                        failWalk(char, failState.Time)
                    end
                end

                tpz.woe.mob.despawnWalkMobs(walk)
                resetWalkVars(zone, walk)
            end
        end
    end
end

-- Verdical Conflux functions
local onTriggerConfluxByName =
{
    ['Veridical_Conflux'] = function(player, npc, isExit)
        return player:startEvent(1004)
    end,

    ['Veridical_Conflux_#01'] = function(player, npc, isExit)
        if isExit then
            return player:startEvent(1001)
        else
            if player:hasKeyItem(entryKI) then
                return player:startEvent(1000, 3156583169, 9216, 0, 0, 443030912, 440934272, 709375488, 1) -- Has KI
            else
                return player:startEvent(1000, 3160777217, 9216, 0, 0, 0, 0, 1986, 0) -- TODO: Does not have KI
            end
        end
    end,

    ['Echo_Disseminator'] = function(player, npc, isExit)
        local hasKI = player:hasKeyItem(entryKI) and 1 or 0 -- 1 means has KI, 0 means doesn't. Lua doesn't return boooleans as 1/0 like C++
        return player:startEvent(1600, 0, hasKI)
    end,
}

local onEventUpdateConfluxByName =
{
    ['Veridical_Conflux'] = function(player, csid, option, isExit)
    end,

    ['Veridical_Conflux_#01'] = function(player, csid, option, isExit)
        if isExit then
            if (csid == 1001 and option == 1) then
                player:updateEvent(4294547296, 13500, 4294935296, 3072, 445648640, 436212096, 436212736, 0)
                exitWalk(player)
            end
        else
            if (csid == 1000) then -- Entering Walk
                player:updateEvent(4294393296, 17500, 734000, 1024, 436211968, 2415924096, 2415924864, 0)
            end
        end
    end,

    ['Echo_Disseminator'] = function(player, csid, option, isExit) 
        local ID = zones[player:getZoneID()]

        if (csid == 1600)  then
            if (option == 8) then -- Give Kupofried's Medallion Key Item
                if not player:hasKeyItem(entryKI) then
                    npcUtil.giveKeyItem(player, entryKI)
                    player:delGil(1000)
                    player:messageSpecial(ID.text.LOSE_GIL, 1000)
                    player:updateEvent(1000, 446175232, 436209920, 436211200, 445645824, 436209280, 436210048, 1)
                end
            end
        end
    end,
}

local onEventFinishConfluxByName =
{
    ['Veridical_Conflux'] = function(player, csid, option, isExit)
        if (csid == 1004 and option == 0) then -- Return to Xarcabard
            ClearPlayerCofferLoot(player)
            player:setPos(238, -8, -248, 0, 137)
        end
    end,

    ['Veridical_Conflux_#01'] = function(player, csid, option, isExit)
        if isExit then
        else
        end
    end,

    ['Echo_Disseminator'] = function(player, csid, option, isExit)
    end,
}

tpz.woe.verdicalConflux = tpz.woe.verdicalConflux or {}

tpz.woe.verdicalConflux.onTrigger = function(player, npc)
    local npcId = npc:getID()
    local npcName = npc:getName()
    local verdicalConfluxBF = 17523253
    local isExit = false
    local trigger = onTriggerConfluxByName[npcName]

    if npcId >= verdicalConfluxBF then -- The numbered Verdical Conflux INSIDE the Battlefield - used for exiting
        isExit = true
    end

    if trigger then
        trigger(player, npc, isExit)
    end
end

tpz.woe.verdicalConflux.onEventUpdate = function(player, csid, option)
    local npc = player:getEventTarget()
    local npcId = npc:getID()
    local npcName = npc:getName()
    local verdicalConfluxBF = 17523253
    local isExit = false
    local eventUpdate = onEventUpdateConfluxByName[npcName]

    if npcId >= verdicalConfluxBF then -- The numbered Verdical Conflux INSIDE the Battlefield - used for exiting
        isExit = true
    end

    printf("[onEventUpdate] csid %d, option %d", csid, option)
    if eventUpdate then
        eventUpdate(player, csid, option, isExit)
    end
end

tpz.woe.verdicalConflux.onEventFinish = function(player, csid, option)
    local npc = player:getEventTarget()
    local npcId = npc:getID()
    local npcName = npc:getName()
    local walkIndex = npcId - 17523237
    local verdicalConfluxBF = 17523253
    local isExit = false
    local eventFinish = onEventFinishConfluxByName[npcName]

    if npcId >= verdicalConfluxBF then -- The numbered Verdical Conflux INSIDE the Battlefield - used for exiting
        isExit = true
    end

    printf("[onEventFinish] csid %d, option %d", csid, option)
    if eventFinish then
        eventFinish(player, csid, option, isExit)
    end

    if (csid == 1000) then -- Entering Walk
        startWalk(player, walkIndex) -- TODO: Add option, hitting any option starts the walk
        -- TODO: Add logic for "Assess the situation"


        -- [13:28:35] [CSData] Type: Update, EventID: 0, Params: 4294393296, 17500, 734000, 1024, 436211968, 2415924096, 2415924864, 0
        -- [13:28:40] [CSData] Type: MsgID, EventID: 7255, Params: 73, 17500, 734000, 1024
        -- [13:28:40] [CSData] Type: MsgID, EventID: 7256, Params: 1599, 17500, 734000, 1024
        -- [13:28:40] [CSData] Type: Update, EventID: 0, Params: 1599, 17500, 734000, 1024, 436211968, 2415924096, 2415924864, 0
        -- [13:28:41] [CSData] Type: MsgID, EventID: 7271, Params: 5, 17500, 734000, 1024

    end
end

-- Treasure Coffer functions
tpz.woe.TreasureCoffer = tpz.woe.TreasureCoffer or {}

tpz.woe.TreasureCoffer.onTrigger = function(player, npc)
    local ID = zones[player:getZoneID()]
    local items = GetPlayerCofferLoot(player)
    local hasLoot = false;
    for i = 1,10 do if items[i] then hasLoot = true; break; end end

    if hasLoot then
            local itemParams = {};
            for i = 0,4 do
                local item1 = items[(i*2)+1]
                local item2 = items[(i*2)+2]
                local value = 0;
                if item1 then
                    value = value + item1;
                end
                if item2 then
                    value = value + bit.lshift(item2, 16)
                end
                itemParams[i+1] = value;
            end

            local flagValue = 0x7FE
            for i = 1,10 do
                if items[i] then
                    flagValue = flagValue - bit.lshift(1,i)
                end
            end

            SavePlayerCofferLoot(player, items)
            return player:startEvent(1601, 182, itemParams[1], itemParams[2], itemParams[3], itemParams[4], itemParams[5], flagValue, 0)

        -- None = option 0
        -- Obtaining individual item = option 1-10
        -- Destroy all = option 11
        -- All items = option 12
    else
        return player:messageSpecial(ID.text.CANT_OPEN_CHEST)
    end
end

tpz.woe.TreasureCoffer.onEventUpdate = function(player, csid, option)
    local items = GetPlayerCofferLoot(player)

    if csid == 1601 then
        -- Take single item
        if option >= 1 and option <= 10 then
            local item = items[option]

            if item then
                if npcUtil.giveItem(player, item) then
                    items[option] = nil
                    SavePlayerCofferLoot(player, items)
                end
            end
        end

        -- Destroy all
        if option == 11 then
            ClearPlayerCofferLoot(player)
        end

        -- Take all
        if option == 12 then
            local gaveItem = false;
            for i = 1,10 do
                if items[i] then
                    if npcUtil.giveItem(player, items[i]) then
                        gaveItem = true;
                        items[i] = nil;
                    end
                end
            end
            if gaveItem then
                SavePlayerCofferLoot(player, items)
            end
        end
    end
end

tpz.woe.TreasureCoffer.onEventFinish = function(player, csid, option)
end
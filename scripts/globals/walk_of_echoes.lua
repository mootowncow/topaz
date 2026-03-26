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
-- TODO: A raise is automatically applied to anyone K.O'd after 30 seconds of being defeated. 
-- TODO: No XP loss
-- TODO: Askar, Denali, Goliard. 1 piece per walk? Drops directly from final boss?
-- TODO: Craft mats from boss, too. Maybe used to make new gear? Voidwalker gear? Or abyssea crafted gear? Or furia / ebur / w/e Synergy sets with new stats? or Lore Robe / Gules Harness / ??? sets
-- TODO: Test stun immunity on everything
-- TODO: Test nuke dmg on everything
-- TODO: Temps from kills, too?
-- TODO: Magic cool on everything
-- TODO: Entering gives Battlefield Status
-- TODO: There is no longer a timer UI element?
-- TODO: 45m time limit(All Walks I think)
-- TODO: Timer is charutils::SendTimerPacket(PChar, m_TimeLimit);, need a lua binding for charutils::SendClearTimerPacket(PChar); I think
-- TODO: Bosses can be terror procced (random element randomly selected for every boss on spawn)
-- TODO: Magiant rials for emp weapons
-- TODO: Code emp weapon skill unlock events
-- TODO: All true sound / sight
-- TODO: Treasure pool cleared on zoning out to Xarcabard and back in. Check if logging clears it, too.
-- TODO: No XP, alliance wide enmity, all mobs link (Make "SetUpWoEMob")
-- TODO: Temps drop from killing mobs (pretty often). Strange milk, strange juice, body boost, mana boost, healing salve I, clerics drink, lucid ether, clear salve, instant rr, berserkers drink, mana powder, healing mist, mana mist
-- Catholicion, catholicion +1
-- TODO: Use addon to capture models
-- TODO: New spell scrolls?
-- TODO: Misc items, new jewels like Fulmenite and new ore like Durium Ore? Or save for Abyssea?
-- TODO: Give Wizards / Giants drink to trusts also when a player uses
-- TODO: "Endowed, event 7297" weaker mobs, bonus evaluation, and give a temp item. Seems to lower MDEF too, so probably defense, dmg, attack mdef?
-- TODO: Exiting after 3m of defeats sends back to "lobby" -420, 14, -32 facing conflux #07 
-- TODO: Fill Misc item list
-- TODO: All members Fallen msg: [13:17:55] [CSData] Type: MsgID, EventID: 7260, Params: 67, 0, 734000, 3
-- TODO: Save temp gained between runs into other walks. Prob save temps by zone ID and load them by zone ID if applicable, maybe LSB has for abyssea?
-- TODO: delTempItems(player, temps) doesn't work and should only delete when in lobby but not remove from saved sql database for that player and zone. Maybe delItem() doesn't work with tpz.inv.TEMPITEMS?


-- Current:
    -- TODO: failWalk (and probably on zone tick) needs logic for all party members in zone dead, then display this stuff
    -- All party members have fallen in battle. Exiting in <param4> minutes, <param3> seconds.
    -- player:messageSpecial(ID.text.EXITING_IN)


-- Testing:
-- 865 stone's on cyanic/damask crabs
-- 865 (1022 after weakened msg) Stone on Caldera crab
-- TODO: Test dmg outside on 0 mdt/mdef mob


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
local lobbyPos = { -420, 14, -32, 192 }
local leaveWoeEvent = 1004
local timeLimit = 2700
local defeatEvent = 7260 -- (params: 10, 12352, 73400, 3) 3 is minutes when it's exiting, 73400 is seconds
local completionEvent = 1003 -- sends back to "lobby" -420, 14, -32 facing conflux #07 
local walkData =
{
    [1] =
    {
        -- Cyanic Crab, lvl { 77 }, Model { Blue }, Size { Small }  Amount { 9 }, Ids {}  Partied { 4, need ids }, Boss { False }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Enwater, Water II, Waterga II }, TP Moves: { Crab}
        -- Damask Crab, lvl { 77 }, Model { Red }, Size { Small }  Amount { 9 }, Ids {} Partied { 4, need ids }, Boss { False }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Poisonga II, Waterga II, Water IV }, TP Moves: { Crab}
        -- Caldera Crab, lvl { 80 }, Model { Barnacle }, Size { Small? } Ids {},  Amount { 3 }, Partied { 3 }, Boss { True }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Water IV, Waterga III }, TP Moves: { Mega Scissors, Venom Shower (Goes off without target?) } 
            -- Mechanics { Always uses Mega Scissors x3 in a row, Plague Aura after using Venom Shower for (50/tick) ~20 seconds }
        -- Crabs from deeper in the battlefield will come to the defeated crab's corpse. Make sure you are at least 16' from the corpse and you will not be aggrod.
        -- Upon killing crabs, occasionally the boss Caldera Crab will come to its aid, running to where the crab was killed.
        -- 15 yard aggro range
        -- Completion: Caldera crabs dead
        Events      = { Conflux = 1000, Entry = 7033, Exit = 1001 },
        StartPos    = { X =-574, Y = 18, Z =734, Rot = 62 },
        Mobs        = { IdStart = 17522689, IdEnd = 17522709, Lvl = 77 },
        Drops       = { item.THRIFT_GLOVES, item.BELISAMAS_ROPE, item.ARDOR_PENDANT, item.KARAGOZ_MANTLE },
        SetDrop     = { item.ASKAR_GAMBIERAS },
        Title       = { title.TORCHBEARER_OF_THE_1ST_WALK },
        Exp         = { 15000 }
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
        Drops       = { item.THRIFT_GLOVES, item.BELISAMAS_ROPE, item.ARDOR_PENDANT, item.KARAGOZ_MANTLE },
        SetDrop     = { item.DENALI_GAMASHES, item.GOLIARD_CLOGS },
        Title       = { title.TORCHBEARER_OF_THE_2ND_WALK },
        Exp         = { 15000 }
    },
    [3] =
    {
        -- Grenade Syrup lvl { 77 }, Model { 0x0000260100000000000000000000000000000000 }, Size { Small }  Amount { 9 }, Ids {} Partied { 4, need ids }, Boss { False }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Blind, Bio III }, TP Moves: { Mucus Spread}
        -- Morbid Molasses, lvl { 80 }, Model { 0x0000250100000000000000000000000000000000 }, Size { Large } Ids {},  Amount { 3 }, Partied { 3 }, Boss { True }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Blindga, Dispelga, Sleepga II }, TP Moves: { Dissolve , Cytokinesis, Mucus Spread (All before next go off even if no targets in range), Fluid Spread } 
        -- 3-4 Grenade Syrups with a Morbid Molasses
        -- Killing Morbid Molasses kills the Grenade Syrups partied with them
        -- 15 yard aggro range
        Events  = { Conflux = 1000, Entry = 7033, Exit = 1001 },
        StartPos    = { X =-574, Y = 18, Z =734, Rot = 157 }, -- TODO
        Mobs        = { IdStart = 12522699, IdEnd = 12522709, Lvl = 77 }, -- TODO
        Drops   = { item.THRIFT_GLOVES, item.BELISAMAS_ROPE, item.ARDOR_PENDANT, item.KARAGOZ_MANTLE },
        SetDrop = { item.GOLIARD_CLOGS },
        Title   = { title.TORCHBEARER_OF_THE_2ND_WALK },
        Exp     = { 15000 }
    },


    Temps =
    {
        item.LUCID_POTION_III, item.LUCID_ETHER_III, item.MEGALIXIR, item.TUBE_OF_HEALING_SALVE_II, item.BOTTLE_OF_CATHOLICON, item.BOTTLE_OF_VICARS_DRINK, item.TUBE_OF_CLEAR_SALVE_II,
        item.DUSTY_WING, item.SCROLL_OF_INSTANT_RERAISE, item.DUSTY_SCROLL_OF_RERAISE, item.BOTTLE_OF_GIANTS_DRINK, item.BOTTLE_OF_WIZARDS_DRINK, item.BOTTLE_OF_FANATICS_DRINK, item.BOTTLE_OF_FOOLS_DRINK,
        item.BOTTLE_OF_ASCETICS_TONIC, item.BOTTLE_OF_CHAMPIONS_TONIC, item.BOTTLE_OF_BRAVERS_DRINK, item.BOTTLE_OF_MONARCHS_DRINK, item.BOTTLE_OF_BERSERKERS_TONIC, item.BOTTLE_OF_SWIFTSHOT_TONIC
    },
    ExtraDrops =
    {
        -- Coins and pouches share a group, one or other per slot]
        Coins =     { item.COIN_OF_ADVANCEMENT, item.COIN_OF_BIRTH, item.COIN_OF_DECAY, item.COIN_OF_GLORY, item.COIN_OF_RUIN },
        Pouches =   { item.FRAYED_POUCH_OF_ADVANCEMENT, item.FRAYED_POUCH_OF_BIRTH, item.FRAYED_POUCH_OF_DECAY, item.FRAYED_POUCH_OF_GLORY, item.FRAYED_POUCH_OF_RUIN, item.POUCH_OF_LIMINAL_RESIDUE },
        Scrolls =    { }, -- t5 scrolls, nocturne, cura III, Jubaku: Ni
        Misc =      { }, --ores, cloth, etc
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

-- Mob functions
local function spawnWalkMobs(walk)
    local data = walkData[walk]

    if not data then return end

    for mobId = data.Mobs.IdStart, data.Mobs.IdEnd do
        local mob = GetMobByID(mobId)

        if mob and not mob:isSpawned() then
            mob:spawn()
        end
    end
end

local function despawnWalkMobs(walk)
    local data = walkData[walk]

    if not data then return end
    for mobId = data.Mobs.IdStart, data.Mobs.IdEnd do
        local mob = GetMobByID(mobId)

        if mob and mob:isSpawned() then
            DespawnMob(mobId)
        end
    end
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

local function createWalk(player, walk)
    local zone = player:getZone()

    -- Check if Walk is already active
    if zone:getLocalVar("WalkTimer_" .. walk) > os.time() then return end

    spawnWalkMobs(walk)
    activeWalks[walk] = true
    zone:setLocalVar("WalkTimer_" .. walk,os.time() + 2700)
end

local function addTempItems(player, temps)
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

    -- delete key items to player, with message
    for _, tempId in pairs(givenTemps) do
        if not player:hasItem(tempId) then
            player:addTempItem(tempId)
        end
    end

    if #givenTemps > 1 then
        player:messageSpecial(ID.text.OBTAINS_MULTIPLE_TEMPS, #givenTemps)
    else
        player:messageSpecial(ID.text.OBTAINS_TEMP_ITEM, givenTemps[1])
    end
    return true
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

    delTempItems(player, walkData.Temps)
    addTempItems(player, walkData.Temps)
    player:setCharVar("[WoE]CurrentWalk", walk)
    player:countdown(timer - os.time())
end

local function exitWalk(player)
    local walk = player:getCharVar("[WoE]CurrentWalk")

    if walk == 0 then return end

    player:setCharVar("[WoE]CurrentWalk", 0)
    player:setLocalVar("defeatTimer", 0)
    player:countdown(0)
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
        printf("times up!")
        despawnWalkMobs(walk)
        activeWalks[walk] = nil
        player:messageSpecial(ID.text.TIMES_UP)
    elseif fail == failState.Defeat then
        player:messageSpecial(ID.text.FALLEN_NOW_EXITING)
        printf("Defeat!")
        -- TODO: set a 3 minute timer as a char var, then exit them and eventupdate for setting their pos (same as times up?)
        -- TODO: failWalk (and probably on zone tick) needs logic for all party members in zone dead, then display this stuff
    -- All party members have fallen in battle. Exiting in <param4> minutes, <param3> seconds.
    -- player:messageSpecial(ID.text.EXITING_IN)
    end
    player:startEvent(1002, 4294547296, 13500, 4294935296, 3072, 0, 0, 0, 0)
    exitWalk(player)
end

local function completeWalk(player)
    local walk = player:getCharVar("[WoE]CurrentWalk")
    player:setCharVar("[WoE]CurrentWalk", 0)
    player:countdown(0)
    generateTreasureCofferLoot(player, walk)
end

tpz.woe.onZoneTick = function(player, zone, region)
    local players = zone:getPlayers()
    local ID = zones[player:getZoneID()]

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
            -- zone:setLocalVar("WalkTimer_" .. walk, os.time() + 15)
            -- player:countdown(15)

            local remaining = timer - os.time()
            local minutes = math.floor(remaining / 60)
            local seconds = remaining % 60

            printf("[%d] Time Remaining: %02d:%02d", walk, minutes, seconds)

        -- Display time remaining message every minute start at 5 minutes left
        local remainingMsgDelay = zone:getLocalVar("WalkMinute_" .. walk)
        if minutes > 0 and minutes <= 5 and remaining % 60 == 0 and os.time() > remainingMsgDelay then  -- Every minute (exactly)
            zone:setLocalVar("WalkMinute_" .. walk, os.time() +3)
            player:messageSpecial(ID.text.MINUTES_REMAINING, minutes, minutes, minutes, minutes)
        end

            local allDead = true

            for _, char in pairs(walkPlayers) do
                if not char:isDead() then
                    allDead = false
                    char:setLocalVar("raiseTimer", 0)
                else -- Raise players
                    local raiseTimer = char:getLocalVar("raiseTimer")

                    -- Add a 5s delay before sending the Reraise
                    if raiseTimer == 0 then
                        char:setLocalVar("raiseTimer", os.time() + 5)
                    elseif os.time() >= raiseTimer then
                        if not char:hasRaise() then
                            char:sendRaise(3)
                        end
                        char:setLocalVar("raiseTimer", 0)
                    end
                end
            end

            -- Party wipe logic
            if allDead then
                for _, char in pairs(walkPlayers) do
                    local defeatTimer = char:getLocalVar("defeatTimer")

                    if defeatTimer == 0 then
                        char:setLocalVar("defeatTimer", os.time() + 180)
                        player:messageSpecial(ID.text.ALL_MEMBERS_FALEN, 0, 0, 7200, 3)
                    elseif os.time() > defeatTimer then
                        failWalk(char, failState.Defeat)
                    end
                end
            else
                for _, char in pairs(walkPlayers) do
                    char:setLocalVar("defeatTimer", 0)
                end
            end

            -- Return player to lobby after 3 minutes
            if os.time() > timer then
                for _, char in pairs(walkPlayers) do
                    failWalk(char, failState.Time)
                end

                zone:setLocalVar("WalkTimer_" .. walk, 0)
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
        startWalk(player, walkIndex)
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
                    value = value + bit.lshift(item2, 16);
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
    else -- Remove, for testing!
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
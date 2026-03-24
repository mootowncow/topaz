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
-- TODO: There is no longer a timer UI element?
-- TODO: 45m time limit(All Walks I think)
-- TODO: Timer is charutils::SendTimerPacket(PChar, m_TimeLimit);, need a lua binding for charutils::SendClearTimerPacket(PChar); I think
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
local entry = tpz.ki.KUPOFRIEDS_MEDALLION
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
        -- Caldera Crab, lvl { 80 }, Model { Barnacle }, Size { Large } Ids {},  Amount { 3 }, Partied { 3 }, Boss { True }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Water IV, Waterga III }, TP Moves: { Mega Scissors, Venom Shower } 
            -- Mechanics { Always uses Mega Scissors x3 in a row, Plague Aura after using Venom Shower for (50/tick) ~20 seconds }
        -- Crabs from deeper in the battlefield will come to the defeated crab's corpse. Make sure you are at least 16' from the corpse and you will not be aggrod.
        -- Upon killing crabs, occasionally the boss Caldera Crab will come to its aid, running to where the crab was killed.
        -- 15 yard aggro range
        -- Completion: Caldera crabs dead
        Events  = { Conflux = 1000, Entry = 7033, Exit = 1001 },
        Mobs    = { Ids = { 12522699, 999999 }, Lvl = { 77 } }, -- Unsure where ids end, one was 12522708
        Drops   = { item.THRIFT_GLOVES, item.BELISAMAS_ROPE, item.ARDOR_PENDANT, item.KARAGOZ_MANTLE },
        SetDrop = { item.ASKAR_GAMBIERAS },
        Title   = { title.TORCHBEARER_OF_THE_1ST_WALK },
        Exp     = { 15000 }
    },
    [2] =
    {
        -- Grenade Syrup lvl { 77 }, Model { 0x0000260100000000000000000000000000000000 }, Size { Small }  Amount { 9 }, Ids {} Partied { 4, need ids }, Boss { False }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Blind, Bio III }, TP Moves: { Mucus Spread}
        -- Morbid Molasses, lvl { 80 }, Model { 0x0000250100000000000000000000000000000000 }, Size { Large } Ids {},  Amount { 3 }, Partied { 3 }, Boss { True }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Blindga, Dispelga, Sleepga II }, TP Moves: { Dissolve , Cytokinesis, Mucus Spread (All before next go off even if no targets in range), Fluid Spread } 
        -- 3-4 Grenade Syrups with a Morbid Molasses
        -- Killing Morbid Molasses kills the Grenade Syrups partied with them
        -- 15 yard aggro range
        Events  = { Conflux = 1000, Entry = 7033, Exit = 1001 },
        Mobs    = { Ids = { 12522699, 999999 }, Lvl = { 77 } }, -- Unsure where ids end, one was 12522708
        Drops   = { item.THRIFT_GLOVES, item.BELISAMAS_ROPE, item.ARDOR_PENDANT, item.KARAGOZ_MANTLE },
        SetDrop = { item.DENALI_GAMASHES, item.GOLIARD_CLOGS },
        Title   = { title.TORCHBEARER_OF_THE_2ND_WALK },
        Exp     = { 15000 }
    },
    [3] =
    {
        -- Grenade Syrup lvl { 77 }, Model { 0x0000260100000000000000000000000000000000 }, Size { Small }  Amount { 9 }, Ids {} Partied { 4, need ids }, Boss { False }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Blind, Bio III }, TP Moves: { Mucus Spread}
        -- Morbid Molasses, lvl { 80 }, Model { 0x0000250100000000000000000000000000000000 }, Size { Large } Ids {},  Amount { 3 }, Partied { 3 }, Boss { True }, Immune { Sleep, Break, Bind, Gravity, Silence }, Spells { Blindga, Dispelga, Sleepga II }, TP Moves: { Dissolve , Cytokinesis, Mucus Spread (All before next go off even if no targets in range), Fluid Spread } 
        -- 3-4 Grenade Syrups with a Morbid Molasses
        -- Killing Morbid Molasses kills the Grenade Syrups partied with them
        -- 15 yard aggro range
        Events  = { Conflux = 1000, Entry = 7033, Exit = 1001 },
        Mobs    = { Ids = { 12522699, 999999 }, Lvl = { 77 } }, -- Unsure where ids end, one was 12522708
        Drops   = { item.THRIFT_GLOVES, item.BELISAMAS_ROPE, item.ARDOR_PENDANT, item.KARAGOZ_MANTLE },
        SetDrop = { item.GOLIARD_CLOGS },
        Title   = { title.TORCHBEARER_OF_THE_2ND_WALK },
        Exp     = { 15000 }
    },


    Temps =
    {
        item.LUCID_POTION_III, item.LUCID_ETHER_III, item.MEGALIXIR, item.TUBE_OF_HEALING_SALVE_I, item.TUBE_OF_HEALING_SALVE_II, item.BOTTLE_OF_CATHOLICON, item.BOTTLE_OF_VICARS_DRINK, item.TUBE_OF_CLEAR_SALVE_II,
        item.DUSTY_WING, item.SCROLL_OF_INSTANT_RERAISE, item.DUSTY_SCROLL_OF_RERAISE, item.BOTTLE_OF_GIANTS_DRINK, item.BOTTLE_OF_WIZARDS_DRINK, item.BOTTLE_OF_FANATICS_DRINK, item.BOTTLE_OF_FOOLS_DRINK,
        item.BOTTLE_OF_ASCETICS_TONIC, item.BOTTLE_OF_CHAMPIONS_TONIC, item.BOTTLE_OF_BRAVERS_DRINK, item.BOTTLE_OF_MONARCHS_DRINK, item.BOTTLE_OF_BERSERKERS_TONIC, item.BOTTLE_OF_SWIFTSHOT_TONIC
    },
    ExtraDrops =
    {
        -- Coins and pouches share a group, one or other per slot]
        Coins =     { item.COIN_OF_ADVANCEMENT, item.COIN_OF_BIRTH, item.COIN_OF_DECAY, item.COIN_OF_GLORY, item.COIN_OF_RUIN },
        Pouches =   { item.FRAYED_POUCH_OF_ADVANCEMENT, item.FRAYED_POUCH_OF_BIRTH, item.FRAYED_POUCH_OF_DECAY, item.FRAYED_POUCH_OF_GLORY, item.FRAYED_POUCH_OF_RUIN, item.POUCH_OF_LIMINAL_RESIDUE },
        -- Scrolls =    { item.THRIFT_GLOVES, item.BELISAMAS_ROPE, item.ARDOR_PENDANT, item.KARAGOZ_MANTLE },
        Misc =      { }, --ores, cloth, etc
    }
}

local function startWalk(player, walk)
end

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

local function completeWalk(player, walk)
    generateTreasureCofferLoot(player, walk)
end

-- Verdical Conflux functions
tpz.woe.verdicalConflux = tpz.woe.verdicalConflux or {}

tpz.woe.verdicalConflux.onTrigger = function(player, npc)
    local confluxData =
    {
        [0] = { Name = 'Veridical_Conflux',         Event = 1004 },
        [1] = { Name = 'Veridical_Conflux_#01',     Event = 1003 },
    }

    for _, conflux in pairs(confluxData) do
        if conflux.Name == npc:getName() then
            player:startEvent(conflux.Event)
            break
        end
    end
end

tpz.woe.verdicalConflux.onEventUpdate = function(player, csid, option)
end

tpz.woe.verdicalConflux.onEventFinish = function(player, csid, option)

    -- Return to Xarcabard
    if (csid == 1004 and option == 0) then
        ClearPlayerCofferLoot(player)
        player:setPos(238, -8, -248, 0, 137)
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
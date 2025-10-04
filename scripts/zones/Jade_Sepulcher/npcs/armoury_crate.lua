-----------------------------------
-- Area: Monarch Linn
-- NPC:  Armoury Crate
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/titles")
require("scripts/globals/quests")

local loot =
{
    -- ISNM: Making a Mockery
    [1152] =
    {
        {
            {itemid = 65535, droprate = 1000, amount = 18000},  -- gil

        },
        {
            { itemid = 16217, droprate = 100 },
            { itemid = 14944, droprate = 100 },
            { itemid = 17718, droprate = 100 },
            { itemid = 15976, droprate = 100 },
        },
        {
            { itemid = 4205, droprate = 250 },
            { itemid = 4203, droprate = 250 },
            { itemid = 4199, droprate = 250 },
            { itemid = 4201, droprate = 250 },
        },
        {
            { itemid = 738, droprate = 300 },
            { itemid = 645, droprate = 300 },
            { itemid = 646, droprate = 150 },
            { itemid = 739, droprate = 150 },
            { itemid = 902, droprate = 100 },
        },
        {
            { itemid = 2308, droprate = 100 },
            { itemid = 1636, droprate = 100 },
            { itemid = 670, droprate = 100 },
            { itemid = 2006, droprate = 100 },
        },
        {
            { itemid = 4765, droprate = 110 },
            { itemid = 5074, droprate = 110 },
            { itemid = 5030, droprate = 110 },
            { itemid = 4812, droprate = 110 },
            { itemid = 4822, droprate = 110 },
            { itemid = 4816, droprate = 110 },
            { itemid = 4903, droprate = 110 },
            { itemid = 4902, droprate = 110 },
            { itemid = 2249, droprate = 40 },
            { itemid = 2245, droprate = 40 },
            { itemid = 2257, droprate = 40 },
        },
        {
            { itemid = 4207, droprate = 250 },
            { itemid = 4209, droprate = 250 },
            { itemid = 4211, droprate = 250 },
            { itemid = 4213, droprate = 250 },
        },
        {
            { itemid = 2148, droprate = 1000 },
        },
        {
            { itemid = 2314, droprate = 1000 },
        },
    },

    -- ISNM: Shadows of the Mind
    [1153] =
    {
        {
            {itemid = 65535, droprate = 1000, amount = 12000},  -- gil

        },
        {
            { itemid = 17720, droprate = 80 },
            { itemid = 18026, droprate = 80 },
            { itemid = 15528, droprate = 80 },
            { itemid = 18114, droprate = 80 },
        },
        {
            { itemid = 935, droprate = 125 },
            { itemid = 883, droprate = 125 },
            { itemid = 1656, droprate = 125 },
            { itemid = 903, droprate = 125 },
            { itemid = 2228, droprate = 125 },
            { itemid = 2146, droprate = 125 },
            { itemid = 1886, droprate = 125 },
        },
        {
            { itemid = 883, droprate = 125 },
            { itemid = 1656, droprate = 125 },
            { itemid = 903, droprate = 125 },
            { itemid = 2228, droprate = 125 },
            { itemid = 2146, droprate = 125 },
            { itemid = 1886, droprate = 125 },
            { itemid = 935, droprate = 125 },
        },
        {
            { itemid = 1615, droprate = 25 },
            { itemid = 1765, droprate = 25 },
            { itemid = 2288, droprate = 25 },
            { itemid = 830, droprate = 25 },
            { itemid = 1132, droprate = 25 },
            { itemid = 1829, droprate = 25 },
            { itemid = 1415, droprate = 25 },
            { itemid = 2289, droprate = 25 },
        },
        {
            { itemid = 4207, droprate = 250 },
            { itemid = 4209, droprate = 250 },
            { itemid = 4211, droprate = 250 },
            { itemid = 4213, droprate = 250 },
        },
        {
            { itemid =     0, droprate =  950}, -- nothing
            { itemid = 685, droprate = 50 }, -- Khroma ore
        },
        {
            { itemid = 2148, droprate = 1000 },
        },
        {
            { itemid = 2314, droprate = 1000 },
        },
    },
}

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local bfData =
    {
        [1152] = tpz.ki.CONFIDENTIAL_IMPERIAL_ORDER,
        [1153] = tpz.ki.SECRET_IMPERIAL_ORDER,
    }

    local battlefield = player:getBattlefield()
    if battlefield then
        local bfId = battlefield:getID()
        local requiredKI = bfData[bfId]

        -- Only allow player to open chest if they have the KI
        if requiredKI and player:hasKeyItem(requiredKI) then
            tpz.battlefield.HandleLootRolls(battlefield, loot[bfId], nil, npc)
        else
            player:PrintToPlayer("You do not have the required key item to open that.", 0xD, nil)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

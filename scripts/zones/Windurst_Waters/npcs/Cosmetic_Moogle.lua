-----------------------------------
-- Area: Windurst Waters
--  NPC: Taza
-- Moogle Coins Moogle
-- !pos
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/items")
require("scripts/globals/augments")
-----------------------------------
local itemList =
{
    { armor = tpz.items.FANCY_TOP, coins = 50, egg = tpz.items.F_EGG },
    { armor = tpz.items.FANCY_SHORTS, coins = 40, egg = tpz.items. F_EGG },
    { armor = tpz.items.COSSIE_TOP, coins = 50, egg = tpz.items.C_EGG },
    { armor = tpz.items.COSSIE_BOTTOM, coins = 40, egg = tpz.items.C_EGG },
    { armor = tpz.items.STARLET_FLOWER, coins = 15, egg = tpz.items.S_EGG },
    { armor = tpz.items.STARLET_JABOT, coins = 50, egg = tpz.items.S_EGG },
    { armor = tpz.items.STARLET_GLOVES, coins = 15, egg = tpz.items.S_EGG },
    { armor = tpz.items.STARLET_SKIRT, coins = 40, egg = tpz.items.S_EGG },
    { armor = tpz.items.STARLET_BOOTS, coins = 20, egg = tpz.items.S_EGG },
    { armor = tpz.items.MITHRA_TOP, coins = 35, egg = tpz.items.M_EGG },
    { armor = tpz.items.MITHRA_SHORTS, coins = 25, egg = tpz.items.M_EGG },
    { armor = tpz.items.SAVAGE_TOP, coins = 35, egg = tpz.items.S_EGG },
    { armor = tpz.items.SAVAGE_SHORTS, coins = 25, egg = tpz.items.S_EGG },
    { armor = tpz.items.LADYS_YUKATA, coins = 25, egg = tpz.items.L_EGG },
    { armor = tpz.items.OMINA_YUKATA, coins = 25, egg = tpz.items.O_EGG },
    { armor = tpz.items.ONNAGUSA_YUKATA, coins = 35, egg = tpz.items.O_EGG },
    { armor = tpz.items.HIMEGAMI_YUKATA, coins = 35, egg = tpz.items.H_EGG },
    { armor = tpz.items.DREAM_HAT, coins = 25, egg = tpz.items.D_EGG },
    { armor = tpz.items.DREAM_ROBE, coins = 35, egg = tpz.items.D_EGG },
    { armor = tpz.items.DREAM_MITTENS, coins = 15, egg = tpz.items.D_EGG },
    { armor = tpz.items.DREAM_PANTS, coins = 30, egg = tpz.items.D_EGG },
    { armor = tpz.items.DREAM_BOOTS, coins = 20, egg = tpz.items.D_EGG },
    { armor = tpz.items.PIEUJE_UNITY_SHIRT, coins = 40, egg = tpz.items.P_EGG },
    { armor = tpz.items.AYAME_UNITY_SHIRT, coins = 40, egg = tpz.items.A_EGG },
    { armor = tpz.items.INVINCIBLE_SHIELD_UNITY_SHIRT, coins = 40, egg = tpz.items.I_EGG },
    { armor = tpz.items.APURURU_UNITY_SHIRT, coins = 40, egg = tpz.items.U_EGG },
    { armor = tpz.items.MAAT_UNITY_SHIRT, coins = 40, egg = tpz.items.M_EGG },
    { armor = tpz.items.ALDO_UNITY_SHIRT, coins = 40, egg = tpz.items.L_EGG },
    { armor = tpz.items.JAKOH_WAHCONDALO_UNITY_SHIRT, coins = 40, egg = tpz.items.J_EGG },
    { armor = tpz.items.NAJA_SALAHEEM_UNITY_SHIRT, coins = 40, egg = tpz.items.N_EGG },
    { armor = tpz.items.FLAVIRIA_UNITY_SHIRT, coins = 40, egg = tpz.items.F_EGG },
    { armor = tpz.items.YORAN_ORAN_UNITY_SHIRT, coins = 40, egg = tpz.items.Y_EGG },
    { armor = tpz.items.SYLVIE_UNITY_SHIRT, coins = 40, egg = tpz.items.S_EGG },
    { armor = tpz.items.CHOCOBO_SHIRT, coins = 40, egg = tpz.items.C_EGG },
    { armor = tpz.items.ALLIANCE_SHIRT, coins = 50, egg = tpz.items.A_EGG },
    { armor = tpz.items.AKITU_SHIRT, coins = 45, egg = tpz.items.A_EGG },
    { armor = tpz.items.GIL_NABBER_SHIRT, coins = 45, egg = tpz.items.G_EGG },
    { armor = tpz.items.AGENT_COAT, coins = 55, egg = tpz.items.A_EGG },
    { armor = tpz.items.DECENNIAL_DRESS, coins = 50, egg = tpz.items.D_EGG },
    { armor = tpz.items.DECENNIAL_HOSE, coins = 40, egg = tpz.items.D_EGG },
    { armor = tpz.items.DINNER_JACKET, coins = 30, egg = tpz.items.D_EGG },
    { armor = tpz.items.HEART_APRON, coins = 60, egg = tpz.items.H_EGG },
    { armor = tpz.items.NOVENNIAL_DRESS, coins = 60, egg = tpz.items.N_EGG },
    { armor = tpz.items.NOVENNIAL_THIGH_BOOTS, coins = 50, egg = tpz.items.N_EGG },
    { armor = tpz.items.PRETTY_PINK_SUBLIGAR, coins = 60, egg = tpz.items.P_EGG },
    { armor = tpz.items.SHOAL_MAILLOT, coins = 55, egg = tpz.items.S_EGG },
    { armor = tpz.items.SHOAL_TRUNKS, coins = 45, egg = tpz.items.S_EGG },
    { armor = tpz.items.SHOKUJO_HANMOMOHIKI, coins = 55, egg = tpz.items.S_EGG },
}

local function DistributeItem(player, item)
    player:tradeComplete()
    player:addItem(item)
    local ID = zones[player:getZoneID()]
    player:PrintToPlayer("A wonderful choice, kupo!",0,"Moogle")
    player:messageSpecial(ID.text.ITEM_OBTAINED, item)
end

function onTrade(player, npc, trade)    
    for _, items in pairs(itemList) do
        if (type(itemList) == 'table') and npcUtil.tradeHasExactly(trade, { { tpz.items.MOOGLE_COIN, items.coins} , items.egg  }) then
            DistributeItem(player, items.armor)
            return
        end
    end
    player:PrintToPlayer("I can't do anything with those items, kupo!",0,"Moogle")
end

function onTrigger(player, npc)
    player:PrintToPlayer("Kupo! Give me Moogle Coins and the correct egg for fantastic prizes!",0,"Moogle")
    for i = tpz.items.A_EGG, tpz.items.Z_EGG, 1 do
        player:addItem(i)
    end
    player:messageSpecial(ID.text.ITEM_OBTAINED, tpz.items.A_EGG)
end
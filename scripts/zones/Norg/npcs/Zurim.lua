-----------------------------------
-- Area: Norg
--  NPC: Zurim
-- !gotoid 17809552
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------
local menus = {
    { Cost=10, Items={
        tpz.items.ESCHALIXIR_PLUS_TWO,
        tpz.items.FRAYED_SACK_OF_FECUNDITY,
        tpz.items.FRAYED_SACK_OF_PLENTY,
        tpz.items.FRAYED_SACK_OF_OPULENCE
    } },

    { Cost=40, Items={
        tpz.items.HERVOR_GALEA,
        tpz.items.HERVOR_HAUBERT,
        tpz.items.HERVOR_MOUFFLES,
        tpz.items.HERVOR_BRAYETTES,
        tpz.items.HERVOR_SOLLERETS,

        tpz.items.HEIDREK_MASK,
        tpz.items.HEIDREK_HARNESS,
        tpz.items.HEIDREK_GLOVES,
        tpz.items.HEIDREK_BRAIS,
        tpz.items.HEIDREK_BOOTS,

        tpz.items.ANGANTYR_BERET,
        tpz.items.ANGANTYR_ROBE,
        tpz.items.ANGANTYR_MITTENS,
        tpz.items.ANGANTYR_TIGHTS,
        tpz.items.ANGANTYR_BOOTS
    } },

    { Cost=80, Items={
        tpz.items.VOLUSPA_KNUCKLES,
        tpz.items.VOLUSPA_KNIFE,
        tpz.items.VOLUSPA_SWORD,
        tpz.items.VOLUSPA_BLADE,
        tpz.items.VOLUSPA_AXE,
        tpz.items.VOLUSPA_CHOPPER,
        tpz.items.VOLUSPA_SCYTHE,
        tpz.items.VOLUSPA_LANCE,
        tpz.items.VOLUSPA_KATANA,
        tpz.items.VOLUSPA_TACHI,
        tpz.items.VOLUSPA_HAMMER,
        tpz.items.VOLUSPA_POLE,
        tpz.items.VOLUSPA_POLE,
        tpz.items.VOLUSPA_BOW,
        tpz.items.VOLUSPA_GUN,
        tpz.items.VOLUSPA_GRIP,
        tpz.items.VOLUSPA_SHIELD,
        tpz.items.VOLUSPA_QUIVER,
        tpz.items.VOLUSPA_BOLT_QUIVER,
        tpz.items.VOLUSPA_BULLET_POUCH,
        tpz.items.DATE_SHURIKEN_POUCH
    } },

    { Cost=100, Items={
        tpz.items.SANCTITY_NECKLACE,
        tpz.items.GISHDUBAR_SASH,
        tpz.items.EABANI_EARRING,
        tpz.items.ETANA_RING,
        tpz.items.IZDUBAR_MANTLE,
        tpz.items.SOLEMNITY_CAPE
    } },

    -- TODO:
    { Cost=200, Items={
        tpz.items.HERVOR_GALEA,
    } },

    { Cost=400, Items={
        tpz.items.HERVOR_GALEA,
    } },

    { Cost=600, Items={
        tpz.items.HERVOR_GALEA,
    } },

    { Cost=800, Items={
        tpz.items.HERVOR_GALEA,
    } },

    { Cost=1000, Items={
        tpz.items.HERVOR_GALEA,
    } },

    { Cost=1200, Items={
        tpz.items.HERVOR_GALEA,
    } },
};

local function ParamToItem(option)
    local lowBits = bit.band(option, 0x0000003F)
    local menuIndex = ((lowBits - 1) / 4) + 1;
    local menu = menus[menuIndex]
    if menu then
        local highBits = bit.band(option, 0xFFFFFFC0);
        local item = (highBits / 0x40) + 1;
        return menu.Items[item], menu.Cost
    end
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local zurimIntro = player:getCharVar("zurimIntro")
    local currentPoints = player:getCurrency("domain_points")

    if (zurimIntro == 0) then
        return player:startEvent(9511) -- intro first time talking
    end

    player:startEvent(9512, currentPoints, 750909734, 2, 0, 67108863, 112165045, 4095, 128) -- normal
end

function onEventUpdate(player, csid, option)
    local currentPoints = player:getCurrency("domain_points")

    if (csid == 9512) then
        local item,cost = ParamToItem(option)
        printf("Option: [%d], Item: [%d], Cost: [%d]", option, item, cost)

        if (currentPoints >= cost) then
            player:updateEvent(90, 7, 1880556290, 24119625, 675706948, 136512258, 138676741, 0)
            player:addItem(item)
            player:messageSpecial( ID.text.ITEM_OBTAINED, item)
            player:delCurrency("domain_points", cost)
        end
    end
end

function onEventFinish(player, csid, option)
    if (csid == 9511) then
        player:setCharVar("zurimIntro", 1)
    elseif (csid == 9512) then
    end
end
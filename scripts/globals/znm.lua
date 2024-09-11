-----------------------------------
--
--  ZNM(Zeni Notorious Monster) utilities
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/npc_util")
require("scripts/globals/status")
require("scripts/globals/zone")
require("scripts/globals/keyitems")
require("scripts/globals/items")
require("scripts/globals/augments")
-----------------------------------

tpz = tpz or {}
tpz.znm = tpz.znm or {}

local nmPopData =
{
    -- Tier 1
    { name = 'Vulpangue',                 popItem = tpz.items.HELLCAGE_BUTTERFLY },
    { name = 'Chamrosh',                  popItem = tpz.items.JUG_OF_FLORAL_NECTAR },
    { name = 'Cheese Hoarder Gigiroon',   popItem = tpz.items.WEDGE_OF_RODENT_CHEESE },
    { name = 'Brass Borer',               popItem = tpz.items.CLUMP_OF_SHADELEAVES },
    { name = 'Claret',                    popItem = tpz.items.BEAKER_OF_PECTIN },
    { name = 'Ob',                        popItem = tpz.items.FLASK_OF_COG_LUBRICANT },
    { name = 'Velionis',                  popItem = tpz.items.PILE_OF_GOLDEN_TEETH },
    { name = 'Lil Apkallu',               popItem = tpz.items.GREENLING },
    { name = 'Chigre',                    popItem = tpz.items.BOTTLE_OF_SPOILT_BLOOD },
    -- Tier 2
    { name = 'Iriz Ima',                  popItem = tpz.items.BUNCH_OF_SENORITA_PAMAMAS },
    { name = 'Iriri Samariri',            popItem = tpz.items.STRAND_OF_SAMARIRI_CORPSEHAIR },
    { name = 'Lividroot Amooshah',        popItem = tpz.items.JAR_OF_OILY_BLOOD },
    { name = 'Anantaboga',                popItem = tpz.items.SLAB_OF_RAW_BUFFALO },
    { name = 'Reacton',                   popItem = tpz.items.LUMP_OF_BONE_CHARCOAL },
    { name = 'Dextrose',                  popItem = tpz.items.PINCH_OF_GRANULATED_SUGAR },
    { name = 'Zareehkl the Jubilant',     popItem = tpz.items.MERROW_NO_11_MOLTING },
    { name = 'Verdelet',                  popItem = tpz.items.MINT_DROP },
    { name = 'Wulgaru',                   popItem = tpz.items.OPALUS_GEM },
    -- Tier 3
    { name = 'Armed Gears',               popItem = tpz.items.BAR_OF_FERRITE },
    { name = 'Gotoh Zha the Redolent',    popItem = tpz.items.BAGGED_SHEEP_BOTFLY },
    { name = 'Dea',                       popItem = tpz.items.OLZHIRYAN_CACTUS_PADDLE },
    { name = 'Nosferatu',                 popItem = tpz.items.VIAL_OF_PURE_BLOOD },
    { name = 'Khromasoul Bhurborlor',     popItem = tpz.items.VINEGAR_PIE },
    { name = 'Achamoth',                  popItem = tpz.items.JAR_OF_ROCK_JUICE },
    { name = 'Mahjlaef the Paintorn',     popItem = tpz.items.BOUND_EXORCISM_TREATISE },
    { name = 'Experimental Lamia',        popItem = tpz.items.CLUMP_OF_MYRRH },
    { name = 'Nuhn',                      popItem = tpz.items.WHOLE_ROSE_SCAMPI },
    -- Tier 4
    { name = 'Tinnin',                    popItem = tpz.items.JUG_OF_MONKEY_WINE },
    { name = 'Sarameya',                  popItem = tpz.items.CHUNK_OF_BUFFALO_CORPSE },
    { name = 'Tyger',                     popItem = tpz.items.CHUNK_OF_SINGED_BUFFALO },
    -- Tier 5
    { name = 'Pandemonium Warden',        popItem = tpz.items.PANDEMONIUM_KEY },
}

tpz.znm.onTrade = function(player, popItem)
    player:setLocalVar("znmTrade-" .. popItem, 1)
    player:confirmTrade()
    player:addItem(popItem)
end

tpz.znm.OnMobDeath = function(mob, player, isKiller, noKiller)
    local nearbyPlayers = mob:getPlayersInRange(50)
    if nearbyPlayers == nil then return end
    if nearbyPlayers then
        for _,PChar in ipairs(nearbyPlayers) do
            local mobName = mob:getName()
            mobName = string.gsub(mobName, '_', ' ');

            for _, nmData in pairs(nmPopData) do
                if (mobName == nmData.name) then
                    if (PChar:getLocalVar("znmTrade-" .. nmData.popItem) > 0) then
                        PChar:delItem(nmData.popItem, 1)
                        PChar:setLocalVar("znmTrade-" .. nmData.popItem, 0)
                        break
                    end
                end
            end
        end
    end
end
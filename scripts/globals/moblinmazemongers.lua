-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/zone")
require("scripts/globals/items")
-----------------------------------
local ore =
{
    tpz.items.CHUNK_OF_COPPER_ORE, tpz.items.CHUNK_OF_TIN_ORE, tpz.items.CHUNK_OF_ZINC_ORE, tpz.items.CHUNK_OF_SILVER_ORE,
    tpz.items.CHUNK_OF_IRON_ORE, tpz.items.CHUNK_OF_MYTHRIL_ORE, tpz.items.CHUNK_OF_GOLD_ORE, tpz.items.CHUNK_OF_PLATINUM_ORE,
    tpz.items.CHUNK_OF_DARKSTEEL_ORE, tpz.items.CHUNK_OF_ADAMAN_ORE
}
local log =
{
    tpz.items.ARROWWOOD_LOG, tpz.items.LAUAN_LOG, tpz.items.ELM_LOG, tpz.items.MAPLE_LOG, tpz.items.BEECH_LOG,
    tpz.items.WALNUT_LOG, tpz.items.CHESTNUT_LOG, tpz.items.WILLOW_LOG, tpz.items.YEW_LOG, tpz.items.HOLLY_LOG,
    tpz.items.OAK_LOG, tpz.items.MAHOGANY_LOG, tpz.items.ROSEWOOD_LOG, tpz.items.EBONY_LOG, tpz.items.PETRIFIED_LOG
}
local thread =
{
    tpz.items.SPOOL_OF_SILK_THREAD, tpz.items.SPOOL_OF_GRASS_THREAD, tpz.items.SPOOL_OF_COTTON_THREAD, tpz.items.SPOOL_OF_LINEN_THREAD,
    tpz.items.SPOOL_OF_WOOL_THREAD, tpz.items.SPOOL_OF_RAINBOW_THREAD, tpz.items.SPOOL_OF_SILVER_THREAD, tpz.items.SPOOL_OF_GOLD_THREAD
}
local leather =
{
    tpz.items.SQUARE_OF_SHEEP_LEATHER, tpz.items.SQUARE_OF_DHALMEL_LEATHER, tpz.items.SQUARE_OF_RAM_LEATHER,
    tpz.items.SQUARE_OF_BLACK_TIGER_LEATHER, tpz.items.UNDEAD_SKIN, tpz.items.RAPTOR_SKIN, tpz.items.COCKATRICE_SKIN,
    tpz.items.SQUARE_OF_MANTICORE_LEATHER, tpz.items.SQUARE_OF_COEURL_LEATHER
}
local gem =
{
    tpz.items.EMERALD, tpz.items.RUBY, tpz.items.DIAMOND, tpz.items.PERIDOT, tpz.items.TOPAZ, tpz.items.GARNET, tpz.items.AQUAMARINE,
    tpz.items.PEARL, tpz.items.BLACK_PEARL, tpz.items.SAPPHIRE, tpz.items.LAPIS_LAZULI, tpz.items.LIGHT_OPAL, tpz.items.PAINITE,
    tpz.items.TURQUOISE, tpz.items.ONYX, tpz.items.AMETHYST, tpz.items.CHRYSOBERYL, tpz.items.MOONSTONE, tpz.items.SUNSTONE,
    tpz.items.SPINEL, tpz.items.ZIRCON, tpz.items.TOURMALINE, tpz.items.SARDONYX, tpz.items.GOSHENITE, tpz.items.CLEAR_TOPAZ,
    tpz.items.FLUORITE, tpz.items.AMETRINE, tpz.items.JADEITE
}
local chests =
{
    { tpz.zone.JUGNER_FOREST_S, 17113838 },
    { tpz.zone.VUNKERL_INLET_S, 17117903 },
    { tpz.zone.BATALLIA_DOWNS_S, 17122061 },
    { tpz.zone.NORTH_GUSTABERG_S, 17138420 },
    { tpz.zone.GRAUBERG_S, 17142462 },
    { tpz.zone.PASHHOW_MARSHLANDS_S, 17146521 },
    { tpz.zone.ROLANBERRY_FIELDS_S, 17150679 },
    { tpz.zone.WEST_SARUTABARUTA_S, 17167124 },
    { tpz.zone.FORT_KARUGO_NARUGO_S, 17171014 },
    { tpz.zone.MERIPHATAUD_MOUNTAINS_S, 17175261 },
    { tpz.zone.SAUROMUGUE_CHAMPAIGN_S, 17179274 },
    { tpz.zone.BEAUCEDINE_GLACIER_S, 17335170 }, 
    { tpz.zone.XARCABARD_S, 17339266 },
}
local hpMPAugments = {1, 9}
local attributeAugments = {512, 513, 514, 515, 516, 517, 518}
local physicalAugments = {23, 25, 27, 29, 31, 33}
local specialAugments = {35, 133, 140, 57, 134, 211, 142, 49 }


tpz = tpz or {}
tpz.moblinmazemongers = tpz.moblinmazemongers or {}

tpz.moblinmazemongers.SpawnChest = function(mob, player, isKiller)
    local zone = mob:getZoneID()
    local chestID = GetChestID(zone)

    if isKiller or noKiller then
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()
        GetNPCByID(chestID):setPos(mobX, mobY, mobZ)
        GetNPCByID(chestID):setStatus(tpz.status.NORMAL)
        GetNPCByID(chestID):setLocalVar("Message", 0)GetNPCByID(chestID):setLocalVar("Message", 0)
    end
end

function GetChestID(zone)
    for i,chestIDs in pairs(chests) do
        if (zone == chestIDs[1]) then
            return chestIDs[2]
        end
    end

    return 0
end

function MMMAddChestLoot(player, npc)
    local zonePlayers = player:getZone():getPlayers()

    player:addTreasure(ore[math.random(#ore)], npc)
    player:addTreasure(log[math.random(#log)], npc)
    player:addTreasure(thread[math.random(#thread)], npc)
    player:addTreasure(leather[math.random(#leather)], npc)
    player:addTreasure(gem[math.random(#gem)], npc)
    for _, zonePlayer in pairs(zonePlayers) do
        AddAugmentedItem(zonePlayer)
        zonePlayer:addExp(2500)
    end
end

function AddAugmentedItem(player)
    local ID = zones[player:getZoneID()]
    firstAugment = hpMPAugments[math.random(#hpMPAugments)]
    secondAugment = attributeAugments[math.random(#attributeAugments)]
    thirdAugment = physicalAugments[math.random(#physicalAugments)]
    fourthAugment = specialAugments[math.random(#specialAugments)]
    augmentNumber = getAugmentAmount()

    if (augmentNumber == 1) then
        player:addItem(tpz.items.MOBLIN_CEST,1,firstAugment,math.random(9, 24))
    elseif (augmentNumber == 2) then
        player:addItem(tpz.items.MOBLIN_CEST,1,firstAugment,math.random(9, 24), secondAugment, math.random(1, 3))
    elseif (augmentNumber == 3) then
        player:addItem(tpz.items.MOBLIN_CEST,1,firstAugment,math.random(9, 24), secondAugment, math.random(1, 3), thirdAugment, math.random(0, 6))
    elseif (augmentNumber == 4) then
        player:addItem(tpz.items.MOBLIN_CEST,1,firstAugment,math.random(9, 24), secondAugment, math.random(1, 3), fourthAugment, math.random(0, 2))
    end
    player:messageSpecial( ID.text.ITEM_OBTAINED, tpz.items.MOBLIN_CEST)
end

tpz.moblinmazemongers.OpenChest = function(player, npc)
	local Message = npc:getLocalVar("Message")
    if (Message == 0) then
        MMMAddChestLoot(player, npc)
        npc:setLocalVar("Message", 1)
    end
    npc:entityAnimationPacket("open")
    npc:setLocalVar("open", 1)
    npc:timer(15000, function(npc)
        npc:entityAnimationPacket("kesu")
    end)
    npc:timer(16000, function(npc)
        npc:setStatus(tpz.status.DISAPPEAR)
        npc:timer(500, function(mob)
            npc:setLocalVar("open", 0)
        end)
    end)
end

function getAugmentAmount()
    rnd = math.random()

    if rnd < 0.2 then
        return 1
    elseif rnd < 0.4 then
        return 2
    elseif rnd < 0.9 then
        return 3
    else
        return 4
    end
end

tpz.moblinmazemongers.MobMods = function(mob)
	mob:setDamage(125)
    mob:setMod(tpz.mod.UDMGBREATH, -66)
    mob:setMod(tpz.mod.REGEN, 5)
    mob:setMod(tpz.mod.REGAIN, 25)
    mob:setMod(tpz.mod.MOVE, 20)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.ACC, 200)
    mob:setMod(tpz.mod.DEF, 1250)
    mob:setMod(tpz.mod.EVA, 374)
    mob:setMod(tpz.mod.VIT, 68)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 25)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 25)
end
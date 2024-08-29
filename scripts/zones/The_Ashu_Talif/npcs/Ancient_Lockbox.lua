-----------------------------------
-- Area: The Ashu Talif
-- Ancient Lockbox
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
require("scripts/globals/appraisal")
require("scripts/globals/items")
-----------------------------------

function onTrigger(player, npc)
    local loot = {
        {itemid = tpz.items.GOLD_BEASTCOIN, droprate = 100},
        {itemid = tpz.items.MYTHRIL_BEASTCOIN, droprate = 100},
        {itemid = tpz.items.PLATINUM_BEASTCOIN, droprate = 100},
        {itemid = tpz.items.JADEITE, droprate = 100},
        {itemid = tpz.items.EMERALD, droprate = 100},
        {itemid = tpz.items.RUBY, droprate = 100},
        {itemid = tpz.items.DIAMOND, droprate = 100},
        {itemid = tpz.items.PERIDOT, droprate = 100},
        {itemid = tpz.items.TOPAZ, droprate = 100},
        {itemid = tpz.items.GARNET, droprate = 100},
        {itemid = tpz.items.AQUAMARINE, droprate = 100},
        {itemid = tpz.items.PEARL, droprate = 100},
        {itemid = tpz.items.BLACK_PEARL, droprate = 100},
        {itemid = tpz.items.SAPPHIRE, droprate = 100},
        {itemid = tpz.items.PAINITE, droprate = 100},
        {itemid = tpz.items.TURQUOISE, droprate = 100},
        {itemid = tpz.items.CHRYSOBERYL, droprate = 100},
        {itemid = tpz.items.MOONSTONE, droprate = 100},
        {itemid = tpz.items.SUNSTONE, droprate = 100},
        {itemid = tpz.items.SPINEL, droprate = 100},
        {itemid = tpz.items.ZIRCON, droprate = 100},
        {itemid = tpz.items.GOSHENITE, droprate = 100},
        {itemid = tpz.items.FLUORITE, droprate = 100},
        {itemid = tpz.items.AMETRINE, droprate = 100},
        {itemid = tpz.items.ANGELSTONE, droprate = 100},
        {itemid = tpz.items.SPHENE, droprate = 100}
    }

    local qItem = {
        [55] = {
            {itemid = tpz.items.QUESTIONMARK_CAPE, droprate = 334},
            {itemid = tpz.items.QUESTIONMARK_HEADPIECE, droprate = 333},
            {itemid = tpz.items.QUESTIONMARK_GLOVES, droprate = 333}
        }
    }

    local royalPainterItem =
    {
        {itemid = tpz.items.GOLD_BEASTCOIN, droprate = 100},
        {itemid = tpz.items.MYTHRIL_BEASTCOIN, droprate = 100},
        {itemid = tpz.items.PLATINUM_BEASTCOIN, droprate = 100},
        {itemid = tpz.items.JADEITE, droprate = 100},
        {itemid = tpz.items.EMERALD, droprate = 100},
        {itemid = tpz.items.RUBY, droprate = 100},
        {itemid = tpz.items.DIAMOND, droprate = 100},
        {itemid = tpz.items.PERIDOT, droprate = 100},
        {itemid = tpz.items.TOPAZ, droprate = 100},
        {itemid = tpz.items.GARNET, droprate = 100},
        {itemid = tpz.items.AQUAMARINE, droprate = 100},
        {itemid = tpz.items.PEARL, droprate = 100},
        {itemid = tpz.items.BLACK_PEARL, droprate = 100},
        {itemid = tpz.items.SAPPHIRE, droprate = 100},
        {itemid = tpz.items.PAINITE, droprate = 100},
        {itemid = tpz.items.TURQUOISE, droprate = 100},
        {itemid = tpz.items.CHRYSOBERYL, droprate = 100},
        {itemid = tpz.items.MOONSTONE, droprate = 100},
        {itemid = tpz.items.SUNSTONE, droprate = 100},
        {itemid = tpz.items.SPINEL, droprate = 100},
        {itemid = tpz.items.ZIRCON, droprate = 100},
        {itemid = tpz.items.GOSHENITE, droprate = 100},
        {itemid = tpz.items.FLUORITE, droprate = 100},
        {itemid = tpz.items.AMETRINE, droprate = 100},
        {itemid = tpz.items.ANGELSTONE, droprate = 100},
        {itemid = tpz.items.YOICHIS_SASH, droprate = 100},
        {itemid = tpz.items.WARLOCKS_BAG, droprate = 100},
    }

    local royalPainterItemBoss =
    {
        {itemid = tpz.items.QUESTIONMARK_BOX, droprate = 1000},
    }

    local royalPainterItemFaluuya =
    {
        {itemid = tpz.items.QUESTIONMARK_RING, droprate = 500},
        {itemid = tpz.items.QUESTIONMARK_BOX, droprate = 500},
    }

    local targetingCaptainBoxA =
    {
        {itemid = tpz.items.GOLD_BEASTCOIN, droprate = 100},
        {itemid = tpz.items.MYTHRIL_BEASTCOIN, droprate = 100},
        {itemid = tpz.items.PLATINUM_BEASTCOIN, droprate = 100},
        {itemid = tpz.items.JADEITE, droprate = 100},
        {itemid = tpz.items.EMERALD, droprate = 100},
        {itemid = tpz.items.RUBY, droprate = 100},
        {itemid = tpz.items.DIAMOND, droprate = 100},
        {itemid = tpz.items.PERIDOT, droprate = 100},
        {itemid = tpz.items.TOPAZ, droprate = 100},
        {itemid = tpz.items.GARNET, droprate = 100},
        {itemid = tpz.items.AQUAMARINE, droprate = 100},
        {itemid = tpz.items.PEARL, droprate = 100},
        {itemid = tpz.items.BLACK_PEARL, droprate = 100},
        {itemid = tpz.items.SAPPHIRE, droprate = 100},
        {itemid = tpz.items.PAINITE, droprate = 100},
        {itemid = tpz.items.TURQUOISE, droprate = 100},
        {itemid = tpz.items.CHRYSOBERYL, droprate = 100},
        {itemid = tpz.items.MOONSTONE, droprate = 100},
        {itemid = tpz.items.SUNSTONE, droprate = 100},
        {itemid = tpz.items.SPINEL, droprate = 100},
        {itemid = tpz.items.ZIRCON, droprate = 100},
        {itemid = tpz.items.GOSHENITE, droprate = 100},
        {itemid = tpz.items.FLUORITE, droprate = 100},
        {itemid = tpz.items.ANGELSTONE, droprate = 100},
        {itemid = tpz.items.SPHENE, droprate = 100},
        {itemid = tpz.items.YOICHIS_SASH, droprate = 100},
        {itemid = tpz.items.BARBAROSSAS_ZEREHS, droprate = 100},
    }

    local targetingCaptainBoxB =
    {
        {itemid = tpz.items.QUESTIONMARK_BOX, droprate = 1000},
    }

    local targetingCaptainBoxC_Gloves =
    {
        {itemid = tpz.items.QUESTIONMARK_GLOVES, droprate = 1000},
    }
    local targetingCaptainBoxC_Attachments =
    {
        {itemid = tpz.items.SCHURZEN, droprate = 100},
        {itemid = tpz.items.DYNAMO, droprate = 100},
        {itemid = tpz.items.ECONOMIZER, droprate = 100},
        {itemid = tpz.items.OPTIC_FIBER, droprate = 100},
        {itemid = tpz.items.TURBO_CHARGER, droprate = 100},
        {itemid = tpz.items.REACTIVE_SHIELD, droprate = 100},
        {itemid = tpz.items.TRANQUILIZER, droprate = 100},
        {itemid = tpz.items.CONDENSER, droprate = 100},
    }


    local regItem = {
        [55] = {itemid = tpz.items.STAR_SAPPHIRE, droprate = 100}
    }

    local instance = player:getInstance()
    local instanceID = instance:getID()
    local chars = instance:getChars()
    local chestID = npc:getID()
    local boxClootTables = {
        targetingCaptainBoxC_Gloves,
        targetingCaptainBoxC_Attachments,
    }

    -- Instance IDs
    local SCOUTING_THE_ASHU_TALIF = 55
    local ROYAL_PAINTER_ESCORT = 56
    local TARGETING_THE_CAPTAIN = 57
    
    local chests = {
        {name = "qChest", id = ID.npc[55].ANCIENT_LOCKBOX_EXTRA},
        {name = "mainChest", id = ID.npc[56].ANCIENT_LOCKBOX},
        {name = "firstBonusChest", id = ID.npc[56].ANCIENT_LOCKBOX_BOSS_BONUS},
        {name = "secondBonusChest", id = ID.npc[56].ANCIENT_LOCKBOX_NO_DAMAGE_BONUS}
    }

    if instance:completed() and npc:getLocalVar("open") == 0 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED + 1)
        else
            npc:entityAnimationPacket("open")
            npc:setLocalVar("open", 1)
            npc:timer(15000, function(npc) npc:entityAnimationPacket("kesu") end)
            npc:timer(16000, function(npc) npc:setStatus(tpz.status.DISAPPEAR) end)

            local chestType = nil

            for _, chest in ipairs(chests) do
                if chestID == chest.id then
                    chestType = chest.name
                    break
                end
            end

            if chestType == "qChest" then
                distributeLoot(player, chars, qItem[instanceID], instanceID)
            elseif chestType == "mainChest" then
                player:addTreasure(tpz.items.KOGA_SHURIKEN, npc)
                if (instanceID == ROYAL_PAINTER_ESCORT) then
                    distributeLoot(player, chars, royalPainterItem, instanceID)
                elseif (instanceID == TARGETING_THE_CAPTAIN) then
                    distributeLoot(player, chars, targetingCaptainBoxA, instanceID)
                end
            elseif chestType == "firstBonusChest" then
                if (instanceID == ROYAL_PAINTER_ESCORT) then
                    distributeLoot(player, chars, royalPainterItemBoss, instanceID)
                elseif (instanceID == TARGETING_THE_CAPTAIN) then
                    distributeLoot(player, chars, targetingCaptainBoxB, instanceID)
                end
            elseif chestType == "secondBonusChest" then
                if (instanceID == ROYAL_PAINTER_ESCORT) then
                    distributeLoot(player, chars, royalPainterItemFaluuya, instanceID)
                elseif (instanceID == TARGETING_THE_CAPTAIN) then
                    distributeLoot(player, chars, boxClootTables[math.random(#boxClootTables)], instanceID)
                end
            else
                player:addTreasure(tpz.items.KOGA_SHURIKEN, npc)

                table.insert(loot, regItem[instanceID]) -- Add quest specific item
                for i = 1, 3 do -- 3 more items
                    distributeLoot(player, chars, loot, instanceID, npc)
                end
            end
        end
    end
end

function distributeLoot(player, chars, lootGroup, instanceID, npc)
    if lootGroup then
        local max = 0
        for _, entry in pairs(lootGroup) do
            max = max + entry.droprate
        end
        local roll = math.random(max)
        for _, entry in pairs(lootGroup) do
            max = max - entry.droprate
            if roll > max then
                if entry.itemid > 0 then
                    player:addItem({id = entry.itemid, appraisal = instanceID})
                    for _, v in pairs(chars) do
                        v:messageName(ID.text.PLAYER_OBTAINS_ITEM, player, entry.itemid)
                    end
                end
                break
            end
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

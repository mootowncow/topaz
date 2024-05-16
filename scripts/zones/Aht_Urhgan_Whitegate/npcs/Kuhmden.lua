-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Kuhmden
-- Standard Info NPC
-- ToAU Augmenting NPC
-- Storage NPC (ToAU augment mats)
-- !pos 74 -0 35 50
-----------------------------------

function onTrade(player, npc, trade)
    -----------------------------------
    -- Storage
    local material =
    {
        [tpz.items.QUTRUB_BANDAGE]          = 'Qutrub Bandage',
        [tpz.items.CHUNK_OF_FLAN_MEAT]      = 'Chunk of Flan Meat',
        [tpz.items.SLICE_OF_KARAKUL_MEAT]   = 'Slice of Karakul Meat',
        [tpz.items.SLICE_OF_ZIZ_MEAT]       = 'Slice of Ziz Meat',
        [tpz.items.WIVRE_MAUL]              = 'Wivre Maul',
        [tpz.items.QIQIRN_SANDBAG]          = 'Qiqirn Sandbag',
        [tpz.items.SOULFLAYER_TENTACLE]     = 'Soulflayer Tentacle',
        [tpz.items.WAMOURA_SCALE]           = 'Wamoura Scale',
        [tpz.items.LOCK_OF_MARID_HAIR]      = 'Lock of Marid Hair',
        [tpz.items.PUK_WING]                = 'Puk Wing',
        [tpz.items.APKALLU_FEATHER]         = 'Apkallu Feather',
        [tpz.items.PEPHREDO_HIVE_CHIP]      = 'Pephredo Hive Chip',
        [tpz.items.IMP_WING]                = 'Imp Wing',
        [tpz.items.LAMIA_SKIN]              = 'Lamia Skin',
        [tpz.items.MERROW_SCALE]            = 'Merrow Scale'
    }


    local gilTable =
    {
        tpz.items.QUTRUB_BANDAGE,
        tpz.items.CHUNK_OF_FLAN_MEAT,
        tpz.items.SLICE_OF_KARAKUL_MEAT,
        tpz.items.SLICE_OF_ZIZ_MEAT,
        tpz.items.WIVRE_MAUL,
        tpz.items.QIQIRN_SANDBAG,
        tpz.items.SOULFLAYER_TENTACLE,
        tpz.items.WAMOURA_SCALE,
        tpz.items.LOCK_OF_MARID_HAIR,
        tpz.items.PUK_WING,
        tpz.items.APKALLU_FEATHER,
        tpz.items.PEPHREDO_HIVE_CHIP,
        tpz.items.IMP_WING,
        tpz.items.LAMIA_SKIN,
        tpz.items.MERROW_SCALE
    }
    -----------------------------------
    -- Storage
    -- Check if the trade only contains materials
    local isValidTrade = false
    for v, _ in pairs(material) do
        if npcUtil.tradeHas(trade, v) then
            if (trade:getSlotCount() == 1) then
                isValidTrade = true
                break
            end
        end
    end

    if not isValidTrade then
        -- Handle invalid trade here
        player:PrintToPlayer("Invalid trade! Please trade only augment materials (1 stack max).", 0, "Kuhmden")
        return
    end

    -- Trade any amount of materials to store them
    for v, name in pairs(material) do
        if npcUtil.tradeHas(trade, v) then
            local currentAmount = player:getCharVar(name)
            local tradeAmount = trade:getItemQty(v)
            local newAmount = currentAmount + tradeAmount
            player:setCharVar(name, newAmount)
            player:PrintToPlayer("I was holding " .. currentAmount .. " " .. name .. " for you.", 0, "Kuhmden")
            player:PrintToPlayer("I am now holding " .. newAmount .. " " .. name .. " for you.", 0, "Kuhmden")
            player:tradeComplete()
            return
        end
    end


    -- Trade Specificed gil amount to get the alexandrite items back
    for _, gil in pairs(gilTable) do
        if (gil == trade:getGil()) then
            local materialNameBase = GetItem(material[gil])
            local materialName = string.gsub(materialNameBase:getName(), '_', ' ');
            local amount = player:getCharVar(materialName)
            player:addItem(gil, amount)
            player:addGil(gil)
            player:setCharVar(materialName, 0)
            -- TODO: NPC text saying what happened
            player:tradeComplete()
            return
        end
    end
end

function onTrigger(player, npc)
    --player:startEvent(252)
    player:PrintToPlayer("Would you like to see the additional list of items required to imbue?",0,"Kuhmden")
    player:timer(3000, function(player)
        player:PrintToPlayer("Qutrub Bandage - HP",0x1F,"Kuhmden")
        player:PrintToPlayer("Flan Meat - MP",0x1F,"Kuhmden")
        player:PrintToPlayer("Karakul Meat - Attack",0x1C,"Kuhmden")
        player:PrintToPlayer("Ziz Meat - Ranged Attack",0x1C,"Kuhmden")
        player:PrintToPlayer("Wivre Maul - Accuracy",0x1C,"Kuhmden")
        player:PrintToPlayer("Qiqirn Sandbag - Ranged Accuracy",0x1C,"Kuhmden")
        player:PrintToPlayer("Soulflayer Tentacle - Magic Attack",0x1C,"Kuhmden")
        player:PrintToPlayer("Wamoura Scale - Magic Accuracy",0x1C,"Kuhmden")
    end)
    player:timer(10000, function(player)
        player:PrintToPlayer("Marid Hair - STR",0xF,"Kuhmden")
        player:PrintToPlayer("Puk Wing - DEX",0xF,"Kuhmden")
        player:PrintToPlayer("Apkallu Feather - VIT",0xF,"Kuhmden")
        player:PrintToPlayer("Pephredo Hive Chip - AGI",0xF,"Kuhmden")
        player:PrintToPlayer("Imp Wing - INT",0xF,"Kuhmden")
        player:PrintToPlayer("Lamia Skin - MND",0xF,"Kuhmden")
        player:PrintToPlayer("Merrow Scale - CHR",0xF,"Kuhmden")
    end)
    player:timer(15000, function(player)
        player:PrintToPlayer("I can also store these materials for you.",0,"Kuhmden")
    end)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

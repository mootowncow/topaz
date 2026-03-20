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
        [tpz.items.MERROW_SCALE]            = 'Merrow Scale',
        [tpz.items.JA_JAS_CHESTPLATE]       = 'Ja Jas Chestplate',
        [tpz.items.HYDRA_SCALE]             = 'Hydra Scale',
        [tpz.items.GURFURLURS_HELMET]       = 'Gurfurlurs Helmet',
        [tpz.items.CERBERUS_CLAW]           = 'Cerberus Claw',
        [tpz.items.MEDUSAS_ARMLET]          = 'Medusa\'s Armlet',
        [tpz.items.KHIMAIRA_HORN]           = 'Khimaira Horn'
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
        tpz.items.MERROW_SCALE,
        tpz.items.JA_JAS_CHESTPLATE,
        tpz.items.HYDRA_SCALE,
        tpz.items.GURFURLURS_HELMET,
        tpz.items.CERBERUS_CLAW,
        tpz.items.MEDUSAS_ARMLET,
        tpz.items.KHIMAIRA_HORN,
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
    player:PrintToPlayer("I can also store ToAU augment materials for you.",0,"Kuhmden")
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

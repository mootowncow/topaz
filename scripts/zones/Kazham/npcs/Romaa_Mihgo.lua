-----------------------------------
-- Area: Kazham
--   NPC: Romaa Mihgo
-- Type: Standard NPC
-- Storage NPC (Dynamis and WoTG Strongholds currency)
-- !pos 29.000 -13.023 -176.500 250
--
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
    -----------------------------------
    -- Storage
    local currency =
    {
        [tpz.items.TUKUKU_WHITESHELL]           = 'Single Shell',
        [tpz.items.LUNGO_NANGO_JADESHELL]       = '100 Shell',
        [tpz.items.RIMILALA_STRIPESHELL]        = '10,000 Shell',
        [tpz.items.ORDELLE_BRONZEPIECE]         = 'Single Piece',
        [tpz.items.MONTIONT_SILVERPIECE]        = '100 Piece',
        [tpz.items.RANPERRE_GOLDPIECE]          = '10,000 Piece',
        [tpz.items.ONE_BYNE_BILL]               = 'Single Byne',
        [tpz.items.ONE_HUNDRED_BYNE_BILL]       = '100 Byne',
        [tpz.items.TEN_THOUSAND_BYNE_BILL]      = '10,000 Byne',
        [tpz.items.CONDENSED_EMPTYNESS]         = 'Single Emptyness',
        [tpz.items.L_CONDENSED_EMPTYNESS]       = 'Large Emptyness',
        [tpz.items.ZILARTIAN_ORB]               = 'Single Zilartian Orb',
        [tpz.items.L_ZILARTIAN_ORB]             = 'Large Zilartian Orb',
        [tpz.items.KULUU_SPHERE]                = 'Single Kuluu Sphere',
        [tpz.items.L_KULUU_SPHERE]              = 'Large Kuluu Sphere',
    }

    local gilTable =
    {
        tpz.items.TUKUKU_WHITESHELL,
        tpz.items.LUNGO_NANGO_JADESHELL,
        tpz.items.RIMILALA_STRIPESHELL,
        tpz.items.ORDELLE_BRONZEPIECE,
        tpz.items.MONTIONT_SILVERPIECE,
        tpz.items.RANPERRE_GOLDPIECE,
        tpz.items.ONE_BYNE_BILL,
        tpz.items.ONE_HUNDRED_BYNE_BILL,
        tpz.items.TEN_THOUSAND_BYNE_BILL,
        tpz.items.CONDENSED_EMPTYNESS,
        tpz.items.L_CONDENSED_EMPTYNESS,
        tpz.items.ZILARTIAN_ORB,
        tpz.items.L_ZILARTIAN_ORB,
        tpz.items.KULUU_SPHERE,
        tpz.items.L_KULUU_SPHERE,
    }
    -----------------------------------
    -- Storage
    -- Check if the trade only contains currency
    local isValidTrade = false
    for v, _ in pairs(currency) do
        if npcUtil.tradeHas(trade, v) then
            isValidTrade = true
            break
        end
    end

    if not isValidTrade then
        -- Handle invalid trade here
        player:PrintToPlayer("Invalid trade! Please trade only Dynamis or Stronghold currency.", 0, "Romaa Mihgo")
        return
    end

    -- Trade any amount of currency to store them
    for v, name in pairs(currency) do
        if npcUtil.tradeHas(trade, v) then
            local currentAmount = player:getCharVar(name)
            local tradeAmount = trade:getItemQty(v)
            local newAmount = currentAmount + tradeAmount
            player:setCharVar(name, newAmount)
            player:PrintToPlayer("I was holding " .. currentAmount .. " " .. name .. " for you.", 0, "Romaa Mihgo")
            player:PrintToPlayer("I am now holding " .. newAmount .. " " .. name .. " for you.", 0, "Romaa Mihgo")
            player:tradeComplete()
            return
        end
    end


    -- Trade Specificed gil amount to get the alexandrite items back
    for _, gil in pairs(gilTable) do
        if (gil == trade:getGil()) then
            local currencyNameBase = GetItem(currency[gil])
            local currencyName = string.gsub(currencyNameBase:getName(), '_', ' ');
            local amount = player:getCharVar(currencyName)
            player:addItem(gil, amount)
            player:addGil(gil)
            player:setCharVar(currencyName, 0)
            -- TODO: NPC text saying what happened
            player:tradeComplete()
            return
        end
    end
end

function onTrigger(player, npc)
    local tuningOutProgress = player:getCharVar("TuningOut_Progress")

    if (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getCharVar("MissionStatus") == 2) then
        player:startEvent(266)
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getCharVar("MissionStatus") == 3) then
        player:startEvent(267)

    elseif tuningOutProgress == 2 then
        player:startEvent(295) -- Ildy meets Romaa. Romaa tells player to go to waterfall
    elseif tuningOutProgress == 3 or tuningOutProgress == 4 then
        player:startEvent(296) -- Repeats hint to go to waterfall
    elseif tuningOutProgress == 5 then
        player:startEvent(297, 0, 1695, 4297, 4506) -- After fight with the Nasus. Mentions guard needs Habaneros, Black Curry, Mutton Tortilla
    elseif tuningOutProgress == 6 then
        player:startEvent(298, 0, 1695, 4297, 4506) -- Repeats guard need for Habaneros, Black Curry, Mutton Tortilla

    else
        player:startEvent(263)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 266) then
        player:setCharVar("MissionStatus", 3)

    elseif csid == 295 then
        player:setCharVar("TuningOut_Progress", 3)
    elseif csid == 297 then
        player:setCharVar("TuningOut_Progress", 6)
    end

end

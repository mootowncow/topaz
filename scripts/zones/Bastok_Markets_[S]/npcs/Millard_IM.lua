-----------------------------------
-- Area: Bastok Markets [S]
--  NPC: Millard IM
-- Type: Sigil NPC
-- !gotoid 17134130
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets_[S]/IDs")
require("scripts/globals/campaign")
require("scripts/globals/status")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local notes = player:getCurrency("allied_notes")
    local freelances = 99 -- Faking it for now
    local avilableCiphers = 0 -- 4 = Valaineral, 8 = Adelheid
    local medalRank = getMedalRank(player)
    local bonusEffects = 0 -- 1 = regen, 2 = refresh, 4 = meal duration, 8 = exp loss reduction, 15 = all
    local timeStamp = 0 -- getSigilTimeStamp(player)
    -- todo add in Throne Room controls

    -- if ( medal_rank > 25 and nation controls Throne_Room_S ) then
        -- medal_rank = 32
        -- this decides if allied ring is in the Allied Notes item list.
    -- end

    if (medalRank == 0) then
        player:startEvent(14)
    elseif player:getCampaignAllegiance() == 2 then
        -- Event Option 2 Denotes Bastok Allegience --
        player:startEvent(13, 2, notes, freelances, avilableCiphers, medalRank, bonusEffects, timeStamp, 0)
    else
        player:startEvent(13, 0, notes, freelances, avilableCiphers, medalRank, bonusEffects, timeStamp, 0)
    end

end

function onEventUpdate(player, csid, option)
    local itemid = 0
    local canEquip = 2 -- Faking it for now.
    -- 0 = Wrong job, 1 = wrong level, 2 = Everything is in order, 3 or greater = menu exits...
    if (csid == 13 and option >= 2 and option <= 2562) then
        itemid = getBastokNotesItem(option)
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, canEquip) -- canEquip(player, itemid));  <- works for sanction NPC, wtf?
    end
end

function onEventFinish(player, csid, option)
    local medalRank = getMedalRank(player)
    if (csid == 13) then
        -- Note: the event itself already verifies the player has enough AN, so no check needed here.
        if (option >= 2 and option <= 2562) then -- player bought item
            if player:getCampaignAllegiance() == 2 then
            -- Pricing for Those Allied with Bastok --
            -- currently only "ribbons" rank coded.
                item, price = getBastokNotesItemAllegience(option)
                if (npcUtil.giveItem(player, item)) then
                    player:delCurrency("allied_notes", price)
                end
            else
            -- Pricing For Everyone Else -- 
            -- currently only "ribbons" rank coded.
                item, price = getBastokNotesItem(option)
                if (npcUtil.giveItem(player, item)) then
                    player:delCurrency("allied_notes", price)
                end
            end
        elseif option % 4096 == 1 then
            local power = math.floor((option - 1) / 4096)
            local duration = 10800 + ((15 * medalRank) * 60)
            local subPower = 85

            printf("[Sigil Debug] option=%d, power=%d, medalRank=%d, duration=%d, subPower=%d",
                option, power, medalRank, duration, subPower)

            -- cost table (indexed by power value)
            local costTable = {
                [1]  = 50, -- Regen
                [2]  = 50, -- Refresh
                [4]  = 50, -- Meal Duration
                [3]  = 100, -- Regen + Refresh
                [5]  = 100, -- Regen + Meal Duration
                [6]  = 100, -- Refresh + Meal Duration
                [8]  = 100, -- Reduced EXP loss
                [12] = 100, -- Meal Duration + Reduced EXP loss
                [7]  = 150, -- Regen + Refresh + Meal Duration
                [9]  = 150, -- Regen + Reduced EXP loss
                [10] = 150, -- Refresh + Reduced EXP loss
                [11] = 150, -- Regen + Refresh + Reduced EXP loss
                [13] = 150, -- Regen + Meal Duration + Reduced EXP loss
                [14] = 150, -- Refresh + Meal Duration + Reduced EXP loss
                [15] = 200, -- Everything
            }

            local cost = costTable[power] or 0
            printf("[Sigil Debug] cost=%d", cost)

            player:delStatusEffectsByFlag(tpz.effectFlag.INFLUENCE, true)
            player:addStatusEffect(tpz.effect.SIGIL, power, 0, duration, 0, subPower, 0)
            player:messageSpecial(ID.text.ALLIED_SIGIL)

            if cost > 0 then
                printf("[Sigil Debug] Deducting %d allied_notes", cost)
                player:delCurrency("allied_notes", cost)
            end
        end
    end
end
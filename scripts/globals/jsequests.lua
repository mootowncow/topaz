-- JSE quests
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local questItems =
{
    [tpz.job.WAR] = { items =  { tpz.items.SCOWLENKOS_LEG, tpz.items.GHASTLY_CLOTH }, reward = { tpz.items.WARRIORS_BEAD } },
    [tpz.job.MNK] = { items =  { tpz.items.ARCH_BRACELET, tpz.items.DIREMITE_WEB }, reward = { tpz.items.MONKS_NODOWA } },
    [tpz.job.WHM] = { items =  { tpz.items.ANTLION_CLAW, tpz.items.MOLECH_WING }, reward = { tpz.items.CLERICS_TORQUE } },
    [tpz.job.BLM] = { items =  { tpz.items.SPARTOI_STAFF, tpz.items.KINDRED_STAFF }, reward = { tpz.items.SORCERERS_STOLE } },
    [tpz.job.RDM] = { items =  { tpz.items.OVINNIK_TAIL, tpz.items.CAMELOPARD_HOOVES }, reward = { tpz.items.DUELISTS_TORQUE } },
    [tpz.job.THF] = { items =  { tpz.items.CARAFE_CORE, tpz.items.COCKATRICE_BEAK }, reward = { tpz.items.ASSASSINS_GORGET } },
    [tpz.job.PLD] = { items =  { tpz.items.SPARTOI_SKULL, tpz.items.SKELETON_LIMB }, reward = { tpz.items.KNIGHTS_BEADS } },
    [tpz.job.DRK] = { items =  { tpz.items.BIGHT_FOOT, tpz.items.EERIE_CLOTH }, reward = { tpz.items.ABYSSAL_BEADS } },
    [tpz.job.BST] = { items =  { tpz.items.ABRAXAS_FEATHER, tpz.items.TYPHOON_WING }, reward = { tpz.items.BEASTMASTER_COLLAR } },
    [tpz.job.BRD] = { items =  { tpz.items.HECTEYES_FLESH, tpz.items.HURRICANE_FANG }, reward = { tpz.items.BARDS_CHARM } },
    [tpz.job.RNG] = { items =  { tpz.items.ANTARES_CLAW, tpz.items.WEIGHTLESS_CLOTH }, reward = { tpz.items.SCOUTS_GORGET } },
    [tpz.job.SAM] = { items =  { tpz.items.KING_HORN, tpz.items.DARTER_WING}, reward = { tpz.items.SAMURAIS_NODOWA } },
    [tpz.job.NIN] = { items =  { tpz.items.SAPLING_BUD, tpz.items.WYVERN_TAIL }, reward = { tpz.items.NINJA_NODOWA } },
    [tpz.job.DRG] = { items =  { tpz.items.TARANTULA_FANG, tpz.items.DEMONIC_SHARD }, reward = { tpz.items.DRAGOONS_COLLAR } },
    [tpz.job.SMN] = { items =  { tpz.items.MANTICORE_CLAW, tpz.items.EFT_CLAW }, reward = { tpz.items.SUMMONERS_COLLAR } },
    [tpz.job.BLU] = { items =  { tpz.items.AMERETAT_EYE, tpz.items.PUDDING_PUTTY  }, reward = { tpz.items.MIRAGE_STOLE } },
    [tpz.job.COR] = { items =  { tpz.items.IMP_EYE, tpz.items.KRAKEN_TENTACLE }, reward = { tpz.items.COMMODORE_CHARM } },
    [tpz.job.PUP] = { items =  { tpz.items.SPINNER_HEART, tpz.items.WAMOURA_FEELER }, reward = { tpz.items.PUPS_COLLAR } },
    [tpz.job.DNC] = { items =  { tpz.items.GARGOUILLE_WING, tpz.items.PEISTE_FANG }, reward = { tpz.items.ETOILE_GORGET } },
    [tpz.job.SCH] = { items =  { tpz.items.CARACAL_WHISKER, tpz.items.GNAT_EYE }, reward = { tpz.items.ARGUTE_STOLE } },
    [tpz.job.GEO] = { items = {}, reward = { tpz.items.BAGUA_CHARM } },
    [tpz.job.RUN] = { items = {}, reward = { tpz.items.FUTHARK_TORQUE } },
}

tpz = tpz or {}
tpz.jsequest = tpz.jsequest or {}

tpz.jsequest.onTrigger = function(player, npc, job)
    local stage = player:getCharVar("[JSEQUEST" .. job .. "]")
    local currentMerits = player:getMeritCount()
    local totalMeritsGiven = player:getCharVar("[JSEQUEST" .. job .. "Merits]")
    local meritsRemaining = 300 - player:getCharVar("[JSEQUEST" .. job .. "Merits]")
    local npcName = npc:getName()
    local isCorrectJob = player:getMainJob() == job
    local isLevelCapped = player:getMainLvl() >= 75

    -- If var is 1, then player has seen the intro quest text already, don't show again
    if isCorrectJob and isLevelCapped then
        if (stage == 0) then
            if questItems[job] and #questItems[job].items >= 2 then
                local itemOne = GetItem(questItems[job].items[1])
                local itemTwo = GetItem(questItems[job].items[2])
                local itemOneName = string.gsub(itemOne:getName(), '_', ' ');
                local itemTwoName = string.gsub(itemTwo:getName(), '_', ' ');

                player:setCharVar("[JSEQUEST" .. job .. "]", 1)
                player:PrintToPlayer("To show your mastery in your job, please bring me a " .. itemOneName .. " and a ".. itemTwoName .. ".", 0, npcName)
            end
        elseif (stage == 1) then
            player:PrintToPlayer("You are on stage 1. I require " .. itemOneName .. " and a ".. itemTwoName .. ".", 0, npcName)
        elseif (stage == 2) then
            player:PrintToPlayer("You are on stage 2. I still require " .. meritsRemaining .. " merit points.", 0, npcName)
        elseif (stage == 3) then
            player:PrintToPlayer("You are on stage 3. I require 5 Star Sapphires, 50 Scintillant Ingots, 50 Amph. Leather, 10 Divine Lumber", 0, npcName)
        end
    end
end

tpz.jsequest.onTrade = function(player, npc, trade, job)
    local stage = player:getCharVar("[JSEQUEST" .. job .. "]")
    local currentMerits = player:getMeritCount()
    local totalMeritsGiven = player:getCharVar("[JSEQUEST" .. job .. "Merits]")
    local npcName = npc:getName()
    local isCorrectJob = player:getMainJob() == job
    local isLevelCapped = player:getMainLvl() >= 75

    if isCorrectJob and isLevelCapped then
        if (stage == 1) then
            if npcUtil.tradeHasExactly(trade, { questItems[job].items[1], questItems[job].items[2] }) then
                player:setCharVar("[JSEQUEST" .. job .. "]", 2)
                player:PrintToPlayer("Fantastic job, now please bring me 300 merit points.", 0, npcName)
            end
        elseif (stage == 2) then
            local meritsToAdd = currentMerits + totalMeritsGiven
            if meritsToAdd < 300 then
                player:setMerits(0)
                player:setCharVar("[JSEQUEST" .. job .. "Merits]", meritsToAdd)
                player:setCharVar("[JSEQUEST" .. job .. "]", 3)
                player:PrintToPlayer("You've gathered enough merit points!", 0, npcName)
                player:PrintToPlayer("Now please bring me 25 imperial ingots", 0, npcName)
            else
                local requiredMerits = 300 - totalMeritsGiven
                    
                if currentMerits >= requiredMerits then
                    player:delMerits(requiredMerits)
                else
                    player:delMerits(currentMerits)
                end

                player:setCharVar("[JSEQUEST" .. job .. "Merits]", 300)
                player:setCharVar("[JSEQUEST" .. job .. "]", 3)
                player:PrintToPlayer("You've gathered enough merit points!", 0, npcName)
                player:PrintToPlayer("Now please bring me 5 Star Sapphires, 50 Scintillant Ingots, 50 Amph. Leather, 10 Divine Lumber", 0, npcName)
            end
        elseif (stage == 3) then
            if npcUtil.tradeHasExactly(trade, { { tpz.items.STAR_SAPPHIRE, 5 }, { tpz.items.SCINTILLANT_INGOT, 50 }, { tpz.items.SQUARE_OF_AMPHIPTERE_LEATHER, 50 }, { tpz.items.PIECE_OF_DIVINE_LUMBER, 10 }  }) then
                player:PrintToPlayer("You have done well, here is your reward", 0, npcName)
                player:setCharVar("[JSEQUEST" .. job .. "]", 4)
                npcUtil.giveItem(player, questItems[job].reward[1])
            end
        end
    end
end
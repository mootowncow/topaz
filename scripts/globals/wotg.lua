-----------------------------------
--
--  WotG utilities
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/utils")
require("scripts/globals/status")
require("scripts/globals/zone")
require("scripts/globals/items")
require("scripts/globals/keyitems")
-----------------------------------

tpz = tpz or {}
tpz.wotg = tpz.wotg or {}

tpz.wotg.NMMods = function(mob)
    if mob:getMainJob() == tpz.job.MNK then
        mob:setDamage(35)
    else
	    mob:setDamage(140)
    end
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.ACC, 25) 
    mob:addMod(tpz.mod.EVA, 25)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 60)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
end

tpz.wotg.QuadavTrashDrops = function(mob, player, isKiller, noKiller)
	if isKiller or noKiller then
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1500) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1000) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 500) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        -- Campaign Ops KI
        if  math.random(1,10000) <= 1 then
            utils.givePartyKeyItem(player, tpz.ki.DIAMOND_SEAL)
        end
    end
end

tpz.wotg.YagudoTrashDrops = function(mob, player, isKiller, noKiller)
	if isKiller or noKiller then
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1500) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1000) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 500) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        -- Campaign Ops KI
        if  math.random(1,10000) <= 1 then
            utils.givePartyKeyItem(player, tpz.ki.XICUS_ROSARY)
        end
    end
end

tpz.wotg.OrcTrashDrops = function(mob, player, isKiller, noKiller)
	if isKiller or noKiller then
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1500) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1000) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 500) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        -- Campaign Ops KI
        if  math.random(1,10000) <= 1 then
            utils.givePartyKeyItem(player, tpz.ki.TIGRIS_STONE)
        end
    end
end

tpz.wotg.MagianT1 = function(mob, player, isKiller, noKiller)
    player:addCurrency("allied_notes", 200)
	if isKiller or noKiller then
        if math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            if math.random(2) == 2 then
		        player:addTreasure(tpz.items.DAYBREAK_SOUL, mob)
            else
                player:addTreasure(tpz.items.TWILIGHT_SOUL, mob)
            end
	    end
    end
end

tpz.wotg.MagianT2 = function(mob, player, isKiller, noKiller)
    player:addCurrency("allied_notes", 300)
	if isKiller or noKiller then
        if math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            if math.random(2) == 2 then
		        player:addTreasure(tpz.items.INCRESCENT_SHADE, mob)
            else
                player:addTreasure(tpz.items.DECRESCENT_SHADE, mob)
            end
	    end
    end
end

tpz.wotg.MagianT3 = function(mob, player, isKiller, noKiller)
    player:addCurrency("allied_notes", 400)
	if isKiller or noKiller then 
        if math.random(1,10000) <= utils.getDropRate(mob, 2400) then 
		    player:addTreasure(tpz.items.SILVER_MIRROR, mob)
	    end
    end
end

tpz.wotg.MagianT4 = function(mob, player, isKiller, noKiller)
    player:addCurrency("allied_notes", 500)
	if isKiller or noKiller then
        if math.random(1,10000) <= utils.getDropRate(mob, 2400) then 
		    player:addTreasure(tpz.items.CHUNK_OF_RIFTSAND, mob)
	    end
    end
end

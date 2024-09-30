-----------------------------------
-- Area: Bhaflau Thickets
--  ZNM: Lividroot Amooshah
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setDamage(125)
    mob:setMod(tpz.mod.DEF, 400)
    mob:setMod(tpz.mod.EVA, 320)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    if mob:getID() == 16990631 then -- Final Form
        mob:setMobMod(tpz.mobMod.GIL_MIN, 6500) -- 7k Gil
        mob:setMobMod(tpz.mobMod.GIL_MAX, 7300) 
        mob:setMobMod(tpz.mobMod.GIL_BONUS, 0) 
        mob:setMobMod(tpz.mobMod.NO_DROPS, 0)
        mob:setModelSize(3)
    else
        mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
        mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
        mob:setModelSize(1)
    end
    local NearbyPlayers = mob:getPlayersInRange(50)
    if NearbyPlayers == nil then return end
    if NearbyPlayers then
        for _,v in ipairs(NearbyPlayers) do
            mob:updateClaim(v)
        end
    end
end



function onMobDeath(mob, player, isKiller, noKiller)
    if mob:getID() ~= 16990473 then -- First form
        if mob:getID() == 16990631 then -- Final Form
            return
        end
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()
        local NextForm = GetMobByID(mob:getID()+1)
        NextForm:setSpawn(mobX, mobY, mobZ)
        NextForm:spawn()
    else
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()
        local NextForm = GetMobByID(16990629)
        NextForm:setSpawn(mobX, mobY, mobZ)
        NextForm:spawn()
    end
    if mob:getID() == 16990631 then -- Final Form
        player:addCurrency("zeni_point", 200)
	    if isKiller  then 
		    player:addTreasure(5735, mob)--Cotton Coin Purse
	    end
	    if isKiller and math.random(1,100) <= 24 then 
		    player:addTreasure(5735, mob)--Cotton Coin Purse
	    end
	    if isKiller and math.random(1,100) <= 15 then 
		    player:addTreasure(5735, mob)--Cotton Coin Purse
	    end
    end
end

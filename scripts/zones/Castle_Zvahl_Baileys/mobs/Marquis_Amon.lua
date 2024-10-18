-----------------------------------
-- Area: Castle Zvahl Baileys (161)
--   NM: Marquis Amon
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/mobs")
------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.MATT, 32) 
    mob:addMod(tpz.mod.MDEF, 24) 
    mob:setMod(tpz.mod.UFASTCAST, 50) 
    mob:addImmunity(tpz.immunity.SLEEP)
    mob:addImmunity(tpz.immunity.GRAVITY)
    mob:addImmunity(tpz.immunity.BIND)
    mob:addImmunity(tpz.immunity.SILENCE)
    local Lives = GetServerVariable("Lives")
    -- Set number of lives
    if Lives == 0 then
        --printf("Lives %u", Lives)
	    SetServerVariable("Lives", math.random(5, 10))
    end
    local AmonsKiller = GetServerVariable("AmonsKiller")
    if AmonsKiller ~= nil then
        local Killer = GetPlayerByID(AmonsKiller)
        if Killer ~= nil and not Killer:isEngaged() and Killer:checkDistance(mob) <= 50 then
            mob:updateClaim(Killer)
        end
        local zonePlayers = mob:getZone():getPlayers()
        for _, zonePlayer in pairs(zonePlayers) do
            zonePlayer:PrintToPlayer("You cannot escape death itself...",0,"Amon")
        end
    end
end

function onMobFight(mob, target)
    local Revives = GetServerVariable("Revives")
    local Lives = GetServerVariable("Lives")
    -- Only drops loot/gil and gives xp on the final revive
    if Revives >= Lives then
        mob:setMobMod(tpz.mobMod.EXP_BONUS, 0)
        mob:setMobMod(tpz.mobMod.NO_DROPS, 0)
        mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
        mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    else
        mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
        mob:setMobMod(tpz.mobMod.GIL_MIN, 0)
        mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
        mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller then
        local Revives = GetServerVariable("Revives")
	    SetServerVariable("Revives", Revives + 1)
        --printf("Revives %u", Revives)
        SetServerVariable("AmonsKiller", player:getID())
    end
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    -- Revives up to 10 times
    local Revives = GetServerVariable("Revives")
    local Lives = GetServerVariable("Lives")
        --printf("Lives %u", Lives)
        --printf("Revives %u", Revives)
    if Revives >= Lives then
        -- Make sure he resets his mechanics fully for next pop
        SetServerVariable("Lives", 0)
        SetServerVariable("Revives", 0)
        mob:setRespawnTime(36000)
    else
        mob:setRespawnTime(10)
    end
end

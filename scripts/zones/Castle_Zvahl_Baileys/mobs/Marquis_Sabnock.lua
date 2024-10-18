------------------------------
-- Area: Castle Zvahl Baileys
--   NM: Marquis Sabnock
-- Drops Astrolabe
-- "Astro" based mob using space themed attacks
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/mobs")
------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:addMod(tpz.mod.MDEF, 24) 
    mob:setMod(tpz.mod.UFASTCAST, 50) 
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    mob:addImmunity(tpz.immunity.SLEEP)
    mob:addImmunity(tpz.immunity.GRAVITY)
    mob:addImmunity(tpz.immunity.BIND)
    mob:addImmunity(tpz.immunity.SILENCE)
    mob:setLocalVar("SunTime", math.random(45, 60))
end

function onMobFight(mob, target)
	local SunTime = mob:getLocalVar("SunTime")
	local MoonTime = mob:getLocalVar("MoonTime")
    local Msg = mob:getLocalVar("Msg")
    local BattleTime = mob:getBattleTime()

    -- Alternates between Dark Sun and Dark Moon after a random amount of time(45-60s)
    if SunTime > 0 and BattleTime >= SunTime then
        local zonePlayers = mob:getZone():getPlayers()
        for _, zonePlayer in pairs(zonePlayers) do
            zonePlayer:PrintToPlayer("Sabnock calls on the power of the sun!",0,"Sabnock")
        end
        mob:useMobAbility(2691) -- Dark Sun
        mob:setLocalVar("SunTime", 0)
        mob:setLocalVar("MoonTime", BattleTime + math.random(45, 60))
    end

    if MoonTime > 0 and BattleTime >= MoonTime then
        local zonePlayers = mob:getZone():getPlayers()
        for _, zonePlayer in pairs(zonePlayers) do
            zonePlayer:PrintToPlayer("Sabnock calls on the power of the moon!",0,"Sabnock")
        end
        mob:useMobAbility(2690) -- Dark Moon
        mob:setLocalVar("MoonTime", 0)
        mob:setLocalVar("SunTime", BattleTime + math.random(45, 60))
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 352)
end

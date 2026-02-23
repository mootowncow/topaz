-----------------------------------
-- Area: Ve'Lugannon Palace
--   NM: Steam Cleaner
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.REFRESH, 300)
    mob:addMod(tpz.mod.MATT, 50)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 25)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.TP_DRAIN, {chance = 25, power = math.random(50, 100)})
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    local respawn = 7200
    mob:setRespawnTime(respawn) -- 2 hours
    SetServerVariable("SteamCleaner_Respawn", (os.time() + respawn))
end

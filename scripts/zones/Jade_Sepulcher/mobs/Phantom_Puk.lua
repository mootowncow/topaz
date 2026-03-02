-----------------------------------
-- Area: Jade Sepulcher
-- MOB: Phantom Puk
-- ISNM3000: Shadows of the Mind
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
local ID = require("scripts/zones/Jade_Sepulcher/IDs")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setDamage(150)
    mob:addMod(tpz.mod.ATTP, 75)
    mob:addMod(tpz.mod.DEFP, 75)
    AddAllAttributes(mob, 30)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("boreas_mantle", os.time() + math.random(15, 30))
end

function onMobFight(mob, target)
    local now = os.time()
    if mob:getLocalVar("boreas_mantle") <= now then
        mob:useMobAbility(1980)
        mob:setLocalVar("boreas_mantle", now + 45)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    mobid = mob:getID()
    for cloneid = mobid + 1, mobid + 4 do
        if GetMobAction(cloneid) ~= 0 then
            DespawnMob(cloneid)
        end
    end
end

-----------------------------------
-- Area: Garlaige Citadel
--  NM: Guardian Statue
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.REFRESH, 300)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.UDMGPHYS, -50)
    mob:setMod(tpz.mod.UDMGMAGIC, -50)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
end


function onMobInitialize(mob)
end

function onMobFight(mob, target)
    local hitTrigger = mob:getLocalVar("TriggerHit")
    if mob:getHPP() <= 50 and hitTrigger == 0 then
        mob:setMod(tpz.mod.STORETP, 25)
        mob:setLocalVar("TriggerHit", 1)
    end
    if mob:getHPP() <= 25 and hitTrigger == 1 then
        mob:setMod(tpz.mod.STORETP, 50)
        mob:setLocalVar("TriggerHit", 2)
    end
end




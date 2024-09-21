------------------------------
-- Area: The Eldieme Necropolis
--   Burtgang
--  !additem 480
-- Mythic weapon fight
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")
require("scripts/globals/mobs")
require("scripts/globals/status")
------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:addMod(tpz.mod.DEFP, 300) 
    mob:setMod(tpz.mod.UFASTCAST, 50)
    mob:setMod(tpz.mod.UDMGMAGIC, 200)
    mob:setMod(tpz.mod.UDMGPHYS, -10)
	mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    --mob:setModelId(640) -- Dullahan
end

function onMobFight(mob, target)
end


function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 45 or 405 or 2142 then
        mob:resetEnmity(target)        
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnDeathMessage(mob, player, isKiller, noKiller, "Maybe...you...are...worthy...of...my...power...",0,"Burtgang")
end



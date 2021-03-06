-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Tipha
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
require("scripts/globals/status")

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 0)
end

function onMobFight(mob, target)
    if mob:getHPP() <= 50 then
        target:PrintToPlayer("Oh no! He's coming! I'm out of here!",0,"Tipha")
        DespawnMob(mob:getID())
		DespawnMob(mob:getID()+1)
    end
    mob:setMobMod(tpz.mobMod.SHARE_TARGET, 17281031)
end


function onMobDespawn(mob)
    local BigBoss = GetMobByID(17281063)
    BigBoss:spawn()
end

function onMobDeath(mob, player, isKiller)
end


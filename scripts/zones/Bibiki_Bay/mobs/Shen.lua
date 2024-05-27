-----------------------------------
-- Area: Bibiki Bay
--  MOB: Shen
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
mixins = {require("scripts/mixins/families/uragnite")}
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

function onMobFight(mob,target)
    for i = 1, 2 do
        local pet = GetMobByID(ID.mob.SHENS_FILTRATE[i])
        if not pet:isSpawned() and pet:getLocalVar("respawnTime") < os.time() then
            if mob:getBattleTime() >= 45 or mob:getHPP() <= 33 then
                pet:spawn()
                pet:updateClaim(target)
                pet:setMobMod(tpz.mobMod.SHARE_TARGET, mob:getTarget())
            end
        end
        if pet:isSpawned() then
            pet:setMobMod(tpz.mobMod.SHARE_TARGET, mob:getTarget())
        end
    end
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end;

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 18000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 28000)
    mob:setMobMod(tpz.mobMod.MUG_GIL, 2500)
end

function onMobSpawn(mob)
    mob:setLocalVar("[USHELL]minEntry", 45)
    mob:setLocalVar("[USHELL]maxEntry", 60)
    mob:setLocalVar("[USHELL]minDuration", 60)
    mob:setLocalVar("[USHELL]maxDuration", 120)
    mob:setLocalVar("[USHELL]ability", 1571) -- Gas Shell
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        DespawnMob(ID.mob.SHENS_FILTRATE[1])
        DespawnMob(ID.mob.SHENS_FILTRATE[2])
    end
end;

function onMobDespawn(mob)
    DespawnMob(ID.mob.SHENS_FILTRATE[1])
    DespawnMob(ID.mob.SHENS_FILTRATE[2])
end

function onMonsterMagicPrepare(mob,target)
    -- casts Water IV, Waterga III, Flood, Drown
    local rnd = math.random();

    if (rnd < 0.5) then
        return 201; -- waterga 3
    elseif (rnd < 0.7) then
        return 172; -- water 4
    elseif (rnd < 0.9) then
        return 214; -- flood
    else
        return 240; -- drown
    end

end;

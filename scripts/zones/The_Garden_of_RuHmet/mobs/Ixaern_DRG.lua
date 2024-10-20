-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Ix'aern DRG
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
-----------------------------------

function onMobSpawn(mob)
	mob:setDamage(145)
    mob:addMod(tpz.mod.DEFP, 15) 
    mob:addMod(tpz.mod.ATTP, 15)
    mob:setMod(tpz.mod.REFRESH, 50)
end

function onMobFight(mob, target)
    -- Spawn the pets if they are despawned
    -- TODO: summon animations?
    local mobId = mob:getID()
    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()

    for i = mobId + 1, mobId + 3 do
        local wynav = GetMobByID(i)
        if not wynav:isSpawned() then
            wynav:setSpawn(x + math.random(1, 5), y, z + math.random(1, 5))
            wynav:spawn()
            wynav:updateEnmity(target)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    -- despawn pets
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 3 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end
end

function onMobDespawn( mob )
    -- despawn pets
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 3 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end

    -- Pick a new PH for Ix'Aern (DRG)
    local groups = ID.mob.AWAERN_DRG_GROUPS
    SetServerVariable("[SEA]IxAernDRG_PH", groups[math.random(1, #groups)] + math.random(0, 2))
end

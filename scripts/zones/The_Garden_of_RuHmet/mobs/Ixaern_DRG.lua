-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Ix'aern DRG
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------

function onMobSpawn(mob)
	mob:setDamage(145)
    mob:addMod(tpz.mod.ATTP, 35)
    mob:addMod(tpz.mod.DEFP, 35)
    mob:setMod(tpz.mod.REFRESH, 50)
    local partyWithWynavs = 19236
    mob:setMobMod(tpz.mobMod.CUSTOMLINK, partyWithWynavs)
end

function onMobFight(mob, target)
        local mobId = mob:getID()
        local wynav1 = GetMobByID(mobId +1)
        local wynav2 = GetMobByID(mobId +2)
        local wynav3 = GetMobByID(mobId +3)
        local currentlySummoning = mob:getLocalVar("SpawnPetAnimation")

    -- Spawn the pets if they are despawned
    if (currentlySummoning == 0) then
        if not wynav1:isSpawned() or not wynav2:isSpawned() or not wynav3:isSpawned() then
            utils.spawnPetInBattle(mob, { wynav1, wynav2, wynav3 }, true, false, true)
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

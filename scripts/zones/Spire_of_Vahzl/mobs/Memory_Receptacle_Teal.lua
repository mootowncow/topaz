-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Memory Receptacle Teal
-- Pulling the Plug
-- !addkeyitem CENSER_OF_ACRIMONY
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/pathfind")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.DONT_FOLLOW_TARGET, 1)
    mob:SetAutoAttackEnabled(false)
    mob:speed(40)
end

function onMobFight(mob, target)
    local rotationTimer = mob:getLocalVar("rotationTimer")

    if (mob:isFollowingPath()) then
        printf("Following path - disenaging")
        mob:disengage()
    end

    if (os.time() >= rotationTimer) then
        mob:setMobMod(tpz.mobMod.IGNORE_COMBAT, 1)
        mob:disengage()
    end

    -- Reset TP to 0 if it accumulates any
    if mob:getTP() > 0 then
        mob:setTP(0)
    end
end

function onMobRoam(mob)
    local rotationTimer = mob:getLocalVar("rotationTimer")
    local currentRotation = mob:getLocalVar("currentRotation")
    local flags = tpz.path.flag.SCRIPT
    local spawnPos
    local greenReceptacle = GetMobByID(mob:getID() - 1)
    local blueReceptacle = GetMobByID(mob:getID() - 2)

    if (os.time() >= rotationTimer) then
        -- Determine where to path to based on current rotation
        if (currentRotation == 0) then
            printf("Moving to green")
            spawnPos = greenReceptacle:getSpawnPos()
        elseif (currentRotation == 1) then
            printf("Moving to blue")
            spawnPos = blueReceptacle:getSpawnPos()
        elseif (currentRotation == 2) then
            printf("Moving back to spawn")
            spawnPos = mob:getSpawnPos()
        end

        -- Path
        print(string.format("spawnPos.x: %d, spawnPos.y: %d, spawnPos.z: %d",spawnPos.x, spawnPos.y, spawnPos.z))
        local path = { spawnPos.x, spawnPos.y, spawnPos.z }
        mob:pathThrough(path, flags)

        if (mob:isFollowingPath()) then
            printf("Currently pathing, wait to set vars")
            return
        end

        mob:setLocalVar("rotationTimer", os.time() + 45)

        -- Update rotation for the next move
        if (currentRotation >= 2) then
            printf("Restarting rotation")
            mob:setLocalVar("currentRotation", 0)  -- Reset to start a new rotation
        else
            printf("Incrimenting rotation by 1")
            mob:setLocalVar("currentRotation", currentRotation + 1)
        end
    end
    mob:setMobMod(tpz.mobMod.IGNORE_COMBAT, 0)
end


function onMobDeath(mob, player, isKiller, noKiller)
    local Red = GetMobByID(mob:getID() - 3)
    local Add = GetMobByID(mob:getID()+1)
    Add:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
    Add:spawn()
    Add:updateEnmity(player)
    Red:delStatusEffectSilent(tpz.effect.PHYSICAL_SHIELD)
end



-- THF/THF
-- Immune to Paralyze, Sleep, Bind, Gravity, Break
-- Does not RA in melee range
-- Runs away and stays at range using Ore Toss every 10 seconds
-- Runs away to ~23.5 yalms then runs back to ~13.5 if you run to him, but if you chase again after he won't run away again for a while
-- Run Timer 01;53 - > 02:27 - > 03:04 - > 03:38 - > 04:14 - > 04:46 - > 05:29 - > 06:43
-- Summons (summoning animation) a random tube that uses a random TP move then despawns.
-- Summon Timer: 54:41 - > 55:46 - > 56:31 - > 57:12 - > 58:29 - > 59:24 -> 00:22 - > 01:15 1m?
-- Summoner Timer (49% HP): 07:34 - > 08:08 - > 08:33 - > 08:54 - > 09:23 - > 09:46 - 10:12 30s?
-- Summoner Timer (24% HP): 12:46 - > 12:58 - > 13:13 - > 13:26 - > 13:43 - > 13:57 - > 14:12 15s
-- Summoner Timer (9% HP): 16:42 - > 16:53 -> 17:03 -> 17:13 - > 17:23 - > 17:33 - > 17:43 10s
-- Uses Diamond Shell, Ore Lob, Head Butt, Shell Guard, Howl
-- Used Pefect Dodge at 70%ish
-----------------------------------
-- Area: Beadeaux [S]
--   NM: Mu'Nhi Thimbletail
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
require("scripts/globals/utils")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobInitialize(mob)
end

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
    mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 1123)
    mob:setMobMod(tpz.mobMod.SPECIAL_COOL, 18) 
    mob:setMobMod(tpz.mobMod.STANDBACK_COOL, 10)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, 1)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("tubeTime", os.time() + 60)
    mob:setLocalVar("pathIndex", 1)
end

function onMobFight(mob, target)
    local tubeTime = mob:getLocalVar("tubeTime")
    local runAwayTimer = mob:getLocalVar("runAwayTimer")
    local pathIndex = mob:getLocalVar("pathIndex")
    local tube = GetMobByID(mob:getID() + math.random(3))

    -- Does not Ore Toss in melee range
    if mob:checkDistance(target) <= 5 then
        mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 0)
    else
        mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 1123)
    end

    -- Run away pathing logic
    -- If the mob is in range and the run away timer has expired
    if mob:checkDistance(target) <= 5 and (os.time() >= runAwayTimer) then
        mob:SetMobAbilityEnabled(false)

        -- Path points for running away
        local pathPoints = {
            { X=247.491745, Y=-3.070058, Z=86.589287 },
            { X=231.316696, Y=-3.000000, Z=128.621414 }
        }

        -- Get the current path point based on the pathIndex
        local currentPath = pathPoints[pathIndex]

        -- Ensure the currentPath is valid
        if currentPath then
            -- print("Moving to path point: X=" .. currentPath.X .. ", Z=" .. currentPath.Z)

            -- Path the mob to the current path point
            mob:pathTo(currentPath.X, mob:getYPos(), currentPath.Z)

            -- Toggle the pathIndex between 1 and 2 for the next run
            if pathIndex == 1 then
                mob:setLocalVar("pathIndex", 2)  -- Set to 2 for the next path
            else
                mob:setLocalVar("pathIndex", 1)  -- Set to 1 for the next path
            end
        end

        mob:setLocalVar("runningAway", 1)  -- Mark that the mob is running away

        -- Set the cooldown timer for the next run away behavior
        mob:setLocalVar("runAwayTimer", os.time() + math.random(30, 45))

        -- Re-enable mob abilities after 10 seconds
        mob:timer(5000, function(mob)
            mob:setLocalVar("runningAway", 0)  -- Reset running away flag after 10 seconds
            mob:SetMobAbilityEnabled(true)
        end)
    end

    local isRunningAway = mob:getLocalVar("runningAway")
    -- Path to the target if distance is greater than 13.5 and mob is not running away
    if mob:checkDistance(target) > 13.5 and isRunningAway == 0 then
        -- Path the mob towards the target
        mob:pathTo(target:getXPos(), mob:getYPos(), target:getZPos())
    elseif mob:checkDistance(target) <= 13.5 and isRunningAway == 0 then
        -- Stop pathing towards the target once within 13.5
        mob:clearPath()  -- Call clearPath() to stop the mob's movement, but only if it's not running away
    end

    -- Summons a random tube that uses a random TP move then despawns.
    if os.time() >= tubeTime and mob:checkDistance(target) <= 20.00 and isRunningAway == 0 then
        if not tube:isSpawned() then
            mob:setLocalVar("tubeTime", os.time() + math.random(30, 60))
            utils.spawnPetInBattle(mob, tube, true, false, true)
        end
    end
end

function onMobWeaponSkillPrepare(mob, target)
   local tpMoves = { 612, 614, 762, 2233, 2234 }
   --  Headbutt, Shell Guard, Howl, Diamond Shell, Ore Lob

   return tpMoves[math.random(#tpMoves)]
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT4(mob, player, isKiller, noKiller)
end

function getVialTimer(mob)
    local hp = mob:getHPP()
    local timer = 60

    if (hp < 10) then
        timer = 10
    elseif (hp < 25) then
        timer = 15
    elseif (hp < 50) then
        timer = 30
    end

    return timer
end

-----------------------------------
-- Area: The Ashu Talif (Royal Painter Escort
--  Mob: Faluuya
-- TOAU-15 Mission Battle
-- TODO: If she takes too much damage she will say OUCH_PROTECT_ME, then a chest is lost
-- TODO: More text
-- TODO: After fighting mobs doesn't remember her path and gets stuck
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
require("scripts/globals/instance")
require("scripts/globals/status")
require("scripts/globals/pathfind")
-----------------------------------
-- First stop (by door) rot: 253
-- At door: -7.56, -22.50, 3.40
-- Port through door: -8.02, -22.50, -4.83
-- Spawn mobs: -3.92, -14.50, -16.01 
local stageOnePts1 = {
    { 4.15, -22.00, 16.72 },
    { -1.10, -22.00, 12.90 },
    { -7.16, -22.03, 10.21 },
    { -7.81, -22.50, 2.58 }, -- Added
}

local stageOnePts2 = {
    { -6.54, -22.50, -6.73 }, -- Might need to be removed/changed
    { -2.11, -20.75, -6.82 },
    { 4.85, -18.50, -7.44 },
    { 3.52, -18.50, -10.32 },
    { -1.05, -17.25, -10.45 },
    { -6.93, -14.50, -10.68 },
    { -6.85, -14.50, -12.76 },
    { -4.68, -14.50, -15.22 },
    { -3.92, -14.50, -16.01 }
}

local retreatToTopPts1 = {
    { -6.05, -14.50, -11.10 },
    { 3.23, -18.50, -10.15 },
    { 3.13, -18.50, -6.96 },
    { -7.55, -22.50, -6.04 } -- Inside door
}

local retreatToTopPts2 = {
    { -6.99, -22.50, 3.23 }, -- Seems to go back inside and teleports down?
    { -6.63, -22.00, 23.39 },
    { -7.51, -31.00, 41.82 },
    { -7.53, -31.00, 53.43 },
    { 0.46, -31.00, 53.54 } -- Once all mobs dead, immediately pathTwo
}

local sketchOnePt1 = {
    { -4.81, -31.00, 53.49 },
    { -7.04, -31.00, 46.30 },
    { -6.66, -29.50, 36.56 },
    { -6.54, -24.19, 28.27 },
    { -6.30, -22.00, 17.00 },
    { -7.81, -22.50, 2.58 }, -- Waits as mobs spawn all inside and behind
}

local sketchOnePt2 = {
    { -7.57, -22.50, -6.75 }
}

local sketchTwo = { -- Waits as mobs spawn in front and behind again
    { -6.82, -22.50, -6.52 },
    { 0.50, -19.00, -7.26 },
    { 2.88, -18.50, -7.37 },
    { 2.09, -18.50, -11.09 } -- NM SPAWNS
}

local retreatToTopTwoPts1 = { -- Retreats back to top mobs spawning on top of deck and below and running at her
    { 4.15, -18.50, -6.85 },
    { -0.13, -19.50, -5.86 },
    { -7.55, -22.50, -6.04 } -- Inside door
}

function onMobSpawn(mob)
    mob:setDamage(40)
    mob:setMobMod(tpz.mobMod.NO_ROAM , 1)
    mob:setLocalVar("waitTimer", os.time() + 30) -- Allow players to load in
    mob:setLocalVar("path", 0)
end

function onMobRoam(mob)
    local instance = mob:getInstance()
    local stage = instance:getStage()
    local progress = instance:getProgress()
    local chars = instance:getChars()
    local sketchOneWait = mob:getLocalVar("sketchOneWait")
    local sketchTwoWait = mob:getLocalVar("sketchTwoWait")

    local escortProgress = {
        { Stage = 1,    Path = firstPath,           Flags = tpz.path.flag.NONE        },
        { Stage = 2,    Path = retreatToTop,        Flags = tpz.path.flag.RUN         },
        { Stage = 3,    Path = sketchOne,           Flags = tpz.path.flag.NONE        },
        { Stage = 4,    Path = sketchTwo,           Flags = tpz.path.flag.NONE        },
        { Stage = 5,    Path = retreatToTopTwo,     Flags = tpz.path.flag.RUN         },
    }

    if ShouldWait(mob) then
        return printf("Waiting...") -- Unsure if returning this works
    end

    if IsCompleted(instance) and not IsAtChest(mob) then
        Teleport(mob, -0.07, -22.00, 16.13, 193)
    end

    if (IsCompleted(instance)) then
        return
    end

    if IsOutsideDoor(mob) then
        if (stage == 0) then
            printf("Waiting for door to be opened")
            DisplayText(mob, "canYouOpen", ID.text.CAN_YOU_OPEN)
        end
        if (stage == 1) then
            printf("Outside door, increasing progress and teleporting")
            instance:setProgress(instance:getProgress() +1)
            Teleport(mob, -8.02, -22.50, -4.83)
            return
        end
        if (stage == 4) then
                printf("Outside door, increasing progress and teleporting")
                instance:setStage(instance:getStage() +1)
                Teleport(mob, -8.02, -22.50, -4.83)
            return
        end
    end

    if IsAtFirstSpawns(mob) and (stage == 1) and (progress == 1) then
        printf("At first spawns, spawning mobs and setting stage to 2")
        instance:setStage(instance:getStage() +1)
        instance:setProgress(0)
        mob:clearPath()
        mob:setLocalVar("path", 0)
        mob:setLocalVar("pathingDone", 0)
        return
    end

    if IsInsideDoor(mob) then
        if (stage == 2) or (stage == 7) then
            printf("Inside door, increasing stage and teleporting")
            instance:setStage(instance:getStage() +1)
            instance:setProgress(0)
            Teleport(mob, -7.56, -22.50, 3.40)
            return
        end
    end

    if IsAtTop(mob) then
        if (stage == 3) or (stage == 8) then
            printf("At top")
            instance:setStage(instance:getStage() +1)
            instance:setProgress(0)
            mob:clearPath()
            mob:setLocalVar("path", 0)
            mob:setLocalVar("pathingDone", 0)
            return
        end
    end

    if IsAtBalconyOne(mob) and (stage == 5) then
        printf("At balcony one, setting a timer before moving")
        instance:setStage(instance:getStage() +1)
        mob:clearPath()
        mob:setLocalVar("path", 0)
        mob:setLocalVar("pathingDone", 0)
        mob:setLocalVar("sketchOneWait", os.time() + 60)
        return
    end

    if IsAtBalconyTwo(mob) and (stage == 6) then
        printf("At balcony two, setting a timer before moving") 
        instance:setStage(instance:getStage() +1)
        mob:clearPath()
        mob:setLocalVar("path", 0)
        mob:setLocalVar("pathingDone", 0)
        mob:setLocalVar("sketchTwoWait", os.time() + 60)
        return
    end

    if (sketchOneWait > 0) and (sketchTwoWait - os.time() <= 30) then
        DisplayText(mob, "almostDone", ID.text.ALMOST_DONE)
    end

    if IsCompleted(instance) and IsAtChest(mob) then
        DisplayText(mob, "treasureChest", ID.text.A_TREASURE_CHEST)
    end

    if (stage == 0) then
        printf("stageOnePts1")
        DisplayText(mob, "introText", ID.text.SHALL_WE_BE_OFF)
        tpz.path.followPointsInstance(mob, stageOnePts1, tpz.path.flag.NONE)
    elseif (stage == 1) and (progress == 1) then
        DisplayText(mob, "givingCreeps", ID.text.GIVING_ME_CREEPS)
        tpz.path.followPointsInstance(mob, stageOnePts2, tpz.path.flag.NONE)
        printf("stageOnePts2")
    elseif (stage == 2) then
        tpz.path.followPointsInstance(mob, retreatToTopPts1, tpz.path.flag.RUN)
        printf("retreatToTopPts1")
    elseif (stage == 3) then 
        printf("retreatToTopPts2")
        tpz.path.followPointsInstance(mob, retreatToTopPts2, tpz.path.flag.RUN)
    elseif (stage == 4) then
        printf("sketchOnePt1")
        DisplayText(mob, "mustSketch", ID.text.MUST_SKETCH)
        tpz.path.followPointsInstance(mob, sketchOnePt1, tpz.path.flag.RUN)
    elseif (stage == 5) then
        printf("sketchOnePt2")
        tpz.path.followPointsInstance(mob, sketchOnePt2, tpz.path.flag.RUN)
    elseif (stage == 6)  and (os.time() >= sketchOneWait) then
        printf("sketchTwo")
        DisplayText(mob, "mustDraw", ID.text.MUST_DRAW)
        tpz.path.followPointsInstance(mob, sketchTwo, tpz.path.flag.RUN)
    elseif (stage == 7)  and (os.time() >= sketchTwoWait) then
        printf("retreatToTopTwoPts1")
        tpz.path.followPointsInstance(mob, retreatToTopTwoPts1, tpz.path.flag.RUN)
    elseif (stage == 8) then -- TODO: Go back to middle, complete instance
        printf("completed")
        DisplayText(mob, "finished", ID.text.FINISHED)
        instance:complete()
        tpz.path.followPointsInstance(mob, retreatToTopPts2, tpz.path.flag.RUN)
    end
end

function onMobEngaged(mob, target)
end

function onMobFight(mob, target)
    local dmgTakenMsgTimer = mob:getLocalVar("dmgTakenMsgTimer")
    local randomhelpMsg = { ID.text.MAKE_IT_STOP, ID.text.UGH, ID.text.PLEASE_STAY_CLOSE, ID.text.HELP}

    mob:addListener("TAKE_DAMAGE", "FALUUYA_TAKE_DAMAGE", function(mob, amount, attacker, attacktype, damagetype)
        local totalDmgTaken = mob:getLocalVar("totalDmgTaken")
        totalDmgTaken = amount + totalDmgTaken
        mob:setLocalVar("totalDmgTaken")
            -- TODO: Random msg on damage taken + timer
        if (totalDmgTaken >= 1000) then
            DisplayText(mob, "ouch", ID.text.OUCH_PROTECT_ME)
        end
    end)

end

function onMobDisengage(mob)
    ClearPathing(mob)
end

function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    DisplayText(mob, "howCouldHappen", ID.text.HOW_COULD_HAPPEN)
    instance:fail()
end

function DisplayText(mob, textVar, msgId)
    local instance = mob:getInstance()
    local chars = instance:getChars()

    if (mob:getLocalVar(textVar) == 0) then
        for _, v in pairs(chars) do
            v:showText(mob, msgId)
            mob:setLocalVar(textVar, 1)
        end
    end
end

function Teleport(mob, x, y, z, rot)
    ClearPathing(mob)
    if (rot == nil) then
        mob:setPos(x, y, z)
    else
        mob:setPos(x, y, z, rot)
    end
end

function ShouldWait(mob)
    local wait = mob:getLocalVar("waitTimer")

    -- Generic wait
    if (wait > 0) and (os.time() <= wait) then
        ClearPathing(mob)
        return true
    end

    return false
end

function IsStuck(mob)
end

function ClearPathing(mob)
    mob:clearPath()
    mob:setLocalVar("path", 0)
    mob:setLocalVar("pathingDone", 0)
end

function IsOutsideDoor(mob)
    local currentPos = mob:getPos()
    local pathingDone = mob:getLocalVar("pathingDone") == 1
    if (math.abs(currentPos.x - -8.0) <= 1.0 and pathingDone) then
        return true
    end
    return false
end

function IsInsideDoor(mob)
    local currentPos = mob:getPos()
    local pathingDone = mob:getLocalVar("pathingDone") == 1
    if
        (math.abs(currentPos.x - (-8.0)) <= 1.0  and
        math.abs(currentPos.y - (-23)) <= 1.0 and
        pathingDone)
    then
        return true
    end
    return false
end

function IsAtFirstSpawns(mob)
    local currentPos = mob:getPos()
    local pathingDone = mob:getLocalVar("pathingDone") == 1
    if (math.abs(currentPos.x - -4) <= 1.0 and pathingDone) then
        return true
    end
    return false
end

function IsAtTop(mob)
    local currentPos = mob:getPos()
    local pathingDone = mob:getLocalVar("pathingDone") == 1
    if (math.abs(currentPos.x - 0) <= 1.0 and pathingDone) then
        return true
    end
    return false
end

function IsAtBalconyOne(mob)
    local currentPos = mob:getPos()
    local pathingDone = mob:getLocalVar("pathingDone") == 1
    if
        (math.abs(currentPos.x - (-7.0)) <= 1.0  and
        math.abs(currentPos.y - (-23)) <= 1.0 and
        pathingDone)
    then
        return true
    end
    return false
end

function IsAtBalconyTwo(mob)
    local currentPos = mob:getPos()
    local pathingDone = mob:getLocalVar("pathingDone") == 1
    if
        (math.abs(currentPos.x - (2.0)) <= 1.0  and -- TODO
        math.abs(currentPos.y - (-18)) <= 1.0 and
        pathingDone)
    then
        return true
    end
    return false
end

function IsAtChest(mob)
    local currentPos = mob:getPos()
    if (math.abs(currentPos.x - (0.0)) <= 1.0) then
        return true
    end
    return false
end

function IsCompleted(instance)
    if (instance:completed()) then
        return true
    end
    return false
end
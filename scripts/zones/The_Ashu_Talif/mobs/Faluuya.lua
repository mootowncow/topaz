-----------------------------------
-- Area: The Ashu Talif 
--  Mob: Faluuya
-- BCNM: Royal Painter Escort
-- TODO: Failing black screens
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

local sketchTwo = {
    { -6.82, -22.50, -6.52 }, -- Needed?
    { 0.50, -19.00, -7.26 },
    { 2.88, -18.50, -7.37 },
    { 2.09, -18.50, -11.09 }
}

local pathToChestPt1 = { -- Retreats back to top mobs spawning on top of deck and below and running at her
    { 4.15, -18.50, -6.85 },
    { -0.13, -19.50, -5.86 },
    { -7.55, -22.50, -6.04 } -- Inside door
}

local pathToChestPt2 ={

    { -6.89, -22.09, 12.44 },
    { -0.18, -22.00, 12.42 },
    { -0.06, -22.00, 16.90 }
}

function onMobSpawn(mob)
    mob:setDamage(10)
    mob:setMobMod(tpz.mobMod.NO_REST, 1)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
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
        return
        printf("Waiting...") -- Unsure if returning this works
    end

    if IsCompleted(instance) then
        if not IsAtChest(mob) then
            Teleport(mob, -0.07, -22.00, 16.13, 193)
        else
            mob:clearPath()
            return
        end
    end

    if IsStuck(mob) then
        local pathX = mob:getLocalVar("currentPathX")
        local pathY = mob:getLocalVar("currentPathY")
        local pathZ = mob:getLocalVar("currentPathZ")
        printf("Faluuya is stuck, teleporting to %d, %d, %d", pathX, pathY, pathZ)
        mob:setPos(pathX, pathY, pathZ)
    end

    if IsOutsideDoor(mob) then
        if (stage == 0) then
            printf("Waiting for door to be opened")
            DisplayText(mob, "canYouOpen", ID.text.CAN_YOU_OPEN)
            instance:setProgress(1)
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

    if IsAtFirstSpawns(mob) and (stage == 1) and (progress == 2) then
        printf("At first spawns, spawning mobs and setting stage to 2")
        mob:setLocalVar("dmgTakenMsgTimer", os.time() + 15)
        mob:timer(0, function(mob)
            DisplayText(mob, "givingCreeps", ID.text.GIVING_ME_CREEPS)
        end)
        mob:timer(1000, function(mob)
            DisplayText(mob, "chillDownSpine", ID.text.CHILL_DOWN_SPINE, true)
        end)
        mob:timer(3000, function(mob)
            DisplayText(mob, "exclamationQuestionMark", ID.text.EXCLAMATION_QUESTION_MARK)
        end)
        mob:timer(5000, function(mob)
            DisplayText(mob, "whatIsThis", ID.text.WHAT_IS_THIS)
        end)
        mob:timer(7000, function(mob)
            DisplayText(mob, "whatInUrghuum", ID.text.WHAT_IN_URHGUUM)
        end)
        instance:setStage(instance:getStage() +1)
        instance:setProgress(0)
        mob:clearPath()
        mob:setLocalVar("path", 0)
        mob:setLocalVar("pathingDone", 0)
        return
    end

    if IsInsideDoor(mob) then
        if (stage == 2) or (stage == 7) then
            printf("Inside door, teleporting")
            instance:setStage(instance:getStage() +1)
            Teleport(mob, -7.56, -22.50, 3.40)
            return
        end
    end

    if IsAtTop(mob) then
        if (stage == 3) then
            printf("At top")
            DisplayText(mob, "itsHere", ID.text.ITS_HERE)
            instance:setStage(instance:getStage() +1)
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

    if IsAtChest(mob) and (stage == 8) then
        printf("completed")
        DisplayText(mob, "treasureChest", ID.text.A_TREASURE_CHEST)
        instance:complete()
    end

    if (sketchOneWait > 0) and (sketchOneWait - os.time() <= 30) then
        DisplayText(mob, "almostDone", ID.text.ALMOST_DONE)
    end

    if (sketchTwoWait > 0) and (sketchTwoWait - os.time() <= 30) then
        DisplayText(mob, "almostDone2", ID.text.ALMOST_DONE)
    end

    if (stage == 0) then
        printf("stageOnePts1")
        DisplayText(mob, "introText", ID.text.SHALL_WE_BE_OFF)
        tpz.path.followPointsInstance(mob, stageOnePts1, tpz.path.flag.NONE)
    elseif (stage == 1) and (progress == 2) then
        DisplayText(mob, "phew", ID.text.PHEW)
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
        printf("pathToChestPt1")
        DisplayText(mob, "finished", ID.text.FINISHED)
        tpz.path.followPointsInstance(mob, pathToChestPt1, tpz.path.flag.RUN)
    elseif (stage == 8) then
        printf("pathToChestPt2")
        tpz.path.followPointsInstance(mob, pathToChestPt2, tpz.path.flag.NONE)
    end
    CheckInstanceStatue(mob, instance)
end

function onMobEngaged(mob, target)
    local instance = mob:getInstance()
    local chars = instance:getChars()
    for _, v in pairs(chars) do
        v:showText(mob, ID.text.PLEASE_STAY_CLOSE)
    end
end

function onMobFight(mob, target)
    local instance = mob:getInstance()

    mob:addListener("TAKE_DAMAGE", "FALUUYA_TAKE_DAMAGE", function(mob, amount, attacker, attacktype, damagetype)
        local totalDmgTaken = mob:getLocalVar("totalDmgTaken")
        local dmgTakenMsgTimer = mob:getLocalVar("dmgTakenMsgTimer")
        local dmgTakenMsg = { ID.text.MAKE_IT_STOP, ID.text.UGH, ID.text.PLEASE_STAY_CLOSE, ID.text.HELP}
        local instance = mob:getInstance()
        local chars = instance:getChars()

        totalDmgTaken = amount + totalDmgTaken
        mob:setLocalVar("totalDmgTaken", totalDmgTaken)
        if (totalDmgTaken >= 1000) then
            DisplayText(mob, "ouch", ID.text.OUCH_PROTECT_ME)
            mob:setLocalVar("dmgTakenMsgTimer", os.time() + 15)
            instance:setLocalVar("faluuya_damaged", 1)
        end

        if (os.time() >= dmgTakenMsgTimer) then
            mob:setLocalVar("dmgTakenMsgTimer", os.time() + 15)
            for _, v in pairs(chars) do
                v:showText(mob, dmgTakenMsg[math.random(#dmgTakenMsg)])
            end
        end
    end)

    if tpz.path.CheckIfStuck(mob) then
        if (mob:checkDistance(target) >= 10) then
            mob:setPos(target:getXPos(), target:getYPos(), target:getZPos())
        end
    end
    CheckInstanceStatue(mob, instance)
end

function onMobDisengage(mob)
    ClearPathing(mob)
    mob:setLocalVar("stuckTimer", os.time() + 5)
end

function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    DisplayText(mob, "howCouldHappen", ID.text.HOW_COULD_HAPPEN)
    instance:fail()
end

function DisplayText(mob, textVar, msgId, noName)
    local instance = mob:getInstance()
    local chars = instance:getChars()

    if (mob:getLocalVar(textVar) == 0) then
        for _, v in pairs(chars) do
            if (noName ~= nil) then
                v:messageSpecial(msgId)
            else
                v:showText(mob, msgId)
            end
        end
        mob:setLocalVar(textVar, 1)
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
    local sketchOneWait = mob:getLocalVar("sketchOneWait")
    local sketchTwoWait = mob:getLocalVar("sketchTwoWait")
    if (os.time() >= sketchOneWait) and (os.time() >= sketchTwoWait) then
        if tpz.path.CheckIfStuck(mob) then
            return true
        end
    end
    return false
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

function CheckInstanceStatue(mob, instance)
    if (instance:getLocalVar("bartholomew_killed") > 0) then
        DisplayText(mob, "youAreIncredible", ID.text.YOU_ARE_INCREDIBLE)
    elseif (instance:getLocalVar("allWavedCleared") > 0) then
        DisplayText(mob, "notCreepyAnymore", ID.text.NOT_CREEPY_ANYMORE)
    end
end

function IsCompleted(instance)
    if (instance:completed()) then
        return true
    end
    return false
end
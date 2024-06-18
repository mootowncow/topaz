------------------------------------
--
-- NPC PATH WALKING
--
------------------------------------
local npcPreviousPositions = {}
tpz = tpz or {}

tpz.path =
{
    flag =
    {
        NONE     = 0,
        RUN      = 1,
        WALLHACK = 2,
        REVERSE  = 4,
    },

    -- returns the point at the given index
    get = function(points, index)
        local pos = {}

        if index < 0 then
            index = (#points + index - 2) / 3
        end

        pos[1] = points[index*3-2]
        pos[2] = points[index*3-1]
        pos[3] = points[index*3]

        return pos
    end,

    -- returns number of points in given path
    length = function(points)
        return #points / 3
    end,

    -- returns first point in given path
    first = function(points)
        return tpz.path.get(points, 1)
    end,

    -- are two points the same?
    equal = function(point1, point2)
        return point1[1] == point2[1] and point1[2] == point2[2] and point1[3] == point2[3]
    end,

    -- returns last point in given path
    last = function(points)
        local length = tpz.path.length(points)
        return tpz.path.get(points, length)
    end,

    -- returns random point from given path
    random = function(points)
        local length = tpz.path.length(points)
        return tpz.path.get(points, math.random(length))
    end,

    -- returns the start path without the first element
    fromStart = function(points, start)
        start = start or 1
        local t2 = {}
        local maxLength = 50
        local length = tpz.path.length(points)
        local count = 1
        local pos = start + 1
        local index = 1

        while pos <= length and count <= maxLength do
            local pt = tpz.path.get(points, pos)

            t2[index] = pt[1]
            t2[index+1] = pt[2]
            t2[index+2] = pt[3]

            pos = pos + 1
            count = count + 1
            index = index + 3
        end

        return t2
    end,

    -- reverses the array and removes the first element
    fromEnd = function(points, start)
        start = start or 1
        local t2 = {}
        local length = tpz.path.length(points)
        start = length - start
        local index = 1

        for i = start, 1, -1 do
            local pt = tpz.path.get(points, i)

            t2[index] = pt[1]
            t2[index+1] = pt[2]
            t2[index+2] = pt[3]

            index = index + 3

            if i > 50 then
                break
            end
        end

        return t2
    end,


    -- continusly run the path
    patrol = function(npc, points, flags)
        if npc:atPoint(tpz.path.first(points)) or npc:atPoint(tpz.path.last(points)) then
            npc:pathThrough(tpz.path.fromStart(points), flags)
        else
            local length = tpz.path.length(points)
            local currentLength = 0
            local i = 51

            while(i <= length) do
                if npc:atPoint(tpz.path.get(points, i)) then
                    npc:pathThrough(tpz.path.fromStart(points, i), flags)
                    break
                end

                i = i + 50
            end
        end
    end,

    patrolsimple = function(npc, points, flags)
        local nextPatrolIndex = npc:getLocalVar("nextPatrolIndex")
        local length = tpz.path.length(points)
        local i = nextPatrolIndex > 0 and nextPatrolIndex or 1

        if i <= length then
            if npc:atPoint(tpz.path.get(points, i)) then
                i = i + 1
            end
        else
            i = 1
        end

        npc:pathThrough(tpz.path.get(points, i), flags)
        npc:setLocalVar("nextPatrolIndex", i)
    end,

    -- Loops back and forth from point 1 > 2 > 3 > 4 > 3 > 2 > 1 etc.
    loop = function(npc, points, flags)
        if not npc:isFollowingPath() then
            local path = npc:getLocalVar("path")
            local step = (npc:getLocalVar("pathstep") == 2) and -1 or 1;
            path = path + step;
            if (path > #points) then
                path = #points - 1;
                npc:setLocalVar("pathstep", 2);
            elseif (path < 1) then
                path = 2;
                npc:setLocalVar("pathstep", 1);
            end
        
            npc:setLocalVar("path", path);
            local currentPath = points[path];
            -- print(string.format('%.2f,%.2f,%.2f [%u] - %s', currentPath.x, currentPath.y, currentPath.z, path, (step == 1) and 'Forward' or 'Reverse'));
            npc:pathTo(currentPath.x, currentPath.y, currentPath.z, flags);
            -- TODO: Change to capital X Y Z and change files using this function to use X Y Z for tables
            -- TODO: Use pathThrough ?
        end
    end,

    -- Paths a table of points once then steps
    followPoints = function(npc, points, flags)
        -- printf("Following path")
        if not npc:isFollowingPath() then
            local path = npc:getLocalVar("path")
            path = path + 1;
            -- print(#points)
            if (path > #points) then
                -- printf("Pathing is done")
                npc:setLocalVar("pathingDone", 1)
                return
            end

            npc:setLocalVar("path", path);
            npc:setLocalVar("pathingDone", 0)
            local currentPath = points[path];
            -- print(string.format('Following path point: %.2f, %.2f, %.2f [%u]', currentPath[1], currentPath[2], currentPath[3], path))
            npc:pathThrough(currentPath, flags);
        end
    end,

    followPointsInstance = function(npc, points, flags)
        local path = npc:getLocalVar("path")
        if (path == 0) then
            npc:setLocalVar("path", 1)
            npc:setLocalVar("currentPathX", points[1][1])
            npc:setLocalVar("currentPathY", points[1][2])
            npc:setLocalVar("currentPathZ", points[1][3])
            -- printf(string.format('Following path point: %.2f, %.2f, %.2f [1]', points[1][1], points[1][2], points[1][3]))
            npc:pathThrough(points[1], flags)
        end

        local currentPos = npc:getPos()

        -- Ensure the path index is within the range of the points table
        if path > 0 and path <= #points then
            local currentPath = points[path]

            -- Ensure currentPath is not nil before accessing its elements
            if currentPath ~= nil then
                -- Check if the absolute difference between currentPos.x and currentPath[1] is <= 1 yard
                if math.abs(currentPos.x - currentPath[1]) <= 1.0 and math.abs(currentPos.y - currentPath[2]) <= 1.0 then
                    path = path + 1
                    npc:setLocalVar("path", path)
                    npc:setLocalVar("pathingDone", 0)

                    if path > #points then
                        -- printf("Pathing is done")
                        npc:setLocalVar("pathingDone", 1)
                        return
                    end

                    currentPath = points[path]
                    -- printf(string.format('Following path point: %.2f, %.2f, %.2f [%u]', currentPath[1], currentPath[2], currentPath[3], path))
                    npc:setLocalVar("currentPathX", currentPath[1])
                    npc:setLocalVar("currentPathY", currentPath[2])
                    npc:setLocalVar("currentPathZ", currentPath[3])
                    npc:pathThrough(currentPath, flags)
                end
            else
                printf("Error: currentPath is nil")
            end
        end
    end,

    IsStuck = function(npc)
        local npcId = npc:getID()
        local currentPosition = {x = npc:getXPos(), y = npc:getYPos(), z = npc:getZPos()}

        -- Check if there is a previous position recorded
        if npcPreviousPositions[npcId] then
            local previousPosition = npcPreviousPositions[npcId]

            -- Compare the current position with the previous position
            if currentPosition.x == previousPosition.x and currentPosition.y == previousPosition.y and currentPosition.z == previousPosition.z then
                -- Positions are the same, mob might be stuck
                return true
            else
                -- Update the previous position
                npcPreviousPositions[npcId] = currentPosition
                return false
            end
        else
            -- No previous position recorded, record the current position
            npcPreviousPositions[npcId] = currentPosition
            return false
        end
    end,

    CheckIfStuck = function(npc)
        local stuckTimer = npc:getLocalVar("stuckTimer")
        if (stuckTimer == 0) then
            npc:setLocalVar("stuckTimer", os.time() + 10)
        elseif (os.time() >= stuckTimer) then
            if tpz.path.IsStuck(npc) then
                -- print(string.format("Entity is stuck: %s | %s", npc:getName(), npc:getID()))
                return true
            end
            npc:setLocalVar("stuckTimer", os.time() + 10)
        end
        return false
    end,
}
require("scripts/zones/Promyvion-Dem/IDs")
require("scripts/zones/Promyvion-Holla/IDs")
require("scripts/zones/Promyvion-Mea/IDs")
require("scripts/zones/Promyvion-Vahzl/IDs")
require("scripts/globals/status")
------------------------------------

tpz = tpz or {}
tpz.promyvion = tpz.promyvion or {}
------------------------------------
-- LOCAL FUNCTIONS
------------------------------------

local function maxFloor(ID)
    local m = 0

    for _, v in pairs(ID.mob.MEMORY_RECEPTACLES) do
        m = math.max(m, v[1])
    end

    return m
end

local function randomizeFloorExit(ID, floor)
    local streams = {}

    for _, v in pairs(ID.mob.MEMORY_RECEPTACLES) do
        if v[1] == floor then
            GetNPCByID(v[3]):setLocalVar("[promy]floorExit", 0)
            table.insert(streams, v[3])
        end
    end

    local exitStreamId = streams[math.random(#streams)]
    GetNPCByID(exitStreamId):setLocalVar("[promy]floorExit", 1)
end

local function findMother(mob)
    local ID = zones[mob:getZoneID()]
    local mobId = mob:getID()
    local mother = 0
    for k, v in pairs(ID.mob.MEMORY_RECEPTACLES) do
        if k < mobId and k > mother then
            mother = k
        end
    end
    return mother
end

local function selectRandomModel(models, mob)
    local model = math.random(1,4)
    local sub = math.random(1,2)

    -- set elemental type
    local element = 0
    if sub == 1 then
        if model == 1 then
        element = 8 -- dark
        mob:setMod(tpz.mod.SDT_DARK, 5)
        mob:setMod(tpz.mod.EEM_DARK_SLEEP, 5)
        mob:setMod(tpz.mod.EEM_BLIND, 5)
        mob:setMod(tpz.mod.SDT_LIGHT, 150)
        mob:setMod(tpz.mod.EEM_LIGHT_SLEEP, 150)
        mob:setMod(tpz.mod.EEM_CHARM, 150)
        elseif model == 2 then
        element = 5 -- thunder
        mob:setMod(tpz.mod.SDT_THUNDER, 5)
        mob:setMod(tpz.mod.EEM_STUN, 5)
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.EEM_POISON, 5)
        mob:setMod(tpz.mod.SDT_EARTH, 150)
        mob:setMod(tpz.mod.EEM_SLOW, 150)
        mob:setMod(tpz.mod.EEM_PETRIFY, 150)
        mob:setMod(tpz.mod.EEM_TERROR, 150)
        elseif model == 3 then
        element = 7 -- light
        mob:setMod(tpz.mod.SDT_LIGHT, 5)
        mob:setMod(tpz.mod.EEM_LIGHT_SLEEP, 5)
        mob:setMod(tpz.mod.EEM_CHARM, 5)
        mob:setMod(tpz.mod.SDT_DARK, 150)
        mob:setMod(tpz.mod.EEM_DARK_SLEEP, 150)
        mob:setMod(tpz.mod.EEM_BLIND, 150)
        elseif model == 4 then
        element = 2 -- ice
        mob:setMod(tpz.mod.SDT_ICE, 5)
        mob:setMod(tpz.mod.EEM_PARALYZE, 5)
        mob:setMod(tpz.mod.EEM_BIND, 5)
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.EEM_SILENCE, 5)
        mob:setMod(tpz.mod.EEM_GRAVITY, 5)
        mob:setMod(tpz.mod.SDT_FIRE, 150)
        mob:setMod(tpz.mod.EEM_AMNESIA, 150)
        mob:setMod(tpz.mod.EEM_VIRUS, 150)
        end
    else
        if model == 1 then
        element = 6 -- water
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.EEM_POISON, 5)
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.EEM_AMNESIA, 5)
        mob:setMod(tpz.mod.EEM_VIRUS, 5)
        mob:setMod(tpz.mod.SDT_THUNDER, 150)
        mob:setMod(tpz.mod.EEM_STUN, 150)
        elseif model == 2 then
        element = 4 -- earth
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMod(tpz.mod.EEM_SLOW, 5)
        mob:setMod(tpz.mod.EEM_PETRIFY, 5)
        mob:setMod(tpz.mod.EEM_TERROR, 5)
        mob:setMod(tpz.mod.SDT_THUNDER, 5)
        mob:setMod(tpz.mod.EEM_STUN, 5)
        mob:setMod(tpz.mod.SDT_WIND, 150)
        mob:setMod(tpz.mod.EEM_SILENCE, 150)
        mob:setMod(tpz.mod.EEM_GRAVITY, 150)
        elseif model == 3 then
        element = 1 -- fire
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.EEM_AMNESIA, 5)
        mob:setMod(tpz.mod.EEM_VIRUS, 5)
        mob:setMod(tpz.mod.SDT_ICE, 5)
        mob:setMod(tpz.mod.EEM_PARALYZE, 5)
        mob:setMod(tpz.mod.EEM_BIND, 5)
        mob:setMod(tpz.mod.SDT_WATER, 150)
        mob:setMod(tpz.mod.EEM_POISON, 150)
        elseif model == 4 then
        element = 3 -- wind
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.EEM_SILENCE, 5)
        mob:setMod(tpz.mod.EEM_GRAVITY, 5)
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMod(tpz.mod.EEM_SLOW, 5)
        mob:setMod(tpz.mod.EEM_PETRIFY, 5)
        mob:setMod(tpz.mod.EEM_TERROR, 5)
        mob:setMod(tpz.mod.SDT_ICE, 150)
        mob:setMod(tpz.mod.EEM_PARALYZE, 150)
        mob:setMod(tpz.mod.EEM_BIND, 150)
        end
    end

    mob:setModelId(models[model])
    mob:AnimationSub(sub)
    mob:setLocalVar("element", element)
end

------------------------------------
-- PUBLIC FUNCTIONS
------------------------------------

tpz.promyvion.initZone = function(zone)
    local ID = zones[zone:getID()]

    -- register teleporter regions
    for k, v in pairs(ID.npc.MEMORY_STREAMS) do
        zone:registerRegion(k,v[1],v[2],v[3],v[4],v[5],v[6])
    end

    -- randomize floor exits
    for i = 1, maxFloor(ID) do
        randomizeFloorExit(ID, i)
    end
end

tpz.promyvion.setEmptyModel = function (mob)
    switch (mob:getFamily()) : caseof {
        [78] = function()
            selectRandomModel({
                [1] = 1134,
                [2] = 1135,
                [3] = 1137,
                [4] = 1138
            }, mob) -- Craver
        end,
        [138] = function()
            selectRandomModel({
                [1] = 1129,
                [2] = 1130,
                [3] = 1131,
                [4] = 1132
            }, mob) -- Gorger
        end,
        [220] = function()
            selectRandomModel({
                [1] = 1117,
                [2] = 1119,
                [3] = 1120,
                [4] = 1121
            }, mob) -- Seether
        end,
        [241] = function()
            selectRandomModel({
                [1] = 1123,
                [2] = 1124,
                [3] = 1126,
                [4] = 1127
            }, mob) -- Thinker
        end,
        [255] = function()
            selectRandomModel({
                [1] = 1106,
                [2] = 1107,
                [3] = 1108,
                [4] = 1110
            }, mob) -- Wanderer
        end,
        [256] = function()
            selectRandomModel({
                [1] = 1112,
                [2] = 1113,
                [3] = 1114,
                [4] = 1115
            }, mob) -- Weeper
        end,
        [499] = function()
            selectRandomModel({
                [1] = 1106,
                [2] = 1107,
                [3] = 1108,
                [4] = 1110
            }, mob) -- Wanderer
        end,
    }
end

tpz.promyvion.onEmptyDeath = function(mob)
    mob:AnimationSub(0)
end

tpz.promyvion.strayOnRoam = function(mob)
    local mother = mob:getLocalVar("mother")
    if (mother == 0) then
        mother = findMother(mob)
    end
    mother = GetMobByID(mother)
    local target = mother:getTarget()

    if target ~= nil then
        mob:updateEnmity(target)
    end
end

tpz.promyvion.strayOnSpawn = function(mob)
    local mother = GetMobByID(findMother(mob))

    if mother ~= nil and mother:isSpawned() then
        mob:setPos(mother:getXPos(), mother:getYPos() - 5, mother:getZPos())
        mother:AnimationSub(1)
    end
end

tpz.promyvion.receptacleOnFight = function(mob, target)
    if os.time() > mob:getLocalVar("[promy]nextStray") then
        local ID = zones[mob:getZoneID()]
        local mobId = mob:getID()
        local numStrays = ID.mob.MEMORY_RECEPTACLES[mobId][2]

        for i = mobId + 1, mobId + numStrays do
            local stray = GetMobByID(i)
            if not stray:isSpawned() then
                mob:setLocalVar("[promy]nextStray", os.time() + math.random(20, 40))
                stray:spawn()
                stray:updateEnmity(target)
                break
            end
        end
    else
        mob:AnimationSub(2)
    end
end

tpz.promyvion.receptacleOnDeath = function(mob, isKiller)
    if isKiller then
        local ID = zones[mob:getZoneID()]
        local mobId = mob:getID()
        local floor = ID.mob.MEMORY_RECEPTACLES[mobId][1]
        local streamId = ID.mob.MEMORY_RECEPTACLES[mobId][3]
        local stream = GetNPCByID(streamId)

        mob:AnimationSub(0)

        -- open floor exit portal
        if stream:getLocalVar("[promy]floorExit") == 1 then
            randomizeFloorExit(ID, floor)
            local events = ID.npc.MEMORY_STREAMS[streamId][7]
            local event = events[math.random(#events)]
            stream:setLocalVar("[promy]destination", event)
            stream:openDoor(180)
        end
    end
end


tpz.promyvion.receptacleOnDespawn = function(mob)
    local ID = zones[mob:getZoneID()]
    local mobId = mob:getID()
    local floor = ID.mob.MEMORY_RECEPTACLES[mobId][1]
    local numAlive = 1
    for k, v in pairs(ID.mob.MEMORY_RECEPTACLES) do
        if k ~= mobId and v[1] == floor and GetMobByID(k):isAlive() then
            numAlive = numAlive + 1
        end
    end

    -- open floor exit portal
    if math.random(numAlive) == 1 then
        local streamId = ID.mob.MEMORY_RECEPTACLES[mobId][3]
        local stream = GetNPCByID(streamId)
        local events = ID.npc.MEMORY_STREAMS[streamId][7]
        local event = events[math.random(#events)]
        stream:setLocalVar("[promy]destination",event)
        stream:openDoor(180)
        randomizeFloorExit(ID, floor)
    end
end

tpz.promyvion.onRegionEnter = function(player, region)
    if player:getAnimation() == 0 then
        local ID = zones[player:getZoneID()]
        local regionId = region:GetRegionID()
        local event = nil

        if regionId < 100 then
            event = ID.npc.MEMORY_STREAMS[regionId][7][1]
        else
            local stream = GetNPCByID(regionId)
            if stream ~= nil and stream:getAnimation() == tpz.anim.OPEN_DOOR then
                event = stream:getLocalVar("[promy]destination")
            end
        end

        if event ~= nil then
            player:startEvent(event)
        end
    end
end

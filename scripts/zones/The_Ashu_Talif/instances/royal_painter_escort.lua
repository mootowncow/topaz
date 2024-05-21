-----------------------------------
--
-- Royal Painter Escort
--
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/status")
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
-----------------------------------

function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:setCharVar("Halshaob_Quest", 0)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)
    SpawnMob(ID.mob[56].FALUUYA, instance)
    instance:getEntity(bit.band(ID.npc.DOOR_CARGO_HOLD, 0xFFF), tpz.objType.NPC):untargetable(false)
    instance:setProgress(0)
end

function onInstanceTimeUpdate(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

function onInstanceFailure(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

function onInstanceProgressUpdate(instance, progress)
    if progress == 1 then -- Wave 1
        spawnWave(1, instance)
    elseif progress == 4 then -- Wave 2
        spawnWave(2, instance)
    elseif progress == 9 then -- Wave 3
        spawnWave(3, instance)
    elseif progress == 18 then -- Wave 4
        spawnWave(4, instance)
    elseif progress == 27 then -- Wave 5
        spawnWave(5, instance)
    elseif progress == 28 then -- Wave 6
        spawnWave(6, instance)
    elseif progress == 29 then -- Wave 7
        spawnWave(7, instance)
    elseif progress == 31 then -- Wave 8
        spawnWave(8, instance)
    elseif progress == 35 then -- Wave 9
        giveTempItems(instance)
        spawnWave(9, instance)
    elseif progress == 36 then -- Wave 10
        spawnWave(10, instance)
    elseif progress == 40 then -- Wave 11
        spawnWave(11, instance)
    elseif progress == 44 then -- Wave 12
        spawnWave(12, instance)
    elseif progress == 52 then -- Wave 13
        spawnWave(13, instance)
    elseif progress == 60 then -- Wave 14
        spawnWave(14, instance)
    elseif progress == 69 then -- Wave 15
        spawnWave(15, instance)
    elseif progress == 73 then -- Wave 16
        giveTempItems(instance)
        spawnWave(16, instance)
    elseif progress == 74 then -- Wave 17
        spawnWave(17, instance)
    elseif progress == 82 then -- Wave 18
        spawnWave(18, instance)
    elseif progress == 90 then -- Wave 19
        spawnWave(19, instance)
    elseif progress == 94 then -- Wave 20
        spawnWave(20, instance)
    elseif progress == 102 then -- Wave 21
        spawnWave(21, instance)
    elseif (progress == 110 and instance:completed() == false) then
        instance:complete()
    end
end

function onInstanceComplete(instance)
    local mob = GetMobByID(ID.mob[55].SWIFTWINGED_GEKKO, instance)
    local chars = instance:getChars()
    
    for _, v in pairs(chars) do
        v:completeQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.SCOUTING_THE_ASHU_TALIF)
    end

    -- Spawn exit and chest(s)
    instance:getEntity(bit.band(ID.npc.GATE_LIFEBOAT, 0xFFF), tpz.objType.NPC):untargetable(false)
    instance:getEntity(bit.band(ID.npc[55].ANCIENT_LOCKBOX, 0xFFF), tpz.objType.NPC):setStatus(tpz.status.NORMAL)
    if not mob:isSpawned() then
        instance:getEntity(bit.band(ID.npc[55].ANCIENT_LOCKBOX_EXTRA, 0xFFF), tpz.objType.NPC):setStatus(tpz.status.NORMAL)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 101 or csid == 102 then
        player:setPos(0, 0, 0, 0, 54)
    end
end

function spawnWave(wave, instance)
    for i, v in pairs(waves[wave]) do
        local mob = GetMobByID(v, instance)

        if v == ID.mob[55].SWIFTWINGED_GEKKO then
            if mob:isSpawned() then
                -- Give a random person if hate
                local chars = instance:getChars()
                mob:addEnmity(chars[math.random(#chars)], 0, 1)

                -- Show mob
                mob:hideName(false)
                mob:untargetable(false)
                mob:setStatus(tpz.status.UPDATE)
                mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
                
                -- Delay casting
                mob:timer(1000, function(mob)
                    if mob:isSpawned() then
                        mob:SetMagicCastingEnabled(true)
                    end
                end)
            else
                instance:setProgress(instance:getProgress() + 1)
            end
        else
            mob:timer(2000, function(mob)
                if not mob:isSpawned() then
                    mob:spawn()
                    mob:SetMobSkillAttack(0)
                    mob:setMobMod(tpz.mobMod.LINK_RADIUS, 30)
                else
                    instance:setProgress(instance:getProgress() + 1) -- If the mob can't spawn, then just increase the counter
                end
            end)
        end
    end
end

function giveTempItems(instance)
    local chars = instance:getChars()
    for _, v in pairs(chars) do
        v:messageSpecial(ID.text.BAG_FEELS_HEAVIER)
        -- Deadalus Wing
        if not v:hasItem(4202, 3) then
            v:addTempItem(4202, 1)
        end
        -- Vile Elixer +1
        if not v:hasItem(4175, 3) then
            v:addTempItem(4175, 1)
        end
        -- Revitalizer
        if not v:hasItem(4146, 3) then
            v:addTempItem(4146, 1)
        end

        if v:getMainJob() == tpz.job.DRG and not v:hasItem(5246, 3) then
            v:addTempItem(5246, 1) -- Drachenessence
        elseif v:getMainJob() == tpz.job.BST and not v:hasItem(17021, 3) then
            v:addTempItem(17021, 1) -- Pet Food Zeta
        end
    end
end

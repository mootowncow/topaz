-----------------------------------
--
-- Targeting the Captain
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
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)
    -- Spawn mobs
    for v = ID.mob[57].WINDJAMMER_IMP[1], ID.mob[57].CUTTHROAT_KABSALAH do
        SpawnMob(v, instance)
    end

    -- Allow doors to be targetable
    instance:getEntity(bit.band(ID.npc.DOOR_CARGO_HOLD, 0xFFF), tpz.objType.NPC):untargetable(false)
    instance:getEntity(bit.band(ID.npc.DOOR_GREAT_CABIN, 0xFFF), tpz.objType.NPC):untargetable(false)
    instance:setProgress(0)
end

function onInstanceTimeUpdate(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

function onInstanceFailure(instance)
    local chars = instance:getChars()
    local mobs = instance:getMobs()

    for _,v in pairs(mobs) do
        local mobID = v:getID()
        DespawnMob(mobID, instance)
    end

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

function onInstanceProgressUpdate(instance, progress)
end

function onInstanceComplete(instance)
    local chars = instance:getChars()
    
    for _, v in pairs(chars) do
        v:setCharVar("Halshaob_Quest", 0)
        v:completeQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.TARGETING_THE_CAPTAIN)
        v:messageSpecial(ID.text.RETURN_TO_LIFEBOAT)
    end

    -- Despawn mobs
    for v = ID.mob[57].WINDJAMMER_IMP[1], ID.mob[57].CUTTHROAT_KABSALAH do
        DespawnMob(v, instance)
    end

    -- Spawn exit and chest(s)
    instance:getEntity(bit.band(ID.npc.GATE_LIFEBOAT, 0xFFF), tpz.objType.NPC):untargetable(false)
    instance:getEntity(bit.band(ID.npc[57].ANCIENT_LOCKBOX, 0xFFF), tpz.objType.NPC):setStatus(tpz.status.NORMAL)

    if (instance:getLocalVar("bubbly_Defeated") == 1) then
        instance:getEntity(bit.band(ID.npc[57].ANCIENT_LOCKBOX_BUBBLY_BONUS, 0xFFF), tpz.objType.NPC):setStatus(tpz.status.NORMAL)
    end

    if (instance:getLocalVar("detected") == 0) then
        instance:getEntity(bit.band(ID.npc[57].ANCIENT_LOCKBOX_NO_AGGRO_BONUS, 0xFFF), tpz.objType.NPC):setStatus(tpz.status.NORMAL)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

function spawnWave(wave, instance)
    local waveMobs = ID.mob[56].WAVES[wave]

    if (instance:completed()) or (instance:getLocalVar("bartholomew_killed") > 0) then
        return
    end

    if not waveMobs then
        -- printf("Invalid wave number:", wave)
        return
    end

    for _, mobId in pairs(waveMobs) do
        -- printf("Spawning mob with ID:", mobId)
        local mob = GetMobByID(mobId, instance)
        
        if not mob then
            printf("Invalid mob returned for ID:", mobId)
            return
        end

        mob:spawn()

        if mob:isSpawned() then
            -- printf("Mob spawned successfully:", mobId)
            local faluuya = GetMobByID(ID.mob[56].FALUUYA, instance)
            if faluuya then
                mob:updateEnmity(faluuya)
            else
                printf("Faluuya mob not found.")
            end
        else
            printf("Mob failed to spawn:", mobId)
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

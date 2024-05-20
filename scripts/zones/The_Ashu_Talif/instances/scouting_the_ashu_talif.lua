-----------------------------------
--
-- Scouting the Ashu Talif
--
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/status")
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
-----------------------------------

local waves =
{
    [1] =
    {
        ID.mob[55].CREW_MNK[3],
        ID.mob[55].CREW_RDM[4],
        ID.mob[55].CREW_RNG[5],
    },
    [2] =
    {
        ID.mob[55].CREW_MNK[1], ID.mob[55].CREW_MNK[4],
        ID.mob[55].CREW_RDM[2], ID.mob[55].CREW_RDM[5],
        ID.mob[55].CREW_RNG[3],
    },
    [3] =
    {
        ID.mob[55].CREW_MNK[1], ID.mob[55].CREW_MNK[3],
        ID.mob[55].CREW_RDM[2], ID.mob[55].CREW_RDM[3], ID.mob[55].CREW_RDM[5],
        ID.mob[55].CREW_RNG[1], ID.mob[55].CREW_RNG[2], ID.mob[55].CREW_RNG[3], ID.mob[55].CREW_RNG[4],
    },
    [4] =
    {
        ID.mob[55].CREW_MNK[3], ID.mob[55].CREW_MNK[4], ID.mob[55].CREW_MNK[5], 
        ID.mob[55].CREW_RDM[1], ID.mob[55].CREW_RDM[3], ID.mob[55].CREW_RDM[5],
        ID.mob[55].CREW_RNG[2], ID.mob[55].CREW_RNG[4], ID.mob[55].CREW_RNG[5],
    },
    [5] =
    {
        ID.mob[55].SWIFTWINGED_GEKKO,
    },
    [6] =
    {
        ID.mob[55].IMP[1],
    },
    [7] =
    {
        ID.mob[55].IMP[2], ID.mob[55].IMP[3],
    },
    [8] =
    {
        ID.mob[55].IMP[1], ID.mob[55].IMP[2], ID.mob[55].IMP[3], ID.mob[55].IMP[4],
    },
    [9] =
    {
        ID.mob[55].SWIFTWINGED_GEKKO,
    },
    [10] =
    {
        ID.mob[55].CREW_MNK[1],
        ID.mob[55].CREW_RDM[2],
        ID.mob[55].CREW_RNG[3],
        ID.mob[55].IMP[1],
    },
    [11] =
    {
        ID.mob[55].CREW_MNK[3],
        ID.mob[55].CREW_RDM[1],
        ID.mob[55].CREW_RNG[2],
        ID.mob[55].IMP[1],
    },
    [12] =
    {
        ID.mob[55].CREW_MNK[1], ID.mob[55].CREW_MNK[2], ID.mob[55].CREW_MNK[3],
        ID.mob[55].CREW_RDM[2], ID.mob[55].CREW_RDM[5],
        ID.mob[55].CREW_RNG[3],
        ID.mob[55].IMP[1], ID.mob[55].IMP[2],
    },
    [13] =
    {
        ID.mob[55].CREW_MNK[3],
        ID.mob[55].CREW_RDM[1], ID.mob[55].CREW_RDM[2], ID.mob[55].CREW_RDM[3],
        ID.mob[55].CREW_RNG[2], ID.mob[55].CREW_RNG[5],
        ID.mob[55].IMP[1], ID.mob[55].IMP[2],
    },
    [14] =
    {
        ID.mob[55].CREW_MNK[2], ID.mob[55].CREW_MNK[5],
        ID.mob[55].CREW_RDM[3],
        ID.mob[55].CREW_RNG[1], ID.mob[55].CREW_RNG[2], ID.mob[55].CREW_RNG[3],
        ID.mob[55].IMP[1], ID.mob[55].IMP[2],
        ID.mob[55].SWIFTWINGED_GEKKO,
    },
    [15] =
    {
        ID.mob[55].CREW_MNK[3], ID.mob[55].CREW_MNK[4],
        ID.mob[55].CREW_RDM[1],
        ID.mob[55].CREW_RNG[2],
    },
    [16] =
    {
        ID.mob[55].SWIFTWINGED_GEKKO,
    },
    [17] =
    {
        ID.mob[55].CREW_MNK[1], ID.mob[55].CREW_MNK[3],
        ID.mob[55].CREW_RDM[2], ID.mob[55].CREW_RDM[5],
        ID.mob[55].CREW_RNG[3], ID.mob[55].CREW_RNG[5],
        ID.mob[55].IMP[1], ID.mob[55].IMP[2],
    },
    [18] =
    {
        ID.mob[55].CREW_MNK[4], ID.mob[55].CREW_MNK[5],
        ID.mob[55].CREW_RDM[1], ID.mob[55].CREW_RDM[4],
        ID.mob[55].CREW_RNG[2], ID.mob[55].CREW_RNG[5],
        ID.mob[55].IMP[1], ID.mob[55].IMP[2],
    },
    [19] =
    {
        ID.mob[55].IMP[1], ID.mob[55].IMP[2], ID.mob[55].IMP[3],
        ID.mob[55].SWIFTWINGED_GEKKO,
    },
    [20] =
    {
        ID.mob[55].CREW_MNK[1], ID.mob[55].CREW_MNK[3],
        ID.mob[55].CREW_RDM[2], ID.mob[55].CREW_RDM[3],
        ID.mob[55].CREW_RNG[3], ID.mob[55].CREW_RNG[5],
        ID.mob[55].IMP[2], ID.mob[55].IMP[3],
    },
    [21] =
    {
        ID.mob[55].CREW_MNK[1], ID.mob[55].CREW_MNK[2],
        ID.mob[55].CREW_RDM[2], ID.mob[55].CREW_RDM[4],
        ID.mob[55].CREW_RNG[3], ID.mob[55].CREW_RNG[4],
        ID.mob[55].IMP[1], ID.mob[55].IMP[4],
    },
}

function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:setCharVar("Halshaob_Quest", 0)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)
    local mob = GetMobByID(ID.mob[55].SWIFTWINGED_GEKKO, instance)
    mob:spawn()
    mob:hideName(true)
    mob:untargetable(true)
    mob:setStatus(tpz.status.INVISIBLE)
    instance:setProgress(1)
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

function onInstanceProgressUpdate(instance, elapsed)
    local stage = instance:getStage()
    local progress = instance:getProgress()

    if (stage == 1 and progress == 0) -- Escort start
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

-----------------------------------
-- Area: The Ashu Talif
-- (The Black Coffin & Scouting the Ashu Talif & Royal Painter Escort)
--  Mob: Ashu Talif Crew
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
require("scripts/globals/status")
require("scripts/globals/pathfind")
-----------------------------------
-- Instance IDs
local SCOUTING_THE_ASHU_TALIF = 55
local ROYAL_PAINTER_ESCORT = 56
local TARGETING_THE_CAPTAIN = 57

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobSpawn(mob)
    local instance = mob:getInstance()
    local instanceID = instance:getID()

    mob:setDamage(40)

    if (instanceID == SCOUTING_THE_ASHU_TALIF) then
        if (mob:getMainJob() == tpz.job.MNK) then
            mob:setDamage(10)
        else
            mob:setDamage(20)
        end
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:setMobMod(tpz.mobMod.SOUND_RANGE, 14)
    end
end

function onMobRoam(mob)
    local instance = mob:getInstance()
    local instanceID = instance:getID()

    if (instance:completed()) then
        DespawnMob(mob:getID(), instance)
    end
    if (instanceID == ROYAL_PAINTER_ESCORT) then
        if tpz.path.CheckIfStuck(mob) then
            mob:setPos(15.82,-22.74,-1.99) -- Maybe should be 16, -22, 0.4?
        end
    end
end

function onMobEngaged(mob, target)
    local instance = mob:getInstance()
    local instanceID = instance:getID()
    -- Black Coffin
    local allies = mob:getInstance():getAllies()
    for i, v in pairs(allies) do
        if (v:isAlive()) then
            v:setLocalVar("ready", 1)
        end
    end

    local mobs = mob:getInstance():getMobs()
    for i, v in pairs(mobs) do
        if(v:isAlive()) then
            v:setLocalVar("ready", 1)
        end
    end

    if (instanceID == SCOUTING_THE_ASHU_TALIF) then
        for adds = 17022986, 17023008 do
            local selectedAdd = GetMobByID(adds, instance)
            if selectedAdd then
                selectedAdd:updateEnmity(target)
            end
        end
    end
end

function onMobFight(mob, target)
    local instance = mob:getInstance()
    if (instance:completed()) then
        DespawnMob(mob:getID(), instance)
    end

    if tpz.path.CheckIfStuck(mob) then
        if (mob:checkDistance(target) >= 10) then
            mob:setPos(target:getXPos(), target:getYPos(), target:getZPos())
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

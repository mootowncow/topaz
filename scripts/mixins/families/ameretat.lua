--[[
https://ffxiclopedia.fandom.com/wiki/Great_Ameretat

Ameretat mobs can optionally be modified by calling tpz.mix.ameretat.config(mob, params) from within onMobSpawn.

params is a table that can contain the following keys:
    sleepHour : changes hour at which ameretat ameretat naturally fall asleep (default: 20)
    wakeHour  : changes hour at which ameretat ameretat naturally wake (default: 5)

Example:

tpz.mix.ameretat.config(mob, {
    sleepHour = 20,
    wakeHour = 5,
})

http://wiki.ffo.jp/html/2634.html
Strong regen when near it's spawn
Absorbs HP as an additional effect of normal attacks when out of range (100%, absorbs about 10 times)
It will not move at night ( it will not sleep and deactivate like Elka or Karakul , if you approach without sneaking , it will attack and chase you)
Vampiric route added to special skills

--]]
require("scripts/globals/mixins")
require("scripts/globals/utils")
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------

tpz = tpz or {}
tpz.mix = tpz.mix or {}
tpz.mix.ameretat = tpz.mix.ameretat or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function nightTime(mob)
    mob:setMobMod(tpz.mobMod.NO_ROAM , 1)
    mob:setLocalVar("ResleepTime", 0)
end

local function dayTime(mob)
    mob:setMobMod(tpz.mobMod.NO_ROAM , 0)
    mob:setLocalVar("ResleepTime", 0)
end

tpz.mix.ameretat.config = function(mob, params)
    if params.sleepHour and type(params.sleepHour) == "number" then
        mob:setLocalVar("[ameretat]sleepHour", params.sleepHour)
    end
    if params.wakeHour and type(params.wakeHour) == "number" then
        mob:setLocalVar("[ameretat]wakeHour", params.wakeHour)
    end
end

g_mixins.families.ameretat = function(mob)
    -- these defaults can be overwritten by using tpz.mix.ameretat.config() in onMobSpawn.  sleepHour must be > wakeHour to function properly.
    mob:addListener("SPAWN", "AMERETAT_SPAWN", function(mob)
        mob:setLocalVar("[ameretat]sleepHour", 20)
        mob:setLocalVar("[ameretat]wakeHour", 5)
        mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    end)

    mob:addListener("ROAM_TICK", "AMERETAT_ROAM_TICK", function(mob)
        local currentHour = VanadielHour()
        local sleepHour = mob:getLocalVar("[ameretat]sleepHour")
        local wakeHour = mob:getLocalVar("[ameretat]wakeHour")

        if (currentHour >= sleepHour or currentHour < mob:getLocalVar("[ameretat]wakeHour")) and not mob:isEngaged() then
            local resleepTime = mob:getLocalVar("ResleepTime")

            if resleepTime ~= 0 and mob:checkDistance(mob:getSpawnPos()) > 25 then
                mob:setLocalVar("ResleepTime", os.time() + 120) -- Reset sleep timer until Ameretat returns home
            elseif resleepTime <= os.time() then -- No timer was set (normal behavior) OR Ameretat has been back home for 2 minutes since disengaged
                nightTime(mob)
            end
        elseif currentHour < sleepHour and currentHour >= mob:getLocalVar("[ameretat]wakeHour") then
            dayTime(mob)
        end
    end)


    mob:addListener("ENGAGE", "AMERETAT_ENGAGE", function(mob, target)
        dayTime(mob)
     end)

     mob:addListener("COMBAT_TICK", "AMERETAT_CTICK", function(mob)
        -- Strong regen if near it's spawn point
        if mob:checkDistance(mob:getSpawnPos()) < 30 then
            utils.AddDynamicMod(mob, tpz.mod.REGEN, 100)
        else
            utils.DelDynamicMod(mob, tpz.mod.REGEN)
        end
    end)

    mob:addListener("DISENGAGE", "AMERETAT_DISENGAGE", function(mob)
        mob:setLocalVar("ResleepTime", os.time() + 120) -- Ameretat go back to sleep exactly 2 minutes after they were engaged.
    end)
end

return g_mixins.families.ameretat

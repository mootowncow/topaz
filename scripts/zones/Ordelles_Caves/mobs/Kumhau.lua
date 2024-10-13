-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Kumhau
-- WKR NM
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
function onMobInitialize(mob)
end

function onMobSpawn(mob)
    mob:setDamage(90)
    mob:SetMobSkillAttack(6140)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
end

function onMobEngaged(mob, target)
    mob:setWeather(tpz.weather.BLIZZARDS)
end

function onMobFight(mob, target)
    local weather = mob:getWeather()

    if (weather ~= tpz.weather.BLIZZARDS) then
        mob:setWeather(tpz.weather.BLIZZARDS)
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDisengage(mob)
    mob:setWeather(tpz.weather.NONE)
end

function onMobDeath(mob, player, isKiller, noKiller)
    mob:setWeather(tpz.weather.NONE)
    player:addTitle(tpz.title.KUMHAU_ROASTER)
end

function onMobDespawn(mob)
end
-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Colkhab
-- WKR NM
-----------------------------------
local ID = require("scripts/zones/Ifrits_Cauldron/IDs")
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
function onMobInitialize(mob)
end

function onMobSpawn(mob)
    mob:setDamage(90)
    mob:SetMobSkillAttack(6146)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
end

function onMobEngaged(mob, target)
    mob:setWeather(tpz.weather.HEAT_WAVE)
end

function onMobFight(mob, target)
    local weather = mob:getWeather()

    if (weather ~= tpz.weather.HEAT_WAVE) then
        mob:setWeather(tpz.weather.HEAT_WAVE)
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
    player:addTitle(tpz.title.ACHUKA_GLACIATOR)
end

function onMobDespawn(mob)
end
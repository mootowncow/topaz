-----------------------------------
-- Area: Jugner Forest [S]
--  Mob: Gnoletrap
-- Note: JP camp
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest_[S]/IDs")
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.CAPACITY_BONUS, 200)
end

function onMobSpawn(mob)
    -- 5% chance to fulll restore MP/HP or party members at 1% HP(basically death)
    if (math.random(100) <= 5) then
        mob:setLocalVar("restoreProc", 1)
    end

    -- Regen + Regain during Water weather
	if mob:getWeather() == tpz.weather.RAIN or mob:getWeather() == tpz.weather.SQUALL then
		mob:setMod(tpz.mod.REGEN, 30)
        mob:setMod(tpz.mod.REGAIN, 50)
	else
		mob:setMod(tpz.mod.REGEN, 0)
        mob:setMod(tpz.mod.REGAIN, 0)
	end

    SetJPMobStats(mob)
end

function onMobFight(mob, target)
    local restoreProc = mob:getLocalVar("restoreProc")

    if (restoreProc == 1) then -- Var randomed on spawn
        mob:setUnkillable(true) -- Removed after restoring players HP or MP
    end

    if (mob:getHPP() < 2) and (restoreProc == 1) then
        if (mob:checkDistance(target) <= 30) then
            mob:useMobAbility(math.random(1124, 1125)) -- Heal MP or HP
        end
    end

    -- Regen + Regain during Water weather
	if mob:getWeather() == tpz.weather.RAIN or mob:getWeather() == tpz.weather.SQUALL then
		mob:setMod(tpz.mod.REGEN, 30)
        mob:setMod(tpz.mod.REGAIN, 50)
	else
		mob:setMod(tpz.mod.REGEN, 0)
        mob:setMod(tpz.mod.REGAIN, 0)
	end
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
end

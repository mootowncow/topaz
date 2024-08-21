-----------------------------------
-- Area: The Celestial Nexus
--  Mob: Eald'narche (Phase 2)
-- Zilart Mission 16 BCNM Fight
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobInitialize(mob)
    -- 60% fast cast, -75% physical damage taken, 10tp/tick regain, no standback
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.EVA, 100)
    mob:setMod(tpz.mod.UFASTCAST, 60)
    mob:setMod(tpz.mod.UDMGPHYS, -75)
    mob:setMod(tpz.mod.UDMGRANGE, -75)
    mob:setMod(tpz.mod.UDMGMAGIC, -95)
    mob:setMod(tpz.mod.UDMGBREATH, -95)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 60)
    if GetMobByID(mob:getID() - 1):isDead() and GetMobByID(mob:getID() - 2):isDead() then
        mob:getBattlefield():setLocalVar("phaseChange", 0)
    end
end

function onMobEngaged(mob, target)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 100)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 100)
end

function onMobFight(mob, target)
	mob:setMod(tpz.mod.REGAIN, 100)
    local battletime = mob:getBattleTime()
    local WarpTime = mob:getLocalVar("WarpTime")
    if WarpTime == 0 then
        mob:setLocalVar("WarpTime", math.random(15, 20))
	elseif battletime >= WarpTime then
        -- Keep TP when warping out
    	local CurrentTP = mob:getTP()
	    mob:setLocalVar("TP", CurrentTP)
		mob:useMobAbility(989) -- Warp out
		mob:setLocalVar("WarpTime", battletime + math.random(15, 20))
	end
end


function onMobDeath(mob, player, isKiller, noKiller)
end

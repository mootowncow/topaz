-----------------------------------
-- Area: Emperial Paradox
--  Mob: Eald'narche
-- Apocalypse Nigh Final Fight
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    mob:addMod(tpz.mod.EVA, 100)
    mob:setMod(tpz.mod.UFASTCAST, 60)
    mob:setMod(tpz.mod.UDMGPHYS, -75)
    mob:setMod(tpz.mod.UDMGRANGE, -75)
    mob:setMod(tpz.mod.UDMGMAGIC, -95)
    mob:setMod(tpz.mod.UDMGBREATH, -95)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 60)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 25)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 25)
end

function onMobFight(mob, target)
	mob:setMod(tpz.mod.REGAIN, 100)
    local battletime = mob:getBattleTime()
    local WarpTime = mob:getLocalVar("WarpTime")
    if WarpTime == 0 then
        mob:setLocalVar("WarpTime", math.random(15, 20))
	elseif battletime >= WarpTime then
		mob:useMobAbility(989) -- Warp out
		mob:setLocalVar("WarpTime", battletime + math.random(15, 20))
	end
end

function onMobDeath(mob, player, isKiller, noKiller)
end

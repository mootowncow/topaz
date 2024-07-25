-----------------------------------
-- Area: Emperial Paradox
--  Mob: Eald'narche
-- Apocalypse Nigh Final Fight
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    mob:addMod(tpz.mod.ATTP, 50)
    mob:addMod(tpz.mod.DEFP, 50) 
    mob:addMod(tpz.mod.ACC, 50) 
    mob:addMod(tpz.mod.EVA, 70)
    mob:setMod(tpz.mod.UDMGMAGIC, -95)
    mob:setMod(tpz.mod.REFRESH, 400)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobInitialize(mob)
    mob:setMod(tpz.mod.MDEF, 50);
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

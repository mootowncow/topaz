------------------------------
-- Area: Mamook
--   NM: Hundredfaced Hapool Ja Clone
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    mob:setDamage(20)
    mob:setMod(tpz.mod.REGAIN, 250)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:SetMagicCastingEnabled(false)
    mob:setLocalVar("MijinTime", 0)
end

function onMobFight(mob, target)
	local MijinTime = mob:getLocalVar("MijinTime")
	local BattleTime = mob:getBattleTime()

	if MijinTime == 0 then
		mob:setLocalVar("MijinTime", BattleTime + math.random(30, 60))
	elseif BattleTime >= MijinTime then
		mob:useMobAbility(731) -- Mijin Gakure
		mob:setLocalVar("MijinTime", BattleTime + math.random(30, 60))
	end
end

function onMobDeath(mob, player, isKiller, noKiller)
end

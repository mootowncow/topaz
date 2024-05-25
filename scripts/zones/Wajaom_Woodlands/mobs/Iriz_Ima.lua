-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Iriz Ima
-----------------------------------
mixins = {
    require("scripts/mixins/rage"),
    require("scripts/mixins/families/marid")
}
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setDamage(125)
    mob:setMod(tpz.mod.DEF, 500)
    mob:setMod(tpz.mod.EVA, 300)
    mob:setMod(tpz.mod.MOVE, -25)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 6500) -- 7k Gil
    mob:setMobMod(tpz.mobMod.GIL_MAX, 7300) 
    mob:setMobMod(tpz.mobMod.GIL_BONUS, 0) 
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setLocalVar("BreakChance", 5)
end


function onMobFight(mob, target)
end

function onMobWeaponSkillPrepare(mob, target)
    return 1703 -- Always keeps Barrier Tusk up
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addCurrency("zeni_point", 200)
	if mob:AnimationSub() >= 1 then
		if math.random(1,100) <= 10 then 
			player:addTreasure(2147, mob) --Marid Tusk
		end
		if mob:AnimationSub() == 2 then
			if math.random(1,100) <= 24 then 
				player:addTreasure(2147, mob) --Marid Tusk
			end
		end
	end

	if isKiller  then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
	if isKiller and math.random(1,100) <= 15 then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
end

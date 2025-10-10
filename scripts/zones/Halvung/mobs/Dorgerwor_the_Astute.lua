-----------------------------------
-- Area: Halvung
--   NM: Dorgerwor the Astute
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobSpawn(mob)
    mob:setDamage(120)
	mob:setMod(tpz.mod.DEF, 10000)
    mob:setMod(tpz.mod.VIT, 200)
    mob:setMod(tpz.mod.REGAIN, 250)
    mob:setMod(tpz.mod.REFRESH, 300)
    mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 0) -- Does not use Zarraqa
    mob:setAggressive(0)
end

function onMobFight(mob, target)
     tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.EES_TROLL, cooldown = 60, hpp = 90},
        },
     })
end

function onMobDeath(mob, player, isKiller, noKiller)
	if isKiller  then 
		player:addTreasure(5736, mob)--Linen Coin Purse
	end
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(5736, mob)--Linen Coin Purse
	end
	if isKiller and math.random(1,100) <= 15 then 
		player:addTreasure(5736, mob)--Linen Coin Purse
	end
end

-----------------------------------
-- Area: Halvung
--  Mob: Farlarder the Shrewd
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    mob:setDamage(30)
	mob:setMod(tpz.mod.DEF, 10000)
    mob:setMod(tpz.mod.VIT, 200)
    mob:setMod(tpz.mod.REGAIN, 250)
    mob:setMod(tpz.mod.REFRESH, 300)
    mob:setAggressive(0)

    tpz.mix.jobSpecial.config(mob, {
    specials =
    {
        {id = tpz.jsa.HUNDRED_FISTS, cooldown = 300, hpp = 90},
    },
    })

    mob:addListener("ATTACK","FARLARDER_ATTACK", function(mob, target)
        if mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) then
            mob:resetEnmity(target)
        end
    end)
end

function onMobFight(mob, target)
end

function onAdditionalEffect(mob, target, damage)
    if mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PETRIFY, {chance = 24, duration = 8})
    else
        return 0
    end
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

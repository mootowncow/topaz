-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Gerwitz's Scythe
-- Involved In Quest: Blade of Evil
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/quests")
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:addImmunity(tpz.immunity.SLEEP)
    mob:addImmunity(tpz.immunity.PETRIFY)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
	local RNG = math.random(1, 2)
	if RNG == 1 then
		return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.TP_DRAIN, {chance = 25, power = math.random(100, 150)})
	elseif RNG == 2 then
		return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.MP_DRAIN, {chance = 25, power = math.random(100, 150)})
	end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if player:getQuestStatus(BASTOK, tpz.quest.id.bastok.BLADE_OF_EVIL) == QUEST_ACCEPTED then
        player:setCharVar("bladeOfEvilCS", 1)
    end
end

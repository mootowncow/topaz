-----------------------------------
-- Area: Balga's Dais
--  Mob: Nenaunir's Wife
-- BCNM: Harem Scarem
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 0)
end

function onMobEngaged(mob, target)
    mob:useMobAbility(tpz.mob.skills.BERSERK_DHALMEL)
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

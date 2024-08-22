-----------------------------------
-- Area: Balga's Dais
--  Mob: Nenaunir
-- BCNM: Harem Scarem
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 0)
    mob:SetAutoAttackEnabled(false)
end

function onMobEngaged(mob, target)
    mob:useMobAbility(tpz.mob.skills.WHISTLE)
end

function onMobFight(mob, target)
end

function onMobWeaponSkillPrepare(mob, target)
end


function onMobDeath(mob, player, isKiller, noKiller)
end

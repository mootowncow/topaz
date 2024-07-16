-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Omega
-- RAID NM
-----------------------------------
require("scripts/globals/raid")
-----------------------------------
function onMobSpawn(mob)
    tpz.raid.onMobSpawn(mob)
end

function onMobFight(mob, target)
    tpz.raid.onMobFight(mob)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN)
end

function onSpellPrecast(mob, spell)
end

function onMobDespawn(mob)
    tpz.raid.onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.raid.onMobDeath(mob)
end
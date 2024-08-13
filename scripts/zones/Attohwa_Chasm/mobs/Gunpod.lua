-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Gunpod (Summoned by Omega)
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
end

function onSpellPrecast(mob, spell)
end

function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
end
-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Trion
-- RAID Ally
-----------------------------------
require("scripts/globals/raid")
-----------------------------------
function onMobSpawn(mob)
    tpz.raid.onNpcSpawn(mob)
end

function onMobRoam(mob)
    tpz.raid.onNpcRoam(mob)
end

function onMobFight(mob, target)
    tpz.raid.onNpcFight(mob, target)
end

function onSpellPrecast(mob, spell)
    tpz.raid.onSpellPrecast(mob, spell)
end

function onMobDespawn(mob)
    tpz.raid.onNpcDespawn(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.raid.onNpcDeath(mob, target)
end

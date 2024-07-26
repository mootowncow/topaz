-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Monberaux
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

function onMobDeath(mob, player, isKiller, noKiller)
end

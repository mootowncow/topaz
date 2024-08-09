-----------------------------------
-- Area: Qufim Island
--  Mob: Ark Angels Wyvern
-- RAID NM (Pet)
-----------------------------------
require("scripts/globals/raid")
-----------------------------------
function onMobSpawn(mob)
    printf("Ark angels wyvern spawned")
end

function onMobEngaged(mob, target)
end

function onMobFight(mob, target)
    tpz.raid.onMobFight(mob)
end

function onMobWeaponSkill(target, mob, skill)
end

function onSpellPrecast(mob, spell)
    tpz.raid.onSpellPrecast(mob, spell)
end

function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
end
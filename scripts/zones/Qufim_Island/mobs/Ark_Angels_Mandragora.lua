-----------------------------------
-- Area: Qufim Island
--  Mob: Ark Angels Mandragora
-- RAID NM (Pet)
-----------------------------------
require("scripts/globals/raid")
-----------------------------------
function onMobSpawn(mob)
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
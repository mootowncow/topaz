-----------------------------------
-- Area: Qufim Island
--  Mob: Ark Angel HM
-- RAID NM
-----------------------------------
require("scripts/globals/raid")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobSpawn(mob)
    tpz.raid.onMobSpawn(mob)
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
    tpz.raid.onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.raid.onMobDeath(mob)
end
-----------------------------------
-- Area: Bibiki Bay
--  Mob: Adelheid
-- RAID Ally
-----------------------------------
require("scripts/globals/raid")
-----------------------------------
function onMobSpawn(mob)
    tpz.raid.onNpcSpawn(mob)
end

function onMobRoam(mob)
    local entities = mob:getNearbyMobs(12)
    for i, entity in pairs(entities) do
        entity:updateEnmity(mob)
    end
end

function onMobFight(mob, target)
    tpz.raid.onNpcFight(mob, target)
end

function onSpellPrecast(mob, spell)
    tpz.raid.onSpellPrecast(mob, spell)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

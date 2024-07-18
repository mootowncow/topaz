-----------------------------------
-- Area: Lufaise Meadows
--  Mob: Bahamut
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

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1551 then --Giga Flare
        mob:setLocalVar("MegaFlare", 1)   
    end
end

function onSpellPrecast(mob, spell)
end

function onMobDespawn(mob)
    tpz.raid.onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.raid.onMobDeath(mob)
end
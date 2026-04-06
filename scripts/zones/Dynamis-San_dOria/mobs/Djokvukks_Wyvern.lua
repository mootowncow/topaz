-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Spellspear Djokvukk Wyvern
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 1)
end

function onMobEngaged(mob, target)
end

function onMobFight(mob, target)
end

function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

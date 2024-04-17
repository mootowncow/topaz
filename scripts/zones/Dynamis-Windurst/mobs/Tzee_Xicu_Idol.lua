-----------------------------------
-- Area: Dynamis - Windurst
--  Mob: Tzee Xicu Idol
-- Note: Mega Boss
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.REFRESH, 300)
    mob:delImmunity(tpz.immunity.STUN)
    mob:delImmunity(tpz.immunity.PARALYZE)
    mob:delImmunity(tpz.immunity.BLIND)
    mob:delImmunity(tpz.immunity.POISON)
end

function onMobFight(mob, target)
    TickConfrontation(mob, target)
end

function onMobEngaged(mob, target)
end

function onMobDespawn(mob)
    OnBattleEndConfrontation(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    dynamis.megaBossOnDeath(mob, player, isKiller)
    OnBattleEndConfrontation(mob)
end

------------------------------
-- Area: Crawlers Nest [S]
--   NM: Abatwa
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    mob:setDamage(140)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 100)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 514)
end

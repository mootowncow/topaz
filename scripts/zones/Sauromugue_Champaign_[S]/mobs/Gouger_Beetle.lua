-----------------------------------
-- Area: Sauromugue_Champaign [S]
--  Mob: Gouger Beetle
-- Note: JP camp
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DMGMAGIC, 25)
    mob:setMobMod(tpz.mobMod.CAPACITY_BONUS, 100)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

-----------------------------------
-- West Sarutabaruta [S]
--  Mob: Hispid Rarab
-- Note: JP camp
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.CAPACITY_BONUS, 100)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

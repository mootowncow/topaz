-----------------------------------
-- Area: Davoi
--   NM: Dirtyhanded Gochakzuk
-- Involved in mission Vain (Windurst 8-1)
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.UFASTCAST, 70)
    mob:setMod(tpz.mod.DMGMAGIC, -50)
    mob:setMod(tpz.mod.EEM_SILENCE, 30)
    mob:setMod(tpz.mod.EEM_DARK_SLEEP, 25)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

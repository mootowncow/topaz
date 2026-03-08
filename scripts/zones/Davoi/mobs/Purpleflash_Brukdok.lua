-----------------------------------
-- Area: Davoi
--   NM: Purpleflash Brukdok
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.EEM_SILENCE, 30)
    mob:setMod(tpz.mod.EEM_DARK_SLEEP, 25)
    mob:setMod(tpz.mod.EEM_LIGHT_SLEEP, 25)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
end
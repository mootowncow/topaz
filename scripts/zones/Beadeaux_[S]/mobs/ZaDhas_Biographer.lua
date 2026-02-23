-----------------------------------
-- Area: Beadeaux [S] (92)
--   ZaDhas Biographer
-- BCNM: The Buried God
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.MATT, 50)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
end

function onMobEngaged(mob, target)
    -- Force adds to link when aggrod
    for v = 17154387, 17154391 do
        GetMobByID(v):updateEnmity(target)
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

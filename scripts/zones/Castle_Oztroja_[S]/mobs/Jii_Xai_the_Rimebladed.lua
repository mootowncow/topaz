-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Soo Luma The Ascended
-- BCNM: Plucking Wings
-- SCH/SCH
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja_[S]/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE , 20)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 20)
end

function onMobEngaged(mob, target)
end

function onMobFight(mob, target)
    local sooLuma1 = GetMobByID(17183047)

    -- Shares target with Soo Luma The Ascended
    if sooLuma1:isAlive() then
        mob:setMobMod(tpz.mobMod.SHARE_TARGET, sooLuma1:getShortID())
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

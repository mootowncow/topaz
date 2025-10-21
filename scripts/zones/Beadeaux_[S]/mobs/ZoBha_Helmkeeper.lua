-----------------------------------
-- Area: Beadeaux [S]
--   NM: Za'Dha Adamantking
-- BCNM: Cracking Shells
-- RNG/RNG
-----------------------------------
local ID = require("scripts/zones/Beadeaux_[S]/IDs")
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
    local zaDhaAdamantKing = GetMobByID(17154372)

    -- Shares target with Za'Dha Adamantking
    if zaDhaAdamantKing:isAlive() then
        mob:setMobMod(tpz.mobMod.SHARE_TARGET, zaDhaAdamantKing:getShortID())
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

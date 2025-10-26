-----------------------------------
-- Area: La Vaule [S]
--   NM: Darkheir Grradhod
-- BCNM: Plucking Wings
-- SAM/SAM
-----------------------------------
local ID = require("scripts/zones/La_Vaule_[S]/IDs")
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
    local darkheirGrradhood = GetMobByID(17125666)

    -- Shares target with Darkheir Grradhod
    if darkheirGrradhood:isAlive() then
        mob:setMobMod(tpz.mobMod.SHARE_TARGET, darkheirGrradhood:getShortID())
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local darkHeir = GetMobByID(mob:getID() - 4)
    darkHeir:setLocalVar("Add_" .. mob:getID(), os.time())
end


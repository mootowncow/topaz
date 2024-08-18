-----------------------------------
-- Area: La Vaule [S]
--   NM: Bhogbigg''s Grenade
-- Runs towards a random target and uses a TP move then despawns.
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    mob:addTP(3000)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:SetAutoAttackEnabled(false)
    mob:setUnkillable(true)
end

function onMobFight(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
    mob:setUnkillable(false)
    mob:setHP(0)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

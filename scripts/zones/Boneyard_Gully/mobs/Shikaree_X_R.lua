-----------------------------------
-- Area: Boneyard_Gully
-- Name: Shikaree X
-- ENM: Requiem of Sin  
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Boneyard_Gully/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    SetGenericNMStats(mob)
    mob:addMod(tpz.mod.DEFP, 50)
    mob:setMod(tpz.mod.EEM_DARK_SLEEP, 25)
    mob:setMobMod(tpz.mobMod.DUAL_WIELD, 1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobSpawn(mob)
    mob:setLocalVar("chat", ID.text.DEFEATED)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("distracted", 0)
    mob:setMod(tpz.mod.REGAIN, 175)
	mob:setLocalVar("regain", 175)
end

function onMobFight(mob, target)
    local wyvern = GetMobByID(mob:getID() +2)
    if wyvern:isDead() then
        SpawnMob(mob:getID() + 2)
        mob:useMobAbility(1017) -- Call Beast
    end
end

function onMobWeaponSkill(target, mob, skill)
    mob:showText(mob, ID.text.MY_TURN_MY_TURN)
end

function onMobDeath(mob, player, isKiller, noKiller)
    mob:showText(mob, mob:getLocalVar("chat"))
end
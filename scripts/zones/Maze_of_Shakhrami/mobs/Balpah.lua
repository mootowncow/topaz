-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Balpah
-- Note: BST mythic weapon fight
-- !spawnmob 17584515
-- Mythic weapon fight
-----------------------------------
local ID = require("scripts/zones/Maze_of_Shakhrami/IDs")
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/magic")
require("scripts/globals/utils")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
	mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    SpawnMob(mob:getID()+1)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.FAMILIAR, cooldown = 60, hpp = 50},
        },
    })
end

function onMobEngaged(mob, target)
    local pet = GetMobByID(mob:getID() +1)
    pet:updateEnmity(mob:getTarget())
    mob:setLocalVar("rewardCD", 0)
end

function onMobFight(mob, target)
    local rewardCD = mob:getLocalVar("rewardCD")
    local pet = GetMobByID(mob:getID() + 1)
	if (pet ~= nil) then
        if pet:getHPP() <= 50 and (os.time() >= rewardCD) then
            mob:useMobAbility(2005) -- Reward
            mob:setLocalVar("rewardCD", os.time() + 30)
        end
	end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnDeathMessage(mob, player, isKiller, noKiller, "The beasts are calmer now.", 0, "Balpah")
    DespawnMob(mob:getID()+1)
end

function onMobDespawn(mob)
    DespawnMob(mob:getID()+1)
end
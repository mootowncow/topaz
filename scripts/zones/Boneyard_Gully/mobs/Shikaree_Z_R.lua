-----------------------------------
-- Area: Boneyard_Gully
-- Name: Shikaree Z
-- ENM: Requiem of Sin  
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Boneyard_Gully/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

-- TODO: They skillchain with each other

function onMobInitialize(mob)
    SetGenericNMStats(mob)
    mob:addMod(tpz.mod.DEFP, 50) 
    mob:setMod(tpz.mod.EEM_DARK_SLEEP, 30)
end

function onMobSpawn(mob)
    mob:setLocalVar("regain", 150)
    mob:setLocalVar("chat", ID.text.HOW_IS_THIS_POSSIBLE)
end

function onMobEngaged(mob, target)
    mob:showText(mob, ID.text.WE_ARE_TRACKERS)
    mob:setLocalVar("distracted", 0)
    mob:setMod(tpz.mod.REGAIN, 150)
end

function onMobFight(mob, target)
    local wyvern = GetMobByID(mob:getID() +3)
    if wyvern:isDead() then
        SpawnMob(mob:getID() + 3)
        mob:useMobAbility(732) -- Call Wyvern
    end

    -- Handle Healing Breath
    mob:addListener("MAGIC_STATE_EXIT", "SHIKAREE_Z_REQ", function(mob, spell)
        local wyvern = GetMobByID(mob:getID() +3)
        if (mob:getLocalVar("forceBreath") == 0) then
            mob:setLocalVar("forceBreath", 1)
            wyvern:useMobAbility(896) -- Healing Breath III
        end
    end)
end

function onMobWeaponSkill(target, mob, skill)
    mob:showText(mob, ID.text.TIME_TO_DIE)
end

function onMobDeath(mob, player, isKiller, noKiller)
    mob:showText(mob, mob:getLocalVar("chat"))
end
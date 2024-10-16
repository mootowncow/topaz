-----------------------------------
-- Area: Boneyard_Gully
-- Name: Shikaree Z
-----------------------------------
local ID = require("scripts/zones/Boneyard_Gully/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

-- TODO: They skillchain with each other

function onMobInitialize(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.EEM_DARK_SLEEP, 25)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
end

function onMobSpawn(mob)
    mob:setLocalVar("regain", 150)
    mob:setLocalVar("chat", ID.text.HOW_IS_THIS_POSSIBLE)
end

function onMobEngaged(mob, target)
    mob:showText(mob, ID.text.WE_ARE_TRACKERS)
    SpawnMob(mob:getID() + 3)
    mob:setLocalVar("distracted", 0)
    mob:setMod(tpz.mod.REGAIN, 150)
end

function onMobFight(mob, target)
    -- Handle Healing Breath
    mob:addListener("MAGIC_STATE_EXIT", "SHIKAREE_Z", function(mob, spell)
        local wyvern = GetMobByID(mob:getID() +3)
        if mob:getHPP() <= 50 then
            wyvern:useMobAbility(895) -- Healing Breath II
        end
    end)
end

function onMobWeaponSkill(target, mob, skill)
    mob:showText(mob, ID.text.TIME_TO_DIE)
end

function onMobDeath(mob, player, isKiller, noKiller)
    mob:showText(mob, mob:getLocalVar("chat"))
    DespawnMob(mob:getID()+3)
end
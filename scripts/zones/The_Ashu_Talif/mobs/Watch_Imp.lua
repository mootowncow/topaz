-----------------------------------
-- Area: The Ashu Talif
--   NM: Watch Imp
-----------------------------------
require("scripts/globals/status")
mixins = {require("scripts/mixins/families/imp")}
-----------------------------------

function onMobInitialize(mob)
	mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMod(tpz.mod.REFRESH, 40)
end

function onMobSpawn(mob)
    mob:setDamage(20)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 15)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
end

function onMobEngaged(mob, target)
    local instance = mob:getInstance()
    local instanceID = instance:getID()

    for adds = 17022986, 17023008 do
        local selectedAdd = GetMobByID(adds, instance)
        if selectedAdd then
            selectedAdd:updateEnmity(target)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end
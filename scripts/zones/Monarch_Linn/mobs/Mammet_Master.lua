-----------------------------------
-- Area: Monarch Linn
--  Mob: Mammet Master
-- ENM: Uninvited Guests
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
mixins = { require("scripts/mixins/families/mammet") }
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 15)
    mob:setMod(tpz.mod.REFRESH, 40)
	mob:addMod(tpz.mod.MDEF, 12) 
end

function onMobSpawn(mob)
    mob:SetMagicCastingEnabled(false)
    mob:addMod(tpz.mod.DEFP, 20)
end

function onMobEngaged(mob, target)
    SpawnMob(mob:getID()+1):updateEnmity(mob:getTarget())
end

function onMobDeath(mob, player, isKiller, noKiller)
end

-----------------------------------
-- Area: Monarch Linn
--  Mob: Mammet-800
-- ENM: Uninvited Guests
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
mixins = { require("scripts/mixins/families/mammet") }
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 15)
end

function onMobSpawn(mob)
    mob:SetMagicCastingEnabled(false)
    mob:addMod(tpz.mod.ACC, 25)
    mob:addMod(tpz.mod.DEFP, 25)
    mob:addMod(tpz.mod.MDEF, 24)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 22)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 22)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

-----------------------------------
-- Area: Boneyard Gully
--  Mob: Swift Hunter
-----------------------------------
require("scripts/globals/status")
mixins = {require("scripts/mixins/families/antlion_ambush")}
local ID = require("scripts/zones/Boneyard_Gully/IDs")
-----------------------------------

function onMobSpawn(mob)
    mob:setDamage(150)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 25)
    -- Aggros via ambush, not superlinking
    mob:setMobMod(tpz.mobMod.SUPERLINK, 0)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobEngaged(mob, target)
    mob:hideName(false)
    mob:untargetable(false)
    mob:AnimationSub(1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    for _, char in pairs(mob:getBattlefield():getPlayers()) do
        char:messageSpecial(ID.text.SMALL_ANTLION)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end

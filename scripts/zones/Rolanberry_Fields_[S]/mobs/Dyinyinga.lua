------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Dyinyinga
------------------------------
require("scripts/globals/hunts")
local ID = require("scripts/zones/Rolanberry_Fields_[S]/IDs")
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/world")
require("scripts/globals/magic")
require("scripts/globals/utils")
mixins = { require("scripts/mixins/families/slug") }
------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.DEFP, 20) 
    mob:addMod(tpz.mod.ATTP, 10)
    mob:addMod(tpz.mod.ACC, 30) 
    mob:addMod(tpz.mod.EVA, 30)
	mob:setMod(tpz.mod.MOVE, 20)
	mob:setMod(tpz.mod.UDMGMAGIC, 25)
    mob:setLocalVar("AuraTick", 0)
    mob:setLocalVar("RainRegen", 100)
end

function onMobFight(mob, target)
	local AuraTick = mob:getLocalVar("AuraTick")
	local BattleTime = mob:getBattleTime()

    -- "Stick" to target
    if mob:checkDistance(target) > 1 then
        local targetPos = target:getPos()
        local radians = (256 - targetPos.rot) * (math.pi / 128)
        mob:pathTo(targetPos.x + math.cos(radians), targetPos.y, targetPos.z + math.sin(radians))
    end
    -- Debuff nearby targets
    if BattleTime >= AuraTick then
        mob:setLocalVar("AuraTick", BattleTime + 3)
        local nearbyPlayers = mob:getPlayersInRange(8)
        if nearbyPlayers == nil then return end
        for _,v in ipairs(nearbyPlayers) do
            v:delStatusEffectSilent(tpz.effect.AMNESIA)
            v:addStatusEffectEx(tpz.effect.AMNESIA, tpz.effect.AMNESIA, 1, 0, 3)
            v:delStatusEffectSilent(tpz.effect.MUTE)
            v:addStatusEffectEx(tpz.effect.MUTE, tpz.effect.MUTE, 1, 0, 3)
        end
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SLOW, {power = 25})
end


function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 511)
end

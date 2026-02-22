-----------------------------------
-- Area: Rolanberry Fields [S]
--   ANNM
--   NM: Gummy Guillaume
--  !addkeyitem BLUE_LABELED_CRATE
-----------------------------------
require("scripts/globals/annm")
require("scripts/globals/status")
mixins = { require("scripts/mixins/families/slug") }
-----------------------------------
function onMobSpawn(mob)
    mob:setLocalVar("AuraTick", 0)
    tpz.annm.NMMods(mob)
    mob:SetAutoAttackEnabled(false)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 25)
    mob:setMod(tpz.mod.REGAIN, 250)
    mob:setMod(tpz.mod.MOVE, -75)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("AuraTick", 15)
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
            v:delStatusEffectSilent(tpz.effect.GEO_POISON)
            v:addStatusEffectEx(tpz.effect.GEO_POISON, tpz.effect.GEO_POISON, 100, 3, 3)
        end
    end
    tpz.annm.PetShield(mob, 17150323, 17150328)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.annm.SpawnChest(mob, player, isKiller)
end

function onMobDespawn(mob)
end

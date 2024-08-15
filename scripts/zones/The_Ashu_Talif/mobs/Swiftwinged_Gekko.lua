-----------------------------------
-- Area: The Ashu Talif
--   NM: Swiftwinged Gekko
-----------------------------------
mixins = {require("scripts/mixins/families/imp")}
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.NO_REST, 1)
end

function onMobSpawn(mob)
	mob:setDamage(125)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.ACC, 15) 
    mob:addMod(tpz.mod.EVA, 15)
    mob:setMod(tpz.mod.REFRESH, 40)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 50)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 50)
end


function onMobFight(mob, target)
    local mobPos = mob:getPos()

    if mobPos.x == 5.5 then
        mob:hideName(true)
        mob:untargetable(true)
        mob:setStatus(tpz.status.INVISIBLE)
        mob:disengage()
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:setPos(0.000, -22.500, 18.000)

        local instance = mob:getInstance()
        instance:setProgress(instance:getProgress() + 1)
    end
end

function onCastStarting(mob, spell)
    mob:SetMagicCastingEnabled(false)
    mob:pathTo(5.500, -31.000, 47.000)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

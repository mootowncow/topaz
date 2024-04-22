-----------------------------------
-- Area: Valley of Sorrows
--  HNM: Aspidochelone
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
function onMobSpawn(mob)
    mob:addMod(tpz.mod.ATTP, 33)
    mob:addMod(tpz.mod.DEFP, 100)
	mob:setDamage(130)
    mob:addMod(tpz.mod.EVA, 35)
    mob:setMod(tpz.mod.REGEN, 0)
    mob:setMod(tpz.mod.UDMGPHYS, 0)
    mob:setMod(tpz.mod.UDMGRANGE, 0)
    mob:AnimationSub(0)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 20000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 20000) 
    mob:setMobMod(tpz.mobMod.GIL_BONUS, 0)
    if LandKingSystem_NQ > 0 or LandKingSystem_HQ > 0 then
        GetNPCByID(ID.npc.ADAMANTOISE_QM):setStatus(tpz.status.DISAPPEAR)
    end
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

function onMobRoam(mob)
    mob:AnimationSub(0)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1) -- Says only add as spawn mod?
end

function onMobFight(mob, target)
    local hitTrigger = mob:getLocalVar("TriggerHit")
    local Dmg = mob:getLocalVar("Dmg")
    local Shell = mob:getLocalVar("Shell")

    if mob:getHPP() <= 75 and hitTrigger == 0 and Shell == 0 then
        mob:setLocalVar("TriggerHit", 1)
        mob:setLocalVar("Shell", 1)
    end
    if mob:getHPP() <= 50 and hitTrigger == 1 and Shell == 0  then
        mob:setLocalVar("TriggerHit", 2)
        mob:setLocalVar("Shell", 1)
    end
    if mob:getHPP() <= 25 and hitTrigger == 2 and Shell == 0  then
        mob:setLocalVar("TriggerHit", 3)
        mob:setLocalVar("Shell", 1)
    end

    if Shell == 1  then
        mob:removeAllNegativeEffects()
        mob:setMod(tpz.mod.REGEN, 300)
        mob:setMod(tpz.mod.UDMGPHYS, -95)
        mob:setMod(tpz.mod.UDMGRANGE, -95)
        mob:AnimationSub(1)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:setLocalVar("Shell", 2)
        mob:addListener("TAKE_DAMAGE", "URAGNITE_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if amount >= 1500  then
            mob:removeListener("URAGNITE_TAKE_DAMAGE")
        mob:setMod(tpz.mod.REGEN, 0)
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
        mob:AnimationSub(0)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
        mob:setLocalVar("Shell", 0)
        end
    end)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.ASPIDOCHELONE_SINKER)
end

function onMobDespawn(mob)
    -- Set Aspidochelone's Window Open Time
    if LandKingSystem_HQ ~= 1 then
        local wait = 72 * 3600
        SetServerVariable("[POP]Aspidochelone", os.time() + wait) -- 3 days
        if LandKingSystem_HQ == 0 then -- Is time spawn only
            DisallowRespawn(mob:getID(), true)
        end
    end

    -- Set Adamantoise's spawnpoint and respawn time (21-24 hours)
    if LandKingSystem_NQ ~= 1 then
        SetServerVariable("[PH]Aspidochelone", 0)
        DisallowRespawn(ID.mob.ADAMANTOISE, false)
        UpdateNMSpawnPoint(ID.mob.ADAMANTOISE)
        GetMobByID(ID.mob.ADAMANTOISE):setRespawnTime(36000 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
    end
end

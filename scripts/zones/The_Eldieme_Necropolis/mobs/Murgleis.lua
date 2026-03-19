------------------------------
-- Area: The Eldieme Necropolis
--   Murgleis
--  !additem 16547
-- Mythic weapon fight
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")
require("scripts/globals/mobs")
require("scripts/globals/status")
------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
    mob:addMod(tpz.mod.DEFP, 10) 
    mob:addMod(tpz.mod.ATTP, 10)
	mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:SetMagicCastingEnabled(false)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
end

function onMobFight(mob, target)
    local hitTrigger = mob:getLocalVar("TriggerHit")

    if mob:getHPP() <= 90 and hitTrigger == 0 then
        MessageGroup(mob, target, "You cannot handle my power!",0,"Murgleis")
        mob:SetMagicCastingEnabled(true)
        mob:setDamage(50)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
        mob:setMod(tpz.mod.ATT, 200)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 0)
        mob:setMod(tpz.mod.UFASTCAST, 50)
        mob:setMod(tpz.mod.MATT, 255)
        mob:setLocalVar("TriggerHit", 1)
    end
    if mob:getHPP() <= 80 and hitTrigger == 1 then
        mob:setLocalVar("RNGelement", math.random(1,8))
        MessageGroup(mob, target, "My barrier cannot be destroyed by the likes of you!",0,"Murgleis")
        mob:useMobAbility(624) -- 2 hour "cloud" animation
        mob:setMod(tpz.mod.REGEN, 100)
        mob:addStatusEffect(tpz.effect.BLAZE_SPIKES, 200, 0, 3600)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:setLocalVar("TriggerHit", 2)
    end
    if mob:getHPP() <= 70 and hitTrigger == 2 then
        MessageGroup(mob, target, "Give up already, you're too weak.",0,"Murgleis")
        mob:SetMagicCastingEnabled(false)
        mob:setDamage(200)
        mob:setMod(tpz.mod.MATT, 0)
        mob:setMod(tpz.mod.ATT, 400)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
        mob:setLocalVar("TriggerHit", 3)
    end
    if mob:getHPP() <= 60 and hitTrigger == 3 then
        mob:SetMagicCastingEnabled(true)
        MessageGroup(mob, target, "You cannot handle my power!",0,"Murgleis")
        mob:setDamage(50)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
        mob:setMod(tpz.mod.ATT, 200)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 0)
        mob:setMod(tpz.mod.UFASTCAST, 50)
        mob:setMod(tpz.mod.MATT, 255)
        mob:setLocalVar("TriggerHit", 4)
    end
    if mob:getHPP() <= 50 and hitTrigger == 4 then
        MessageGroup(mob, target, "My barrier cannot be destroyed by the likes of you!",0,"Murgleis")
        mob:useMobAbility(624) -- 2 hour "cloud" animation
        mob:setMod(tpz.mod.REGEN, 100)
        mob:addStatusEffect(tpz.effect.BLAZE_SPIKES, 200, 0, 3600)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:setLocalVar("TriggerHit", 5)
    end
    if mob:getHPP() <= 40 and hitTrigger == 5 then
        MessageGroup(mob, target, "You cannot handle my power!",0,"Murgleis")
        mob:SetMagicCastingEnabled(false)
        mob:setDamage(200)
        mob:setMod(tpz.mod.MATT, 0)
        mob:setMod(tpz.mod.ATT, 400)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
        mob:setLocalVar("TriggerHit", 6)
    end
    if mob:getHPP() <= 30 and hitTrigger == 6 then
        MessageGroup(mob, target, "You cannot handle my power!",0,"Murgleis")
        mob:SetMagicCastingEnabled(true)
        mob:setDamage(50)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
        mob:setMod(tpz.mod.ATT, 200)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 0)
        mob:setMod(tpz.mod.UFASTCAST, 50)
        mob:setMod(tpz.mod.MATT, 255)
        mob:setLocalVar("TriggerHit", 7)
    end
    if mob:getHPP() <= 20 and hitTrigger == 7 then

       MessageGroup(mob, target, "My barrier cannot be destroyed by the likes of you!",0,"Murgleis")
        mob:useMobAbility(624) -- 2 hour "cloud" animation
        mob:setMod(tpz.mod.REGEN, 100)
        mob:addStatusEffect(tpz.effect.BLAZE_SPIKES, 200, 0, 3600)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:setLocalVar("TriggerHit", 8)
    end
    if mob:getHPP() <= 10 and hitTrigger == 8 then
        MessageGroup(mob, target, "You cannot handle my power!",0,"Murgleis")
        mob:SetMagicCastingEnabled(false)
        mob:setDamage(200)
        mob:setMod(tpz.mod.MATT, 0)
        mob:setMod(tpz.mod.ATT, 400)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
        mob:setLocalVar("TriggerHit", 9)
    end
end


function onMagicHit(caster, target, spell)
    local elem = target:getLocalVar("RNGelement")
    local spellElem = spell:getElement()

    if spellElem > 0 and spellElem <= 8 and (caster:isPC() or caster:isPet()) then
        if elem == spellElem then
            target:useMobAbility(624)
            target:delStatusEffect(tpz.effect.BLAZE_SPIKES) -- Blaze spikes
            target:setMod(tpz.mod.REGEN, 0)
            target:setMobMod(tpz.mobMod.NO_MOVE, 0)
            target:SetAutoAttackEnabled(true)
            target:SetMobAbilityEnabled(true)

            -- Set to a new different element
            repeat
                elem = math.random(1,8)
            until elem ~= target:getLocalVar("RNGelement")

            target:setLocalVar("RNGelement", elem)
        end
    end

    return 1
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnDeathMessage(mob, player, isKiller, noKiller, "Maybe...you...are...worthy...of...my...power...",0,"Murgleis")
end



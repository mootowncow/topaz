-----------------------------------------
-- Trust: Qultada
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/roe")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
require("scripts/globals/raid")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.ALWAYS, 0, ai.r.RATTACK, 0, 0, 10)

    tpz.trust.onMobSpawn(mob)
end

function onMobFight(mob, target)
    local globalJATimer = mob:getLocalVar("globalJATimer")
    local qdCharges = mob:getLocalVar("qdCharges")
    local qdLastUsed = mob:getLocalVar("qdLastUsed")
    local snakeEyeTimer = mob:getLocalVar("snakeEyeTimer")
    local activeRolls = 0
    local canDoubleUp = false
    local snakeEye = false
    local rolls = { tpz.jobAbility.FIGHTERS_ROLL, tpz.jobAbility.CHAOS_ROLL, tpz.jobAbility.HUNTERS_ROLL, tpz.jobAbility.SAMURAI_ROLL }

    -- Quick Draw
    if (qdCharges < 2) and (os.time() - qdLastUsed >= 60) then
        qdCharges = qdCharges + 1
        mob:setLocalVar("qdCharges", qdCharges)
        mob:setLocalVar("qdLastUsed", os.time())
    end

    if (qdCharges > 0) then
        if HasDispellableEffect(target) then
            if (os.time() > globalJATimer) then
                if CanUseAbility(mob) then
                    qdCharges = qdCharges - 1
                    mob:setLocalVar("qdCharges", qdCharges)
                    mob:setLocalVar("globalJATimer", os.time() + 3)
                    mob:useJobAbility(tpz.jobAbility.DARK_SHOT, target)
                    return
                end
            end
        end
    end

    -- Rolls
    local effects = mob:getStatusEffects()
    for _, effect in ipairs(effects) do
        if
            (effect:getType() >= tpz.effect.FIGHTERS_ROLL and effect:getType() <= tpz.effect.NATURALISTS_ROLL) or
            effect:getType() == tpz.effect.RUNEISTS_ROLL or
            effect:getType() == tpz.effect.BUST
        then
            if (effect:getSubPower() <= 6) then
                canDoubleUp = true
            end

            if (effect:getSubPower() == 10) then
                snakeEye = true
                if mob:hasStatusEffect(tpz.effect.SNAKE_EYE) then
                    canDoubleUp = true
                end
            end

            if (effect:getSubType() == mob:getID()) then
                activeRolls = activeRolls +1
            end
        end
    end

    if mob:hasStatusEffect(tpz.effect.DOUBLE_UP_CHANCE) then
        if snakeEye and (os.time() > snakeEyeTimer) then
            if (os.time() > globalJATimer) then
                if CanUseAbility(mob) then
                    if not mob:hasStatusEffect(tpz.effect.SNAKE_EYE) then
                        mob:setLocalVar("globalJATimer", os.time() + 3)
                        mob:setLocalVar("snakeEyeTimer", os.time() + 300)
                        mob:useJobAbility(tpz.jobAbility.SNAKE_EYE, mob)
                        return
                    end
                end
            end
        end

        if canDoubleUp then
            if (os.time() > globalJATimer) then
                if CanUseAbility(mob) then
                    mob:setLocalVar("globalJATimer", os.time() + 3)
                    mob:useJobAbility(tpz.jobAbility.DOUBLE_UP, mob)
                    return
                end
            end
        end
    else
        if (activeRolls < 2) then
            if (os.time() > globalJATimer) then
                local nearbyFriendly = mob:getNearbyEntities(20)
                if (nearbyFriendly ~= nil) then 
                    local friendlyCount = 0
                    for _, friendlyTarget in pairs(nearbyFriendly) do
                        if (friendlyTarget:getAllegiance() == mob:getAllegiance()) then
                            friendlyCount = friendlyCount + 1
                            if (friendlyCount > 1) then
                                if CanUseAbility(mob) then
                                    mob:setLocalVar("globalJATimer", os.time() + 3)
                                    mob:useJobAbility(rolls[math.random(#rolls)], mob)
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function onMobDespawn(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
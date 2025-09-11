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
    tpz.trust.setUpFood(mob)

    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS, tpz.effect.DOOM, ai.r.ITEM, ai.s.SPECIFIC, tpz.items.FLASK_OF_HOLY_WATER)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.ALWAYS, 0, ai.r.RATTACK, 0, 0, 10)

    tpz.trust.onMobSpawn(mob)

    -- Track that Evoker's Roll was successfully used
    mob:addListener("ABILITY_STATE_EXIT", "QULTADA_ABILITY_EXIT", function(mob, skill)
        if (skill:getID() == tpz.jobAbility.EVOKERS_ROLL) then
            mob:setLocalVar("shouldEvokers", 0)
        end
    end)
end

function onMobFight(mob, target)
    local globalJATimer = mob:getLocalVar("globalJATimer")
    local qdCharges = mob:getLocalVar("qdCharges")
    local qdLastUsed = mob:getLocalVar("qdLastUsed")
    local snakeEyeTimer = mob:getLocalVar("snakeEyeTimer")
    local activeRolls = 0
    local canDoubleUp = false
    local snakeEye = false
    local evokersTarget = { tpz.job.WHM, tpz.job.BLM, tpz.job.RDM, tpz.job.SMN, tpz.job.SCH, tpz.job.GEOMANCER }
    local rolls = { tpz.jobAbility.FIGHTERS_ROLL, tpz.jobAbility.CHAOS_ROLL, tpz.jobAbility.HUNTERS_ROLL, tpz.jobAbility.SAMURAI_ROLL }

    if IsMobBusy(mob) or mob:hasPreventActionEffect() then
        return
    end

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

    -- Build a table of active rolls
    local activeRollTypes = {}
    for _, effect in ipairs(effects) do
        if
            (effect:getType() >= tpz.effect.FIGHTERS_ROLL and effect:getType() <= tpz.effect.NATURALISTS_ROLL) or
            effect:getType() == tpz.effect.RUNEISTS_ROLL
        then
            activeRollTypes[effect:getType()] = true
        end
    end

    -- Filter out rolls already active
    local availableRolls = {}
    for _, roll in ipairs(rolls) do
        if not activeRollTypes[roll] then
            table.insert(availableRolls, roll)
        end
    end

    -- Evoker's Roll var is active, so use it
    if mob:getLocalVar("shouldEvokers") > 0 then
        mob:delStatusEffect(tpz.effect.BIND)
        mob:addStatusEffect(tpz.effect.BIND, 1, 0, 55)
        mob:setEffectUndispellable(tpz.effect.BIND)
        mob:setLocalVar("globalJATimer", os.time() + 3)
        mob:useJobAbility(tpz.jobAbility.EVOKERS_ROLL, mob)
        return
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
                                    if #availableRolls > 0 then
                                        local chosenRoll = availableRolls[math.random(#availableRolls)]
                                        mob:setLocalVar("globalJATimer", os.time() + 3)
                                        mob:useJobAbility(chosenRoll, mob)
                                        return
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            if (os.time() > globalJATimer) then
                local nearbyFriendly = mob:getNearbyEntities(20)
                if nearbyFriendly ~= nil then 
                    local friendlyCount = 0
                    for _, friendlyTarget in pairs(nearbyFriendly) do
                        if friendlyTarget:getAllegiance() == mob:getAllegiance() then
                            if
                                utils.isInTable(friendlyTarget:getMainJob(), evokersTarget) and
                                not friendlyTarget:hasStatusEffect(tpz.effect.EVOKERS_ROLL) and
                                (mob:checkDistance(friendlyTarget) >= 12) and
                                (mob:checkDistance(friendlyTarget) <= 20)
                            then
                                friendlyCount = friendlyCount + 1
                                if friendlyCount > 0 then
                                    if CanUseAbility(mob) then
                                        local pos = friendlyTarget:getPos()
                                        mob:setPos(pos.x, pos.y, pos.z)
                                        mob:addStatusEffect(tpz.effect.BIND, 1, 0, 5)
                                        mob:setEffectUndispellable(tpz.effect.BIND)
                                        mob:setLocalVar("shouldEvokers", 1)
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
end

function onMobDespawn(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
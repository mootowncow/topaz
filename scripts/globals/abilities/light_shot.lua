-----------------------------------
-- Ability: Light Shot
-- Consumes a Light Card to enhance light-based debuffs. Additional effect: Light-based Sleep
-- Dia Effect: Defense Down Effect +5% and DoT + 1
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local duration = 60
    local bonusAcc = player:getStat(tpz.mod.AGI) / 2 + player:getMerit(tpz.merit.QUICK_DRAW_ACCURACY) + player:getMod(tpz.mod.QUICK_DRAW_MACC)
    local typeEffect = tpz.effect.SLEEP_I
    local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.LIGHT, bonusAcc, typeEffect, tpz.skill.MARKSMANSHIP)

    --print(string.format("step1: %u",resist))
	--GetPlayerByID(6):PrintToPlayer(string.format("Hit chance: %u",resist))
    if (target:hasImmunity(tpz.immunity.SLEEP) or target:hasImmunity(tpz.immunity.LIGHTSLEEP)) then
        spell:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    elseif resist < 0.5 then
        ability:setMsg(tpz.msg.basic.JA_MISS_2) -- resist message
        return typeEffect
    end

    duration = duration * resist
    duration = CheckDiminishingReturns(player, target, typeEffect, duration)

    local effects = {}
    local dia = target:getStatusEffect(tpz.effect.DIA)
    if dia ~= nil then
        table.insert(effects, dia)
    end

    if #effects > 0 then
        local effect = effects[math.random(#effects)]
        local duration = effect:getDuration()
        local startTime = effect:getStartTime()
        local tick = effect:getTick()
        local power = effect:getPower()
        local subpower = effect:getSubPower()
        local tier = effect:getTier()
        local effectId = effect:getType()
        local subId = effect:getSubType()
        -- https://www.bg-wiki.com/ffxi/Quick_Draw
        power = power + 1
        subpower = subpower + 5
        target:delStatusEffectSilent(effectId)
        target:addStatusEffect(effectId, power, tick, duration, subId, subpower, tier)
        local newEffect = target:getStatusEffect(effectId)
        newEffect:setStartTime(startTime)
    end

    if (duration > 0) and not target:hasStatusEffect(typeEffect) then
        if target:addStatusEffect(typeEffect, 1, 0, duration) then
            ability:setMsg(tpz.msg.basic.JA_ENFEEB_IS)
            AddDimishingReturns(caster, target, nil, typeEffect)
        else
            ability:setMsg(tpz.msg.basic.JA_NO_EFFECT_2)
        end
    end

    local del = player:delItem(2182, 1) or player:delItem(2974, 1)
    target:updateClaim(player)
    return typeEffect
end

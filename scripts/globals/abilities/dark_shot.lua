-----------------------------------
-- Ability: Dark Shot
-- Consumes a Dark Card to enhance dark-based debuffs. Additional effect: Dark-based Dispel
-- Bio Effect: Attack Down Effect +5% and DoT + 3
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
    local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.DARK, bonusAcc, tpz.effect.NONE, tpz.skill.MARKSMANSHIP)

    --print(string.format("step1: %u",magicacc))
	--GetPlayerByID(6):PrintToPlayer(string.format("Hit chance: %u",magicacc))

    if resist < 0.5 then
        ability:setMsg(tpz.msg.basic.JA_MISS_2) -- resist message
        return 0
    end

    duration = duration * resist

    local effects = {}
    local bio = target:getStatusEffect(tpz.effect.BIO)
    if bio ~= nil then
        table.insert(effects, bio)
    end
    local blind = target:getStatusEffect(tpz.effect.BLINDNESS)
    if blind ~= nil then
        table.insert(effects, blind)
    end
    local threnody = target:getStatusEffect(tpz.effect.THRENODY)
    if threnody ~= nil and threnody:getSubPower() == tpz.mod.LIGHTRES then
        table.insert(effects, threnody)
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
        if bio ~= nil then
            power = power + 3
            subpower = subpower + 5
        else
            power = power + 10
        end
        target:delStatusEffectSilent(effectId)
        target:addStatusEffect(effectId, power, tick, duration, subId, subpower, tier)
        local newEffect = target:getStatusEffect(effectId)
        newEffect:setStartTime(startTime)
    end

    ability:setMsg(tpz.msg.basic.JA_REMOVE_EFFECT_2)
    local dispelledEffect = tpz.effect.NONE

    -- Check for dispel resistance trait
	if math.random(100) > target:getMod(tpz.mod.DISPELRESTRAIT) then
        dispelledEffect = target:dispelStatusEffect()
    end

    if dispelledEffect == tpz.effect.NONE then
        -- no effect
        ability:setMsg(tpz.msg.basic.JA_NO_EFFECT_2)
    end

    if player:isPC() then
        local del = player:delItem(2183, 1) or player:delItem(2974, 1)
    end
    target:updateClaim(player)
    return dispelledEffect
end

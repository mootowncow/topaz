--[[
    Helper functions for jobs

    Place holder
--]]
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
-----------------------------------

jobUtil = {}

function jobUtil.AddIgnisRune(player, damage)
    local IgnisRunes = player:getLocalVar("IgnisRunes")
    local RuneDuration = 7200
    if player:getMainJob() == tpz.job.SAM then 
        if damage > 0 and IgnisRunes <= 2 then
            for v = 524,530,1 do
                player:delStatusEffectSilent(v)
            end
            player:addStatusEffect(tpz.effect.IGNIS, 1, 0, RuneDuration)
        end
    end
end

function jobUtil.ConsumeIgnisRune(player, effect, power)
    local Runes = player:getLocalVar("IgnisRunes")
    if (Runes > 0) then
        power = power * Runes
        local duration = Runes * 30
        player:delStatusEffectSilent(tpz.effect.IGNIS)
        player:delStatusEffectSilent(tpz.effect.IGNIS)
        player:delStatusEffectSilent(tpz.effect.IGNIS)
        player:setLocalVar("IgnisRunes", 0)
        player:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, 13, 3, duration, effect, power, tpz.auraTarget.ALLIES, tpz.effectFlag.AURA)
        return true
    end
    return false
end

function jobUtil.AddUndaRune(player)
    local UndaRunes = player:getLocalVar("UndaRunes")
    local RuneDuration = 7200
    if player:getMainJob() == tpz.job.DRG then 
        if UndaRunes <= 2 then
            player:addStatusEffect(tpz.effect.UNDA, 1, 0, RuneDuration)
        end
    end
end

function jobUtil.ConsumeUndaRune(player, target, effect, power)
    local Runes = player:getLocalVar("UndaRunes")
    local duration = 60
    player:delStatusEffectSilent(tpz.effect.UNDA)
    player:delStatusEffectSilent(tpz.effect.UNDA)
    player:delStatusEffectSilent(tpz.effect.UNDA)
    player:setLocalVar("UndaRunes", 0)
    target:addStatusEffect(effect, power, 0, duration)
end

function jobUtil.CheckForFlyHigh(player, target, ability)
    if player:hasStatusEffect(tpz.effect.FLY_HIGH) then
        local recast = ability:getRecast()
        ability:setRecast(utils.clamp(recast, 0, recast / 2))
    end
end

function jobUtil.GetAutoMainSkill(pet)
    local frame = pet:getAutomatonFrame()

    if frame == tpz.frames.HARLEQUIN then
        return tpz.skill.AUTOMATON_MELEE
    elseif frame == tpz.frames.VALOREDGE then
        return tpz.skill.AUTOMATON_MELEE
    elseif frame == tpz.frames.SHARPSHOT then
        return tpz.skill.AUTOMATON_RANGED
    elseif frame == tpz.frames.STORMWAKER then
        return tpz.skill.AUTOMATON_MAGIC
    end

    return tpz.skill.AUTOMATON_MELEE
end

function jobUtil.HandleCorsairShotTP(player, target, dmg, tp)
    if (dmg > 0) then
        player:addTP(tp)
        target:handleAfflatusMiseryDamage(dmg)
    end
end

function jobUtil.CalculateQd(player, target, ability, element, action, params)
    local dmg = (4 * (player:getRangedDmg() + player:getAmmoDmg()) + player:getMod(tpz.mod.QUICK_DRAW_DMG)) * (1 + player:getMod(tpz.mod.QUICK_DRAW_DMG_PERCENT) / 100)
    local bonusAcc = player:getStat(tpz.mod.AGI) / 2 + player:getMerit(tpz.merit.QUICK_DRAW_ACCURACY) + player:getMod(tpz.mod.QUICK_DRAW_MACC)

    dmg = dmg + (2 * player:getJobPointLevel(tpz.jp.QUICK_DRAW_EFFECT))
    dmg = math.floor(dmg * applyResistanceAbility(player, target, element, tpz.skill.MARKSMANSHIP, bonusAcc))
    dmg = addBonusesAbility(player, element, target, dmg, params)
    dmg = adjustForTarget(target, dmg, element)

    return dmg
end
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

    dmg = dmg + player:getJobPointLevel(tpz.jp.QUICK_DRAW_EFFECT) * 2
    dmg = math.floor(dmg * applyResistanceAbility(player, target, element, tpz.skill.MARKSMANSHIP, bonusAcc))
    dmg = addBonusesAbility(player, element, target, dmg, params)
    dmg = adjustForTarget(target, dmg, element)

    return dmg
end

function jobUtil.HandleFinishingMoves(player, daze)
    -- Get the maximum finishing move cap from the player's mod.
    local maxFinishingMoves = player:getMod(tpz.mod.MAX_FINISHING_MOVES)
    local maxCap = 5 + maxFinishingMoves -- Default cap is 5, increased by the mod.

    -- Check for the highest finishing move effect the player currently has.
    local currentFinishingMove = 0

    -- Check for the current finishing move level, including FINISHING_MOVE_6.
    if player:hasStatusEffect(tpz.effect.FINISHING_MOVE_6) then
        currentFinishingMove = player:getStatusEffect(tpz.effect.FINISHING_MOVE_6):getPower() -- Get the power representing the number of moves.
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_6)
    else
        -- Check from highest to lowest for FINISHING_MOVE_1 to FINISHING_MOVE_5.
        for i = tpz.effect.FINISHING_MOVE_5, tpz.effect.FINISHING_MOVE_1, -1 do
            if player:hasStatusEffect(i) then
                currentFinishingMove = i - tpz.effect.FINISHING_MOVE_1 + 1 -- Convert to numerical count (1-5).
                player:delStatusEffectSilent(i)
                break
            end
        end
    end

    -- Determine the new finishing move count.
    local newFinishingMoveCount = currentFinishingMove + daze

    -- Cap the new count at the calculated maximum (default 5, or higher if modified).
    if newFinishingMoveCount > maxCap then
        newFinishingMoveCount = maxCap
    end

    -- Apply the appropriate effect based on the new count.
    if newFinishingMoveCount <= 5 then
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_1 + (newFinishingMoveCount - 1), 1, 0, 7200)
    else
        -- Use FINISHING_MOVE_6 with power representing 6-9 moves.
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_6, newFinishingMoveCount, 0, 7200)
    end
end

function jobUtil.getFinishingMoveCount(player)
    local finishingMoves = 0

    -- Check if the player has FINISHING_MOVE_6 and get its power if true.
    if player:hasStatusEffect(tpz.effect.FINISHING_MOVE_6) then
        finishingMoves =  player:getStatusEffect(tpz.effect.FINISHING_MOVE_6):getPower()
    end

    -- Otherwise, check from FINISHING_MOVE_5 down to FINISHING_MOVE_1.
    for i = tpz.effect.FINISHING_MOVE_5, tpz.effect.FINISHING_MOVE_1, -1 do
        if player:hasStatusEffect(i) then
            finishingMoves =  i - tpz.effect.FINISHING_MOVE_1 + 1 -- Convert effect ID to numerical count.
        end
    end

    --printf("Finishing moves: %d", finishingMoves)
    return finishingMoves
end

function jobUtil.consumeFinishingMoves(player, movesToConsume)
    local currentFinishingMoveCount = jobUtil.getFinishingMoveCount(player)

    -- If current moves are less than what's needed, consume all that are available.
    local actualConsumed = math.min(currentFinishingMoveCount, movesToConsume)

    -- Remove all finishing moves before updating after
    for i = tpz.effect.FINISHING_MOVE_5, tpz.effect.FINISHING_MOVE_1, -1 do
        player:delStatusEffectSilent(i)
    end
    player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_6)

    -- Readd finishing moves based on how many consumed
    local newFinishingMoveCount = currentFinishingMoveCount - actualConsumed

    if (newFinishingMoveCount > 0) then
        if (newFinishingMoveCount <= 5) then
            player:addStatusEffect(tpz.effect.FINISHING_MOVE_1 + (newFinishingMoveCount - 1), 1, 0, 7200)
        else
            player:addStatusEffect(tpz.effect.FINISHING_MOVE_6, newFinishingMoveCount, 0, 7200)
        end
    end

    --printf("Number of finishing moves consumed: %d", actualConsumed)
    return actualConsumed
end


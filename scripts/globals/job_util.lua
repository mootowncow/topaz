-----------------------------------

--   Helper functions for jobs

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

jobUtil.Cor = {}

function jobUtil.Cor.CalculateQd(player, target, ability, element, action, params)
    local dmg = (2 * (player:getRangedDmg() + player:getAmmoDmg()) + player:getMod(tpz.mod.QUICK_DRAW_DMG)) * (1 + player:getMod(tpz.mod.QUICK_DRAW_DMG_PERCENT) / 100)
    local bonusAcc = player:getStat(tpz.mod.AGI) / 2 + player:getMerit(tpz.merit.QUICK_DRAW_ACCURACY) + player:getMod(tpz.mod.QUICK_DRAW_MACC)

    dmg = dmg + player:getJobPointLevel(tpz.jp.QUICK_DRAW_EFFECT) * 2
    dmg = math.floor(dmg * applyResistanceAbility(player, target, element, tpz.skill.MARKSMANSHIP, bonusAcc))
    dmg = addBonusesAbility(player, element, target, dmg, params)
    dmg = adjustForTarget(target, dmg, element)

    return dmg
end

function jobUtil.Cor.HandleShots(player, target, ability, action)
    local shotData = {
        [tpz.ja.FIRE_SHOT] = {
            Element = tpz.magic.ele.FIRE,
            Effects = {
                { Id = tpz.effect.BURN, Boost = 4, SubBoost = 4, MaxTier = 3 },
                { Id = tpz.effect.ADDLE, Boost = 5, SubBoost = 5, MaxTier = 3 },
            },
            Card = tpz.items.FIRE_CARD
        },

        [tpz.ja.ICE_SHOT] = {
            Element = tpz.magic.ele.ICE,
            Effects = {
                { Id = tpz.effect.FROST, Boost = 4, SubBoost = 4, MaxTier = 3 },
                { Id = tpz.effect.PARALYSIS, Boost = 5, MaxTier = 3 },
            },
            Card = tpz.items.ICE_CARD
        },

        [tpz.ja.WIND_SHOT] = {
            Element = tpz.magic.ele.WIND,
            Effects = {
                { Id = tpz.effect.CHOKE, Boost = 4, SubBoost = 4, MaxTier = 3 },
                { Id = tpz.effect.WEIGHT, Boost = 5, MaxTier = 3 },
            },
            Card = tpz.items.WIND_CARD
        },

        [tpz.ja.EARTH_SHOT] = {
            Element = tpz.magic.ele.EARTH,
            Effects = {
                { Id = tpz.effect.RASP, Boost = 4, SubBoost = 4, MaxTier = 3 },
                { Id = tpz.effect.SLOW, Boost = 500, MaxTier = 3 },
            },
            Card = tpz.items.EARTH_CARD
        },

        [tpz.ja.THUNDER_SHOT] = {
            Element = tpz.magic.ele.LIGHTNING,
            Effects = {
                { Id = tpz.effect.SHOCK, Boost = 4, SubBoost = 4, MaxTier = 3 },
            },
            Card = tpz.items.THUNDER_CARD
        },

        [tpz.ja.WATER_SHOT] = {
            Element = tpz.magic.ele.WATER,
            Effects = {
                { Id = tpz.effect.DROWN, Boost = 4, SubBoost = 4, MaxTier = 3 },
                { Id = tpz.effect.POISON, Boost = 2, MaxTier = 3 },
            },
            Card = tpz.items.WATER_CARD
        },

        [tpz.ja.LIGHT_SHOT] = {
            Element = tpz.magic.ele.LIGHT,
            Effects = {
                { Id = tpz.effect.DIA, Boost = 1, SubBoost = 5, MaxTier = 4 },
            },
            AdditionalEffect = { Effect = tpz.effect.SLEEP_I , Duration = 60, BonusAcc = 175 },
            Card = tpz.items.LIGHT_CARD
        },

        [tpz.ja.DARK_SHOT] = {
            Element = tpz.magic.ele.DARK,
            Effects = {
                { Id = tpz.effect.BIO, Boost = 3, SubBoost = 5, MaxTier = 4 },
                { Id = tpz.effect.BLINDNESS, Boost = 10, MaxTier = 3 },
            },
            AdditionalEffect = { Effect = tpz.effect.NONE , Duration = 0, BonusAcc = 175 },
            Card = tpz.items.DARK_CARD
        },
    }
    local dmg = 0

    local data = shotData[ability:getID()]
    if not data then -- Shouldn't happen
        return dmg
    end

    -- Collect valid active effects to boost
    local activeEffects = {}
    for _, currentEffect in ipairs(data.Effects) do
        local active = target:getStatusEffect(currentEffect.Id)
        if active then
            table.insert(activeEffects, { Effect = active, Boost = currentEffect.Boost, SubBoost = currentEffect.SubBoost or 0, MaxTier = currentEffect.MaxTier })
        end
    end

    -- Apply boosts to matching effects
    for _, entry in ipairs(activeEffects) do
        local old = entry.Effect
        local power = old:getPower() + entry.Boost
        local duration = old:getDuration()
        local tick = old:getTick() / 1000
        local startTime = old:getStartTime()
        local subpower = old:getSubPower() + entry.SubBoost
        local tier = old:getTier()
        local effectId = old:getType()

        if (tier < entry.MaxTier) then
            target:delStatusEffectSilent(effectId)
            target:addStatusEffect(effectId, power, tick, duration, 0, subpower, tier +1)
            local newEffect = target:getStatusEffect(effectId)
            if newEffect then
                newEffect:setStartTime(startTime)
            end
        end
    end

     -- Light / Dark Shot
    if data.AdditionalEffect then
        local duration = data.AdditionalEffect.Duration
        local bonusAcc = data.AdditionalEffect.BonusAcc + player:getStat(tpz.mod.AGI) / 2 + player:getMerit(tpz.merit.QUICK_DRAW_ACCURACY) + player:getMod(tpz.mod.QUICK_DRAW_MACC)
        local typeEffect = data.AdditionalEffect.Effect
        local resist = getAdditionalEffectStatusResist(player, target, typeEffect, data.Element, tpz.skill.MARKSMANSHIP, bonusAcc)

        ability:setMsg(tpz.msg.basic.JA_NO_EFFECT_2)

        if (resist >= 0.5) then
            duration = duration * resist
            duration = CheckDiminishingReturns(player, target, typeEffect, duration)

             -- Handle Dark Shot (Dispel)
            if (typeEffect == tpz.effect.NONE) then
                local dispelledEffect = tpz.effect.NONE

                -- Check for dispel resistance trait
                if math.random(100) > target:getMod(tpz.mod.DISPELRESTRAIT) then
                    dispelledEffect = target:dispelStatusEffect()
                end

                if (dispelledEffect ~= tpz.effect.NONE) then
                    -- Dispelled an effect
                    dmg = dispelledEffect
                    ability:setMsg(tpz.msg.basic.JA_REMOVE_EFFECT_2)
                end

            -- Handle Light Shot (Sleep)
            elseif (duration > 0) and not target:hasStatusEffect(typeEffect) then
                local power = 1
                local tick = 0
                if target:addStatusEffect(typeEffect, power, tick, duration) then
                    dmg = typeEffect
                    ability:setMsg(tpz.msg.basic.JA_ENFEEB_IS)
                    AddDimishingReturns(player, target, nil, typeEffect)
                end
            end
        end

    -- Elemental damage shots
    else
        local params = {}
        params.includemab = true
        params.targetTPMult = 0 -- Quick Draw does not feed TP

        local damageType = data.Element +5

        dmg = jobUtil.Cor.CalculateQd(player, target, ability, data.Element, action, params)
        dmg = takeAbilityDamage(target, player, params, true, dmg, tpz.attackType.MAGICAL, damageType, tpz.slot.RANGED, 1, 0, 0, 0, action, nil)
        player:trySkillUp(target, tpz.skill.MARKSMANSHIP, 1)
    end

    if player:isPC() then
        local del = player:delItem(data.Card, 1) or player:delItem(tpz.items.TRUMP_CARD, 1)
    end

    target:updateClaim(player)
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



function jobUtil.isJAAbsorbedByShadows(target, ability)
    local shadowsToCheck = 1
    shadowsToCheck = utils.takeShadows(target, shadowsToCheck)

    if (shadowsToCheck == 0) then
        ability:setMsg(tpz.msg.basic.SHADOW_ABSORB)
        return true
    end

    return false
end
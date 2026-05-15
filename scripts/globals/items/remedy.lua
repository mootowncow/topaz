-----------------------------------------
-- ID: 4155
-- Item: Remedy
-- Item Effect: This potion remedies status ailments.
-- Works on paralysis, silence, blindness, poison, and disease.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/items")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local removed = false

    if (target:hasStatusEffect(tpz.effect.SILENCE) == true) then
        local effect = target:getStatusEffect(tpz.effect.SILENCE)
        local effectFlags = effect:getFlag()
        if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
            target:delStatusEffect(tpz.effect.SILENCE)
            removed = true
        end
    end

    if (target:hasStatusEffect(tpz.effect.BLINDNESS) == true) then
        local effect = target:getStatusEffect(tpz.effect.BLINDNESS)
        local effectFlags = effect:getFlag()
        if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
            target:delStatusEffect(tpz.effect.BLINDNESS)
            removed = true
        end
    end

    if (target:hasStatusEffect(tpz.effect.POISON) == true) then
        local effect = target:getStatusEffect(tpz.effect.POISON)
        local effectFlags = effect:getFlag()
        if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
            target:delStatusEffect(tpz.effect.POISON)
            removed = true
        end
    end

    if (target:hasStatusEffect(tpz.effect.PARALYSIS) == true) then
        local effect = target:getStatusEffect(tpz.effect.PARALYSIS)
        local effectFlags = effect:getFlag()
        if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
            target:delStatusEffect(tpz.effect.PARALYSIS)
            removed = true
        end
    end

    local rDisease = math.random(1, 2) -- Disease is not garunteed to be cured, 1 means removed 2 means fail. 50% chance
    if (rDisease == 1) then
        if (target:hasStatusEffect(tpz.effect.DISEASE) == true) then
            local effect = target:getStatusEffect(tpz.effect.DISEASE)
            local effectFlags = effect:getFlag()
            if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
                target:delStatusEffect(tpz.effect.DISEASE)
                removed = true
            end
        end

        if (target:hasStatusEffect(tpz.effect.PLAGUE) == true) then
            local effect = target:getStatusEffect(tpz.effect.PLAGUE)
            local effectFlags = effect:getFlag()
            if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
                target:delStatusEffect(tpz.effect.PLAGUE)
                removed = true
            end
        end
    end

    if removed then
        target:messagePublic(tpz.msg.basic.ITEM_REMEDY, target)
    else
        -- TODO: Doesn't work on simple log
        target:messagePublic(tpz.msg.basic.ITEM_NO_EFFECT, target, GetItem(tpz.items.REMEDY):getID())
    end
end


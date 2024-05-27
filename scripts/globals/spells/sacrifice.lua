-----------------------------------------
-- Spell: Sacrifice
--
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/utils")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local removables = utils.GetRemovableEffects()
    local hasSolace = caster:hasStatusEffect(tpz.effect.AFFLATUS_SOLACE)
    local maxRemovals = hasSolace and 7 or 1  -- Remove up to 7 effects if hasSolace is true, otherwise just 1
    local removals = 0

    -- remove one effect and add it to me
    for i, effect in ipairs(removables) do
        if removals >= maxRemovals then
            break
        end

        if target:hasStatusEffect(effect) then
            local currentEffect = target:getStatusEffect(effect)
            local effectFlags = currentEffect:getFlag()
            if bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0 or currentEffect:getType() == tpz.effect.PETRIFICATION then
                spell:setMsg(tpz.msg.basic.MAGIC_ABSORB_AILMENT)
                
                local statusEffect = target:getStatusEffect(effect)

                -- only add it to me if I don't have it
                if not caster:hasStatusEffect(effect) then
                    caster:addStatusEffect(effect, statusEffect:getPower(), statusEffect:getTickCount(), statusEffect:getDuration())
                end

                target:delStatusEffectSilent(effect)
                removals = removals + 1
            end
        end
    end

    if removals == 0 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
    end

    return removals
end


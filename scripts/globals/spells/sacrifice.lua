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
    local count = 1
    local removables = utils.GetRemovableEffects()

    -- remove one effect and add it to me
    for i, effect in ipairs(removables) do

        if (target:hasStatusEffect(effect)) then
            local currentEffect = target:getStatusEffect(effect)
            local effectFlags = currentEffect:getFlag()
            if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) or (currentEffect == tpz.effect.PETRIFICATION) then
                spell:setMsg(tpz.msg.basic.MAGIC_ABSORB_AILMENT)

                local statusEffect = target:getStatusEffect(effect)

                -- only add it to me if I don't have it
                if (caster:hasStatusEffect(effect) == false) then
                    caster:addStatusEffect(effect, statusEffect:getPower(), statusEffect:getTickCount(), statusEffect:getDuration())
                end

                target:delStatusEffectSilent(effect)
                return 1
            end
        end
    end

    spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
    return 0
end

-----------------------------------------
-- Spell: Burn
-- Deals fire damage that lowers an enemy's intelligence and gradually reduces its HP.
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    if (target:getStatusEffect(tpz.effect.DROWN) ~= nil) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
    else
        local dINT = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
        local params = {}
        params.diff = dINT
        params.attribute = tpz.mod.INT
        params.skillType = 36
        params.bonus = 0
        params.effect = tpz.effect.BURN
        local resist = applyResistanceEffect(caster, target, spell, params)
        print(resist)
        if (resist <= 0.5) then
            spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        else
            if (target:getStatusEffect(tpz.effect.FROST) ~= nil) then
                target:delStatusEffectSilent(tpz.effect.FROST)
            end
            local sINT = caster:getStat(tpz.mod.INT)
            local DOT = getElementalDebuffDOT(sINT)
            local effect = target:getStatusEffect(tpz.effect.BURN)
            local noeffect = false
            if (effect ~= nil) then
                if (effect:getPower() >= DOT) then
                    noeffect = true
                end
            end
            if (noeffect) then
                spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
            else
                if (effect ~= nil) then
                    target:delStatusEffectSilent(tpz.effect.BURN)
                end
                spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB)
                CheckForMagicBurst(caster, spell, target)
                local duration = math.floor(ELEMENTAL_DEBUFF_DURATION * resist)

                local mbonus = caster:getMerit(tpz.merit.ELEMENTAL_DEBUFF_EFFECT)
                DOT = DOT + mbonus/2 -- Damage

                target:addStatusEffect(tpz.effect.BURN, DOT, 3, duration)
            end
        end
    end

    return tpz.effect.BURN
end

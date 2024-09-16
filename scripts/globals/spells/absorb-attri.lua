-----------------------------------------
-- Spell: Absorb Attribute
-- Steals an enemy's buff
-- Spell Type: Magical (Dark)
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.DARK_MAGIC
    params.bonus = 175
    local resist = applyResistanceEffect(caster, target, spell, params)
    local effectsToSteal = 0
    local stolenEffects = 0
    local effect = nil

    -- Check if the spell landed..
    if resist >= 0.5 then
        effectsToSteal = effectsToSteal +1
    end

    -- Nether void adds additional dispels
    -- TODO: JP Adds even more dispels to Nether Void!
    if caster:hasStatusEffect(tpz.effect.NETHER_VOID) then
        resist = applyResistanceEffect(caster, target, spell, params)
        if resist >= 0.5 then
            effectsToSteal = effectsToSteal +1
        end
    end

    -- Attempt to steal status effects based on how many are to be stolen
    while stolenEffects < effectsToSteal do
        effect = caster:stealStatusEffect(target)
        if effect ~= 0 then
            stolenEffects = stolenEffects + 1
        else
            break -- No more dispellable effects to steal
        end
    end

    if stolenEffects > 0 then
        spell:setMsg(tpz.msg.basic.MAGIC_STEAL)
    elseif effectsToSteal > 0 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- Resisted or no effects to steal
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST) -- All dispel resist checks failed
    end

    caster:delStatusEffectSilent(tpz.effect.NETHER_VOID)

    return stolenEffects
end

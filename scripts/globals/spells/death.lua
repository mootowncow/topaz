-----------------------------------------
-- Spell: Death
-- Consumes all MP. Has a chance to knock out the target. If Death fails to knock out the target, it
-- will instead deal darkness damage. Ineffective against undead.
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    spell:setFlag(tpz.magic.spellFlag.IGNORE_SHADOWS)
    local CanProvidence = caster:getLocalVar("CanProvidence") > 0
    if CanProvidence then 
        local Providence = caster:getLocalVar("Providence")
        if (Providence == 0) then
            return 1
        end
    end
    return 0
end

function onSpellCast(caster, target, spell)
    if target:isUndead() or target:hasStatusEffect(tpz.effect.MAGIC_SHIELD) or target:hasStatusEffect(tpz.effect.FEALTY) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return 0
    elseif (math.random() < getEffectResistanceTraitChance(caster, target, tpz.effect.KO)) then
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST_2) -- Resist trait proc!
        return 0
    end

    target:setHP(0)
    return 0
end

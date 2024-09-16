-----------------------------------------
-- Spell: Dispelga
--
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 175
    local resist = applyResistance(caster, target, spell, params)
    local effect = tpz.effect.NONE

    -- Check for dispel resistance trait
	if math.random(100) < target:getMod(tpz.mod.DISPELRESTRAIT) then
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST_2)
        return effect
    end

    if (resist >= 0.25) then
        spell:setMsg(tpz.msg.basic.MAGIC_ERASE)
        -- TODO: tpz.msg.basic.EFFECTS_DISAPPEAR_2 for more than 1 effect dispelled, and return # of effects not effect
        effect = target:dispelStatusEffect()
        if (effect == tpz.effect.NONE) then
            -- no effect
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return effect
end

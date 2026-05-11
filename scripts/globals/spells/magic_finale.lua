-----------------------------------------
-- Spell: Magic Finale
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
    -- Pull base stats.
    local dCHR = (caster:getStat(tpz.mod.CHR) - target:getStat(tpz.mod.CHR))

    local params = {}
    params.diff = dCHR
    params.attribute = tpz.mod.CHR
    params.skillType = tpz.skill.SINGING
    params.bonus = 175 + caster:getMod(tpz.mod.FINALE_EFFECT) + caster:getMod(tpz.mod.ALL_SONGS_EFFECT)
    params.effect = nil
    local resist = applyResistanceEffect(caster, target, spell, params)
    local effect = tpz.effect.NONE

    -- Check for dispel resistance trait
	if  math.random(100) < target:getMod(tpz.mod.DISPELRESTRAIT) then
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST_2)
        return effect
    end

    -- Handle Magic Shield
    if target:hasStatusEffect(tpz.effect.MAGIC_SHIELD, 0) and target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() < 2 then
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        return effect
    end

    if (resist >= 0.50) then
        spell:setMsg(tpz.msg.basic.MAGIC_ERASE)
        --TODOCheckForMagicBurst(caster, spell, target)
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

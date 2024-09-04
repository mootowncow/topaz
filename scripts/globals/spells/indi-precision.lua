-----------------------------------------
-- Spell: Indi-Poison
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    if caster:hasStatusEffect(tpz.effect.COLURE_ACTIVE) then
    	local effect = caster:getStatusEffect(tpz.effect.COLURE_ACTIVE)
		if effect:getSubType() ==  tpz.effect.GEO_ACCURACY_BOOST then
		    return tpz.msg.basic.EFFECT_ALREADY_ACTIVE
		end
	end
    return 0
end

function onSpellCast(caster, target, spell)
    local geo_skill = caster:getCharSkillLevel(tpz.skill.GEOMANCY)
    local power = (geo_skill / 18) + 1

    -- Ensure the power doesn't exceed the maximum of +50
    if power > 50 then
        power = 50
    end
    -- TODO: An Indicolure spell cast on another party member with Entrust active will not factor in Geomancy+ equipment from the caster.

    target:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, 13, 3, 180, tpz.effect.GEO_ACCURACY_BOOST, power, tpz.auraTarget.ALLIES, tpz.effectFlag.AURA)
    caster:delStatusEffectSilent(tpz.effect.ENTRUST)
    return tpz.effect.COLURE_ACTIVE
end

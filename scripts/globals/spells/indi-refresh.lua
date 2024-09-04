-----------------------------------------
-- Spell: Indi-Poison
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    if caster:hasStatusEffect(tpz.effect.COLURE_ACTIVE) then
    	local effect = caster:getStatusEffect(tpz.effect.COLURE_ACTIVE)
		if effect:getSubType() ==  tpz.effect.GEO_REFRESH then
		    return tpz.msg.basic.EFFECT_ALREADY_ACTIVE
		end
	end
    return 0
end

function onSpellCast(caster, target, spell)
    local geo_skill = caster:getCharSkillLevel(tpz.skill.GEOMANCY)
    local power = (geo_skill / 180) + 1

    -- Ensure the MP per tick doesn't exceed the maximum of +6
    if power > 6 then
        power = 6
    end
    -- TODO: An Indicolure spell cast on another party member with Entrust active will not factor in Geomancy+ equipment from the caster.


    target:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, 13, 3, 180, tpz.effect.GEO_REFRESH, power, tpz.auraTarget.ALLIES, tpz.effectFlag.AURA)
    caster:delStatusEffectSilent(tpz.effect.ENTRUST)
    return tpz.effect.COLURE_ACTIVE
end

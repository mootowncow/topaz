-----------------------------------------
-- Spell: Indi-Barrier
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    if caster:hasStatusEffect(tpz.effect.COLURE_ACTIVE) then
    	local effect = caster:getStatusEffect(tpz.effect.COLURE_ACTIVE)
		if effect:getSubType() ==  tpz.effect.GEO_DEFENSE_BOOST then
		    return tpz.msg.basic.EFFECT_ALREADY_ACTIVE
		end
	end
    return 0
end

function onSpellCast(caster, target, spell)
    local geo_skill = caster:getCharSkillLevel(tpz.skill.GEOMANCY)
    local min_power = 10
    local max_power = 40
    local max_skill = 900

    -- Calculate the power as a percentage based on skill level
    local power = min_power + math.floor((geo_skill / max_skill) * (max_power - min_power))

    -- Ensure the power doesn't exceed the maximum cap of 40
    if power > max_power then
        power = max_power
    end
    -- TODO: An Indicolure spell cast on another party member with Entrust active will not factor in Geomancy+ equipment from the caster.


    target:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, 13, 3, 180, tpz.effect.GEO_DEFENSE_BOOST, power, tpz.auraTarget.ALLIES, tpz.effectFlag.AURA)
    caster:delStatusEffectSilent(tpz.effect.ENTRUST)
    return tpz.effect.COLURE_ACTIVE
end

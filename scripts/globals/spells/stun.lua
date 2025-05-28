-----------------------------------------
-- Spell: Stun
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end
--[[
function onSpellCast(caster, target, spell)
    local duration = 5

    local dINT = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    local params = {}
    params.diff = nil
    params.attribute = tpz.mod.INT
    params.skillType = 37
    params.bonus = 0
    params.effect = tpz.effect.STUN
    local resist = applyResistanceEffect(caster, target, spell, params)
    if (resist <= (1/16)) then
        -- resisted!
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        return 0
    end

    if (target:hasStatusEffect(tpz.effect.STUN)) then
        -- no effect
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    else
        if (target:addStatusEffect(tpz.effect.STUN, 1, 0, duration*resist)) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    end

    return tpz.effect.STUN
end
--]]
function onSpellCast(caster, target, spell)
    local duration = 5

    local dINT = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    local params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.DARK_MAGIC
    params.bonus = 200
    params.effect = tpz.effect.STUN
    local resist = applyResistanceEffect(caster, target, spell, params)
    duration = math.ceil(duration * resist * tryBuildResistance(tpz.magic.buildcat.STUN, target))
    duration = CheckDiminishingReturns(caster, target, params.effect, duration)

    -- Resist trait proc
    if (math.random() < getEffectResistanceTraitChance(caster, target, params.effect)) then
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST_2) -- Resist trait proc!
        return params.effect
    end

    if (resist >= 0.5) then
		if (target:hasStatusEffect(params.effect)) then
			-- no effect
			spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
		else
			if (target:addStatusEffect(params.effect, 1, 0, duration)) then
                AddDimishingReturns(caster, target, spell, params.effect)
				spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
                CheckForMagicBurst(caster, spell, target)
			else
				spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
			end
		end
	end

    return params.effect
end

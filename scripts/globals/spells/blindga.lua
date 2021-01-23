-----------------------------------------
-- Spell: Blind
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
    local dINT = (caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.MND)) --blind uses caster INT vs target MND

    -- Base power.  May need more research.
    local power = math.floor(dINT * 9/40) + 23

    if (power < 5) then
        power = 5
    end

    if (power > 30) then
        power = 30
    end


    -- Duration, including resistance.  Unconfirmed.
    local duration = 180
    local params = {}
    params.diff = nil
    params.attribute = tpz.mod.INT
    params.skillType = 35
    params.bonus = 0
    params.effect = tpz.effect.BLINDNESS
    duration = duration * applyResistanceEffect(caster, target, spell, params)
    duration = duration * applyResistanceEffect(caster, target, spell, params)
    duration = math.ceil(duration * tryBuildResistance(tpz.magic.buildcat.BLIND, target))

    if (duration >= 60) then --Do it!

        if (target:addStatusEffect(tpz.effect.BLINDNESS, power, 0, duration)) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end
    return tpz.effect.BLINDNESS
end

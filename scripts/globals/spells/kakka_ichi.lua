--------------------------------------
-- Spell: Kakka: Ichi
--  Grants Aquaveil to the caster.
--------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/status")
--------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    -- duration is said to be based on enhancing skill with max 5 minutes, but I could find no
    -- tests that quantify the relationship so I'm using 5 minutes for now.
    local duration = calculateDuration(900, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    local power = AQUAVEIL_COUNTER + caster:getMod(tpz.mod.AQUAVEIL_COUNT)
    if caster:getSkillLevel(tpz.skill.NINJUTSU) >= 300 then
        power = power + 1
    end

    power = math.max(power, 1) -- this shouldn't happen but it's probably best to prevent someone from accidentally underflowing the counter...

    target:delStatusEffectSilent(tpz.effect.AQUAVEIL)
    target:addStatusEffect(tpz.effect.AQUAVEIL, power, 0, duration)
    spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)

    return tpz.effect.AQUAVEIL
end
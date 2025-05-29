-----------------------------------------
-- Spell: Soporific
-- Puts all enemies within range to sleep
-- Spell cost: 38 MP
-- Monster Type: Plantoids
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: HP-5, MP+5
-- Level: 24
-- Casting Time: 3 seconds
-- Recast Time: 90 seconds
-- Duration: 90 seconds
-- Magic Bursts on: Compression, Gravitation, and Darkness
-- Combos: Clear Mind
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    local dINT = (caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    params.diff = dINT
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.effect = tpz.effect.SLEEP_I
    params.eco = ECO_PLANTOID
    params.bonus = BlueHandleCorrelationMACC(caster, target, spell, params, 0)
    local resist = applyResistanceEffect(caster, target, spell, params)
    local duration = 90

	-- Can't overwrite any sleep
    if hasSleepT1Effect(target) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return typeEffect
    end

    TryApplyEffect(caster, target, spell, params.effect, 1, 0, duration, resist, 0.5)

    return params.effect
end
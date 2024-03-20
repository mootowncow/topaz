-----------------------------------------
-- Spell: Auroral Drape
-- Greatly lowers the accuracy of enemies within range for a brief period of time
-- Spell cost: 24 MP
-- Monster Type: Luminions
-- Spell Type: Magical (Light)
-- Blue Magic Points: 4
-- Stat Bonus: CHR+2, HP+20
-- Level: 74
-- Casting Time: 0.5 seconds
-- Recast Time: 60 seconds
-- Effect Time: About 15 seconds
-- Magic Bursts on: Transfixion, Fusion, and Light
-- Combos: Auto Refresh
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local dINT = (caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    local dMND = (caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND))
    local params = {}
    params.diff = dINT
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.eco = ECO_NONE
    params.bonus = BlueHandleCorrelationMACC(caster, target, spell, params, 0)
    params.effect = tpz.effect.BLINDNESS
    
    local resist = applyResistanceEffect(caster, target, spell, params)
    local duration = 180
    local potency = 60

    TryApplyEffect(caster, target, spell, params.effect, potency, 0, duration, resist, 0.5)

    params.diff = dMND
    params.effect = tpz.effect.SILENCE
    local resist = applyResistanceEffect(caster, target, spell, params)
    local duration = 120
    local potency = 1

    local isMaaIllmutheBestower = target:getPool() == 2465

    if isMaaIllmutheBestower then
        resist = 1
        duration = 30
        target:addTP(3000)
    end

    TryApplyEffect(caster, target, spell, params.effect, potency, 0, duration, resist, 0.5)

    return tpz.effect.BLINDNESS
end

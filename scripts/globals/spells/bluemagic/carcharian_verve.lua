-----------------------------------------
-- Spell: Carcharian Verve
-- Enhances attack and magic attack. Reduces spell interruption rate.
-- Spell cost: 28 MP
-- Monster Type: Luminions
-- Spell Type: Magical (Ice)
-- Blue Magic Points: 5
-- Stat Bonus: INT+3 MND+3
-- Level: 74
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Attack Bonus of +20% and Magic Attack Bonus of +20 last for one minute.
-- Aquaveil effect lasts 15 minutes and prevents 10 interruptions.
-- Combos: Magic Attack Bonus
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/bluemagic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.AQUAVEIL
    local effect2 = tpz.effect.ATTACK_BOOST
    local effect3 = tpz.effect.MAGIC_ATK_BOOST
    local power = 20
    local aquaveilPower = 10 + caster:getMod(tpz.mod.AQUAVEIL_COUNT)
    local duration = 300
    local aquaveilDuration = 900
    local tick = 0
    local subid = 0
    local subpower = 0
    local tier = 0
    local bonus = 0
    local params = {}

    BlueBuffSpell(caster, target, spell, effect2, power, tick, duration, subid, subpower, tier, params, bonus)
    BlueBuffSpell(caster, target, spell, effect3, power, tick, duration, subid, subpower, tier, params, bonus)
    return BlueBuffSpell(caster, target, spell, effect, aquaveilPower, tick, aquaveilDuration, subid, subpower, tier, params, bonus)
end

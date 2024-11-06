-----------------------------------------
-- Spell: Regeneration
-- Gradually restores HP
-- Spell cost: 36 MP
-- Monster Type: Aquans
-- Spell Type: Magical (Light)
-- Blue Magic Points: 2
-- Stat Bonus: MND+2
-- Level: 61
-- Casting Time: 2 Seconds
-- Recast Time: 60 Seconds
-- Spell Duration: 30 ticks, 90 Seconds
--
-- Combos: None
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.REGEN
    local power = math.ceil(25 * (1 + 0.01 * caster:getMod(tpz.mod.REGEN_MULTIPLIER)))
    local duration = 90
    local tick = 3
    local subid = 0
    local subpower = 0
    local tier = 0
    local bonus = 0
    local params = {}

    return BlueBuffSpell(caster, target, spell, effect, power, tick, duration, subid, subpower, tier, params, bonus)
end

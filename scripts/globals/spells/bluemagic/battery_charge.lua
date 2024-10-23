-----------------------------------------
-- Spell: Battery Charge
-- Gradually restores MP
-- Spell cost: 50 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Light)
-- Blue Magic Points: 3
-- Stat Bonus: MP+10, MND+1
-- Level: 41
-- Casting Time: 5 seconds
-- Recast Time: 75 seconds
-- Spell Duration: 100 ticks, 300 Seconds (5 Minutes)
--
-- Combos: None
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
    local effect = tpz.effect.REFRESH
    local power = 3 + caster:getMod(tpz.mod.ENHANCES_REFRESH)
    local tick = 0
    local duration = 300 + target:getMod(tpz.mod.REFRESH_DURATION)
    local subid = 0
    local subpower = 0
    local tier = 0
    local bonus = 0
    local params = {}

    return BlueBuffSpell(caster, target, spell, effect, power, tick, duration, subid, subpower, tier, params, bonus
end

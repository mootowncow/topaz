-----------------------------------------
-- Spell: Animating Wail
-- Increases attack speed
-- Spell cost: 53 MP
-- Monster Type: Undead
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 5
-- Stat Bonus: HP+20
-- Level: 79
-- Casting Time: 2 Seconds
-- Recast Time: 45 Seconds
-- 5 minutes
--
-- Combos: Dual Wield
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.HASTE
    local power = 2500 -- 256/1024 25%
    local tick = 0
    local duration = 300
    local subid = 0
    local subpower = 0
    local tier = 0
    local bonus = 0
    local params = {}

    return BlueBuffSpell(caster, target, spell, effect, power, tick, duration, subid, subpower, tier, params, bonus)
end

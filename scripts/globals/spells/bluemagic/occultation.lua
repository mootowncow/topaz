-----------------------------------------
-- Spell: Occultation
-- Creates shadow images that each absorb a single attack directed at you
-- Spell cost: 138 MP
-- Monster Type: Seethers
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+3 CHR-2
-- Level: 88
-- Casting Time: 2 seconds
-- Recast Time: 1 minute, 30 seconds
--
-- Combos: Evasion Bonus
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.BLINK
    local skill = caster:getSkillLevel(tpz.skill.BLUE_MAGIC)
    local numShadows = 2 + math.floor(skill / 50) -- 300 skill = 8 shadows
    local duration = 300
    local subid = 0
    local procChance = 75
    local tier = 0
    local bonus = 0
    local params = {}

    return BlueBuffSpell(caster, target, spell, effect, numShadows, tick, duration, subid, procChance, tier, params, bonus)
end

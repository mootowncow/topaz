-----------------------------------------
-- Spell: Diamondhide
-- Gives party members within area of effect the effect of "Stoneskin"
-- Spell cost: 99 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+1
-- Level: 67
-- Casting Time: 7 seconds
-- Recast Time: 1 minute 30 seconds
-- 5 minutes
--
-- Combos: None
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.STONESKIN
    local blueskill = caster:getSkillLevel(tpz.skill.BLUE_MAGIC)
    local power = ((blueskill)/3) *2
    local duration = 300
    local tick = 0
    local subid = 0
    local subpower = 0
    local tier = 0
    local bonus = 0
    local params = {}

    power = utils.ApplyStoneskinBonuses(caster, power)
    utils.ShouldRemoveStoneskin(target, power)

    return BlueBuffSpell(caster, target, spell, effect, power, tick, duration, subid, subpower, tier, params, bonus)
end

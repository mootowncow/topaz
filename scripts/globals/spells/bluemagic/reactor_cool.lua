-----------------------------------------
-- Spell: Reactor Cool
-- Enhances defense and covers you with magical ice spikes. Enemies that hit you take ice damage
-- Spell cost: 28 MP
-- Monster Type: Luminions
-- Spell Type: Magical (Ice)
-- Blue Magic Points: 5
-- Stat Bonus: INT+3 MND+3
-- Level: 74
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Duration: 120 seconds (2 minutes)
--
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
    local effect = tpz.effect.ICE_SPIKES
    local duration = 300
    local effect2 = tpz.effect.AQUAVEIL
    local power2 = 3 + caster:getMod(tpz.mod.AQUAVEIL_COUNT)
    local duration2 = 900
    local tick = 0
    local subid = 0
    local subpower = 0
    local tier = 0
    local bonus = 0
    local params = {}

    local INT = caster:getStat(tpz.mod.INT)
    local MAB = caster:getMod(tpz.mod.MATT)
    local power = math.floor((INT + 50) / 20) * (1 + MAB / 100)

	if power > 15 then
		power = 15
	end

    -- For tracking what skill to use for spikes MACC formula in C++
    target:setCharVar("bluSpikes", 1)

    target:delStatusEffect(effect)

    BlueBuffSpell(caster, target, spell, effect2, power2, tick, duration2, subid, subpower, tier, params, bonus)
    return BlueBuffSpell(caster, target, spell, effect, power, tick, duration, subid, subpower, tier, params, bonus)
end

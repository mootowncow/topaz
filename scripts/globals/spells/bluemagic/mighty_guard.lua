-----------------------------------------
-- Spell: Mighty Guard
-- Increases own defense, magic defenses, and attack speed, and gradually restores own HP.
-- Spell cost: 28 MP
-- Monster Type: Luminions
-- Spell Type: Magical (Ice)
-- Blue Magic Points: 5
-- Stat Bonus: INT+3 MND+3
-- Level: 74
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Duration: 3 minutes
-- Defense +25%
-- Magic Defense Bonus +15
-- Regen +30 HP/tick
-- Magical haste +15%
-- Unique status buff
-- Stacks with other regen, haste, and defense boost buffs including Embrava.
-- Dispelable.
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
    local effect = tpz.effect.MIGHTY_GUARD
    local power = 25
    local duration = 180
    local tick = 3
    local subid = 0
    local subpower = 15
    local tier = 0
    local bonus = 0
    local params = {}

    if (caster:hasStatusEffect(tpz.effect.DIFFUSION)) then
        local diffMerit = caster:getMerit(tpz.merit.DIFFUSION)

        if (diffMerit > 0) then
            duration = duration + (duration/100)* diffMerit
        end

        caster:delStatusEffectSilent(tpz.effect.DIFFUSION)
    end

    -- Apply unbridled duration mod
    duration = math.floor(duration * (1 + caster:getMod(tpz.mod.UNBRIDLED_DURATION) / 100))

    target:addStatusEffect(tpz.effect.MIGHTY_GUARD, 25, 0, duration, 0, 15, 0)
    spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)

    return BlueBuffSpell(caster, target, spell, effect, power, tick, duration, subid, subpower, tier, params, bonus)
end

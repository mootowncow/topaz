-----------------------------------------
-- Spell: Plasma Charge
-- Covers you with magical lightning spikes. Enemies that hit you take lightning damage
-- Spell cost: 24 MP
-- Monster Type: Luminians
-- Spell Type: Magical (Lightning)
-- Blue Magic Points: 5
-- Stat Bonus: STR+3 DEX+3
-- Level: 75
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Duration: 60 seconds
--
-- Combos: Auto Refresh
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
    local typeEffect = tpz.effect.SHOCK_SPIKES
	local INT = caster:getStat(tpz.mod.INT)
    local MAB = caster:getMod(tpz.mod.MATT)
    local power = math.floor((INT + 50) / 20) * (1 + MAB / 100)

	if power > 15 then
		power = 15
	end
    local duration = 900
    -- https://wiki.ffo.jp/html/3177.html

    if (caster:hasStatusEffect(tpz.effect.DIFFUSION)) then
        local diffMerit = caster:getMerit(tpz.merit.DIFFUSION)

        if (diffMerit > 0) then
            duration = duration + (duration/100)* diffMerit
        end

        caster:delStatusEffectSilent(tpz.effect.DIFFUSION)
    end

    if (target:addStatusEffect(typeEffect, power, 0, duration) == false) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return typeEffect
    end

    -- For tracking what skill to use for spikes MACC formula in C++
    target:setCharVar("bluSpikes", 1)

    return typeEffect
end

-----------------------------------------
-- Spell: Magic Fruit
-- Restores HP for the target party member
-- Spell cost: 72 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Light)
-- Blue Magic Points: 3
-- Stat Bonus: CHR+1 HP+5
-- Level: 58
-- Casting Time: 3.5 seconds
-- Recast Time: 6 seconds
--
-- Combos: Resist Sleep
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

    local divisor = 0
    local constant = 0
    local basepower = 0
    local power = 0
    local basecure = 0
    local final = 0
    local minCure = 640
    local divisor = 0.6666
    local constant = 165
    local power = getCurePowerOld(caster)
    local diff = (target:getMaxHP() - target:getHP())

    if (power < 210) then
        divisor = 1.5
        constant = 600
        basepower = 90
    elseif (power < 300) then
        divisor =  0.9
        constant = 680
        basepower = 210
    elseif (power < 400) then
        divisor = 10/7
        constant = 780
        basepower = 300
    elseif (power < 500) then
        divisor = 2.5
        constant = 850
        basepower = 400
    elseif (power < 700) then
        divisor = 5/3
        constant = 890
        basepower = 500
    else
        divisor = 999999
        constant = 1010
        basepower = 0
    end

    local final = getCureFinal(caster, spell, getBaseCureOld(power, divisor, constant), minCure, false)

    final = final + (final * (target:getMod(tpz.mod.CURE_POTENCY_RCVD)/100))

    if (target:getAllegiance() == caster:getAllegiance() and (target:getObjType() == tpz.objType.PC or target:getObjType() == tpz.objType.MOB)) then
        --Applying server mods....
        final = final * CURE_POWER
    end

    if (final > diff) then
        final = diff
    end

	if target:hasStatusEffect(tpz.effect.CURSE_II) then
		target:addHP(0)
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
	else
		target:addHP(final)
		target:wakeUp()
		caster:updateEnmityFromCure(target, final)
		spell:setMsg(tpz.msg.basic.MAGIC_RECOVERS_HP)
	end

    return final
end

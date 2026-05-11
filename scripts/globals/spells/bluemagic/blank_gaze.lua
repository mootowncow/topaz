-----------------------------------------
-- Spell: Blank Gaze
-- Removes one beneficial magic effect from an enemy
-- Spell cost: 25 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Light)
-- Blue Magic Points: 2
-- Stat Bonus: None
-- Level: 38
-- Casting Time: 3 seconds
-- Recast Time: 10 seconds
-- Magic Bursts on: Transfixion, Fusion, Light
-- Combos: None
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local dINT = (caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    local params = {}
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.effect = tpz.effect.NONE
    params.eco = ECO_BEAST
    params.bonus = BlueHandleCorrelationMACC(caster, target, spell, params, 175)
    local effect = tpz.effect.NONE
    local resist = applyResistanceEffect(caster, target, spell, params)

    -- Check for dispel resistance trait
	if math.random(100) < target:getMod(tpz.mod.DISPELRESTRAIT) then
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST_2)
        return effect
    end

    -- Handle Magic Shield
    if target:hasStatusEffect(tpz.effect.MAGIC_SHIELD, 0) and target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() < 2 then
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        return effect
    end

    if (resist >= 0.50) then
        spell:setMsg(tpz.msg.basic.MAGIC_ERASE)
        effect = target:dispelStatusEffect()
        if (effect == tpz.effect.NONE) then
            -- no effect
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return effect
end

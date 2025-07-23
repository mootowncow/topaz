-----------------------------------------
-- Spell: Stinking Gas
-- Lowers Vitality of enemies within range
-- Spell cost: 37 MP
-- Monster Type: Undead
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 2
-- Stat Bonus: AGI+1
-- Level: 44
-- Casting Time: 4 seconds
-- Recast Time: 60 seconds
-- Magic Bursts on: Detonation, Fragmentation, and Light
-- Combos: Auto Refresh
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
    local typeEffect = tpz.effect.CHOKE
    local dINT = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    local params = {}
    params.diff = dINT
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 30

    -- Does not stack with VIT down, choke, or frost
    if (target:getStatusEffect(tpz.effect.RASP) ~= nil) then
        target:delStatusEffectSilent(tpz.effect.RASP)
    end

    params.effect = typeEffect
    local resist = applyResistanceEffect(caster, target, spell, params)
    local DOT = 22
    local duration = 90 * resist
    local statDown = 39

    if not target:getStatusEffect(tpz.effect.FROST) then
        target:delStatusEffectSilent(tpz.effect.RASP)
        if (resist >= 0.5) then
            target:addStatusEffect(params.effect, DOT, 3, duration, 0, statDown, 0)
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end


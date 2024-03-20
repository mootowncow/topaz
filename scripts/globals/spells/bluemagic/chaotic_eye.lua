-----------------------------------------
-- Spell: Chaotic Eye
-- Silences an enemy
-- Spell cost: 13 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 2
-- Stat Bonus: AGI+1
-- Level: 32
-- Casting Time: 3 seconds
-- Recast Time: 10 seconds
-- Magic Bursts on: Detonation, Fragmentation, and Light
-- Combos: Conserve MP
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
    local typeEffect = tpz.effect.SILENCE
    local dINT = (caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    local params = {}
    params.diff = dINT
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
	local lizard = (target:getSystem() == 14)
	local plantoid = (target:getSystem() == 17)
	-- add correlation bonus
	if lizard then
		params.bonus = 25 + caster:getMerit(tpz.merit.MONSTER_CORRELATION) + caster:getMod(tpz.mod.MONSTER_CORRELATION_BONUS)
	elseif plantoid then
		params.bonus = -25
	end

    if target:hasStatusEffect(tpz.effect.SILENCE) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.SILENCE
    end

    local duration = 120
    local isMaaIllmutheBestower = target:getPool() == 2465

    if isMaaIllmutheBestower then
        duration = 30
        target:addTP(3000)
    end

    params.effect = tpz.effect.SILENCE
    if BlueTryEnfeeble(caster, target, spell, 0, 1, 0, duration, params) then
        spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return tpz.effect.SILENCE
end

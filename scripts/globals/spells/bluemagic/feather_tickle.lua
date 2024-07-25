-----------------------------------------
-- Spell: Feather Tickle
-- Paralyzes an enemy(Para II scaling)
-- Spell cost: 48 MP
-- Monster Type: Birds
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 3
-- Stat Bonus: AGI+1
-- Level: 64
-- Casting Time: 4 seconds
-- Recast Time: 26 seconds
-- Magic Bursts on: Detonation, Fragmentation, and Light
-- Combos: Clear Mind
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
    local params = {}
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.PARALYSIS
    params.eco = ECO_BIRD
    local dMND = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
    local power = utils.clamp(math.floor(dMND / 4) + 20, 10, 30)

	if BlueTryEnfeeble(caster, target, spell, 1, power, 0, 180, params) then
        spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
    else
        if (spell:getMsg() ~= tpz.msg.basic.MAGIC_IMMUNE) then
            spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        end
    end
	return params.effect 
end

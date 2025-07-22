---------------------------------------------
-- Louring Skies
--
-- Description: AoE magical damage
-- Type: Magical
-- Additonal effect: Paralyze(66%), and Bind
-- Utsusemi/Blink absorb: Wipes
-- Range: 20 yards (AOE)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 2.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.DARK, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING)
    MobStatusEffectMove(mob, target, tpz.effect.PARALYSIS, 66, 0, 300)
	MobStatusEffectMove(mob, target, tpz.effect.BIND, 1, 0, 15)
	return dmg
end

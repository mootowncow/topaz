---------------------------------------------------
-- Vortex
-- Creates a vortex that damages targets in an area of effect. Additional effect: Terror and bind.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, tpz.magic.ele.NONE, dmgmod, TP_NO_EFFECT, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.NONE, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.NONE)
	MobStatusEffectMoveSub(mob, target, tpz.effect.TERROR, 1, 0, 5, 0, 0, 0)
	MobStatusEffectMoveSub(mob, target, tpz.effect.BIND, 1, 0, 15, 0, 0, 0)
	
	mob:resetEnmity(target)

    return dmg
end

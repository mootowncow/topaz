---------------------------------------------
--  Storm Wing
--
--  Description: Conal Wind damage + Silence.
--  Type:  Magical
--
--  Notes: Long charge up time, easily stunnable.
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 15' radial
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if not target:isInfront(mob, 90) then
        return 1
    end
	return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SILENCE

    local dmgmod = 3.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.WIND, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 300)
    return dmg
end

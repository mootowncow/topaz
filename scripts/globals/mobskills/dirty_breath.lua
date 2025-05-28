---------------------------------------------------
-- Dirty Breath
-- Damage and Zombie.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local typeEffect = tpz.effect.CURSE_II

    if target:hasStatusEffect(tpz.effect.FEALTY) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    else
		MobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)
    end

    local dmgmod = MobHPBasedMove(mob, target, 0.10, 1, tpz.magic.ele.DARK, 350)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.DARK)

    return dmg
end

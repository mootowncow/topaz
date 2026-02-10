---------------------------------------------------
-- self_destruct_Goblin_Grenade
-- Weapon skill for Goblin Grenades
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")

function onMobSkillCheck(target, mob, skill)
   
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local damage = MobHPBasedMove(mob, target, skill, 0.30, 1, tpz.magic.ele.FIRE, 150, true)
    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    return dmg
end

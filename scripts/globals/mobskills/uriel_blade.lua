---------------------------------------------
-- Uriel Blade
--
-- Description: Deals Light elemental damage. Additional effect: Flash
-- Type: Physical
-- Utsusemi/Blink absorb: Ignores.
-- Range: AoE
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 3.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*1.5, tpz.magic.ele.LIGHT, dmgmod, TP_DMG_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    MobStatusEffectMove(mob, target, tpz.effect.FLASH, 300, 3, 12)
    return dmg
end

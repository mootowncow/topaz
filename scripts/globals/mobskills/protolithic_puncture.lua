---------------------------------------------------
-- Protolithic Puncture
--
-- Magical
-- Element: Water
-- Single Target
-- Additional effect: Hate Reset
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local hpp = 0.95
    local dmg = MobThroatStabMove(mob, target, skill, hpp, tpz.attackType.MAGICAL, tpz.damageType.WATER ,MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WATER)
    mob:resetEnmity(target)
    return dmg
end

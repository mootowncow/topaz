---------------------------------------------
--  Hurricane Breath
--
--  Description: Deals wind damage to enemies within a fan-shaped area originating from the caster.
-- Encumbers 1 piece of gear
-- Unusually high damage.
--  Type: Magical (Wind)
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgCap = 700
    if mob:isNM() then
        dmgcap = 1400
    end
    local dmgmod = MobHPBasedMove(mob, target, 0.125, 1, tpz.magic.ele.WIND, dmgcap)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.WIND, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.WIND)
    MobEncumberMove(mob, target, 1, 30)
    return dmg
end

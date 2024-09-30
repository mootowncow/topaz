---------------------------------------------
-- Uproot
--
-- Description: AoE magical damage Additional effect: Slow, hate reset and dispels all effects on self.
-- Type: Magical
-- Element: Light
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    local hasAura = mob:AnimationSub() == 1
    if (hasAura) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local hpp = 0.95
    local dmg = MobThroatStabMove(mob, target, skill, hpp, tpz.attackType.MAGICAL, tpz.damageType.LIGHT ,MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    MobHasteOverwriteSlowMove(mob, target, 5000, 0, 90, 0, 0, 2)
    MobSelfDispelMove(mob, skill)
    mob:resetEnmity(target)
    skill:setMsg(tpz.msg.basic.DAMAGE)
    mob:AnimationSub(1)
    return dmg
end
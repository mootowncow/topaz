---------------------------------------------
--  Scatter Shell
--
--  Description: Shoots multiple needles at enemies within range.
-- 1000 dmg "needles"
--  Type: Magical (Fire)
--
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local mobhp = mob:getHPP()
    local cogtoothSkagnogg = mob:getPool() == 761

    if cogtoothSkagnogg and (mobhp >= 20) then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local needles = 1000 / skill:getTotalTargets()
    local info = MobNeedlesMagicalMove(mob, target, skill, needles, tpz.magic.ele.FIRE, tpeffect)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)

    return dmg
end

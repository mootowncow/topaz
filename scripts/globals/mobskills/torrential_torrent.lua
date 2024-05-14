---------------------------------------------
-- Torrential Torrent
--
--  Description: Subjects nearby targets to water torture. Additional effect: Strips all equipment.
--  Type:  Magical
--
--  Notes: Long charge up time, easily stunnable.
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 30' radial
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end


function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 2.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.WATER, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WATER, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WATER)
    MobEncumberMove(mob, target, 16, 20)
    return dmg
end

---------------------------------------------
--  Vorticose Sands
--
--  Description: Deals severe Wind damage to enemies within an area of effect. Additional effect: Silence, encumberance, enmity reset.
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
    local result = 1
    local mobhp = mob:getHPP()
    local tzeeAMalciousManifest = mob:getPool() == 6770

    if (mobhp <= 25) then
        result = 0
    end

    if tzeeAMalciousManifest then
        result = 0
    end

    return result
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SILENCE

    local dmgmod = 7
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*6, tpz.magic.ele.WIND, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 300)
    MobEncumberMove(mob, target, 5, 20)
    mob:resetEnmity(target)
    return dmg
end

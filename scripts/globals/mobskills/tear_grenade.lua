---------------------------------------------
--  Tear Grenade
--
--  Description: Deals high Fire damage to enemies within an area of effect. Additional effect: TP Reset
--  Type:  Magical
--
--
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 7' radial
--  Notes: Long charge up time, easily stunnable or outran.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    local result = 1
    local mobhp = mob:getHPP()
    local cogtoothSkagnogg = mob:getPool() == 761

    if (mobhp <= 50) then
        result = 0
    end

    if cogtoothSkagnogg then
        result = 0
    end

    return result
end

function onMobWeaponSkill(target, mob, skill)
local cogtoothSkagnogg = mob:getPool() == 761
    local dmgmod = 5
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
        if cogtoothSkagnogg then
            MobStatusEffectMove(mob, target, tpz.effect.BLINDNESS, 20, 0, 300)
            MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 300)
        else
            local typeEffect = tpz.effect.BURN
            local power = 35
            MobStatusEffectMoveSub(mob, target, typeEffect, power, 3, 60, 0, 33, 0)
            target:setTP(0) 
        end
    return dmg
end

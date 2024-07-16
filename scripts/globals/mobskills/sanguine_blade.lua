---------------------------------------------
-- Sanguine Blade
--
-- Description: Drains a percentage of damage dealt to HP varies with TP.
-- Type: Magical
-- Utsusemi/Blink absorb: 1 Shadow?
-- Range: Melee
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 5.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*1.5, tpz.magic.ele.DARK, dmgmod, TP_DMG_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)

    local tp = mob:getLocalVar("tp")
    if (tp >= 1000 and tp <=1999) then
        drain = 50
    elseif (tp >= 2000 and tp <= 2999) then
        drain = 75
    elseif (tp == 3000) then
        drain = 100
    end

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    if not target:isUndead() then
        mob:addHP(math.floor((dmg/100) * drain))
    end
    return dmg
end

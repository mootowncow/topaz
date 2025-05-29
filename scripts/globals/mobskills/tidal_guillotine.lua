---------------------------------------------------
-- Tidal Guillotine
--
-- Magical
-- Element: Water
-- Conal
-- Additional effect: KO if targets HP is below 50%
-- Notes: Only used below 50% HP
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getHPP() > 50) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 5.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.WATER, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WATER, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WATER)
    if target:getHPP() < 50 then
        target:setHP(0)
        return skill:setMsg(tpz.msg.basic.FALL_TO_GROUND)
    end
    return dmg
end

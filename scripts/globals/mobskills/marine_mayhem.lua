---------------------------------------------------
-- Marine Mayhem
--
-- Magical
-- Element: Water
-- AOE 20'
-- Additional effect: KO if targets HP is further than 8' away
-- Notes: Only used below 25% HP
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getHPP() > 25) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 9.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.WATER, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WATER, MOBPARAM_WIPE_SHADOWS)
    local distance = mob:checkDistance(target)
    if (distance > 8) then
        target:setHP(0)
        return skill:setMsg(tpz.msg.basic.FALL_TO_GROUND)
    end
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WATER)
    return dmg
end

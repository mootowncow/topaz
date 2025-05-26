---------------------------------------------------
-- Holy Roll 2
-- Damage dealt is tied to the dice roll divided against each player's max HP.
-- If the Max HP is not divisible by roll, the spell does 0 damage.
-- If roll is 1, the spell will always do damage.
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 0
    if (target:getMaxHP() % 2 == 0) then
        dmgmod = 7
    else
        skill:setMsg(tpz.msg.basic.DAMAGE)
        skill:addFlag(tpz.mobSkillFlag.MAGIC_SKILL)
        return 0
    end
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.LIGHT, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    return dmg
end

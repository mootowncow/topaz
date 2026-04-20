---------------------------------------------
-- Eradicator
--
--  Description: Deals Lightning damage to enemies within AOE. Additional effect: Weakness
-------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if mob:getHPP() > 50 then
        return 1
    end
    
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 5.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.LIGHTNING, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING)
    local params = {}
    params.ALWAYS_ENFEEBLE = true
    MobStatusEffectMove(mob, target, tpz.effect.WEAKNESS, 1, 0, 30, false, params)
    return dmg
end

---------------------------------------------------
-- Typhoean Rage 
-- Deals Severe Wind damage to enemies in an AOE. 
-- Additional effect: Amnesia, Encumbrance, and Muddle
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getHPP() > 50 then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 9.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*2, tpz.magic.ele.WIND, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    MobStatusEffectMove(mob, target, tpz.effect.AMNESIA, 1, 0, 30)
    MobStatusEffectMove(mob, target, tpz.effect.MUDDLE, 1, 0, 30)
    MobEncumberMove(mob, target, FULL_ENCUMBER, 30)
    return dmg
end

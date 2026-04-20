---------------------------------------------------
-- Kaleidoscopic Fury 
-- Deals wind damage to enemies in an AOE. 
-- Additional effect: Dia , All attributes down -80% and Resets all JA timers to max(including 2 hours)
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
    local dmgmod = 4.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*2, tpz.magic.ele.WIND, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    local params = {}
    params.PERCENT_BASED = true
    MobStatusEffectMoveSub(mob, target, tpz.effect.DIA, 80, 3, 180, 0, 15, 3)
    MobAllStatDownMove(mob, target, 80, 60, false, params)
    target:addMaxRecastToAllAbilities(true)
    return dmg
end

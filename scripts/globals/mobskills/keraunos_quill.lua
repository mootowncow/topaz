---------------------------------------------------
-- Keraunos Quill
-- Deals Wind damage to enemies in an AOE. 
-- Additional effect: Paralysis and Encumbrance. Main weapon/sub slot specific. Does not impact ranged or ammo slot. 
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 4.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*2, tpz.magic.ele.WIND, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    local params = {}
    params.PERCENT_BASED = true
    MobStatusEffectMove(mob, target, tpz.effect.PARALYSIS, 20, 0, 60)
    MobEncumberWeaponMove(mob, target, 60)
    return dmg
end

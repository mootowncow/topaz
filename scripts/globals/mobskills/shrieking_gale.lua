---------------------------------------------------
-- Shrieking Gale
-- Deals wind damage to enemies in an AOE. 
-- Additional effect: Dispels 3 effects + Knockback  
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
    MobMultipleDispelMove(mob, target, skill, 3, tpz.magic.ele.WIND, tpz.effectFlag.DISPELABLE)
    -- TODO: Aello is full alliance hate reset
    return dmg
end

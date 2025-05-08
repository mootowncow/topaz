---------------------------------------------
--  Hadal Summons
--
--  Description: Deals Fire damage to enemies in a 10' AOE'. 
--  Additional effect: Burn
--  Type:  Magical
--
--
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 10' Conal
-- The burn effect takes off upwards of 20 HP per tick. -69 INT burn
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BURN
    local power = 10
    local dmgmod = mob:getMainLvl() * 8 + getMobDStat(INT_BASED, mob, target)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    MobStatusEffectMoveSub(mob, target, typeEffect, power, 3, 60, 0, 69, 0)
    return dmg
end

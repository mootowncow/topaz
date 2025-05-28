---------------------------------------------
--  Poison Breath (Hound)
--
--  Description: Deals water damage to enemies within a fan-shaped area originating from the caster. Additional effect: Poison.
--  Type: Magical Water (Element)
--
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local cap = 400
    local percent = 0.0625
    if mob:getName() == 'Hound_of_Balthazar' then
        cap = 1250
        percent = 0.10
    end
    local typeEffect = tpz.effect.POISON
    local power = 1
    local dmgmod = MobHPBasedMove(mob, target, skill, percent, 1, tpz.magic.ele.WATER, cap)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.WATER)
    MobStatusEffectMove(mob, target, typeEffect, power, 3, 90)
    return dmg
end

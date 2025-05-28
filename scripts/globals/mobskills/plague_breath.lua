---------------------------------------------
--  Plague Breath
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
    local typeEffect = tpz.effect.POISON
    local power = math.floor(mob:getMainLvl() / 10)
    local dmgmod = MobHPBasedMove(mob, target, 0.0625, 1, tpz.magic.ele.WATER, 500)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.WATER)
    MobStatusEffectMove(mob, target, typeEffect, power, 3, 90)
    if (mob:getPool() == 9067) then -- Kendi
        target:delStatusEffectSilent(tpz.effect.POISON)
        MobStatusEffectMove(mob, target, tpz.effect.CURSE_II, 1, 0, 90)
        mob:resetEnmity(target)
    end
    return dmg
end

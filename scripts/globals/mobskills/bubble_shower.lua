---------------------------------------------------
-- Bubble Shower
-- Deals Water damage in an area of effect. Additional effect: STR Down
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local isKrabkatoa = mob:getPool() == 6830

    if isKrabkatoa then
        skill:setDistance(50)
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.STR_DOWN
    local tick = 30
    local power = (target:getStat(tpz.mod.STR) * 0.2) +5
    local cap = 200
    local isKrabkatoa = mob:getPool() == 6830

    if isKrabkatoa then
        cap = 600
    end

    local dmgmod = MobHPBasedMove(mob, target, 0.0625, 1, tpz.magic.ele.WATER, cap)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.WATER)
    MobStatusEffectMove(mob, target, typeEffect, power, tick, 300)
    return dmg
end

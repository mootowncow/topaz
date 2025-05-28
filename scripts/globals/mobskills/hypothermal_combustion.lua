---------------------------------------------
-- Hypothermal Combustion
-- Self-destructs, releasing ice at nearby targets.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores shadows
-- Notes: Damage is based on remaining HP
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    mob:setLocalVar("self-destruct_hp", mob:getHP())
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local damage = MobHPBasedMove(mob, target, 0.30, 1, tpz.magic.ele.ICE, 1250, true)
    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.ICE, MOBPARAM_IGNORE_SHADOWS)

    local isSnollTzar = mob:getPool() == 3684
    if isSnollTzar then
        dmg = 9999
    end

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ICE)
    mob:setHP(0)
    return dmg
end

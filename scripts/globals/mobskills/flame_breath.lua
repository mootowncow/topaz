---------------------------------------------
-- Flame Breath
-- Description: Deals fire damage to enemies within a fan-shaped area originating from the caster.
-- Type: Magical Fire (Element)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local dmgmod = MobHPBasedMove(mob, target, 0.10, 1, tpz.magic.ele.FIRE, 900)
    if mob:getPool() == 9056 then -- Vishap(Assault - Lebros Cavern)
        dmgmod = MobHPBasedMove(mob, target, 0.10, 1, tpz.magic.ele.FIRE, 500)
    end

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.FIRE)
    return dmg
end

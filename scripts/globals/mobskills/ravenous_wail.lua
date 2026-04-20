---------------------------------------------------
-- Ravenous Wail 
-- Deals Breath Wind damage to enemies in an AOE. 
-- Additional effect: Amnesia, Encumbrance, and Muddle
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = MobHPBasedMove(mob, target, skill, 0.125, 1, tpz.magic.ele.WIND, 1250)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.WIND, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.WIND)
    MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.STUN, 1, 0, 4)
    return dmg
end

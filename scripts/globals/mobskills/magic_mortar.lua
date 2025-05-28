---------------------------------------------------
-- Magic Mortar
-- Deals damage based on mobs current HP.
-- Notes: Extremely high damage
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
    local dmgmod = MobHPBasedMove(mob, target, 0.0625, 1, tpz.magic.ele.NONE, 9999, false, true)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.ELEMENTAL, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.ELEMENTAL)
    return dmg
end

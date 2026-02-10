---------------------------------------------------
-- Mijin Gakure
-- Used by Vee Ladu the Titterer
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end


function onMobWeaponSkill(target, mob, skill)
    local damage = MobHPBasedMove(mob, target, skill, 0.30, 1, tpz.magic.ele.NONE, 1250, true)
    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.NONE, MOBPARAM_IGNORE_SHADOWS)

    if target:hasStatusEffect(tpz.effect.FEALTY) then
        dmg = math.floor(dmg / 16)
    end

    mob:setUnkillable(false)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.NONE)
    return dmg
end

---------------------------------------------------
-- FloodELEMENTAL
--
-- Description:  ~300 magic damage, Flash, Blind and Silence, ignores Utsusemi
-- Type: Magical
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- Only uses Laser Shower and Colossal Blow the final phase
    local currentForm = mob:getLocalVar("form") -- this var is only set for proto-omega
    if (currentForm == 2) and mob:AnimationSub() == 2 then
        return 1
    end
    if mob:AnimationSub() == 2 then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.LIGHT, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_IGNORE_SHADOWS)

    MobStatusEffectMove(mob, target, tpz.effect.BLINDNESS, 30, 3, 300)
    MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 300)
    MobStatusEffectMove(mob, target, tpz.effect.FLASH, 300, 3, 12)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    return dmg
end

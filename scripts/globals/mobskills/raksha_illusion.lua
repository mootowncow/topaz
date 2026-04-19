---------------------------------------------------
-- Raksha Illusion
-- Deals magic Damage. Additional effect: Paralysis and Curse (-50% HP/MP)
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/mobs")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getLocalVar("Stance" == tpz.mob.NarakaStance.MDT) then
        return 0
    end

    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 2
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, tpz.magic.ele.DARK, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    MobStatusEffectMove(mob, target, tpz.effect.PARALYSIS, 25, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.CURSE_I, 50, 0, 60)

    return dmg
end

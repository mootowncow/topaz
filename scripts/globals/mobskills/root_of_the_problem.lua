---------------------------------------------
-- Root of the problem
--
-- Description: AoE magical damage
-- Additional effect: All stats down (unerasable), absorbs a buff, HP and TP from players
-- Type: Magical
-- Element: Earth
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 3.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.EARTH, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg , mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.EARTH, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.EARTH)
	MobDrainMove(mob, target, skill, MOBDRAIN_HP, dmg, tpz.attackType.MAGICAL, tpz.damageType.EARTH)
    MobDrainMove(mob, target, skill, MOBDRAIN_TP, dmg, tpz.attackType.MAGICAL, tpz.damageType.EARTH)
    MobDrainStatusEffectMove(mob, target)
    MobAllStatDownMove(mob, target, 21, 60)
    for v = tpz.effect.STR_DOWN, tpz.effect.CHR_DOWN do
        local effect = target:getStatusEffect(v)
        effect:unsetFlag(tpz.effectFlag.WALTZABLE)
        effect:unsetFlag(tpz.effectFlag.ERASABLE)
    end
    return dmg
end
---------------------------------------------
--  Shadow Burst
--
--  Description: Darkess Damage + Curse (-50% HP/MP)
--  Type: Magical
--  Utsusemi/Blink absorb: Removes shadows.
--  Range: Melee
--  Notes: (NMs Only)
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if mob:isNM() then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
local typeEffect = tpz.effect.CURSE_I
    local dmgmod = 9
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, tpz.magic.ele.DARK, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
	MobStatusEffectMove(mob, target, typeEffect, 50, 0, 300)
    return dmg
end

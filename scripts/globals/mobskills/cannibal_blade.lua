---------------------------------------------------
-- Cannibal Blade
-- Drains HP from the target.
-- Notes: Cannot be resisted, only reduced by Slashing resistance.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 9

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.NONE, dmgmod, TP_IGNORE_MACC, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.SLASHING, MOBPARAM_IGNORE_SHADOWS)
    skill:setMsg(MobDrainMove(mob, target, skill, MOBDRAIN_HP, dmg, tpz.attackType.MAGICAL, tpz.damageType.SLASHING))
    return dmg
end

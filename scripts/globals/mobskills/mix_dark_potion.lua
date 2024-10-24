---------------------------------------------
-- Mix: Dark Potion
--
--  Description: Deals Dark magical damage (666 fixed damage, ignores resistance and magic defense).
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local params = {}
    params.IGNORE_DAMAGE_REDUCTION = true
    local dmgmod = 666
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS, params)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    skill:setMsg(tpz.msg.basic.DAMAGE_SECONDARY) -- TODO: Wrong msg
    return dmg
end

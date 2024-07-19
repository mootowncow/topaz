---------------------------------------------
--  Sunburst
--
--  Description: Deals light OR dark damage
--  Type: Magical LIght OR Dark
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
    -- 50/50 shot of being light or dark
    local element = tpz.magic.ele.LIGHT
    local damageType = tpz.damageType.LIGHT
    if math.random() < 0.5 then
        element = tpz.magic.ele.DARK
        damageType = tpz.damageType.DARK
    end

    local dmgmod = 4
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*1, element, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, damageType, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, damageType)
    return dmg
end

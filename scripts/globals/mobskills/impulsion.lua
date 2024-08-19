---------------------------------------------
--  Impulsion
--  Family: Bahamut
--  Description: Deals unaspected elemental damage around the target.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range:
--  Notes: Damage and petrification duration increases at lower HP
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local hp = mob:getHPP()
    local multiplier = 2.75
    local duration = 15

    if (hp < 60) then
        multiplier = 5.5
        duration = 30
    end

    local dmgmod = math.floor(mob:getMainLvl() * multiplier)
    -- Check for resist
    local resist = ApplyPlayerGearResistModCheck(mob, target, typeEffect, getMobDStat(INT_BASED, mob, target), 0, tpz.magic.ele.NONE)
    dmgmod = dmgmod * resist
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL)
    MobStatusEffectMoveSub(mob, target, tpz.effect.PETRIFICATION, 1, 0, duration, 0, 0, 0)
    return dmg
end

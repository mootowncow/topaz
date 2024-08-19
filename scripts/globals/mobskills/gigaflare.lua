---------------------------------------------
--  Gigaflare
--  Family: Bahamut
--  Description: Deals massive Fire damage to enemies within a fan-shaped area.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range:
--  Notes: Used by Bahamut when at 10% of its HP, and can use anytime afterwards at will.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    mob:setLocalVar("GigaFlare", 1) -- When set to 1 the script won't call it.
    mob:setLocalVar("tauntShown", 0)
    mob:SetMobAbilityEnabled(true) -- enable the spells/other mobskills again
    mob:SetMagicCastingEnabled(true)
    if (bit.band(mob:getBehaviour(), tpz.behavior.NO_TURN) == 0) then -- re-enable noturn
        mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    end

    local dmgmod = math.floor(mob:getMainLvl() * 14) + math.floor(getMobDStat(INT_BASED, mob, target) * 1.5)
    -- Check for resist
    local resist = ApplyPlayerGearResistModCheck(mob, target, typeEffect, getMobDStat(INT_BASED, mob, target), 0, tpz.magic.ele.FIRE)
    dmgmod = dmgmod * resist
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    return dmg
end

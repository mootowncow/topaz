---------------------------------------------
--  Gates of Hades
--
--  Description: Deals severe Fire damage to enemies within an area of effect. Additional effect: Burn
--  Type:  Magical
--
--
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 20' radial
--  Notes: Only used when a cerberus's health is 25% or lower (may not be the case for Orthrus). The burn effect takes off upwards of 20 HP per tick.
-- The burn effect takes off upwards of 20 HP per tick. -69 INT burn
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if mob:getName() == 'Marquis_Naberius' or mob:getName() == 'Canis_Dirus' then
        return 0
    end

    local family = mob:getFamily()
    if (family == 316) then
        local mobSkin = mob:getModelId()

        if (mobSkin == 1793) then
            return 0
        else
            return 1
        end
    end

    local result = 1
    local mobhp = mob:getHPP()
    if (family == 315 and mobhp < 50) then -- Tyger < 50%
        result = 0
    end

    if (mobhp <= 25) then
        result = 0
    end

    return result
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BURN
    local dot = 40
    local intDown = 69
    local dmgmod = mob:getMainLvl() * 12.5 + getMobDStat(INT_BASED, mob, target)

    if mob:getName() == 'Canis_Dirus' then
        dot = 20
        intDown = 43
    end 
    
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    MobStatusEffectMoveSub(mob, target, typeEffect, dot, 3, 60, 0, intDown, 0)
    return dmg
end

---------------------------------------------
-- Fulmination
--
-- Description: Deals heavy magical damage in an area of effect. Additional effect: Paralysis + Stun
-- Type: Magical
-- Utsusemi/Blink absorb: Wipes Shadows
-- Range: 30 yalms
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if(mob:getFamily() == 316) then
        local mobSkin = mob:getModelId()

        if (mobSkin == 1805) then
            return 0
        else
            return 1
        end
    end

    if mob:getName() == "Harpimaira" then
        return 0
    end
    
    local family = mob:getFamily()
    local mobhp = mob:getHPP()
    local result = 1

    if (family == 168 and mobhp < 35) then -- Khimaira < 35%
        result = 0
    elseif (family == 315 and mobhp < 50) then -- Tyger < 50%
        result = 0
    end

    return result
end

function onMobWeaponSkill(target, mob, skill)

-- TODO: Hits all players near Khimaira, not just alliance.

    local dmgmod = 9
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, tpz.magic.ele.THUNDER, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING, MOBPARAM_WIPE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING)
    MobStatusEffectMove(mob, target, tpz.effect.PARALYSIS, 65, 0, 300)
    MobStatusEffectMove(mob, target, tpz.effect.STUN, 1, 0, 8)
    return dmg
end

---------------------------------------------
-- Nerve Gas
--
-- Description: Inflicts 50% curse and powerful poison.
-- Type: Magical
-- Wipes Shadows
-- Range: 10' Radial
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getFamily() == 316) then -- PW
        local mobSkin = mob:getModelId()
        if (mobSkin == 1796) then
            return 0
        else
            return 1
        end
    end
    
   if mob:getPool() == 2018 and mob:AnimationSub() < 2 then -- Hydra HNM
        return 1
    else
        return 0
    end

end

function onMobWeaponSkill(target, mob, skill)

    local dmgmod = 5
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, tpz.magic.ele.WATER, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WATER, MOBPARAM_WIPE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WATER)

    MobStatusEffectMove(mob, target, tpz.effect.CURSE_I, 50, 0, 300)
    MobStatusEffectMove(mob, target, tpz.effect.POISON, 20, 3, 90)
    return dmg
end

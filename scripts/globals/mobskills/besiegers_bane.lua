---------------------------------------------
-- Besieged Bane
-- AOE Bio, Zombie, and Terror
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getHPP() > 25 then
        return 1
    end
    
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.TERROR


    MobStatusEffectMove(mob, target, tpz.effect.CURSE_II, 1, 0, 30)
    MobStatusEffectMoveSub(mob, target, skill, tpz.effect.BIO, 56, 3, 180, 0, 15, 3)
    skill:setMsg(MobStatusEffectMove(mob, target, tpz.effect.TERROR, 1, 0, 15))

    return typeEffect
end

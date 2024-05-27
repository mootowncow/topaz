---------------------------------------------
-- Dissipation
-- Dispels all and add terror effect
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.TERROR
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 10)

    local count =  MobFullDispelMove(mob, target, skill, tpz.effectFlag.DISPELABLE)

    if (count == 0 or count == tpz.effect.NONE) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    else
        skill:setMsg(tpz.msg.basic.DISAPPEAR_NUM)
    end
    mob:resetEnmity(target)
    return count
end

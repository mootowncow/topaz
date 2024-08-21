---------------------------------------------
-- Horrible Roar
--
-- Description: Dispels four effects from targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' radial
-- Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dis1 = MobDispelMove(mob, target, skill, tpz.magic.ele.DARK, tpz.effectFlag.DISPELABLE, tpz.effectFlag.FOOD)
    local dis2 = MobDispelMove(mob, target, skill, tpz.magic.ele.DARK, tpz.effectFlag.DISPELABLE, tpz.effectFlag.FOOD)
    local dis3 = MobDispelMove(mob, target, skill, tpz.magic.ele.DARK, tpz.effectFlag.DISPELABLE, tpz.effectFlag.FOOD)
    local dis4 = MobDispelMove(mob, target, skill, tpz.magic.ele.DARK, tpz.effectFlag.DISPELABLE, tpz.effectFlag.FOOD)

    local dispelledCount = 0
    
    if dis1 ~= tpz.effect.NONE then dispelledCount = dispelledCount + 1 end
    if dis2 ~= tpz.effect.NONE then dispelledCount = dispelledCount + 1 end
    if dis3 ~= tpz.effect.NONE then dispelledCount = dispelledCount + 1 end
    if dis4 ~= tpz.effect.NONE then dispelledCount = dispelledCount + 1 end

    if dispelledCount > 0 then
        skill:setMsg(tpz.msg.basic.DISAPPEAR_NUM)
        return dispelledCount
    else
        skill:setMsg(tpz.msg.basic.SKILL_MISS) -- no effect
        return 0
    end
end

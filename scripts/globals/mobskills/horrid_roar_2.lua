---------------------------------------------
-- Horrid Roar (Nidhogg)
-- Dispels all buffs including food. Lowers Enmity.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:AnimationSub() == 1) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dispel =  MobFullDispelMove(mob, target, skill, tpz.effectFlag.DISPELABLE, tpz.effectFlag.FOOD)

    if (dispel == tpz.effect.NONE) then
        -- no effect
        skill:setMsg(tpz.msg.basic.SKILL_MISS) -- no effect
    else
        skill:setMsg(tpz.msg.basic.DISAPPEAR_NUM)
    end

    mob:lowerEnmity(target, 45)

    return dispel
end

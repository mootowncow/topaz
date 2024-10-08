---------------------------------------------
-- Horrid Roar (Fafnir, Cynoprosopi, Smok)
-- Dispels a single buff at random which could be food.  Lowers Enmity.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if not target:isInfront(mob, 90) then
        return 1
    elseif mob:AnimationSub() == 1 then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dispel = MobDispelMove(mob, target, skill, tpz.magic.ele.DARK, tpz.effectFlag.DISPELABLE, tpz.effectFlag.FOOD)

    if (dispel == tpz.effect.NONE) then
        -- no effect
        skill:setMsg(tpz.msg.basic.SKILL_MISS) -- no effect
    else
        skill:setMsg(tpz.msg.basic.SKILL_ERASE)
    end

    mob:lowerEnmity(target, 20)

    return dispel
end

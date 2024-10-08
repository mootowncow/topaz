---------------------------------------------
-- Horrid Roar (Tiamat, Jormungand, Vrtra, Ouryu)
-- Dispels all buffs including food. Lowers Enmity.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES)) then
        return 1
    elseif (mob:hasStatusEffect(tpz.effect.INVINCIBLE)) then
        return 1
    elseif (mob:hasStatusEffect(tpz.effect.BLOOD_WEAPON)) then
        return 1
    elseif (mob:AnimationSub() == 1) then
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

    mob:lowerEnmity(target, 70)

    return dispel
end

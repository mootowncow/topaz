---------------------------------------------
-- Goblin Dice
--
-- Description: Stun
-- Type: Physical (Blunt)
--
--
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
    local slowed = false
    local sleeped = false

    slowed = MobStatusEffectMove(mob, target, tpz.effect.SLOW, 1250, 0, 300)
    sleeped = MobStatusEffectMove(mob, target, tpz.effect.SLEEP_I, 1, 0, 30)

    skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
    if sleeped then
        return tpz.effect.SLEEP_I
    elseif slowed then
        return tpz.effect.SLOW
    else
        skill:setMsg(tpz.msg.basic.SKILL_MISS) -- no effect
    end

    return typeEffect
end

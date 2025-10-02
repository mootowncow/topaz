---------------------------------------------
---  Efflorescent Foetor
---
---  Description: Sprays toxic pollen in a fan-shaped area of effect, inflicting Blind & Silence.
-- Open mouth only (Aimation Sub 6)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:AnimationSub() == 6) or (mob:AnimationSub() == 2) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = 0
    local currentMsg = tpz.msg.basic.NONE
    local msg = tpz.msg.basic.NONE

    msg = MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 300)

    if (msg == tpz.msg.basic.SKILL_ENFEEB_IS) then
        typeEffect = tpz.effect.SILENCE
        currentMsg = msg
    end

    msg = MobStatusEffectMove(mob, target, tpz.effect.BLINDNESS, 100, 0, 300)

    if (msg == tpz.msg.basic.SKILL_ENFEEB_IS) then
        typeEffect = tpz.effect.BLINDNESS
        currentMsg = msg
    end

    skill:setMsg(currentMsg)

    return typeEffect
end

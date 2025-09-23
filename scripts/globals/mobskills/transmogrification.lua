---------------------------------------------
--  Transmogrification
--
--  Description: Activates a shield to absorb all incoming physical damage.
--  Type: Magical
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:AnimationSub() == 0) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)

	mob:addStatusEffect(tpz.effect.PHYSICAL_SHIELD, 2, 0, 30)
    target:setEffectUndispellable(tpz.effect.PHYSICAL_SHIELD)
    skill:setMsg(tpz.msg.basic.NONE)

    return 0
end

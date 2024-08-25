---------------------------------------------
-- Enervation
--
-- Description: Lowers the defense and magical defense of enemies within range.
-- Type: Magical (Dark)
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
    local typeEffect = tpz.effect.DEFENSE_DOWN

    local defDown = false
    local mdefDown = false

    defDown = MobStatusEffectMoveSub(mob, target, tpz.effect.DEFENSE_DOWN, 50, 0, 30, 0, 0, 0)
    mdefDown = MobStatusEffectMoveSub(mob, target, tpz.effect.MAGIC_DEF_DOWN, 50, 0, 30, 0, 0, 0)

    skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)

    -- display defDown first, else blind
    if (defDown == tpz.msg.basic.SKILL_ENFEEB_IS) then
        typeEffect = tpz.effect.DEFENSE_DOWN
    elseif (mdefDown == tpz.msg.basic.SKILL_ENFEEB_IS) then
        typeEffect = tpz.effect.MAGIC_DEF_DOWN
    else
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end

    return typeEffect
end

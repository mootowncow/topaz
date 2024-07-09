---------------------------------------------
-- Wild Card
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    mob:setTP(3000)
    skill:setMsg(tpz.msg.basic.USES)

    return tpz.effect.WILD_CARD
end

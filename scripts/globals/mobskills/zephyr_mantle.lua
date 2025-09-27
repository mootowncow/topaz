---------------------------------------------
--  Zephyr Mantle
--
--  Description: Creates shadow images that each absorb a single attack directed at you.
--  Type: Magical (Wind)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local shadows = 4
    if mob:isNM() then
        shadows = 10
    end
    local typeEffect = tpz.effect.BLINK
    local procChance = 75

    skill:setMsg(MobBuffMoveSub(mob, typeEffect, shadows, 0, 300, 0, procChance, 0))
    return typeEffect
end

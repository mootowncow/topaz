---------------------------------------------
-- Tortoise Song
--
-- Description: Removes all status effects in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 20' radial
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
    local dispelAttempts = 0
    local dispelCount = 0

    while dispelAttempts < 3 do
        if MobDispelMove(mob, target, skill, tpz.magic.ele.LIGHT, tpz.effectFlag.DISPELABLE) ~= tpz.effect.NONE then
            dispelCount = dispelCount + 1
        end

        dispelAttempts = dispelAttempts + 1
    end

    if (dispelCount == 0) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    else
        skill:setMsg(tpz.msg.basic.DISAPPEAR_NUM)
    end

    return dispelCount
end

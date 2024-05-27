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
    local count =  MobFullDispelMove(mob, target, skill, tpz.effectFlag.SONG, tpz.effectFlag.ROLL)

    if (count == 0 or count == tpz.effect.NONE) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    else
        skill:setMsg(tpz.msg.basic.DISAPPEAR_NUM)
    end

    return count
end

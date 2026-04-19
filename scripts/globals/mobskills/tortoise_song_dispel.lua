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
    return skill:setMsg(MobMultipleDispelMove(mob, target, skill, 3, tpz.magic.ele.LIGHT, tpz.effectFlag.DISPELABLE))
end

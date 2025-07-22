---------------------------------------------
--  Fomor Level Up
--  Description: Used to play the level up animation
--  for Shadowreign Fomors and to provide stat bonuses.
--  Type: NA
--  Utsusemi/Blink absorb: NA
--  Range: NA
--  Notes: Additional tuning may be needed in mob lua.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    skill:setMsg(0)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end
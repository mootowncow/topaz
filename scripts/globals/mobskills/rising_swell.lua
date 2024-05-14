---------------------------------------------
--  Rising Swell
--
--  Description: Strips all players in an area of effect of all equipment. 
--  Type:  Magical
--
--  Utsusemi/Blink absorb: Ignores Shadows.
--  Range: 30' radial
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if (mob:isNM()) then
        return 0
    end
    return 1
end



function onMobWeaponSkill(target, mob, skill)
	MobEncumberMove(mob, target, 5, 20)
	skill:setMsg(tpz.msg.basic.NONE)
    return 0
end

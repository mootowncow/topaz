---------------------------------------------
-- Afflicting Gaze
--
-- Description: Gaze Plague (250/tick) + Bind.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    MobGazeMove(mob, target, tpz.effect.PLAGUE, 25, 3, 60)
    return skill:setMsg(MobGazeMove(mob, target, tpz.effect.BIND, 1, 0, 45))
end

---------------------------------------------
-- Mix: Dry Ether Concotion
--
-- Description: Restores MP to Target
-- Type: Healing
-- Utsusemi/Blink absorb: N/A
-- Range: 21 Yalms
-- Notes: Restores 160 MP
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local mpRestored = 160
    target:addMP(mpRestored)
    skill:setMsg(tpz.msg.basic.RECOVERS_MP)

    return mpRestored
end

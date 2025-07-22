---------------------------------------------
-- Cimicine Discharge
-- Reduces the attack speed of enemies within range.
-- Duration: Variable, with max of 3 min
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    if not mob:hasStatusEffect(tpz.effect.HASTE) then
        mob:addStatusEffect(tpz.effect.HASTE, 6000, 0, 120)
    end

    skill:setMsg(MobHasteOverwriteSlowMove(mob, target, 3000, 0, 90, 0, 0, 2))

    return tpz.effect.SLOW
end

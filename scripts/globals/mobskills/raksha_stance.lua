---------------------------------------------------
-- Raksha Stance
-- Gains -50% magic damage taken and erases status ailments. 
-- Dispels three status enhancements from nearby players. 
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/mobs")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getLocalVar("Stance" == tpz.mob.NarakaStance.MDT) then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    mob:setLocalVar("Stance", tpz.mob.NarakaStance.MDT)
    return skill:setMsg(MobMultipleDispelMove(mob, target, skill, 3, tpz.magic.ele.DARK, tpz.effectFlag.DISPELABLE))
end
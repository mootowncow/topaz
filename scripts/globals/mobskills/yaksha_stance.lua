---------------------------------------------------
-- Yaksha Stance
-- Gains -50% physical damage taken and erases status ailments. 
-- Fully erases negative status effects off sef.
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/mobs")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getLocalVar("Stance" == tpz.mob.NarakaStance.PDT) then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    mob:setLocalVar("Stance", tpz.mob.NarakaStance.PDT)
    return MobSelfDispelMove(mob, skill)
end
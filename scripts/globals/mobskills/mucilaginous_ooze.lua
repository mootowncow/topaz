---------------------------------------------------
--  Mucilaginous Ooze
--  Family: Slugs
--  Description: A dusky slime inflicts slow and a long encumberance.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Cone
--  Notes:
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getPool() == 1847 then -- Gummy Guillaume
        if mob:getHPP() > 50 then
            return 1
        else
            return 0
        end
    end
    if mob:isNM()
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLOW
    local duration = 300

    MobStatusEffectMove(mob, target, typeEffect, 2550, 0, duration)
    MobEncumberMove(mob, target, 16, 20)
	return typeEffect
end

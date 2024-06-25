---------------------------------------------
--  Petalback Spin
--  Inflicts Poison, Paralyze, Blind, Silence, Plague and Amnesia and resets hate on only the primary target of the move.
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    MobStatusEffectMove(mob, target, tpz.effect.SLOW, 2500, 0, 300)
    MobStatusEffectMove(mob, target, tpz.effect.POISON, 25, 3, 90)
    MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 300)
    MobStatusEffectMove(mob, target, tpz.effect.PARALYSIS, 25, 0, 300)
    MobStatusEffectMove(mob, target, tpz.effect.BLINDNESS, 20, 0, 300)
    MobStatusEffectMove(mob, target, tpz.effect.PLAGUE, 1, 0, 300)
    skill:setMsg(MobStatusEffectMove(mob, target, tpz.effect.AMNESIA, 1, 0, 30))
    -- Only resets enmity on main target
    if (target:getID() == skill:getPrimaryTargetID()) then
        mob:resetEnmity(target)
    end

    return tpz.effect.AMNESIA
end

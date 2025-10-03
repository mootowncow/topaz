---------------------------------------------
-- Contagion Transfer
-- Absorbs all negative and positive status effects from players in AoE range.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    mob:setLocalVar("effectsDrained", 1)
    return MobDrainAllStatusEffectMove(mob, target, skill, { tpz.effectFlag.ERASABLE, tpz.effectFlag.WALTZABLE, tpz.effectFlag.DISPELABLE} )
end


---------------------------------------------------
-- Flame_Thrower
-- Description: Uses a flamethrower that deals Fire damage to players in a fan-shaped area of effect. Additional effect: Plague
-- Type: BREATH
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- skillList  54 = Omega
    -- skillList 727 = Proto-Omega
    -- skillList 728 = Ultima
    -- skillList 729 = Proto-Ultima
    local skillList = mob:getMobMod(tpz.mobMod.SKILL_LIST)
    local mobhp = mob:getHPP()
    local phase = mob:getLocalVar("battlePhase")
	
    if mob:getLocalVar("nuclearWaste") == 1 then
        return 0
    end
	
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PLAGUE

    local dmgmod = 2.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.FIRE, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.FIRE)
    MobStatusEffectMove(mob, target, typeEffect, 3, 3, 300)
    if target:hasStatusEffect(tpz.effect.ELEMENTALRES_DOWN) then
        target:delStatusEffectSilent(tpz.effect.ELEMENTALRES_DOWN)
    end
    mob:setLocalVar("nuclearWaste", 0)
    return dmg
end
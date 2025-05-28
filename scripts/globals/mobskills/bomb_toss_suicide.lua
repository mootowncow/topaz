---------------------------------------------------
-- Bomb Toss - Suicide
-- Throws a bomb at an enemy. Sometimes backfires.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- notorious monsters shouldn't explode, nor dynamis
    if mob:isNM() or mob:isInDynamis() then
        return 1
    end
    mob:setLocalVar("self-destruct_hp", mob:getHP())

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local damage = MobHPBasedMove(mob, target, 0.30, 1, tpz.magic.ele.FIRE, 1250, true)
    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    mob:setHP(0)
    return dmg
end

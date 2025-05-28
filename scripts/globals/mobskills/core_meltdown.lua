---------------------------------------------------
-- Core Meltdown (Ghrah)
-- Reactor core fails and self-destructs, damaging any nearby targets.
-- Note: Only used below 30% HP
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:isNM()) then
        return 1
    elseif (mob:AnimationSub() ~=0) then -- form check
        return 1
    elseif (mob:getHPP() > 30) then
        return 1
    else
        mob:setLocalVar("self-destruct_hp", mob:getHP())
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local damage = MobHPBasedMove(mob, target, 0.50, 1, tpz.magic.ele.NONE, 1250, true)
    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL)
    mob:setHP(0)
    return dmg
end


---------------------------------------------------
-- Mijin Gakure
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    mob:setLocalVar("self-destruct_hp", mob:getHP())
    return 0
end


function onMobWeaponSkill(target, mob, skill)
    local damage = MobHPBasedMove(mob, target, 0.30, 1, tpz.magic.ele.NONE, 1250, true)
    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.NONE, MOBPARAM_IGNORE_SHADOWS)

    if target:hasStatusEffect(tpz.effect.FEALTY) then
        dmg = math.floor(dmg / 16)
    end

    local veeLadutheTitterer = mob:getID() == 17183035
    if veeLadutheTitterer then
        mob:setUnkillable(false)
        mob:setHP(0)
    end

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.NONE)
    return dmg
end

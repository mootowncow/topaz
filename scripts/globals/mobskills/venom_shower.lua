---------------------------------------------------
-- Venom Shower
-- Deals Water damage to enemies within an area of effect.
-- Additional effect: Poison and Defense Down
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.POISON
    local dmgmod = 2
    local power = 40

    if mob:isPet() then
        local master = mob:getMaster()
        if master:isPC() then
            power = math.floor(mob:getMainLvl() / 2)
        end
    end

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, tpz.magic.ele.WATER, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WATER, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WATER)
    target:delStatusEffect(tpz.effect.POISON)
    MobStatusEffectMove(mob, target, typeEffect, power, 3, 60)
    MobStatusEffectMove(mob, target, tpz.effect.DEFENSE_DOWN, 25, 0, 60)

    local effect1 = target:getStatusEffect(typeEffect)
    if (effect1 ~= nil) then
        effect1:unsetFlag(tpz.effectFlag.WALTZABLE)
    end

    return dmg
end

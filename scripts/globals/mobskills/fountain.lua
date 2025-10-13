---------------------------------------------------
-- Fountain
-- Deals water damage.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local mobhp = mob:getHPP()
    local cogtoothSkagnogg = mob:getPool() == 761

    if cogtoothSkagnogg and (mobhp < 60) then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 3
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.WATER, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)

    if (mob:getPool() == 3075) then -- Overlord Bakgodek
        dmgmod = 5
    end

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WATER)
    return dmg
end

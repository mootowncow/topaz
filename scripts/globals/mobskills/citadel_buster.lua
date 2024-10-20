---------------------------------------------
-- Citadel Buster
-- Deals extreme Light damage to players in an area of effect.
-- Additional effect: Enmity reset
-- Notes: Deals 2088 base damage
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
local ID = require("scripts/zones/Temenos/IDs")

---------------------------------------------
-- https://www.bluegartr.com/threads/56406-Citadel-Buster?p=1965356&viewfull=1#post1965356
-- 6x multiplier?
function onMobSkillCheck(target,mob,skill)
    if (mob:getHPP() > 20) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local params = {}
    params.DAMAGE_OVERRIDE = 2088
    local dmgmod = 8
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.LIGHT, dmgmod, TP_NO_EFFECT, 0, params)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    mob:resetEnmity(target)
    return dmg
end
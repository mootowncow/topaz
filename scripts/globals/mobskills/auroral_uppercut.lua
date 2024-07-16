---------------------------------------------
--  Auroral Uppercut
--
-- Single target Light damage.
---------------------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/zone")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if (target:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) or target:hasStatusEffect(tpz.effect.MAGIC_SHIELD)) then
        return 1
    end
    local zoneId = mob:getZoneID()
    if (zoneId == tpz.zone.EMPYREAL_PARADOX) then
        mob:showText(mob, ID.text.PRISHE_TEXT + 4)
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 6
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.LIGHT, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    return dmg
end

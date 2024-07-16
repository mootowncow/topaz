---------------------------------------------
-- Wheel of Impregnability
---------------------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/zone")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) or mob:hasStatusEffect(tpz.effect.MAGIC_SHIELD)) then
        return 1
    end
    local zoneId = mob:getZoneID()
    if (zoneId == tpz.zone.EMPYREAL_PARADOX) then
        mob:showText(mob, ID.text.PROMATHIA_TEXT + 5)
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PHYSICAL_SHIELD

    mob:addStatusEffect(tpz.effect.PHYSICAL_SHIELD, 0, 0, 0)
    mob:AnimationSub(1)

    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)
    return tpz.effect.PHYSICAL_SHIELD
end

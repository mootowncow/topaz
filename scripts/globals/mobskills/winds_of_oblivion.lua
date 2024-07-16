---------------------------------------------
--  Winds of Oblivion
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/zone")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local zoneId = mob:getZoneID()
    if (zoneId == tpz.zone.EMPYREAL_PARADOX) then
        mob:showText(mob, ID.text.PROMATHIA_TEXT + 6)
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.AMNESIA
    local power = 1
    local duration = 60

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    return typeEffect
end

---------------------------------------------
-- Metalid Body
--
-- Gives the effect of "Stoneskin."
-- Type: Magical
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.STONESKIN
    local power = 25
    local tick = 0
    local duration = 300

    if (mob:isNM()) then
        power = math.floor(300 + mob:getMainLvl() * 20) -- ~1900 on caldera crab
    end

    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, duration))
    tpz.pet.handleJugBuffs(target, mob, skill, typeEffect, math.floor(mob:getMaxHP() * 0.10), tick, duration)
    SetBuffUndispellable(mob, typeEffect)

    return tpz.effect.STONESKIN
end

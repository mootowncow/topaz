---------------------------------------------
-- Shock Absorber
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/spell_data")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    skill:setValidTargets(tpz.magic.targetType.SELF)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local maneuvers = mob:countEffect(tpz.effect.EARTH_MANEUVER)
    local pMod = math.max(mob:getSkillLevel(tpz.skill.AUTOMATON_MELEE), mob:getSkillLevel(tpz.skill.AUTOMATON_RANGED), mob:getSkillLevel(tpz.skill.AUTOMATON_MAGIC))
    local duration = 180
    local amount = 200
    local bonus = 0

    if mob:getLocalVar("shockabsorber") >= 4 then -- Shock Absorber III
        if maneuvers == 1 then
            bonus = pMod * 0.75
        elseif maneuvers == 2 then
            bonus = pMod * 1.0
        elseif maneuvers == 3 then
            bonus = pMod * 1.4
        end
    elseif mob:getLocalVar("shockabsorber") >= 2 then -- Shock Absorber II
        if maneuvers == 1 then
            bonus = pMod * 0.4
        elseif maneuvers == 2 then
            bonus = pMod * 0.75
        elseif maneuvers == 3 then
            bonus = pMod * 1.0
        end
    else -- Shock Absorber
        if maneuvers == 1 then
            bonus = pMod * 0.2
        elseif maneuvers == 2 then
            bonus = pMod * 0.4
        elseif maneuvers == 3 then
            bonus = pMod * 0.6
        end
    end
    amount = amount + math.floor(bonus)
    if mob:addStatusEffect(tpz.effect.STONESKIN, amount, 0, duration, 0, 0, 4) then
        skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    end

    return tpz.effect.STONESKIN
end

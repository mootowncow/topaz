---------------------------------------------
-- Barrage Turbine
---------------------------------------------
require("scripts/globals/automatonweaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, automaton, skill)
    return 0
end

function onPetAbility(target, automaton, skill, master, action)
    automaton:addRecast(tpz.recast.ABILITY, skill:getID(), 180)
    local maneuvers = master:countEffect(tpz.effect.WIND_MANEUVER)
    local duration = 300
    local arrows = 1 + maneuvers

    automaton:setLocalVar("barrage_turbine", arrows)
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)
    for i = 1, maneuvers do
        master:delStatusEffectSilent(tpz.effect.WIND_MANEUVER)
    end

    return tpz.effect.BARRAGE
end

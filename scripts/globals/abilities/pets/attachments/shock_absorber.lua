-----------------------------------
-- Attachment: Shock Absorber
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    -- TODO: target:checkDistance() <= automaton:getMeleeRange() and make sure functions are correct, add to other shock absorbers too
    -- TODO: <7 might be too low? Also edit in disruptor or anywhere else it's used then
    pet:setLocalVar("shockabsorber", pet:getLocalVar("shockabsorber") + 1)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_SHOCK_ABSORBER", function(automaton, target)
        local master = automaton:getMaster()
        if not automaton:hasRecast(tpz.recast.ABILITY, 1946) and master and master:countEffect(tpz.effect.EARTH_MANEUVER) > 0  and
        not automaton:hasStatusEffect(tpz.effect.STONESKIN) and (automaton:checkDistance(target) - target:getModelSize()) < 7 then
            automaton:useMobAbility(1946, automaton)
        end
    end)
end

function onUnequip(pet)
    pet:setLocalVar("shockabsorber", pet:getLocalVar("shockabsorber") - 1)
    pet:removeListener("ATTACHMENT_SHOCK_ABSORBER")
end

function onManeuverGain(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
end

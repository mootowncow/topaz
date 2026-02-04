-----------------------------------
-- Attachment: Replicator
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_REPLICATOR", function(automaton, target)
        local master = automaton:getMaster()
        if master and master:countEffect(tpz.effect.WIND_MANEUVER) > 0 and not automaton:hasStatusEffect(tpz.effect.BLINK) and
        (automaton:checkDistance(target) <= target:getMeleeRange()) then
            automaton:useMobAbility(2132, automaton)
        end
    end)
end

function onUnequip(pet)
    pet:removeListener("ATTACHMENT_REPLICATOR")
end

function onManeuverGain(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
end

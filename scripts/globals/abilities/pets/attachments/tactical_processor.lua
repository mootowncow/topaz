-----------------------------------
-- Attachment: Tactical Processor
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    updateModPerformance(pet, tpz.mod.AUTO_DECISION_DELAY, 'tactical_processor_mod', 25)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.AUTO_DECISION_DELAY, 'tactical_processor_mod', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.AUTO_DECISION_DELAY, 'tactical_processor_mod', 25)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.AUTO_DECISION_DELAY, 'tactical_processor_mod', 45)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.AUTO_DECISION_DELAY, 'tactical_processor_mod', 65)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.AUTO_DECISION_DELAY, 'tactical_processor_mod', 115)
    end
end

-----------------------------------
-- Attachment: Optic Fiber
-- Increases the performance of other attachments by a percentage
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    updateModPerformance(pet, tpz.mod.AUTO_PERFORMANCE_BOOST, 'optic_fiber_mod', 10)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.AUTO_PERFORMANCE_BOOST, 'optic_fiber_mod', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.AUTO_PERFORMANCE_BOOST, 'optic_fiber_mod', 10)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.AUTO_PERFORMANCE_BOOST, 'optic_fiber_mod', 20)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.AUTO_PERFORMANCE_BOOST, 'optic_fiber_mod', 25)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.AUTO_PERFORMANCE_BOOST, 'optic_fiber_mod', 30)
    end
end

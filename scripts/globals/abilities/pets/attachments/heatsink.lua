-----------------------------------
-- Attachment: Heatsink
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    updateModPerformance(pet, tpz.mod.BURDEN_DECAY, 'heatsink_mod', 2)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.BURDEN_DECAY, 'heatsink_mod', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.BURDEN_DECAY, 'heatsink_mod', 2)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.BURDEN_DECAY, 'heatsink_mod', 4)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.BURDEN_DECAY, 'heatsink_mod', 5)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.BURDEN_DECAY, 'heatsink_mod', 6)
    end
end

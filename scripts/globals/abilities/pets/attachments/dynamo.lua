-----------------------------------
-- Attachment: Dynamo
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    updateModPerformance(pet, tpz.mod.CRITHITRATE, 'dynamo_mod', 3)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.CRITHITRATE, 'dynamo_mod', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.CRITHITRATE, 'dynamo_mod', 3)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.CRITHITRATE, 'dynamo_mod', 5)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.CRITHITRATE, 'dynamo_mod', 7)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.CRITHITRATE, 'dynamo_mod', 9)
    end
end

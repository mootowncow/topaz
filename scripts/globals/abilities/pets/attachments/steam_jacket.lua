-----------------------------------
-- Attachment: Steam Jacket
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    onUpdate(pet, 0)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.AUTO_STEAM_JACKET, 'steam_jacket_mod', 0)
    updateModPerformance(pet, tpz.mod.AUTO_STEAM_JACKED_REDUCTION, 'steam_jacket_reduction', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.AUTO_STEAM_JACKET, 'steam_jacket_mod', 2)
        updateModPerformance(pet, tpz.mod.AUTO_STEAM_JACKED_REDUCTION, 'steam_jacket_reduction', 30)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.AUTO_STEAM_JACKET, 'steam_jacket_mod', 3)
        updateModPerformance(pet, tpz.mod.AUTO_STEAM_JACKED_REDUCTION, 'steam_jacket_reduction', 45)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.AUTO_STEAM_JACKET, 'steam_jacket_mod', 4)
        updateModPerformance(pet, tpz.mod.AUTO_STEAM_JACKED_REDUCTION, 'steam_jacket_reduction', 60)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.AUTO_STEAM_JACKET, 'steam_jacket_mod', 5)
        updateModPerformance(pet, tpz.mod.AUTO_STEAM_JACKED_REDUCTION, 'steam_jacket_reduction', 80)
    end
end

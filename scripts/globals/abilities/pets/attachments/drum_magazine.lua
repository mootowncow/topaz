-----------------------------------
-- Attachment: Drum Magazine
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    updateModPerformance(pet, tpz.mod.SNAP_SHOT, 'drum_magazine_mod', 3)
    updateModPerformance(pet, tpz.mod.ACC, 'drum_magazine_mod2', -15)
    updateModPerformance(pet, tpz.mod.RACC, 'drum_magazine_mod3', -15)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.SNAP_SHOT, 'drum_magazine_mod', 0)
    updateModPerformance(pet, tpz.mod.ACC, 'drum_magazine_mod2', 0)
    updateModPerformance(pet, tpz.mod.RACC, 'drum_magazine_mod3', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.SNAP_SHOT, 'drum_magazine_mod', 3)
        updateModPerformance(pet, tpz.mod.ACC, 'drum_magazine_mod2', -15)
        updateModPerformance(pet, tpz.mod.RACC, 'drum_magazine_mod3', -15)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.SNAP_SHOT, 'drum_magazine_mod', 6)
        updateModPerformance(pet, tpz.mod.ACC, 'drum_magazine_mod2', -30)
        updateModPerformance(pet, tpz.mod.RACC, 'drum_magazine_mod3', -30)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.SNAP_SHOT, 'drum_magazine_mod', 9)
        updateModPerformance(pet, tpz.mod.ACC, 'drum_magazine_mod2', -50)
        updateModPerformance(pet, tpz.mod.RACC, 'drum_magazine_mod3', -50)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.SNAP_SHOT, 'drum_magazine_mod', 15)
        updateModPerformance(pet, tpz.mod.ACC, 'drum_magazine_mod2', -75)
        updateModPerformance(pet, tpz.mod.RACC, 'drum_magazine_mod3', -75)
    end
end

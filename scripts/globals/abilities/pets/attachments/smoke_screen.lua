-----------------------------------
-- Attachment: Smoke Screen
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    updateModPerformance(pet, tpz.mod.EVA, 'smoke_screen_mod', 20)
    updateModPerformance(pet, tpz.mod.ACC, 'smoke_screen_mod2', -20)
    updateModPerformance(pet, tpz.mod.RACC, 'smoke_screen_mod3', -20)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.EVA, 'smoke_screen_mod', 0)
    updateModPerformance(pet, tpz.mod.ACC, 'smoke_screen_mod2', 0)
    updateModPerformance(pet, tpz.mod.RACC, 'smoke_screen_mod3', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.EVA, 'smoke_screen_mod', 20)
        updateModPerformance(pet, tpz.mod.ACC, 'smoke_screen_mod2', -20)
        updateModPerformance(pet, tpz.mod.RACC, 'smoke_screen_mod3', -20)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.EVA, 'smoke_screen_mod', 40)
        updateModPerformance(pet, tpz.mod.ACC, 'smoke_screen_mod2', -40)
        updateModPerformance(pet, tpz.mod.RACC, 'smoke_screen_mod3', -40)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.EVA, 'smoke_screen_mod', 80)
        updateModPerformance(pet, tpz.mod.ACC, 'smoke_screen_mod2', -80)
        updateModPerformance(pet, tpz.mod.RACC, 'smoke_screen_mod3', -80)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.EVA, 'smoke_screen_mod', 160)
        updateModPerformance(pet, tpz.mod.ACC, 'smoke_screen_mod2', -160)
        updateModPerformance(pet, tpz.mod.RACC, 'smoke_screen_mod3', -160)
    end
end

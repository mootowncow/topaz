-----------------------------------
-- Attachment: Magniplug
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    updateModPerformance(pet, tpz.mod.MAIN_DMG_RATING, 'magniplug_mod', 5)
    updateModPerformance(pet, tpz.mod.RANGED_DMG_RATING, 'magniplug_mod2', 5)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.MAIN_DMG_RATING, 'magniplug_mod', 0)
    updateModPerformance(pet, tpz.mod.RANGED_DMG_RATING, 'magniplug_mod2', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.MAIN_DMG_RATING, 'magniplug_mod', 5)
        updateModPerformance(pet, tpz.mod.RANGED_DMG_RATING, 'magniplug_mod2', 5)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.MAIN_DMG_RATING, 'magniplug_mod', 15)
        updateModPerformance(pet, tpz.mod.RANGED_DMG_RATING, 'magniplug_mod2', 15)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.MAIN_DMG_RATING, 'magniplug_mod', 30)
        updateModPerformance(pet, tpz.mod.RANGED_DMG_RATING, 'magniplug_mod2', 30)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.MAIN_DMG_RATING, 'magniplug_mod', 45)
        updateModPerformance(pet, tpz.mod.RANGED_DMG_RATING, 'magniplug_mod2', 45)
    end
end

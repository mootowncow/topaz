-----------------------------------
-- Attachment: Magniplug II
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    updateModPerformance(pet, tpz.mod.MAIN_DMG_RATING, 'magniplug_ii_mod', 10)
    updateModPerformance(pet, tpz.mod.RANGED_DMG_RATING, 'magniplug_ii_mod2', 10)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.MAIN_DMG_RATING, 'magniplug_ii_mod', 0)
    updateModPerformance(pet, tpz.mod.RANGED_DMG_RATING, 'magniplug_ii_mod2', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.MAIN_DMG_RATING, 'magniplug_ii_mod', 10)
        updateModPerformance(pet, tpz.mod.RANGED_DMG_RATING, 'magniplug_ii_mod2', 10)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.MAIN_DMG_RATING, 'magniplug_ii_mod', 20)
        updateModPerformance(pet, tpz.mod.RANGED_DMG_RATING, 'magniplug_ii_mod2', 20)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.MAIN_DMG_RATING, 'magniplug_ii_mod', 35)
        updateModPerformance(pet, tpz.mod.RANGED_DMG_RATING, 'magniplug_ii_mod2', 35)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.MAIN_DMG_RATING, 'magniplug_ii_mod', 50)
        updateModPerformance(pet, tpz.mod.RANGED_DMG_RATING, 'magniplug_ii_mod2', 50)
    end
end

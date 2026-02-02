-----------------------------------
-- Attachment: Turbo Charger
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    onUpdate(pet, 0)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.HASTE_MAGIC, 'turbo_charger_haste', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.HASTE_MAGIC, 'turbo_charger_haste', 700)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.HASTE_MAGIC, 'turbo_charger_haste', 1700)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.HASTE_MAGIC, 'turbo_charger_haste', 2800)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.HASTE_MAGIC, 'turbo_charger_haste', 4375)
    end
end

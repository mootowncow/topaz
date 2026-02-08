-----------------------------------
-- Attachment: Amplifier
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    onUpdate(pet, 0)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.MAG_BURST_BONUS, 'amplifier_mburst', 0)
    updateModPerformance(pet, tpz.mod.ELEMENTAL_CELERITY, 'amplifier_fc', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.MAG_BURST_BONUS, 'amplifier_mburst', 10)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.MAG_BURST_BONUS, 'amplifier_mburst', 20)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.MAG_BURST_BONUS, 'amplifier_mburst', 35)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.MAG_BURST_BONUS, 'amplifier_mburst', 50)
    end
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.ELEMENTAL_CELERITY, 'amplifier_fc', 25)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.ELEMENTAL_CELERITY, 'amplifier_fc', 30)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.ELEMENTAL_CELERITY, 'amplifier_fc', 35)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.ELEMENTAL_CELERITY, 'amplifier_fc', 40)
    end
end

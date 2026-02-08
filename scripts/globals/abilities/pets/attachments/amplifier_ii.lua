-----------------------------------
-- Attachment: Amplifier II
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    onUpdate(pet, 0)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.MAG_BURST_BONUS, 'amplifier_mburst_II', 0)
    updateModPerformance(pet, tpz.mod.ELEMENTAL_CELERITY, 'amplifier_fc_II', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.MAG_BURST_BONUS, 'amplifier_mburst_II', 20)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.MAG_BURST_BONUS, 'amplifier_mburst_II', 30)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.MAG_BURST_BONUS, 'amplifier_mburst_II', 50)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.MAG_BURST_BONUS, 'amplifier_mburst_II', 70)
    end
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.ELEMENTAL_CELERITY, 'amplifier_fc_II', 30)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.ELEMENTAL_CELERITY, 'amplifier_fc_II', 35)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.ELEMENTAL_CELERITY, 'amplifier_fc_II', 40)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.ELEMENTAL_CELERITY, 'amplifier_fc_II', 45)
    end
end

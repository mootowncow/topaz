-----------------------------------
-- Attachment: Mana Jammer
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    onUpdate(pet, 0)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.DMGMAGIC, 'mana_jammer_mod', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.DMGMAGIC, 'mana_jammer_mod', -18)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.DMGMAGIC, 'mana_jammer_mod', -20)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.DMGMAGIC, 'mana_jammer_mod', -22)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.DMGMAGIC, 'mana_jammer_mod', -24)
    end
end

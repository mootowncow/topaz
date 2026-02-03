-----------------------------------
-- Attachment: Mana Conserver
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    updateModPerformance(pet, tpz.mod.CONSERVE_MP, 'mana_conserver_mod', 15)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.CONSERVE_MP, 'mana_conserver_mod', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.CONSERVE_MP, 'mana_conserver_mod', 15)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.CONSERVE_MP, 'mana_conserver_mod', 30)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.CONSERVE_MP, 'mana_conserver_mod', 45)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.CONSERVE_MP, 'mana_conserver_mod', 60)
    end
end

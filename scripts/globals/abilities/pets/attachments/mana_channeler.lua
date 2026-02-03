-----------------------------------
-- Attachment: Mana Channeler
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
---
function onEquip(pet)
    updateModPerformance(pet, tpz.mod.MATT, 'mana_channeler_mod', 8)
    updateModPerformance(pet, tpz.mod.AUTO_MAGIC_DELAY, 'mana_channeler_mod2', -3)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.MATT, 'mana_channeler_mod', 0)
    updateModPerformance(pet, tpz.mod.AUTO_MAGIC_DELAY, 'mana_channeler_mod2', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.MATT, 'mana_channeler_mod', 8)
        updateModPerformance(pet, tpz.mod.AUTO_MAGIC_DELAY, 'mana_channeler_mod2', -3)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.MATT, 'mana_channeler_mod', 15)
        updateModPerformance(pet, tpz.mod.AUTO_MAGIC_DELAY, 'mana_channeler_mod2', -9)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.MATT, 'mana_channeler_mod', 25)
        updateModPerformance(pet, tpz.mod.AUTO_MAGIC_DELAY, 'mana_channeler_mod2', -15)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.MATT, 'mana_channeler_mod', 35)
        updateModPerformance(pet, tpz.mod.AUTO_MAGIC_DELAY, 'mana_channeler_mod2', -21)
    end
end

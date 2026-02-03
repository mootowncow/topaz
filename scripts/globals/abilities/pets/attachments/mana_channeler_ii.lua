-----------------------------------
-- Attachment: Mana Channeler II
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
---
function onEquip(pet)
    updateModPerformance(pet, tpz.mod.MATT, 'mana_channeler_ii_mod', 12)
    updateModPerformance(pet, tpz.mod.AUTO_MAGIC_DELAY, 'mana_channeler_ii_mod2', -6)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.MATT, 'mana_channeler_ii_mod', 0)
    updateModPerformance(pet, tpz.mod.AUTO_MAGIC_DELAY, 'mana_channeler_ii_mod2', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.MATT, 'mana_channeler_ii_mod', 12)
        updateModPerformance(pet, tpz.mod.AUTO_MAGIC_DELAY, 'mana_channeler_ii_mod2', -6)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.MATT, 'mana_channeler_ii_mod', 25)
        updateModPerformance(pet, tpz.mod.AUTO_MAGIC_DELAY, 'mana_channeler_ii_mod2', -15)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.MATT, 'mana_channeler_ii_mod', 40)
        updateModPerformance(pet, tpz.mod.AUTO_MAGIC_DELAY, 'mana_channeler_ii_mod2', -24)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.MATT, 'mana_channeler_ii_mod', 50)
        updateModPerformance(pet, tpz.mod.AUTO_MAGIC_DELAY, 'mana_channeler_ii_mod2', -33)
    end
end

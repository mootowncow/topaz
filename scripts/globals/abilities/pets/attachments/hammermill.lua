-----------------------------------
-- Attachment: Hammermill
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
function onEquip(pet)
    updateModPerformance(pet, tpz.mod.SHIELD_BASH, 'hammermill_mod', 10)
    updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_SLOW, 'hammermill_mod2', 1000)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.SHIELD_BASH, 'hammermill_mod', 0)
    updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_SLOW, 'hammermill_mod2', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.SHIELD_BASH, 'hammermill_mod', 10)
        updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_SLOW, 'hammermill_mod2', 1000)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.SHIELD_BASH, 'hammermill_mod', 20)
        updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_SLOW, 'hammermill_mod2', 1200)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.SHIELD_BASH, 'hammermill_mod', 65)
        updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_SLOW, 'hammermill_mod2', 2000)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.SHIELD_BASH, 'hammermill_mod', 100)
        updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_SLOW, 'hammermill_mod2', 2500)
    end
end
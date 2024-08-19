-----------------------------------
-- Attachment: Barrier Module
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
-- 10/20/25/30% block rate
-- 0/1/2/3 Shield Mastery
-- Works on ALL frames

function onEquip(pet)
    onUpdate(pet, 0)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.SHIELDBLOCKRATE, 'barrier_module_block', 0)
    updateModPerformance(pet, tpz.mod.SHIELD_MASTERY_TP, 'barrier_module_mastery', 0)
    updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_DELAY, 'barrier_module_sb_cd', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.SHIELDBLOCKRATE, 'barrier_module_block', 10)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.SHIELDBLOCKRATE, 'barrier_module_block', 20)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.SHIELDBLOCKRATE, 'barrier_module_block', 25)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.SHIELDBLOCKRATE, 'barrier_module_block', 30)
    end

    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.SHIELD_MASTERY_TP, 'barrier_module_mastery', 0)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.SHIELD_MASTERY_TP, 'barrier_module_mastery', 1)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.SHIELD_MASTERY_TP, 'barrier_module_mastery', 2)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.SHIELD_MASTERY_TP, 'barrier_module_mastery', 3)
    end

    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_DELAY, 'barrier_module_sb_cd', 15)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_DELAY, 'barrier_module_sb_cd', 30)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_DELAY, 'barrier_module_sb_cd', 35)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_DELAY, 'barrier_module_sb_cd', 40)
    end
end

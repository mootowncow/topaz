-----------------------------------
-- Attachment: Barrier Module
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
-- 15/30/35/40% block rate 0/1/2
-- 0/1/2/3 Shield Mastery
-- Works on ALL frames

function onEquip(pet)
    onUpdate(pet, 0)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.SHIELDBLOCKRATE, 'barrier_module_block_II', 0)
    updateModPerformance(pet, tpz.mod.SHIELD_MASTERY_TP, 'barrier_module_mastery_II', 0)
    updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_DELAY, 'barrier_module_sb_cd_II', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.SHIELDBLOCKRATE, 'barrier_module_block_II', 15)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.SHIELDBLOCKRATE, 'barrier_module_block_II', 30)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.SHIELDBLOCKRATE, 'barrier_module_block_II', 35)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.SHIELDBLOCKRATE, 'barrier_module_block_II', 40)
    end

    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.SHIELD_MASTERY_TP, 'barrier_module_mastery_II', 0)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.SHIELD_MASTERY_TP, 'barrier_module_mastery_II', 1)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.SHIELD_MASTERY_TP, 'barrier_module_mastery_II', 2)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.SHIELD_MASTERY_TP, 'barrier_module_mastery_II', 3)
    end

    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_DELAY, 'barrier_module_sb_cd_II', 20)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_DELAY, 'barrier_module_sb_cd_II', 40)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_DELAY, 'barrier_module_sb_cd_II', 50)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.AUTO_SHIELD_BASH_DELAY, 'barrier_module_sb_cd_II', 60)
    end
end

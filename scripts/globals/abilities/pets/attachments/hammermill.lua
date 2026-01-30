-----------------------------------
-- Attachment: Hammermill
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    pet:addMod(tpz.mod.SHIELD_BASH, 10)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.SHIELD_BASH, 10)
end

function onManeuverGain(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.SHIELD_BASH, 10)
        pet:addMod(tpz.mod.AUTO_SHIELD_BASH_SLOW, 1200)
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.SHIELD_BASH, 25)
        pet:addMod(tpz.mod.AUTO_SHIELD_BASH_SLOW, 2000)
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.SHIELD_BASH, 60)
        pet:addMod(tpz.mod.AUTO_SHIELD_BASH_SLOW, 2500)
    end
end

function onManeuverLose(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.SHIELD_BASH, 10)
        pet:delMod(tpz.mod.AUTO_SHIELD_BASH_SLOW, 1200)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.SHIELD_BASH, 25)
        pet:delMod(tpz.mod.AUTO_SHIELD_BASH_SLOW, 2000)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.SHIELD_BASH, 60)
        pet:delMod(tpz.mod.AUTO_SHIELD_BASH_SLOW, 2500)
    end
end

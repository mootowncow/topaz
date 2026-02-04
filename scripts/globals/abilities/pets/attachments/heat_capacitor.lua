-----------------------------------
-- Attachment: Heat Capacitor
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/automaton")
-----------------------------------

function onEquip(pet)
    pet:setLocalVar("heat_capacitor", 1)
    pet:addListener("AUTOMATON_ATTACHMENT_CHECK", "ATTACHMENT_HEAT_CAPACITOR", function(automaton, target)
        local master = automaton:getMaster()
        if master and master:countEffect(tpz.effect.FIRE_MANEUVER) > 0 and automaton:getLocalVar("meditate") < VanadielTime() and
        (automaton:checkDistance(target) <= target:getMeleeRange()) then
            automaton:useMobAbility(2745, automaton)
        end
    end)
    pet:setLocalVar("heat_capacitor_manuevers", 25)
end

function onUnequip(pet)
    pet:setLocalVar("heat_capacitor", 0)
    pet:removeListener("ATTACHMENT_HEAT_CAPACITOR")
    pet:setLocalVar("heat_capacitor_manuevers", 0)
end

function onManeuverGain(pet, maneuvers)
    local heatCapacitorBonus = pet:getLocalVar("heat_capacitor_manuevers")
    if maneuvers == 1 then
        pet:setLocalVar("heat_capacitor_manuevers", heatCapacitorBonus + 25)
    elseif maneuvers == 2 then
        pet:setLocalVar("heat_capacitor_manuevers", heatCapacitorBonus + 25)
    elseif maneuvers == 3 then
        pet:setLocalVar("heat_capacitor_manuevers", heatCapacitorBonus + 25)
    end
end

function onManeuverLose(pet, maneuvers)
    local heatCapacitorBonus = pet:getLocalVar("heat_capacitor_manuevers")
    if maneuvers == 1 then
        pet:setLocalVar("heat_capacitor_manuevers", heatCapacitorBonus - 25)
    elseif maneuvers == 2 then
        pet:setLocalVar("heat_capacitor_manuevers", heatCapacitorBonus - 25)
    elseif maneuvers == 3 then
        pet:setLocalVar("heat_capacitor_manuevers", heatCapacitorBonus - 25)
    end
end

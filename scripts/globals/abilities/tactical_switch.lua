-----------------------------------
-- Ability: Tactical Switch
-- Description: Grants your TP to your automaton.
-- Obtained: PUP Level 40
-- Recast Time: 00:00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if not player:getPet() then
        return tpz.msg.basic.REQUIRES_A_PET, 0
    elseif not player:getPetID() or not (player:getPetID() >= 69 and player:getPetID() <= 72) then
        return tpz.msg.basic.PET_CANNOT_DO_ACTION, 0
    end
    return 0, 0
end

function onUseAbility(player, target, ability)
    local buffTable = {

    }
    local pet = player:getPet()
    local playerTP = player:getTP()
    local maneuver = player:countEffect(tpz.effect.EARTH_MANEUVER)
    pet:addTP(playerTP)
    player:setTP(0)
    -- Consume manuevers to give a bonus based on # of manuevers and manuever element to pet and self

    return playerTP
end

-----------------------------------
-- Ability: Deactivate
-- Deactivates your automaton.
-- Obtained: Puppetmaster Level 1
-- Recast Time: 1:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
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
    -- Reset the Activate ability.
    local pet = player:getPet()
    if pet:getHP() == pet:getMaxHP() then
        player:resetRecast(tpz.recast.ABILITY, 205) -- activate
    end
    target:despawnPet()
end

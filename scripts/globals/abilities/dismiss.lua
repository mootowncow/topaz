-----------------------------------
-- Ability: Dismiss
-- Sends the Wyvern away.
-- Obtained: Dragoon Level 1
-- Recast Time: 5.00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
   if (player:getPet() == nil) then
        return tpz.msg.basic.REQUIRES_A_PET, 0
   elseif (player:getPetID() ~= tpz.pet.id.WYVERN) then
      return tpz.msg.basic.NO_EFFECT_ON_PET, 0
   else
      return 0, 0
   end
end

function onUseAbility(player, target, ability)
    -- Reset the Call Wyvern Ability.
    local pet = player:getPet()
    if pet:getHP() == pet:getMaxHP() then
        player:resetRecast(tpz.recast.ABILITY, 163) -- call_wyvern
    end
    target:despawnPet()
end

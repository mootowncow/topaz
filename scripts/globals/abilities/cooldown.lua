-----------------------------------
-- Ability: Cooldown
-- Description: Causes your next repair or maintenance to also effect yourself.
-- Obtained: PUP Level 70
-- Recast Time: 01:30:00
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
    player:setLocalVar("[PUP]Cooldown", 1)
end

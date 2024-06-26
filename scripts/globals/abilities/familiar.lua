-----------------------------------
-- Ability: Familiar
-- Enhances your pet's powers and increases the duration of Charm.
-- Obtained: Beastmaster Level 1
-- Recast Time: 1:00:00
-- Duration: 0:30:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    local pet = player:getPet()
    pet:setLocalVar("ReceivedFamiliar", 1)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:familiar()

    -- pets powers increase!
    ability:setMsg(tpz.msg.basic.FAMILIAR_PC)

    return 0
end

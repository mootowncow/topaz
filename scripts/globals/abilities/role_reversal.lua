-----------------------------------
-- Ability: Role Reversal
-- Swaps Master's current HP with Automaton's current HP.
-- Obtained: Puppetmaster Level 75
-- Recast Time: 2:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local pet = player:getPet()
    if pet then
        local bonus = 1 + (player:getMerit(tpz.merit.ROLE_REVERSAL)-5)/100
        local playerHP = player:getHP()
        local petHP = pet:getHP()
        pet:setHP(math.max(playerHP * bonus, 1))
        player:setHP(math.max(petHP * bonus, 1))
    end
end

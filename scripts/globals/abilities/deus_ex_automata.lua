-----------------------------------
-- Ability: Deus Ex Automata
-- Calls forth your automaton in an unsound state.
-- Obtained: Puppetmaster Level 5
-- Recast Time: 1:00
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
    tpz.pet.spawnPet(player, tpz.pet.id.AUTOMATON)
    local pet = player:getPet()
    if pet then
        local percent = math.floor((player:getMainLvl()/3))/100
        pet:setHP(math.max(pet:getHP() * percent, 1))
        pet:setMP(pet:getMP() * percent)
    end
end

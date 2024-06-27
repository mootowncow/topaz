-----------------------------------
-- Ability: Sic
-- Commands the charmed Pet to make a random special attack.
-- Obtained: Beastmaster Level 25
-- Recast Time: 2 minutes
-- Duration: N/A
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local function doSic(mob)
        if mob == nil then
            return -- Exit if mob is nil
        end

        if mob:getTP() >= 1000 then
            mob:useMobAbility()
        elseif mob:hasSpellList() then
            mob:castSpell()
        else
            mob:queue(1000, doSic) -- Retry after 1 second (1000 ms)
        end
    end

    local pet = player:getPet()
    if pet then
        pet:queue(0, doSic)
    end
end

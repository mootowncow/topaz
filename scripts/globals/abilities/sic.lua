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
        if mob:getTP() >= 1000 then
            mob:useMobAbility()
        elseif mob:hasSpellList() then
            mob:castSpell()
        else
            mob:queue(0, doSic)
        end

    end

    player:getPet():queue(0, doSic)
end

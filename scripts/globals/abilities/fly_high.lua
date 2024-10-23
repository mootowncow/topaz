-----------------------------------
-- Ability: Fly High
-- Description: Resets the cooldown and decreases the recast time of jumps.
-- Obtained: DRG Level 1
-- Recast Time: 02:00:00
-- Duration: 00:00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local jumps = { 158, 159, 160, 166, 167 }
    for _, jumpIds in pairs(jumps) do
        player:resetRecast(tpz.recast.ABILITY, jumpIds)
    end
    player:addStatusEffect(tpz.effect.FLY_HIGH, 14, 0, 60)
end

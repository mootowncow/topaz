-----------------------------------
-- Ability: Caper Emissarius
-- Description: Transfers enmity to a party member of your choice.
-- Obtained: SCH Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:30
-- target:transferEnmity(player, 99, 20.6)
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)

    local jpValue = player:getJobPointLevel(tpz.jp.CAPER_EMMISSARIUS_EFFECT)
    if jpValue > 0 then
        target:addHP(target:getMaxHP() * 0.02 * jpValue)
    end

    local party = player:getPartyWithTrusts()
    for _, member in ipairs(party) do
        member:transferEnmity(target, 99, 20.6)
    end
end

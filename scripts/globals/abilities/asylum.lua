-----------------------------------
-- Ability: Asylum
-- Description: Grants party members a powerful resistance to enfeebling magic and Dispel effects.
-- Also restores 20% of the WHM's MP if a party member is in range and afflatus Misery is active
-- Obtained: WHM Level 75
-- Recast Time: 00:01:00
-- Duration: 0:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local party = player:getParty()
    local asylumMPRecovery = player:getLocalVar("asylumMPRecovery")

    if (os.time() >= asylumMPRecovery) then -- So that it never recovers MP more than once per use
        if player:hasStatusEffect(tpz.effect.AFFLATUS_MISERY) then
            local NearbyEntities = player:getNearbyEntities(10)
            if NearbyEntities == nil then return end
            if NearbyEntities then
                for _,entity in pairs(NearbyEntities) do
                    if entity:isAlive() and
                    (entity:getAllegiance() == player:getAllegiance())
                    and (player:getID() ~= entity:getID()) then
                    local mprecovered = (player:getMaxMP()/100)*20
                        player:addMP(mprecovered)
                        player:setLocalVar("asylumMPRecovery", os.time() + 15)
                        break
                    end
                end
            end
        end
    end

    target:addStatusEffect(tpz.effect.ASYLUM, 0, 0, 60)
end

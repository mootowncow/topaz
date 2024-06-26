-----------------------------------
-- Ability: Stay
-- Commands the Pet to stay in one place, and causes it to regen similar to the /heal command.
-- Obtained: Beastmaster Level 15
-- Recast Time: 5 seconds
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability, action)
    local pet = player:getPet()

    if (not pet:hasPreventActionEffect()) then
        local level = 0
        if (player:getMainJob() == tpz.job.BST) then
            level = player:getMainLvl()
        elseif (player:getSubJob() == tpz.job.BST) then
            level = player:getSubLvl()
        end

        pet:addStatusEffectEx(tpz.effect.HEALING, 0, 0, 10, 0)
        pet:setAnimation(0)
    end
end

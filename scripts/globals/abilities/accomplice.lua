-----------------------------------
-- Ability: Accomplice
-- Steals half of the target party member's enmity and redirects it to the thief.
-- Obtained: Thief Level 65
-- Recast Time: 5:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local mob = player:getTarget()
    if (mob ~= nil) then
        local CE = mob:getCE(target) * (0.50 + player:getMod(tpz.mod.ACC_COLLAB_EFFECT))
        local VE = mob:getVE(target) * (0.50 + player:getMod(tpz.mod.ACC_COLLAB_EFFECT))
        local removeMagicShield = true

        -- Gain a Stoneskin + Magic Stoneskin equal to the amount of enmity redirected
        if player:isPC() then
            if player:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then
                local effect = player:getStatusEffect(tpz.effect.MAGIC_SHIELD)
                local effectPower = effect:getPower()
                if (effectPower < 100) then -- Isn't an absorb shield magic shield effect
                    removeMagicShield = false -- So don't remove it
                end
            end

            if removeMagicShield then
                player:delStatusEffectSilent(tpz.effect.MAGIC_SHIELD)
            end
            utils.ShouldRemoveStoneskin(target, (CE + VE) / 10)
            player:addStatusEffect(tpz.effect.STONESKIN, (CE + VE) / 10, 0, 60)
            player:addStatusEffect(tpz.effect.MAGIC_SHIELD, (CE + VE) / 10, 0, 60)
        end
    end

    target:transferEnmity(player, 50 + player:getMod(tpz.mod.ACC_COLLAB_EFFECT), 20.6)
end

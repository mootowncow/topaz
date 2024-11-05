-----------------------------------
-- Ability: Drain Samba II
-- Inflicts the next target you strike with Drain Daze, allowing all those engaged in battle with it to drain its HP.
-- Obtained: Dancer Level 35
-- TP Required: 25%
-- Recast Time: 1:00
-- Duration: 1:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    -- Only remove TP if the player doesn't have Trance.
    if not player:hasStatusEffect(tpz.effect.TRANCE) then
        player:delTP(ability:getTPCost())
    end

    local duration = 90 + player:getMod(tpz.mod.SAMBA_DURATION) + (player:getJobPointLevel(tpz.jp.SAMBA_DURATION) * 2)
    duration = duration * (100 + player:getMod(tpz.mod.SAMBA_PDURATION))/100
    player:delStatusEffect(tpz.effect.HASTE_SAMBA)
    player:delStatusEffect(tpz.effect.ASPIR_SAMBA)
    player:addStatusEffect(tpz.effect.DRAIN_SAMBA, 2, 0, duration)
end

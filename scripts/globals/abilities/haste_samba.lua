-----------------------------------
-- Ability: Haste Samba
-- Inflicts the next target you strike with Haste daze, increasing the attack speed of all those engaged in battle with it.
-- Obtained: Dancer Level 45
-- TP Cost: 35%
-- Recast Time: 1:00
-- Duration: 1:30
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    -- Only remove TP if the player doesn't have Trance.
    if not player:hasStatusEffect(tpz.effect.TRANCE) then
        player:delTP(170)
    end

    local duration = 90 + player:getMod(tpz.mod.SAMBA_DURATION) + (player:getJobPointLevel(tpz.jp.SAMBA_DURATION) * 2)
    duration = duration * (100 + player:getMod(tpz.mod.SAMBA_PDURATION)) / 100
    player:delStatusEffect(tpz.effect.DRAIN_SAMBA)
    player:delStatusEffect(tpz.effect.ASPIR_SAMBA)

    if player:isPC() then -- Players give 20%(25% with Merits) JA haste
        player:addStatusEffect(tpz.effect.HASTE_SAMBA, 1000 + player:getMerit(tpz.merit.HASTE_SAMBA_EFFECT) * 2, 0, duration)
    else -- Trusts / Mobs / NPCS etc 5%(10% with merits)
        player:addStatusEffect(tpz.effect.HASTE_SAMBA, 500 + player:getMerit(tpz.merit.HASTE_SAMBA_EFFECT), 0, duration)
    end
end

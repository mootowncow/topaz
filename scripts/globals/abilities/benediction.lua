-----------------------------------
-- Ability: Benediction
-- Restores a large amount of HP and removes (almost) all status ailments for party members within area of effect.
-- Obtained: White Mage Level 1
-- Recast Time: 1:00:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    -- To Do: Benediction can remove Charm only while in Assault Mission Lamia No.13
    local removables = utils.GetRemovableEffects()
    local jpMPRecovery = player:getJobPointLevel(tpz.jp.BENEDICTION_EFFECT) / 100

    for i, effect in ipairs(removables) do
        if (target:hasStatusEffect(effect)) then
            local currentEffect = target:getStatusEffect(effect)
            local effectFlags = currentEffect:getFlag()
            if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) or (effect == tpz.effect.PETRIFICATION) then
                target:delStatusEffectSilent(effect)
            end
        end
    end

    local heal = (target:getMaxHP() * player:getMainLvl()) / target:getMainLvl()

    local maxHeal = target:getMaxHP() - target:getHP()

    if (heal > maxHeal) then
        heal = maxHeal
    end

    player:updateEnmityFromCure(target, heal)
    player:addMP(player:getMaxMP() * jpMPRecovery)
    target:addHP(heal)
    target:wakeUp()

    return heal
end

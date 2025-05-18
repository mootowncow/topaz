-----------------------------------
-- Ability: Intervene
-- Description: Strikes the target with your shield and decreases its attack and accuracy.
-- Obtained: PLD Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    -- TODO: Retail testing to determine damage
    local shieldSize = tpz.shieldSize.KITE
    if player:isPC() then
        shieldSize = player:getShieldSize()
    end
    local jpValue    = 1 + ((player:getJobPointLevel(tpz.jp.INTERVENE_EFFECT) * 2) / 100)
    local damage     = math.floor(player:getMainLvl() * 3.36)

    if not player:isPC() then
        shieldSize = player:getMobMod(tpz.mobMod.BLOCK)
    end

    if shieldSize == 2 then
        damage = 13 + damage
    elseif shieldSize == 3 then
        damage = 40 + damage
    elseif shieldSize == 4 then
        damage = 67 + damage
    end

    damage = damage * jpValue

    local bonusAttPercent = 0
    local flatAttackBonus = 0
    local ignoredDef = 0
    local isCritical = false
    local pdif = player:getDamageRatio(target, isCritical, bonusAttPercent, flatAttackBonus, tpz.slot.MAIN, ignoredDef)

    damage = damage * pdif

    -- Apply reductions
    damage = utils.HandlePositionalPDT(player, target, damage)
    damage = target:physicalDmgTaken(damage, tpz.damageType.BLUNT)

    -- Check for phalanx + stoneskin
    if (damage > 0) then
        damage = damage - target:getMod(tpz.mod.PHALANX)
        local attackType = tpz.attackType.PHYSICAL
        damage = utils.stoneskin(target, damage, attackType)
    end

    target:addStatusEffect(tpz.effect.INTERVENE, 1, 0, 30)

    return damage
end

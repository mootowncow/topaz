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

    -- Randomize damage
    local ratio = player:getStat(tpz.mod.ATT)/target:getStat(tpz.mod.DEF)

    if ratio > 1.3 then
        ratio = 1.3
    end

    if ratio < 0.2 then
        ratio = 0.2
    end

    local pdif = math.random(ratio * 0.8 * 1000, ratio * 1.2 * 1000)

    -- printf("damge %d, ratio: %f, pdif: %d\n", damage, ratio, pdif)
    damage = damage * (pdif / 1000)

    -- Apply reductions
    damage = utils.HandlePositionalPDT(mob, target, damage)
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

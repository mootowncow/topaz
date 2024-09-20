-----------------------------------
-- Ability: Shield Bash
-- Delivers an attack that can stun the target. Shield required.
-- Obtained: Paladin Level 15, Valoredge automaton frame Level 1
-- Recast Time: 1:00 minute (3:00 for Valoredge version)
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/items")
require("scripts/globals/utils")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)

    -- Check for PD
    if target:hasStatusEffect(tpz.effect.PERFECT_DODGE) then
        return ability:setMsg(tpz.msg.basic.JA_MISS)
    end

    local shieldSize = player:getShieldSize()
    local jpValue    = player:getJobPointLevel(tpz.jp.SHIELD_BASH_EFFECT)
    local damage = 0
    local chance = 99
    local stunEEM = target:getMod(tpz.mod.EEM_STUN)
    local shield = player:getEquipID(tpz.slot.SUB)
	local hasHighLanderTarget =  (shield == tpz.items.HIGHLANDERS_TARGE)
    local hands = player:getEquipID(tpz.slot.HANDS)
    local hasValorGauntlets = (hands == tpz.items.VALOR_GAUNTLETS)

    if not player:isPC() then
        shieldSize = player:getMobMod(tpz.mobMod.BLOCK)
    end

    if shieldSize == 1 or shieldSize == 5 then
        damage = 25 + damage
    elseif shieldSize == 2 then
        damage = 38 + damage
    elseif shieldSize == 3 then
        damage = 65 + damage
    elseif shieldSize == 4 then
        damage = 90 + damage
    end

    damage = damage + (player:getMod(tpz.mod.SHIELD_BASH) + (jpValue * 10))

    -- Main job factors
    if player:getMainJob() ~= tpz.job.PLD then
        damage = math.floor(damage / 2.5)
        chance = 60
    else
        damage = math.floor(damage)
    end

    -- Calculate stun proc chance
    if
        (math.random()*100 < 99) and
        not target:hasStatusEffect(tpz.effect.STUN) and
        (stunEEM > 5)
    then
        target:addStatusEffect(tpz.effect.STUN, 1, 0, 4)
    end

    -- Highlanders Target hidden effect
	if hasHighLanderTarget then
        local power = (target:getStat(tpz.mod.STR) * 0.2)
        local bonus = 255
        local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.WATER, bonus, tpz.effect.ATTACK_DOWN)

        if (resist >= 0.5) then
            target:delStatusEffect(tpz.effect.ATTACK_BOOST)
            target:addStatusEffect(tpz.effect.ATTACK_DOWN, 10, 0, 60)
        end

        resist = applyResistanceAddEffect(player, target, tpz.magic.ele.WATER, bonus, tpz.effect.STR_DOWN)
        if (resist >= 0.5) then
            target:addStatusEffect(tpz.effect.STR_DOWN, power, 6, 60)
        end
    end

    -- Valor Gauntlets dispel
    if hasValorGauntlets then
        target:dispelStatusEffect()
    end

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

    -- Check for Invincible
    if target:hasStatusEffect(tpz.effect.INVINCIBLE) then
        damage = 0
    end

    -- Check for phalanx + stoneskin
    if (damage > 0) then
        local attackType = tpz.attackType.PHYSICAL
        damage = damage - target:getMod(tpz.mod.PHALANX)
        damage = utils.stoneskin(target, damage, attackType)
    end

    target:takeDamage(damage, player, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(player, damage)
    ability:setMsg(tpz.msg.basic.JA_DAMAGE)

    return damage
end

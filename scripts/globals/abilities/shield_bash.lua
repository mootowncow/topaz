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

    if target:hasStatusEffect(tpz.effect.PERFECT_DODGE) then
        return ability:setMsg(tpz.msg.basic.JA_MISS)
    end
    -- TODO: Resist check (Has 255 MACC bonus?)
    -- Remove pdif, randomize damage (1-5% variance)
    local shieldSize = player:getShieldSize()
    local jpValue    = player:getJobPointLevel(tpz.jp.SHIELD_BASH_EFFECT) * 10
    local chance = 99
    local stunEEM = target:getMod(tpz.mod.EEM_STUN)
    local shield = player:getEquipID(tpz.slot.SUB)
	local hasHighLanderTarget = shield == tpz.items.HIGHLANDERS_TARGE
    local hands = player:getEquipID(tpz.slot.HANDS)
    local hasValorGauntlets = hands == tpz.items.VALOR_GAUNTLETS

    if not player:isPC() then
        shieldSize = player:getMobMod(tpz.mobMod.BLOCK)
    end

    -- Base dmg is 27 at lvl 99 PLD. This value scales with level. 15 base dmg at PLD level 45.
    local baseDamage = 0.2222 * player:getMainLvl() + 5

    -- Shield size bonuses are:
    -- Size 1 Shield (Bucklers): +0
    -- Size 2 Shield (Round Shields): +13
    -- Size 3 Shield (Kite Shields): +40
    -- Size 4 Shield (Tower Shields): +67
    -- Size 5 Shield (Aegis, Srivatsa): +0
    -- Size 6 Shield (Ochain, Duban): +0
    if shieldSize == 1 then
        baseDamage = baseDamage + 0
    elseif shieldSize == 2 then
        baseDamage = baseDamage + 13
    elseif shieldSize == 3 then
        baseDamage = baseDamage + 40
    elseif shieldSize == 4 then
        baseDamage = baseDamage + 67
    elseif shieldSize == 5 or shieldSize == 6 then
        baseDamage = baseDamage + 0
    end

    baseDamage = baseDamage + (player:getMod(tpz.mod.SHIELD_BASH) + jpValue)

    -- Main job factors
    if player:getMainJob() ~= tpz.job.PLD then
        baseDamage = math.floor(baseDamage / 2.5)
        chance = 60
    else
        baseDamage = math.floor(baseDamage)
    end

    -- Calculate stun proc chance
    if
        (math.random()*100 < chance) and
        not target:hasStatusEffect(tpz.effect.STUN) and
        (stunEEM > 5)
    then
        target:addStatusEffect(tpz.effect.STUN, 1, 0, 3)
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
    -- Apply reductions
    baseDamage = utils.HandlePositionalPDT(player, target, baseDamage)
    baseDamage = target:physicalDmgTaken(baseDamage, tpz.damageType.BLUNT)

    -- Check for phalanx + stoneskin
    if (baseDamage > 0) then
        local attackType = tpz.attackType.PHYSICAL
        baseDamage = baseDamage - target:getMod(tpz.mod.PHALANX)
        baseDamage = utils.stoneskin(target, baseDamage, attackType)
    end

    target:takeDamage(baseDamage, player, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(player, baseDamage)
    ability:setMsg(tpz.msg.basic.JA_DAMAGE)

    return baseDamage
end

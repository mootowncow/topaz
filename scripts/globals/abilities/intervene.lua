-----------------------------------
-- Ability: Intervene
-- Description: Strikes the target with your shield and decreases its attack and accuracy.
-- Obtained: PLD Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability, action)
    -- TODO: Retail testing to determine real damage formula
    local jpValue    = 1 + ((player:getJobPointLevel(tpz.jp.INTERVENE_EFFECT) * 2) / 100)
    local damage     = 0
    local shieldSkillMultiplier = player:getSkillLevel(tpz.skill.SHIELD) / 100
    local shieldSize = player:getShieldSize()
    local strModifier = player:getStat(tpz.mod.STR) * 2

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

    damage = damage + strModifier
    damage = math.floor((damage * shieldSkillMultiplier) * jpValue)

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
    action:reaction(target:getID(), 24)
    ability:setMsg(tpz.msg.basic.JA_DAMAGE)

    return damage
end

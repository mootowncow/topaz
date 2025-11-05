-----------------------------------
-- Ability: Weapon Bash
-- Delivers an attack that can stun the target. Requires Two-handed weapon.
-- Obtained: Dark Knight Level 20
-- Cast Time: Instant
-- Recast Time: 3:00 minutes
-----------------------------------
require("scripts/globals/weaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
require("scripts/globals/mobs")
-----------------------------------

function onAbilityCheck(player, target, ability)
return 0, 0
end

function onUseAbility(player, target, ability)
    -- TODO: Resist check (Has 255 MACC bonus?)
    -- TODO: Ignores shadows

    -- Check for PD
    if target:hasStatusEffect(tpz.effect.PERFECT_DODGE) then
        return ability:setMsg(tpz.msg.basic.JA_MISS)
    end

    local stunEEM = target:getMod(tpz.mod.EEM_STUN)
    local hands = player:getEquipID(tpz.slot.HANDS)
    local hasChaosGauntlets = hands == tpz.items.CHAOS_GAUNTLETS

    -- Calculate stun proc chance
    local bonusAcc = 200
    local resist = getAdditionalEffectStatusResist(player, target, tpz.effect.STUN, tpz.magic.ele.LIGHTNING, nil, bonusAcc)
    local duration = 3 * resist
    if (resist >= 0.5) then
        target:addStatusEffect(tpz.effect.STUN, 1, 0, duration)
    end

    -- Chaos Gauntlets effect corrupt
    if hasChaosGauntlets then
        local corruptAmount = 1
        CorruptBuffs(player, target, corruptAmount)
    end

    -- At level 75, unenhanced Weapon Bash deals 21 blunt type damage.
    local baseDamage = 0.2222 * player:getMainLvl() + 5

    if (player:getMainJob() ~= tpz.job.DRK) then
        baseDamage = 0.2222 * player:getSubLvl() + 5
    end

    local gearMod = player:getMod(tpz.mod.WEAPON_BASH)
    local jpValue = player:getJobPointLevel(tpz.jp.WEAPON_BASH_EFFECT) * 10

    baseDamage = (baseDamage + gearMod)
    baseDamage = baseDamage + jpValue

    -- Apply reductions
    baseDamage = utils.HandlePositionalPDT(player, target, baseDamage)
    baseDamage = target:physicalDmgTaken(baseDamage, tpz.damageType.BLUNT)

    -- Check for phalanx + stoneskin
    if (baseDamage > 0) then
        local attackType = tpz.attackType.PHYSICAL

        -- Add dmg variance
        baseDamage = (baseDamage * math.random(95, 100)) / 100

        baseDamage = baseDamage - target:getMod(tpz.mod.PHALANX)
        baseDamage = utils.stoneskin(target, baseDamage, attackType)
    end

    target:takeDamage(baseDamage, player, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(player, baseDamage)

    return baseDamage
end

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

    -- Check for PD
    if target:hasStatusEffect(tpz.effect.PERFECT_DODGE) then
        return ability:setMsg(tpz.msg.basic.JA_MISS)
    end

    local stunEEM = target:getMod(tpz.mod.EEM_STUN)
    local hands = player:getEquipID(tpz.slot.HANDS)
    local hasChaosGauntlets = (hands == tpz.items.CHAOS_GAUNTLETS)

    -- Applying Weapon Bash stun. Rate is said to be near 100%, so let's say 99%.
    if
        (math.random()*100 < 99) and
        not target:hasStatusEffect(tpz.effect.STUN) and
        (stunEEM > 5)
    then
        target:addStatusEffect(tpz.effect.STUN, 1, 0, 4)
    end

    -- Chaos Gauntlets effect corrupt
    if hasChaosGauntlets then
        local corruptAmount = 1
        CorruptBuffs(player, target, corruptAmount)
    end

    -- Get fSTR
    local damage = 0
    local fstr = fSTR(player:getStat(tpz.mod.STR), target:getStat(tpz.mod.VIT), player:getWeaponDmgRank())
    local params = {}
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1
    -- Get Weapon Damage
    local weaponDamage = player:getWeaponDmg()
    -- Calculating and applying Weapon Bash damage
    local base = weaponDamage + fstr
    local cratio, ccritratio = cMeleeRatio(player, target, params, 0, 0)
    local pdif = generatePdif (cratio[1], cratio[2], true)
    local gearMod = player:getMod(tpz.mod.WEAPON_BASH)
    local jpValue = target:getJobPointLevel(tpz.jp.WEAPON_BASH_EFFECT)

    damage = (base + gearMod + jpValue)  * pdif

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

    return damage
end

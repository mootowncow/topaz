-----------------------------------
-- Ability: Violent Flourish
-- Stuns target with a low rate of success. Requires one Finishing Move.
-- Obtained: Dancer Level 45
-- Finishing Moves Used: 1
-- Recast Time: 0:20
-- Duration: ??
-----------------------------------
require("scripts/globals/weaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/job_util")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/ability")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability, action)
    -- Consume finishing moves
    local maxConsumed = 1
    local finishingMoves = jobUtil.getFinishingMoveCount(player)
    if (finishingMoves > 0) then
        local actualConsumed = jobUtil.consumeFinishingMoves(player, maxConsumed)
    end

    -- Check for shadows
    if TryShadowsAbsorb(target, ability) then
        return 1
    end

    -- Check for PD
    if target:hasStatusEffect(tpz.effect.PERFECT_DODGE) then
        return ability:setMsg(tpz.msg.basic.JA_MISS)
    end

    local hit = 4
    --get fstr
    local fSTR = player:getFSTR(target, tpz.slot.MAIN, false, false)

    local params = {}
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1

    --apply WSC
    local weaponDamage = player:getWeaponDmg()

    if (player:getWeaponSkillType(tpz.slot.MAIN) == 1) then
        local h2hSkill = ((player:getSkillLevel(1) * 0.11) + 3)
        weaponDamage = player:getWeaponDmg()-3

        weaponDamage = weaponDamage + h2hSkill
    end

    local base = weaponDamage + fstr
    local bonusAttPercent = 0
    local flatAttackBonus = 0
    local ignoredDef = 0
    local isCritical = false
    local pdif = player:getDamageRatio(target, isCritical, bonusAttPercent, flatAttackBonus, tpz.slot.MAIN, ignoredDef)
    local attackNumber = 0
    local accBonus = 100 -- https://www.bg-wiki.com/ffxi/Violent_Flourish
    local hitrate = player:getHitRate(target, attackNumber, accBonus, false)

    if (math.random() <= hitrate) then
        hit = 3
        dmg = base * pdif

        local spell = getSpell(252)
        local params = {}
        params.diff = 0
        params.skillType = player:getWeaponSkillType(tpz.slot.MAIN)
        params.bonus = 50 - target:getMod(tpz.mod.STUNRES) + player:getMod(tpz.mod.VFLOURISH_MACC) + player:getJobPointLevel(tpz.jp.FLOURISH_I_EFFECT) 
        local resist = applyResistanceEffect(player, target, spell, params)

        if resist >= 0.25 then
            target:addStatusEffect(tpz.effect.STUN, 1, 0, 8 * resist)
        else
            ability:setMsg(tpz.msg.basic.JA_DAMAGE)
        end

        local attackType = tpz.attackType.PHYSICAL
        local damageType = player:getWeaponDamageType(tpz.slot.MAIN)

        -- Apply reductions
        dmg = utils.HandlePositionalPDT(player, target, dmg)
        dmg = target:physicalDmgTaken(dmg, damageType)

        dmg = dmg - target:getMod(tpz.mod.PHALANX)
        dmg = utils.stoneskin(target, dmg, attackType)
        target:takeDamage(dmg, player, tpz.attackType.PHYSICAL, damageType)
        target:updateEnmityFromDamage(player, dmg)

        action:animation(target:getID(), getFlourishAnimation(player:getWeaponSkillType(tpz.slot.MAIN)))
        action:speceffect(target:getID(), hit)
        return dmg
    else
        ability:setMsg(tpz.msg.basic.JA_MISS)
        return 0
    end
end

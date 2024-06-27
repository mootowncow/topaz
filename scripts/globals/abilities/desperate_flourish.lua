-----------------------------------
-- Ability: Desperate Flourish
-- Weighs down a target with a low rate of success. Requires one Finishing Move.
-- Obtained: Dancer Level 30
-- Finishing Moves Used: 1
-- Recast Time: 00:20
-- Duration: ??
-----------------------------------
require("scripts/globals/weaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_1)) then
        player:delStatusEffect(tpz.effect.FINISHING_MOVE_1)
        return 0, 0
    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_2)) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_2)
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_1, 1, 0, 7200)
        return 0, 0
    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_3)) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_3)
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_2, 1, 0, 7200)
        return 0, 0
    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_4)) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_4)
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_3, 1, 0, 7200)
        return 0, 0
    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_5)) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_5)
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_4, 1, 0, 7200)
        return 0, 0
    else
        return 0, 0
    end
end

function onUseAbility(player, target, ability, action)
    --get fstr
    local fstr = fSTR(player:getStat(tpz.mod.STR), target:getStat(tpz.mod.VIT), player:getWeaponDmgRank())

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
    local cratio, ccritratio = cMeleeRatio(player, target, params, 0, 0)
    local isSneakValid = player:hasStatusEffect(tpz.effect.SNEAK_ATTACK)
    if (isSneakValid and not player:isBehind(target)) then
        isSneakValid = false
    end
    local pdif = generatePdif (cratio[1], cratio[2], true)
    local hitrate = getHitRate(player, target, true, false, -50)

	
    if (math.random() <= hitrate or isSneakValid) then
        hit = 2
        dmg = base * pdif
        local spell = getSpell(216)
        local attackType = tpz.attackType.PHYSICAL
        local params = {}
        params.diff = 0
        params.skillType = player:getWeaponSkillType(tpz.slot.MAIN)
        params.bonus = 0 - target:getMod(tpz.mod.GRAVITYRES) + player:getMod(tpz.mod.VFLOURISH_MACC) + player:getJobPointLevel(tpz.jp.FLOURISH_I_EFFECT) 
        local resist = applyResistanceEffect(player, target, spell, params)
		

        if resist >= 0.5 then
            if target:hasStatusEffect(tpz.effect.WEIGHT) then
                dmg = dmg - target:getMod(tpz.mod.PHALANX)
                dmg = utils.stoneskin(target, dmg, attackType)
                 target:takeDamage(dmg, player, tpz.attackType.PHYSICAL, player:getWeaponDamageType(tpz.slot.MAIN))
                target:updateEnmityFromDamage(player, dmg)
                action:animation(target:getID(), getFlourishAnimation(player:getWeaponSkillType(tpz.slot.MAIN)))
                action:speceffect(target:getID(), hit)
                ability:setMsg(tpz.msg.basic.JA_NO_EFFECT)
                return 0
            else
                dmg = dmg - target:getMod(tpz.mod.PHALANX)
                dmg = utils.stoneskin(target, dmg, attackType)
                target:takeDamage(dmg, player, tpz.attackType.PHYSICAL, player:getWeaponDamageType(tpz.slot.MAIN))
                target:updateEnmityFromDamage(player, dmg)
                action:animation(target:getID(), getFlourishAnimation(player:getWeaponSkillType(tpz.slot.MAIN)))
                action:speceffect(target:getID(), hit)
                target:addStatusEffect(tpz.effect.WEIGHT, 50, 0, 60 * resist)
                ability:setMsg(tpz.msg.basic.JA_ENFEEB_IS)
                return tpz.effect.WEIGHT
            end
        else
            dmg = dmg - target:getMod(tpz.mod.PHALANX)
            dmg = utils.stoneskin(target, dmg, attackType)
            target:takeDamage(dmg, player, tpz.attackType.PHYSICAL, player:getWeaponDamageType(tpz.slot.MAIN))
            target:updateEnmityFromDamage(player, dmg)
            action:animation(target:getID(), getFlourishAnimation(player:getWeaponSkillType(tpz.slot.MAIN)))
            action:speceffect(target:getID(), hit)
            ability:setMsg(tpz.msg.basic.JA_DAMAGE)
            return dmg
        end
    else
        ability:setMsg(tpz.msg.basic.JA_MISS)
        return 0
    end
end

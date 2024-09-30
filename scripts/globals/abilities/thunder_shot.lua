-----------------------------------
-- Ability: Thunder Shot
-- Consumes a Thunder Card to enhance lightning-based debuffs. Deals lightning-based magic damage
-- Shock Effect: Enhanced DoT and MND-
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/job_util")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability, action)
    local params = {}
    params.includemab = true
    params.targetTPMult = 0 -- Quick Draw does not feed TP
    local dmg = jobUtil.CalculateQd(player, target, ability, tpz.magic.ele.LIGHTNING, action, params)
    dmg = takeAbilityDamage(target, player, params, true, dmg, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING, tpz.slot.RANGED, 1, 0, 0, 0, action, nil)

    if dmg > 0 then
        local effect = tpz.effect.STUN
        local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.LIGHTNING, bonusAcc, effect, tpz.skill.MARKSMANSHIP)
        local power = 1
        local duration = 6
        local tick = 0

        if (resist >= 0.5) and not target:hasStatusEffect(effect) then
            duration = duration * resist
            duration = CheckDiminishingReturns(player, target, effect, duration)

            if (duration > 0) then
                target:addStatusEffect(effect, power, tick, duration)
                AddDimishingReturns(caster, target, nil, effect)
            end
        end

        local tp = utils.CalcualteTPGain(player, target, true)
        jobUtil.HandleCorsairShotTP(player, target, dmg, tp)
    end

    if player:isPC() then
        local del = player:delItem(2180, 1) or player:delItem(2974, 1)
    end
    target:updateClaim(player)
    return dmg
end

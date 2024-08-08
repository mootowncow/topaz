-----------------------------------
-- Ability: Fire Shot
-- Consumes a Fire Card to enhance fire-based debuffs. Deals fire-based magic damage
-- Burn effect: Enhanced DoT and INT-
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
    local dmg = jobUtil.CalculateQd(player, target, ability, tpz.magic.ele.FIRE, action, params)
    dmg = takeAbilityDamage(target, player, params, true, dmg, tpz.attackType.MAGICAL, tpz.damageType.FIRE, tpz.slot.RANGED, 1, 0, 0, 0, action, nil)

    if dmg > 0 then
        local effect = tpz.effect.ADDLE
        local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.FIRE, bonusAcc, effect, tpz.skill.MARKSMANSHIP)
        local power = 15
        local duration = 180
        local tick = 0

        if (resist >= 0.5) and not target:hasStatusEffect(effect) then
            duration = duration * resist
            target:addStatusEffect(effect, power, tick, duration)
        end

        local tp = utils.CalcualteTPGain(player, target, true)
        jobUtil.HandleCorsairShoTP(player, target, dmg, tp)
    end

    if player:isPC() then
        local del = player:delItem(2176, 1) or player:delItem(2974, 1)
    end

    target:updateClaim(player)
    return dmg
end

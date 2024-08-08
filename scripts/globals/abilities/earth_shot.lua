-----------------------------------
-- Ability: Earth Shot
-- Consumes a Earth Card to enhance earth-based debuffs. Deals earth-based magic damage
-- Rasp Effect: Enhanced DoT and DEX-, Slow Effect +10%
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
    local dmg = jobUtil.CalculateQd(player, target, ability, tpz.magic.ele.EARTH, action, params)
    dmg = takeAbilityDamage(target, player, params, true, dmg, tpz.attackType.MAGICAL, tpz.damageType.EARTH, tpz.slot.RANGED, 1, 0, 0, 0, action, nil)

    if dmg > 0 then
        local effect = tpz.effect.SLOW
        local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.EARTH, bonusAcc, effect, tpz.skill.MARKSMANSHIP)
        local power = 2500
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
        local del = player:delItem(2179, 1) or player:delItem(2974, 1)
    end
    target:updateClaim(player)
    return dmg
end

-----------------------------------
-- Ability: Ice Shot
-- Consumes a Ice Card to enhance ice-based debuffs. Deals ice-based magic damage
-- Frost Effect: Enhanced DoT and AGI-
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/job_util")
-----------------------------------

function onAbilityCheck(player, target, ability)
    --ranged weapon/ammo: You do not have an appropriate ranged weapon equipped.
    --no card: <name> cannot perform that action.
    if player:getWeaponSkillType(tpz.slot.RANGED) ~= tpz.skill.MARKSMANSHIP or player:getWeaponSkillType(tpz.slot.AMMO) ~= tpz.skill.MARKSMANSHIP then
        return 216, 0
    end
    if player:hasItem(2177, 0) or player:hasItem(2974, 0) then
        return 0, 0
    else
        return 71, 0
    end
end

function onUseAbility(player, target, ability, action)
    local params = {}
    params.includemab = true
    params.targetTPMult = 0 -- Quick Draw does not feed TP
    local dmg = jobUtil.CalculateQd(player, target, ability, tpz.magic.ele.ICE, action, params)
    dmg = takeAbilityDamage(target, player, params, true, dmg, tpz.attackType.MAGICAL, tpz.damageType.ICE, tpz.slot.RANGED, 1, 0, 0, 0, action, nil)

    if dmg > 0 then
        local effect = tpz.effect.PARALYSIS
        local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.ICE, bonusAcc, effect, tpz.skill.MARKSMANSHIP)
        local power = 20
        local duration = 120
        local tick = 0

        if (resist >= 0.5) and not target:hasStatusEffect(effect) then
            duration = duration * resist
            target:addStatusEffect(effect, power, tick, duration)
        end

        local tp = utils.CalcualteTPGain(player, target, true)
        jobUtil.HandleCorsairShoTP(player, target, dmg, tp)
    end

    local del = player:delItem(2177, 1) or player:delItem(2974, 1)

    target:updateClaim(player)
    return dmg
end

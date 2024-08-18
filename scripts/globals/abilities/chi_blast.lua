-- Ability: Chi Blast
-- Releases Chi to attack an enemy.
-- Obtained: Monk Level 41
-- Recast Time: 3:00
-- Duration: Instant
-- Inner Strength: Doubles the duration of penance.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local boost = player:getStatusEffect(tpz.effect.BOOST)
    local multiplier = player:getCharVar("boost") -- Get boost variable from abilities/boost.lua
    local penanceDurationMultiplier = 1
	if multiplier == 0 then -- If buff isn't active, don't multiply by zero!
		multiplier = 1
	end
    if (boost ~= nil) then
        penanceDurationMultiplier = 2
        multiplier = multiplier * ( (boost:getPower()/100) * 4 + 1)  -- power is the raw % atk boost. Get boost damage bonus
    end

	local dmg = math.floor((player:getStat(tpz.mod.MND) * (0.5 + (math.random() / 2))) * multiplier) / 3 -- Formula from BG wiki
    
    local penance = player:getMerit(tpz.merit.PENANCE)
    
    if (penance > 0) then
        target:delStatusEffectSilent(tpz.effect.INHIBIT_TP)
        target:addStatusEffect(tpz.effect.INHIBIT_TP,25,3,penance * penanceDurationMultiplier)
    end

    local attackType = tpz.attackType.BREATH
    dmg = utils.stoneskin(target, dmg, attackType)
    target:takeDamage(dmg, player, tpz.attackType.SPECIAL, tpz.damageType.ELEMENTAL)
    target:updateEnmityFromDamage(player, dmg)
    target:updateClaim(player)
    player:delStatusEffectSilent(tpz.effect.BOOST)
	player:setCharVar("boost", 0)

    return dmg
end

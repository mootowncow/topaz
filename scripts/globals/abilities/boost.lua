-----------------------------------
-- Ability: Boost
-- Enhances user's next attack.
-- Obtained: Monk Level 5
-- Recast Time: 0:15
-- Duration: 3:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local power = 12.5 + (0.10 * player:getMod(tpz.mod.BOOST_EFFECT))
	local boost =  player:getCharVar("boost")

    if player:hasStatusEffect(tpz.effect.BOOST) then
        local effect = player:getStatusEffect(tpz.effect.BOOST)
        effect:setPower(effect:getPower() + power)
        player:addMod(tpz.mod.ATTP, power)
		boost = boost + 1
		player:setCharVar("boost", boost)
    else
        player:addStatusEffect(tpz.effect.BOOST, power, 0, 180)
		player:setCharVar("boost", 1)
    end
end

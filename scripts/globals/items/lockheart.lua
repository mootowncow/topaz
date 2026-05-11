-----------------------------------------
-- ID: 16944
-- Item: Lockheart
-- Additional Effect: Dispel
-- +175 Bonus MACC like the spell
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
function onAdditionalEffect(player, target, damage)
    local chance = CalculateAdditionalEffectChance(player, 10)
    local resist = getAdditionalEffectStatusResist(player, target, tpz.effect.NONE, tpz.magic.ele.DARK, 175)

    -- Check for dispel resistance trait
	if math.random(100) < target:getMod(tpz.mod.DISPELRESTRAIT) then
        return 0, 0, 0
    end

    -- Handle Magic Shield
    if target:hasStatusEffect(tpz.effect.MAGIC_SHIELD, 0) and target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() < 2 then
        return 0, 0, 0
    end

    if (math.random(0, 95) >= chance or resist < 0.5) then 
        return 0, 0, 0
    else
        local effect = target:dispelStatusEffect()
        if (effect ~= tpz.effect.NONE) then
            return tpz.subEffect.DISPEL, tpz.msg.basic.ADD_EFFECT_DISPEL, effect
        end
    end
end

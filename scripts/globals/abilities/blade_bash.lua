-----------------------------------
-- Ability: Blade Bash
-- Deliver an attack that can stun the target and occasionally cause Plague.
-- Deals no damage.
-- Obtained: Samurai Level 75
-- Recast Time: 3:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    -- Stun rate
    if (math.random(1, 100) < 99) then
        target:addStatusEffect(tpz.effect.STUN, 1, 0, 6)
    end

    -- Applying Plague based on merit level.
    local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.FIRE, 100)
    local duration = 15 + player:getMerit(tpz.merit.BLADE_BASH)

    duration = duration * resist

    if (resist >= 0.5) then
        target:addStatusEffect(tpz.effect.PLAGUE, 5, 3, duration)
    end
    ability:setMsg(tpz.msg.basic.JA_ENFEEB_IS)

    return tpz.effect.STUN
end

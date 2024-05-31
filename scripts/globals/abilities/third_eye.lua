-----------------------------------
-- Ability: Third Eye
-- Anticipates and dodges the next attack directed at you.
-- Obtained: Samurai Level 15
-- Recast Time: 1:00
-- Duration: 0:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if (player:hasStatusEffect(tpz.effect.SEIGAN)) then
        ability:setRecast(ability:getRecast()/2)
    end
    return 0, 0
end

function onUseAbility(player, target, ability)
    local power = 100 + player:getMod(tpz.mod.THIRD_EYE_ANTICIPATE_RATE)

    if player:hasStatusEffect(tpz.effect.COPY_IMAGE) or player:hasStatusEffect(tpz.effect.BLINK) then
        -- Returns "no effect" message when Copy Image is active when Third Eye is used.
        ability:setMsg(tpz.msg.basic.JA_NO_EFFECT)
    else
        player:delStatusEffectSilent(tpz.effect.THIRD_EYE, 0, 0, 30)
        player:addStatusEffect(tpz.effect.THIRD_EYE, power, 3, 30) -- Power keeps track of proc rate
    end
end


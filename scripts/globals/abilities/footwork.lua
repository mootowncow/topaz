-----------------------------------
-- Ability: Footwork
-- Makes kicks your primary mode of attack.
-- Obtained: Monk Level 65
-- Recast Time: 3:00
-- Duration: 1:30
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local kickDmg = 50 + player:getWeaponDmg()
    local doubleAttackRate = 5 + player:getMerit(tpz.merit.KICK_ATTACK_RATE)
    local duration = 90

    if player:isPC() then
        if player:hasStatusEffect(tpz.effect.BOOST) then
            duration = 180
        end
    end

   player:addStatusEffect(tpz.effect.FOOTWORK, kickDmg, 0, duration, 0, doubleAttackRate)
   player:delStatusEffectSilent(tpz.effect.BOOST)
end

-----------------------------------
-- Ability: Footwork
-- Makes kicks your primary mode of attack.
-- Obtained: Monk Level 65
-- Recast Time: 3:00
-- Duration: 1:30
-- Inner Strength: Doubles duration
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local kickDmg = 3 + player:getWeaponDmg()
    local duration = 60

   player:addStatusEffect(tpz.effect.FOOTWORK, kickDmg, 0, duration)
end

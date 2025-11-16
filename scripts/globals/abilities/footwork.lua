-----------------------------------
-- Ability: Footwork
-- Makes kicks your primary mode of attack and increases the damage of kicks.
-- Obtained: Monk Level 65
-- Recast Time: 1:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local kickDmg = 25 + player:getWeaponDmg()
    local duration = 60

   player:addStatusEffect(tpz.effect.FOOTWORK, kickDmg, 0, duration)
end

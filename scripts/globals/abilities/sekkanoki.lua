-----------------------------------
-- Ability: Sekkanoki
-- Limits TP cost of next weapon skill to 100.
-- Obtained: Samurai Level 40
-- Recast Time: 0:05:00
-- Duration: 01:00, or until a weapon skill is used
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/items")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if (player:getEquipID(tpz.slot.BODY) == tpz.items.SAOTOME_DOMARU) then -- AF body reduces recast by 120s
        ability:setRecast(180)
    elseif (player:getEquipID(tpz.slot.BODY) == tpz.items.SAOTOME_DOMARU_HQ) then -- AF+1 body reduces recast by 150s
        ability:setRecast(150)
    end
    return 0, 0
end

function onUseAbility(player, target, ability)
    target:delStatusEffectSilent(tpz.effect.SEKKANOKI)
    target:addStatusEffect(tpz.effect.SEKKANOKI, 1, 0, 60)
end

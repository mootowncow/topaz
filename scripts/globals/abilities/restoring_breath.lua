-----------------------------------
-- Ability: Restoring Breath
-- Commands your wyvern to use Healing Breath
-- Obtained: Dragoon Level 30
-- Recast Time: 01:00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/pets/wyvern")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local healingbreath = tpz.jobAbility.HEALING_BREATH

    if player:getMainLvl() >= 80 then healingbreath = tpz.jobAbility.HEALING_BREATH_IV
    elseif player:getMainLvl() >= 40 then healingbreath = tpz.jobAbility.HEALING_BREATH_III
    elseif player:getMainLvl() >= 20 then healingbreath = tpz.jobAbility.HEALING_BREATH_II
    end

    doRestoringBreath(player, healingbreath)
end
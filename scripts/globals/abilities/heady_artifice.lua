-----------------------------------
-- Ability: Heady Artifice
-- Description: Greatly reduces the damage your Automaton takes for a short time.
-- Obtained: PUP Level 60
-- Recast Time: 00:00:60
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local pet = player:getPet()
    local head = pet:getAutomatonHead()
    local jpValue = player:getJobPointLevel(tpz.jp.HEADY_ARTIFICE_EFFECT)

    if (head == tpz.heads.VALOREDGE) then
        target:addEnmity(pet, 100 * jpValue, 0)
    elseif (head == tpz.heads.SOULSOOTHER) then
        local mpToAdd = pet:getMaxMP() * (jpValue / 100)
        printf("mpToAdd %d", mpToAdd)
        pet:addMP(mpToAdd)
    end

    pet:addStatusEffect(tpz.effect.INVINCIBLE, 1, 0, 5)
    pet:addStatusEffect(tpz.effect.ELEMENTAL_SFORZO, 1, 0, 5)
end


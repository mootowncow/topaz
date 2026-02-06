-----------------------------------
-- Ability: Cooldown
-- Description: Increases your automaton's effectiveness in combat.
-- Obtained: PUP Level 70
-- Recast Time: 00:05:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local pet = player:getPet()
    local duration = 30
    local jpValue = player:getJobPointLevel(tpz.jp.COOLDOWN_EFFECT)

    player:reduceBurden(50, jpValue)
    pet:queue(0, function(pet)
        pet:addMod(tpz.mod.HASTE_ABILITY, 1000)
        pet:addMod(tpz.mod.MAIN_DMG_RATING, 10)
        pet:addMod(tpz.mod.RANGED_DMG_RATING, 10)
        pet:addMod(tpz.mod.ATTP, 25)
        pet:addMod(tpz.mod.RATTP, 25)
        pet:addMod(tpz.mod.ACC, 25)
        pet:addMod(tpz.mod.RACC, 25)
        pet:addTP(600)
    end)
    pet:queue(duration*1000, function(pet)
        pet:delMod(tpz.mod.HASTE_ABILITY, 1000)
        pet:delMod(tpz.mod.MAIN_DMG_RATING, 10)
        pet:delMod(tpz.mod.RANGED_DMG_RATING, 10)
        pet:delMod(tpz.mod.ATTP, 25)
        pet:delMod(tpz.mod.RATTP, 25)
        pet:delMod(tpz.mod.ACC, 25)
        pet:delMod(tpz.mod.RACC, 25)
    end)
end

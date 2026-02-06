-----------------------------------
-- Ability: Activate
-- Calls forth your automaton.
-- Obtained: Puppetmaster Level 1
-- Recast Time: 0:20:00 (0:16:40 with full merits)
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    tpz.pet.spawnPet(player, tpz.pet.id.AUTOMATON)

    local pet = player:getPet()
    local jpBurdenReduction = player:getJobPointLevel(tpz.jp.ACTIVATE_EFFECT)

    if pet then
        local jpHpMp = player:getJobPointLevel(tpz.jp.AUTOMATON_HP_MP_BONUS)
        pet:addMod(tpz.mod.HP, jpHpMp * 10)
        pet:addMod(tpz.mod.MP, jpHpMp * 5)
        player:reduceBurden(0, jpBurdenReduction)
    end
end

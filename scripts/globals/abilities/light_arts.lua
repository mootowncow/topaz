-----------------------------------
-- Ability: Light Arts
-- Optimizes white magic capability while lowering black magic proficiency. Grants a bonus to divine, enhancing, enfeebling, and healing magic. Also grants access to Stratagems.
-- Obtained: Scholar Level 10
-- Recast Time: 1:00
-- Duration: 2:00:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:delStatusEffectSilent(tpz.effect.DARK_ARTS)
    player:delStatusEffectSilent(tpz.effect.ADDENDUM_BLACK)
    player:delStatusEffectSilent(tpz.effect.PARSIMONY)
    player:delStatusEffectSilent(tpz.effect.ALACRITY)
    player:delStatusEffectSilent(tpz.effect.MANIFESTATION)
    player:delStatusEffectSilent(tpz.effect.EBULLIENCE)
    player:delStatusEffectSilent(tpz.effect.FOCALIZATION)
    player:delStatusEffectSilent(tpz.effect.EQUANIMITY)
    player:delStatusEffectSilent(tpz.effect.IMMANENCE)

    local skillbonus = player:getMod(tpz.mod.LIGHT_ARTS_SKILL)
    local effectbonus = player:getMod(tpz.mod.LIGHT_ARTS_EFFECT)
    local regenbonus = 0
    if (player:getMainJob() == tpz.job.SCH and player:getMainLvl() >= 20) then
        regenbonus = 3 * math.floor((player:getMainLvl() - 10) / 10)
    end

    player:addStatusEffect(tpz.effect.LIGHT_ARTS, effectbonus, 0, 7200, 0, regenbonus)

    return tpz.effect.LIGHT_ARTS
end

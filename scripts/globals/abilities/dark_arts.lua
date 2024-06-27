-----------------------------------
-- Ability: Dark Arts
-- Optimizes black magic capability while lowering white magic proficiency. Grants a bonus to enfeebling, elemental, and dark magic. Also grants access to Stratagems.
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
    player:delStatusEffectSilent(tpz.effect.LIGHT_ARTS)
    player:delStatusEffectSilent(tpz.effect.ADDENDUM_WHITE)
    player:delStatusEffectSilent(tpz.effect.PENURY)
    player:delStatusEffectSilent(tpz.effect.CELERITY)
    player:delStatusEffectSilent(tpz.effect.ACCESSION)
    player:delStatusEffectSilent(tpz.effect.RAPTURE)
    player:delStatusEffectSilent(tpz.effect.ALTRUISM)
    player:delStatusEffectSilent(tpz.effect.TRANQUILITY)
    player:delStatusEffectSilent(tpz.effect.PERPETUANCE)

    local helixbonus = 0
    if (player:getMainJob() == tpz.job.SCH and player:getMainLvl() >= 20) then
        helixbonus = math.floor(player:getMainLvl() / 4)
    end

    player:addStatusEffect(tpz.effect.DARK_ARTS, 1, 0, 7200, 0, helixbonus)

    return tpz.effect.DARK_ARTS
end

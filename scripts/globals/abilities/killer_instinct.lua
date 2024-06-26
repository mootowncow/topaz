---------------------------------------------------
-- Ability: Killer Instinct
-- 	Grants your pet's Killer Effect to party members within area of effect.
-- This translates to +15% dmg to the pets system's strength'
-- Obtained: Beastmaster Level 75 (Merits)
-- Recast Time: 0:05:00
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    -- Pets affinity, Affinity Strength
    local systemStrength =
    {
        { tpz.eco.AMORPH,   tpz.mod.BIRD_CIRCLE, },
        { tpz.eco.AQUAN,    tpz.mod.AMORPH_CIRCLE, },
        { tpz.eco.BEAST,    tpz.mod.LIZARD_CIRCLE, },
        { tpz.eco.BIRD,     tpz.mod.AQUAN_CIRCLE, },
        { tpz.eco.DRAGON,   tpz.mod.DEMON_CIRCLE },
        { tpz.eco.LIZARD,   tpz.mod.VERMIN_CIRCLE },
        { tpz.eco.PLANTOID, tpz.mod.BEAST_CIRCLE },
        { tpz.eco.VERMIN,   tpz.mod.PLANTOID_CIRCLE },
    }
    local meritBonus = (player:getMerit(tpz.merit.KILLER_INSTINCT) * 10) - 10
    local duration = 180 + meritBonus
    local pet = player:getPet()
    local petFamily = pet:getSystem()
    local power = 0
    for _, affinity in pairs(systemStrength) do
        if (petFamily == affinity[1]) then
            power = affinity[2]
        end
    end

    target:addStatusEffect(tpz.effect.KILLER_INSTINCT, power, 0, duration)
end

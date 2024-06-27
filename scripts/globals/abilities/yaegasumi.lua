-----------------------------------
-- Ability: Yaegasumi
-- Description: Allows you to evade special attacks. Grants a weapon skill damage bonus that varies with the number of special attacks evaded.
-- Obtained: SAM Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:45
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/job_util")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    if jobUtil.ConsumeIgnisRune(player, tpz.effect.GEO_DEFENSE_BOOST, 8) then
        target:addStatusEffect(tpz.effect.YAEGASUMI, 25, 0, 60)
    end
end
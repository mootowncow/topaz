-----------------------------------
-- Ability: Spirit Surge
-- Adds your wyvern's strength to your own.
-- Obtained: Dragoon Level 1
-- Recast Time: 1:00:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/job_util")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
   jobUtil.ConsumeUndaRune(player, target, tpz.effect.SPIRIT_SURGE, 10)
end

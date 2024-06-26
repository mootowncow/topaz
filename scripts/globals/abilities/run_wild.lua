-----------------------------------
-- Ability: Run Wild
-- Increases nearby allies Movement Speed.
-- Obtained: BST Level 20
-- TP Required: 0
-- Recast Time: 00:30
-- Duration: 5:00
-----------------------------------
require("scripts/globals/pets")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local duration = 300 + (player:getJobPointLevel(tpz.jp.RUN_WILD_DURATION) * 2)

	target:addStatusEffect(tpz.effect.QUICKENING, 20, 0, duration)
end


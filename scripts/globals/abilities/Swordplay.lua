-----------------------------------
-- Ability: Swordplay
-- 	Increases accuracy and evasion until you take severe damage.
-- 3 Accuracy / Evasion per 3 seconds (3 on initial activation)
-- Caps at +60 Evasion/Accuracy regardless of being main or sub RUN.
-- Obtained: RUN level 20
-- Recast Time: 00:05:00
-- Duration: 0:02:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    target:addStatusEffect(tpz.effect.SWORDPLAY, 1, 0, 120)
end

-----------------------------------
-- Ability: Perpetuance
-- Increases the enhancement effect duration of your next white magic spell.
-- Obtained: Scholar Level 65
-- Recast Time: Stratagem Charge
-- Duration: 00:01:00 or first white Enhancing Magic cast, whichever first
--
-- Level   |Charges |Recharge Time per Charge
-- -----   -------- ---------------
-- 10      |1       |4:00 minutes
-- 30      |2       |2:00 minutes
-- 50      |3       |1:20 minutes
-- 70      |4       |1:00 minute
-- 90      |5       |48 seconds
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.PERPETUANCE, 1, 0, 60)

    return tpz.effect.PERPETUANCE
end

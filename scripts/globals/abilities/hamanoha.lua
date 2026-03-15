-----------------------------------
-- Ability: Hamanoha
-- Description: Lowers accuracy, evasion, magic accuracy, magic evasion and TP gain for demons.
-- Obtained: SAM Level 87
-- Recast Time: 00:05:00
-- Duration: 0:03:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/job_util")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local jpValue = target:getJobPointLevel(tpz.jp.HAMANOHA_DURATION)
    if jobUtil.ConsumeIgnisRune(player, tpz.effect.GEO_MAGIC_DEF_BOOST, 3) then
        local demon = target:getSystem() == 9
	    if demon then
            target:addStatusEffect(tpz.effect.HAMANOHA, 12, 0, 180 + jpValue)
        end
    end
end

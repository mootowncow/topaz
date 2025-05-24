---------------------------------------------
-- Soothing Ruby
-- Removes multiple status ailments from party members within area of effect. (Up to 6)
-- Does not remove curse
---------------------------------------------
require("scripts/globals/summon")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
end

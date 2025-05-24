---------------------------------------------
-- Pacifying Ruby
-- Removes 25% of the targets enmity.
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
    target:lowerAllEnmity(25)
end

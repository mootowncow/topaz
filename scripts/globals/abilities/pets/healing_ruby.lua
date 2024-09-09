---------------------------------------------
-- Healing Ruby
---------------------------------------------
require("scripts/globals/summon")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    getAvatarTP(player)
    return 0, 0
end
function onPetAbility(target, pet, skill)
    local master = pet:getMaster()
    local target = master:getCursorTarget()
    return AvatarHealBP(pet, target, skill, 0.10, false)
end
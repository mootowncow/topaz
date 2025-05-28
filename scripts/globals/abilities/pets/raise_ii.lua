---------------------------------------------
-- Raise II (Avatar)
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

function onPetAbility(target, pet, skill, summoner)
    local params = {}
    params.NO_TP_CONSUMPTION = true

    if (target:isPC()) then
        target:sendRaise(2)
    end

    return 2 -- TODO: Incorrect return
end

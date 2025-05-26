---------------------------------------------
-- Pavor Nocturnus
-- Absorbs 2 status effect from the target
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
    local params = {}
    local bonus = 255
    local amount = 2
    -- TODO: Msg
    skill:setMsg(AvatarAbsorbStatusEffectBloodPact(pet, target, params, bonus, amount))
    return 0
end
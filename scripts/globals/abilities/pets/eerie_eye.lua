-----------------------------------------
-- Eerie Eye
-- Light alligned Dispel
-----------------------------------------
require("scripts/globals/summon")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/spell_data")
require("scripts/globals/summon")
-----------------------------------------

function onAbilityCheck(player, target, ability)
    getAvatarTP(player)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local params = {}

    local dispel = AvatarDispelMove(pet, target, skill, tpz.magic.ele.LIGHT, tpz.effectFlag.DISPELABLE)

    if (dispel == tpz.effect.NONE) then
        skill:setMsg(tpz.msg.basic.NO_EFFECT)
    else
        skill:setMsg(tpz.msg.basic.NONE)
    end

    return 0
end
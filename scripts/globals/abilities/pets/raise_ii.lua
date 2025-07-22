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
    elseif target:isTrust() then
        target:setHP(target:getMaxHP() * 0.25)
        if target:hasStatusEffect(tpz.effect.WEAKNESS) then
            target:addStatusEffect(tpz.effect.WEAKNESS, 2, 0, 120)
        else
            target:addStatusEffect(tpz.effect.WEAKNESS, 1, 0, 120)
        end
    end

    return 0
end

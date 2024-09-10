-----------------------------------
--
--     tpz.effect.LEAVEGAME
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
-----------------------------------
function onEffectGain(target, effect)
    target:setAnimation(33)
    target:messageSystem(effect:getPower(), 30)
end

function onEffectTick(target, effect)
    if (effect:getTickCount() > 5) then
        local pet = target:getPetID()
        if pet then
            if (pet >= tpz.pet.id.FIRE_SPIRIT and pet <= tpz.pet.id.CAIT_SITH) then
                target:setAnimation(0)
                target:messageBasic(tpz.msg.basic.CANT_HEAL_AVATAR, 0, 0, 0, false)
            end
        else
            target:leavegame()
        end
    else
        target:messageSystem(effect:getPower(), 30-effect:getTickCount()*5)
    end
end

function onEffectLose(target, effect)
    target:setAnimation(0)
end

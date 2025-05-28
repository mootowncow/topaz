-----------------------------------------
-- Mewing Lullaby
-- https://www.bg-wiki.com/ffxi/Mewing_Lullaby
-- The TP lowering seems to be a total reset of TP on the mob, and even if the sleep misses,
-- the TP reset cannot miss.
-- Light based sleep in a 10' radius
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
    params.ELEMENT_OVERRIDE = tpz.magic.ele.LIGHT
    local effect = tpz.effect.SLEEP_I
    local power = 1
    local duration = 90
    local bonus = 0

    -- Can't overwrite any sleep
    if hasSleepT1Effect(target) then
        giveAvatarTP(pet)
        skill:setMsg(tpz.msg.basic.JA_NO_EFFECT_2)
        return effect
    end

    skill:setMsg(AvatarStatusEffectBP(pet, target, effect, power, duration, params, bonus))

    return tpz.effect.SLEEP_I
end
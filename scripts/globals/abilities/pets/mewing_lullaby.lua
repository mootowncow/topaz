-----------------------------------------
-- Mewing Lullaby
-- https://www.bg-wiki.com/ffxi/Mewing_Lullaby
-- The TP lowering seems to be a total reset of TP on the mob, and even if the sleep misses,
-- the TP reset cannot miss.
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
    local effect = tpz.effect.LULLABY
    local power = 1
    local duration = 35
    local bonus = 0

    -- Can't overwrite any sleep
    if hasSleepT1Effect(target) then
        giveAvatarTP(pet)
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return effect
    end

    skill:setMsg(AvatarStatusEffectBP(pet, target, effect, power, duration, params, bonus))
    target:setTP(0)
    giveAvatarTP(pet)

    return tpz.effect.SLEEP_II
end
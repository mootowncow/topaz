--------------------------------------
-- Spell: Voidstorm
--     Changes the weather around target party member to "gloomy."
--------------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
--------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = 1800
    duration = calculateDurationForLvl(duration, 47, target:getMainLvl())

    local merit = caster:getMerit(tpz.merit.STORMSURGE)
    local power = 0
    if merit > 0 then
        power = merit + caster:getMod(tpz.mod.STORMSURGE_EFFECT) + 2
    end

    DeleteStormEffects(caster)
    target:addStatusEffect(tpz.effect.VOIDSTORM_II, power, 0, duration)

    return tpz.effect.VOIDSTORM_II
end

-----------------------------------
--
-- tpz.effect.SABER_DANCE
--
-----------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local saberDanceMerits = target:getMerit(tpz.merit.SABER_DANCE)
    if (saberDanceMerits>5) then
        target:addMod(tpz.mod.SAMBA_PDURATION, (saberDanceMerits -5))
    end
    -- Does not stack with warrior Double Attack trait, so disable it
    if (target:hasTrait(tpz.trait.DOUBLE_ATTACK)) then
        target:delMod(tpz.mod.DOUBLE_ATTACK, 10)
    end
    target:addMod(tpz.mod.DOUBLE_ATTACK, effect:getPower())
    target:addMod(tpz.mod.KICK_DMG, effect:getPower())

    target:delStatusEffect(tpz.effect.FAN_DANCE)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local saberDanceMerits = target:getMerit(tpz.merit.SABER_DANCE)
    if (saberDanceMerits>1) then
        target:delMod(tpz.mod.SAMBA_PDURATION, (saberDanceMerits -5))
    end
    if (target:hasTrait(tpz.trait.DOUBLE_ATTACK)) then
        -- put Double Attack trait back on.
        target:addMod(tpz.mod.DOUBLE_ATTACK, 10)
    end
    target:delMod(tpz.mod.DOUBLE_ATTACK, effect:getPower())
    target:delMod(tpz.mod.KICK_DMG, effect:getPower())
end

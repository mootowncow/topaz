-----------------------------------
--
-- tpz.effect.FAN_DANCE
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    -- Waltz recast effect is handled in the waltz scripts
    -- Removes all active Waltz effects when used
    for waltz = tpz.effect.DRAIN_SAMBA, tpz.effect.HASTE_SAMBA do
        target:delStatusEffectSilent(waltz)
    end
    target:delStatusEffectSilent(tpz.effect.SABER_DANCE)
    target:addMod(tpz.mod.ENMITY, 15)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ENMITY, 15)
end

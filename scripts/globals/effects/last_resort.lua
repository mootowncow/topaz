-----------------------------------
--
--     tpz.effect.LAST_RESORT
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.LAST_RESORT_EFFECT) * 2

    target:addMod(tpz.mod.ATT, jpValue)
    target:addMod(tpz.mod.ATTP, 25 + target:getMerit(tpz.merit.LAST_RESORT_EFFECT))
    target:addMod(tpz.mod.RATT, jpValue)
    target:addMod(tpz.mod.RATTP, 25 + target:getMerit(tpz.merit.LAST_RESORT_EFFECT))
    target:addMod(tpz.mod.TWOHAND_HASTE_ABILITY, target:getMod(tpz.mod.DESPERATE_BLOWS) + target:getMerit(tpz.merit.DESPERATE_BLOWS))

    -- Gear that affects this mod is handled by a Latent Effect because the gear must remain equipped
    target:addMod(tpz.mod.DEFP, -25 - target:getMerit(tpz.merit.LAST_RESORT_EFFECT))
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local jpValue = target:getJobPointLevel(tpz.jp.LAST_RESORT_EFFECT) * 2

    target:delMod(tpz.mod.ATT, jpValue)
    target:delMod(tpz.mod.ATTP, 25 + target:getMerit(tpz.merit.LAST_RESORT_EFFECT))
    target:delMod(tpz.mod.RATT, jpValue)
    target:delMod(tpz.mod.RATTP, 25 + target:getMerit(tpz.merit.LAST_RESORT_EFFECT))
    target:delMod(tpz.mod.TWOHAND_HASTE_ABILITY, target:getMod(tpz.mod.DESPERATE_BLOWS) + target:getMerit(tpz.merit.DESPERATE_BLOWS))
     -- Gear that affects this mod is handled by a Latent Effect because the gear must remain equipped
    target:delMod(tpz.mod.DEFP, -25 - target:getMerit(tpz.merit.LAST_RESORT_EFFECT))
end

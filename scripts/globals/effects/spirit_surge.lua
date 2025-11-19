-----------------------------------
--
-- tpz.effect.SPIRIT_SURGE
--
-----------------------------------
require("scripts/globals/status")

function onEffectGain(target, effect)
    local lvl = target:getMainLvl()
    local strBoost = (1 + lvl / 5) + 20
    if target:isMob() then
        target:addMod(tpz.mod.ATTP, 25)
        target:addMod(tpz.mod.ACC, 50)
        target:addMod(tpz.mod.DEFP, 25)
        target:addMod(tpz.mod.HASTE_ABILITY, 2500)
        target:addMod(tpz.mod.STR, strBoost)
    else
        local jpValue = (1 + target:getJobPointLevel(tpz.jp.SPIRIT_SURGE_EFFECT) / 100)
        target:addMod(tpz.mod.CRITHITRATE, effect:getPower() * jpValue)
        target:addMod(tpz.mod.ALL_WSDMG_ALL_HITS, effect:getPower() * jpValue)
        target:addMod(tpz.mod.WYVERN_BREATH, 25 * jpValue)
        target:addPetMod(tpz.mod.ATTP, 45 * jpValue)
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local lvl = target:getMainLvl()
    local strBoost = (1 + lvl / 5) + 20
    if target:isMob() then
        target:delMod(tpz.mod.ATTP, 25)
        target:delMod(tpz.mod.ACC, 50)
        target:delMod(tpz.mod.DEFP, 25)
        target:delMod(tpz.mod.HASTE_ABILITY, 2500)
        target:delMod(tpz.mod.STR, strBoost)
    else
        local jpValue = (1 + target:getJobPointLevel(tpz.jp.SPIRIT_SURGE_EFFECT) / 100)
        target:delMod(tpz.mod.CRITHITRATE, effect:getPower() * jpValue)
        target:delMod(tpz.mod.ALL_WSDMG_ALL_HITS, effect:getPower() * jpValue)
        target:delMod(tpz.mod.WYVERN_BREATH, 25 * jpValue)
        target:delPetMod(tpz.mod.ATTP, 45 * jpValue)
    end
end

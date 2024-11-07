-----------------------------------
--
-- tpz.effect.AVATAR_S_FAVOR
--
-----------------------------------
require("scripts/globals/status")

function onEffectGain(target, effect)
    local modBonus = 1 + (target:getMod(tpz.mod.AVATAR_FAVOR_BONUS) / 100)

    if not target:isPC() then
        target:setLocalVar("avatarsFavor", 1)
        target:addMod(tpz.mod.HASTE_MAGIC, 1500 * modBonus)
        target:addMod(tpz.mod.MAIN_DMG_RATING, 15 * modBonus)
        target:addMod(tpz.mod.RANGED_DMG_RATING, 15 * modBonus)
        target:addMod(tpz.mod.ATTP, 15 * modBonus)
        target:addMod(tpz.mod.RATTP, 15 * modBonus)
        target:addMod(tpz.mod.ACC, 10 * modBonus)
        target:addMod(tpz.mod.RACC, 10 * modBonus)
        target:addMod(tpz.mod.MATT, 10 * modBonus)
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local modBonus = 1 + (target:getMod(tpz.mod.AVATAR_FAVOR_BONUS) / 100)

    if not target:isPC() then
        if target:getLocalVar("avatarsFavor") ~= 0 then
            target:setLocalVar("avatarsFavor", 0)
            target:delMod(tpz.mod.HASTE_MAGIC, 1500 * modBonus)
            target:delMod(tpz.mod.MAIN_DMG_RATING, 15 * modBonus)
            target:delMod(tpz.mod.RANGED_DMG_RATING, 15 * modBonus)
            target:delMod(tpz.mod.ATTP, 15 * modBonus)
            target:delMod(tpz.mod.RATTP, 15 * modBonus)
            target:delMod(tpz.mod.ACC, 10 * modBonus)
            target:delMod(tpz.mod.RACC, 10 * modBonus)
            target:delMod(tpz.mod.MATT, 10 * modBonus)
        end
    end
end

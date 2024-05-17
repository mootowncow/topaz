-----------------------------------------
-- ID: 4210
-- Lethe Water
-- Dispels up to 3 positive status effects from target.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effectsDispelled = 0

    if math.random(100) > target:getMod(tpz.mod.DISPELRESTRAIT) then
        if (target:dispelStatusEffect() ~= tpz.effect.NONE) then
            effectsDispelled = effectsDispelled + 1
        end
    end

    if math.random(100) > target:getMod(tpz.mod.DISPELRESTRAIT) then
        if (target:dispelStatusEffect() ~= tpz.effect.NONE) then
            effectsDispelled = effectsDispelled + 1
        end
    end

    if math.random(100) > target:getMod(tpz.mod.DISPELRESTRAIT) then
        if (target:dispelStatusEffect() ~= tpz.effect.NONE) then
            effectsDispelled = effectsDispelled + 1
        end
    end

    target:messagePublic(tpz.msg.basic.EFFECTS_DISAPPEAR, target, effectsDispelled, effectsDispelled)
end


-----------------------------------------
-- ID: 4148
-- Item: Tincture
-- Item Effect: This potion remedies disease and plague
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)

    if (target:hasStatusEffect(tpz.effect.PLAGUE) == true) then
        target:delStatusEffectSilent(tpz.effect.PLAGUE)
    end

    if (target:hasStatusEffect(tpz.effect.DISEASE) == true) then
        target:delStatusEffectSilent(tpz.effect.DISEASE)
    end
end


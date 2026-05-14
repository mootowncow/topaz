-----------------------------------------
-- ID: 4172
-- Item: Reraiser
-- Item Effect: +50% HP
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local duration = 900
    -- TODO: Trust logic
    if target:hasStatusEffect(tpz.effect.MAX_HP_DOWN) then
        -- return player - > body boost - > no effect 
    end
    target:delStatusEffectSilent(tpz.effect.MAX_HP_BOOST)
    target:addStatusEffect(tpz.effect.MAX_HP_BOOST, 50, 0, duration)
end

-----------------------------------------
-- ID: 4172
-- Item: Reraiser
-- Item Effect: +100% HP
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local duration = 900
    local party = target:getPartyWithTrusts()

    -- TODO: No effect if target:hasStatusEffect(tpz.effect.MAX_HP_DOWN)
    for _, member in ipairs(party) do
        if member:isTrust() then
            member:delStatusEffectSilent(tpz.effect.MAX_HP_BOOST)
            member:addStatusEffect(tpz.effect.MAX_HP_BOOST, 100, 0, duration)
        end
    end
    target:delStatusEffectSilent(tpz.effect.MAX_HP_BOOST)
    target:addStatusEffect(tpz.effect.MAX_HP_BOOST, 100, 0, duration)
end

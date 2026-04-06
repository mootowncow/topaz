-----------------------------------------
-- ID: 4172
-- Item: Wizards Drink
-- Item Effect: +100% MP
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local duration = 900
    local party = target:getPartyWithTrusts()
    for _, member in ipairs(party) do
        if member:isTrust() then
            member:delStatusEffectSilent(tpz.effect.MAX_MP_BOOST)
            member:addStatusEffect(tpz.effect.MAX_MP_BOOST, 100, 0, duration)
        end
    end
    target:delStatusEffectSilent(tpz.effect.MAX_MP_BOOST)
    target:addStatusEffect(tpz.effect.MAX_MP_BOOST, 100, 0, duration)
end

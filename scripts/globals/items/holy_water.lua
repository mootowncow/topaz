-----------------------------------------
-- ID: 4154
-- Item: Flask of Holy Water
-- Item Effect: Removes curse
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local curse = target:getStatusEffect(tpz.effect.CURSE_I)
    local bane = target:getStatusEffect(tpz.effect.BANE)
    local effect = 0
    local effectFlags = 0
    local power = 33 + target:getMod(tpz.mod.ENHANCES_HOLYWATER)

    if (target:hasStatusEffect(tpz.effect.DOOM) and power > math.random(1, 100)) then
        target:delStatusEffect(tpz.effect.DOOM)
        target:messageBasic(tpz.msg.basic.NARROWLY_ESCAPE)
    elseif (curse ~= nil and curse2 ~= nil and bane ~= nil) then
        effect = target:getStatusEffect(tpz.effect.CURSE_I)
        effectFlags = effect:getFlag()
        if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
            target:delStatusEffect(tpz.effect.CURSE_I)
        end
        effect = target:getStatusEffect(tpz.effect.BANE)
        effectFlags = effect:getFlag()
        if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
            target:delStatusEffect(tpz.effect.BANE)
        end
    elseif (curse ~= nil and bane ~= nil) then
        effect = target:getStatusEffect(tpz.effect.BANE)
        effectFlags = effect:getFlag()
        if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
            target:delStatusEffect(tpz.effect.BANE)
        end
    elseif (curse2 ~= nil and bane ~= nil) then
        effect = target:getStatusEffect(tpz.effect.BANE)
        effectFlags = effect:getFlag()
        if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
            target:delStatusEffect(tpz.effect.BANE)
        end
    elseif (curse ~= nil) then
        effect = target:getStatusEffect(tpz.effect.CURSE_I)
        effectFlags = effect:getFlag()
        if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
            target:delStatusEffect(tpz.effect.CURSE_I)
        end
    elseif (bane ~= nil) then
        effect = target:getStatusEffect(tpz.effect.BANE)
        effectFlags = effect:getFlag()
        if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
            target:delStatusEffect(tpz.effect.BANE)
        end
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

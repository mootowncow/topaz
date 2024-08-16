-----------------------------------------
-- ID: 5837
-- Item: tube_of_clear_salve_i
-- Item Effect: Instantly removes 1-2 negative status effects at random from pet
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
-----------------------------------------

function onItemCheck(target)
    if not target:hasPet() then
        return tpz.msg.basic.NO_TARGET_AVAILABLE
    end
    return 0
end

function onItemUse(target)
    local pet = target:getPet()
    local effects = utils.GetRemovableEffects()
    local count = math.random(1, 2)
    local statusEffectTable = utils.shuffle(effects)

    local function removeStatus()
        for _, effect in ipairs(statusEffectTable) do
            if (pet:hasStatusEffect(effect)) then
                local currentEffect = pet:getStatusEffect(effect)
                local effectFlags = currentEffect:getFlag()
                if
                    (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) or
                    (effect == tpz.effect.DOOM) or
                    (effect == tpz.effect.PETRIFICATION)
                then
                    if pet:delStatusEffect(effect) then return true end
                end
            end
        end
        if pet:eraseStatusEffect() ~= 255 then return true end
        return false
    end

    local removed = 0

    for i = 0, count do
        if not removeStatus() then break end
        removed = removed + 1
        if removed >= count then break end
    end

    if removed > 0 then
        target:messagePublic(tpz.msg.basic.EFFECTS_DISAPPEAR, pet, removed, removed)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, pet)
    end

    return removed
end

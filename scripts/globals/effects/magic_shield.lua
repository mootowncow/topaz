-----------------------------------
--
-- Magic Shield blocks magic, but NOT breath attacks
-- if power is > 100, adds a "Magic Stoneskin" effect.
-- if power is > 19 and < 100 then MDT % = power
-- If power is 8, 50% MDT from BEHIND
-- If power is 7, 75% MDT from BEHIND
-- If power is 6, 50% MDT in FRONT
-- If power is 5, 75% MDT in FRONT
-- If power is 4, 100% MDT from BEHIND
-- If power is 3, 100% MDT in FRONT
-- If power is 2, 100% magic absorb
-- If power is < 2, 100% MDT
-----------------------------------

require("scripts/globals/status")

function onEffectGain(target, effect)
    if effect:getPower() < 2 then
        target:addMod(tpz.mod.UDMGMAGIC, -101)
        if target:isPC() and target:hasTrait(tpz.trait.IRON_WILL) then
            target:addMod(tpz.mod.SPELLINTERRUPT, target:getMerit(tpz.merit.IRON_WILL))
        end
    elseif effect:getPower() == 2 then
        target:addMod(tpz.mod.MAGIC_ABSORB, 100)
    elseif (effect:getPower() > 19 and effect:getPower() < 100) then
        target:addMod(tpz.mod.UDMGMAGIC, -effect:getPower())
    elseif effect:getPower() > 100 then
        target:setMod(tpz.mod.MAGIC_SS, effect:getPower())
    end
end

function onEffectLose(target, effect)
    if effect:getPower() < 2 then
        target:delMod(tpz.mod.UDMGMAGIC, -101)
        if target:isPC() and target:hasTrait(tpz.trait.IRON_WILL) then
            target:delMod(tpz.mod.SPELLINTERRUPT, target:getMerit(tpz.merit.IRON_WILL))
        end
    elseif effect:getPower() == 2 then
        target:delMod(tpz.mod.MAGIC_ABSORB, 100)
    elseif (effect:getPower() > 19 and effect:getPower() < 100) then
        target:delMod(tpz.mod.UDMGMAGIC, -effect:getPower())
    elseif effect:getPower() == 100 then
        target:setMod(tpz.mod.MAGIC_SS, 0)
    end
end

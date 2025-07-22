-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    effect:setSubPower(effect:getPower()*(256/100))
    target:addMod(tpz.mod.UDMGPHYS, -effect:getPower())
    target:addMod(tpz.mod.UDMGBREATH, -effect:getPower())
    target:addMod(tpz.mod.UDMGMAGIC, -effect:getSubPower())
    target:addMod(tpz.mod.UDMGRANGE, -effect:getPower())
    target:addMod(tpz.mod.SLEEPRES, effect:getPower() *3)
    target:addMod(tpz.mod.POISONRES, effect:getPower() *3)
    target:addMod(tpz.mod.PARALYZERES, effect:getPower() *3)
    target:addMod(tpz.mod.BLINDRES, effect:getPower() *3)
    target:addMod(tpz.mod.SILENCERES, effect:getPower() *3)
    target:addMod(tpz.mod.BINDRES, effect:getPower() *3)
    target:addMod(tpz.mod.CURSERES, effect:getPower() *3)
    target:addMod(tpz.mod.SLOWRES, effect:getPower() *3)
    target:addMod(tpz.mod.STUNRES, effect:getPower() *3)
    target:addMod(tpz.mod.CHARMRES, effect:getPower() *3)
end

function onEffectTick(target, effect)
    if (effect:getTickCount() > ((effect:getDuration() / effect:getTick())/2)) then
        if (effect:getPower() > 2) then
            effect:setPower(effect:getPower() - 4)
            effect:setSubPower(effect:getSubPower() - 3)
            target:delMod(tpz.mod.UDMGPHYS, -4)
            target:delMod(tpz.mod.UDMGBREATH, -4)
            target:delMod(tpz.mod.UDMGMAGIC, -4)
            target:delMod(tpz.mod.UDMGRANGE, -4)
            target:delMod(tpz.mod.SLEEPRES, 10)
            target:delMod(tpz.mod.POISONRES, 10)
            target:delMod(tpz.mod.PARALYZERES, 10)
            target:delMod(tpz.mod.BLINDRES, 10)
            target:delMod(tpz.mod.SILENCERES, 10)
            target:delMod(tpz.mod.BINDRES, 10)
            target:delMod(tpz.mod.CURSERES, 10)
            target:delMod(tpz.mod.SLOWRES, 10)
            target:delMod(tpz.mod.STUNRES, 10)
            target:delMod(tpz.mod.CHARMRES, 10)
        end
    end
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.UDMGPHYS, -effect:getPower())
    target:delMod(tpz.mod.UDMGBREATH, -effect:getPower())
    target:delMod(tpz.mod.UDMGMAGIC, -effect:getSubPower())
    target:delMod(tpz.mod.UDMGRANGE, -effect:getPower())
    target:delMod(tpz.mod.SLEEPRES, effect:getPower() * 3)
    target:delMod(tpz.mod.POISONRES, effect:getPower() * 3)
    target:delMod(tpz.mod.PARALYZERES, effect:getPower() * 3)
    target:delMod(tpz.mod.BLINDRES, effect:getPower() * 3)
    target:delMod(tpz.mod.SILENCERES, effect:getPower() * 3)
    target:delMod(tpz.mod.BINDRES, effect:getPower() * 3)
    target:delMod(tpz.mod.CURSERES, effect:getPower() * 3)
    target:delMod(tpz.mod.SLOWRES, effect:getPower() * 3)
    target:delMod(tpz.mod.STUNRES, effect:getPower() * 3)
    target:delMod(tpz.mod.CHARMRES, effect:getPower() * 3)
end

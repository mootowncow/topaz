-----------------------------------
--
--     tpz.effect.PALISADE
--     Increases chance of blocking with shield by 30%, and eliminates enmity loss. 
--     If cast by a player, AOES custom below logic onto all party members and does not provide shield block increase.
--     Only effects main job PLDs
--     Grants +100% Defense and reduces enmity loss for taking damage for 1 minute
--     Causes the user and all enemy targets in range to be unable to move.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    if target:getMainJob() == tpz.job.PLD then
        target:addMod(tpz.mod.ENMITY_LOSS_REDUCTION, 100)

        if target:isPC() then
            target:addMod(tpz.mod.DEFP, 100)
            if not target:hasStatusEffect(tpz.effect.BIND) then
                effect:setPower(target:speed())
                target:speed(0)
            end
        end
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    if target:getMainJob() == tpz.job.PLD then
        target:delMod(tpz.mod.ENMITY_LOSS_REDUCTION, 100)

        if target:isPC() then
            target:delMod(tpz.mod.DEFP, 100)
            if not target:hasStatusEffect(tpz.effect.BIND) then
                target:speed(effect:getPower())
            end
        end
    end
end

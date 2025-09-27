-----------------------------------------
-- Spell: Raise
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    if (target:isPC()) then
        if caster:isPC() then
            target:sendTractor(caster:getXPos(), caster:getYPos(), caster:getZPos(), target:getRotPos())
            target:allowSendRaisePrompt()
            target:addStatusEffect(tpz.effect.RERAISE, 2, 0, 3600)
        else
            target:setLocalVar("jobLevel", target:getJobLevel(target:getMainJob()))
            target:sendRaise(2)
        end
    else
        if (target:getName() == "Prishe") then
            -- CoP 8-4 Prishe
            target:setLocalVar("Raise", 1)
            target:entityAnimationPacket("sp00")
            target:addHP(target:getMaxHP())
            target:addMP(target:getMaxMP())
        elseif target:isTrust() then
            target:setHP(target:getMaxHP() * 0.25)
            if target:hasStatusEffect(tpz.effect.WEAKNESS) then
                target:addStatusEffect(tpz.effect.WEAKNESS, 2, 0, 120)
            else
                target:addStatusEffect(tpz.effect.WEAKNESS, 1, 0, 120)
            end
            target:disengage()
        end
    end
    spell:setMsg(tpz.msg.basic.MAGIC_CASTS_ON)

    return 2
end

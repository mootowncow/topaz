-----------------------------------------
-- Spell: Arise
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    if (target:isPC()) then
        target:sendTractor(caster:getXPos(), caster:getYPos(), caster:getZPos(), target:getRotPos())
        target:allowSendRaisePrompt()
        target:addStatusEffect(tpz.effect.RERAISE, 5, 0, 3600)
    else
        if (target:getName() == "Prishe") then
            -- CoP 8-4 Prishe
            target:setLocalVar("Raise", 1)
            target:entityAnimationPacket("sp00")
            target:addHP(target:getMaxHP())
            target:addMP(target:getMaxMP())
        end
    end
    spell:setMsg(tpz.msg.basic.MAGIC_CASTS_ON)

    return 1
end

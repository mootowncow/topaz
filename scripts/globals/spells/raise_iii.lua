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
        if (caster:getObjType() == tpz.objType.MOB) and (caster:getMobMod(tpz.mobMod.PIXIE) > 0) then
            target:sendRaise(6)
        else
            target:sendTractor(caster:getXPos(), caster:getYPos(), caster:getZPos(), target:getRotPos())
            target:allowSendRaisePrompt()
            target:addStatusEffect(tpz.effect.RERAISE, 3, 0, 3600)
        end
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

    return 3
end

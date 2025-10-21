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
            target:sendRaise(3)
        end
    else
        if (target:getName() == "Prishe") then
            -- CoP 8-4 Prishe
            target:setLocalVar("Raise", 1)
            target:entityAnimationPacket("sp00")
            target:addHP(target:getMaxHP())
            target:addMP(target:getMaxMP())
        elseif target:isTrust() then
            if target:isDead() then
                target:setHP(target:getMaxHP() * 0.50)
                if target:hasStatusEffect(tpz.effect.WEAKNESS) then
                    target:addStatusEffect(tpz.effect.WEAKNESS, 2, 0, 60)
                else
                    target:addStatusEffect(tpz.effect.WEAKNESS, 1, 0, 60)
                end
                target:disengage()
            end
        end
    end
    spell:setMsg(tpz.msg.basic.MAGIC_CASTS_ON)

    return 3
end

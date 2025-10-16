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
        target:sendRaise(1)
    else
        if (target:getName() == "Prishe") then
            -- CoP 8-4 Prishe
            target:setLocalVar("Raise", 1)
            target:entityAnimationPacket("sp00")
            target:addHP(target:getMaxHP())
            target:addMP(target:getMaxMP())
        elseif target:isTrust() then
            if target:isDead() then
                target:setHP(target:getMaxHP() * 0.1)
                if target:hasStatusEffect(tpz.effect.WEAKNESS) then
                    target:addStatusEffect(tpz.effect.WEAKNESS, 2, 0, 180)
                else
                    target:addStatusEffect(tpz.effect.WEAKNESS, 1, 0, 180)
                end
                target:disengage()
            end
        end
    end
    spell:setMsg(tpz.msg.basic.MAGIC_CASTS_ON)

    return 1
end

-----------------------------------------
-- Spell: Goddess's Hymnus
-- Grants Reraise.
-----------------------------------------

require("scripts/globals/status")
require("scripts/globals/msg")

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = 120

    if not (target:addBardSong(caster, tpz.effect.HYMNUS, 1, 0, 120, caster:getID(), 0, 1)) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.HYMNUS
end

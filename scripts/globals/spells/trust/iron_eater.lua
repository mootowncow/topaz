-----------------------------------------
-- Trust: Iron Eater
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------------

local message_page_offset = 21

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    tpz.trust.teamworkMessage(mob, message_page_offset, {
        [tpz.magic.spell.NAJI] = tpz.trust.message_offset.TEAMWORK_1,
    })

    mob:addSimpleGambit(ai.t.MASTER, ai.c.HPP_LT, 50,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.PROVOKE)

    if mob:getMainLvl() >= 70 then
        mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.SEIGAN)
        mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.THIRD_EYE)
    end

    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.RESTRAINT)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.BERSERK, ai.r.JA, ai.s.SPECIFIC, tpz.ja.BERSERK)
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.AGGRESSOR, ai.r.JA, ai.s.SPECIFIC, tpz.ja.AGGRESSOR)

    if mob:getMainLvl() >= 50 then
        mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.HASSO)
    end

    if mob:getMainLvl() >= 60 then
        mob:addSimpleGambit(ai.t.SELF, ai.c.TP_LT, 400, ai.r.JA, ai.s.SPECIFIC, tpz.ja.MEDITATE)
    end

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end

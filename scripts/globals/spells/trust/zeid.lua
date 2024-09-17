-----------------------------------------
-- Trust: Zeid
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------------

local message_page_offset = 86

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 906)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    --[[
    TODO
    tpz.trust.teamworkMessage(mob, {
        [tpz.magic.spell.LION_II] = tpz.trust.message_offset.TEAMWORK_1,
    })
    ]]

    -- Stun all the things!
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_WS, 0,
                        ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_MS, 0,
                        ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_JA, 0,
                        ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.CASTING_MA, 0,
                        ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_WS, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.WEAPON_BASH)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_MS, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.WEAPON_BASH)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_JA, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.WEAPON_BASH)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.CASTING_MA, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.WEAPON_BASH)

    if mob:getMainLvl() >= 70 then
        mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.SEIGAN)
        mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.THIRD_EYE)
    end

    if mob:getMainLvl() >= 50 then
        mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.HASSO)
    end

    mob:addSimpleGambit(ai.t.TARGET, ai.c.STATUS_FLAG, tpz.effectFlag.DISPELABLE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.ABSORB_ATTRI)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.CAN_ASPIR, 50, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.ASPIR)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.CAN_DRAIN, 50, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.DRAIN)

    if mob:getMainLvl() >= 60 then
        mob:addSimpleGambit(ai.t.SELF, ai.c.TP_LT, 400, ai.r.JA, ai.s.SPECIFIC, tpz.ja.MEDITATE)
    end

    -- Non-stun things
    mob:addSimpleGambit(ai.t.SELF, ai.c.PT_HAS_WHM, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.SOULEATER)

    mob:addSimpleGambit(ai.t.SELF, ai.c.ALWAYS, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.LAST_RESORT)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.ENDARK, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.ENDARK)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.IS_ECOSYSTEM,tpz. ecosystem.ARCANA, ai.r.JA, ai.s.SPECIFIC,tpz.ja.ARCANE_CIRCLE)

    if mob:getMainLvl() >= 61 then
        mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.ACCURACY_DOWN, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.ABSORB_ACC)
    else
        mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.STR_DOWN, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.ABSORB_STR)
    end

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
